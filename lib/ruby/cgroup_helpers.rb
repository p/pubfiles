# frozen_string_literal: true

module CgroupHelpers
  extend self

  # Set which CPU cores a cgroup can use
  # @param cgroup [String] cgroup path (e.g., "system.slice/myservice.service")
  # @param cpus [Integer, Range, Array] CPU core(s) to assign (e.g., 13, 12..13, [12, 13])
  def set_cpuset_cpus(cgroup, cpus)
    set_cgroup_value(cgroup, "cpuset.cpus", Array(cpus).to_a.join(','))
  end

  # Set CPU idle scheduling for a cgroup
  # @param cgroup [String] cgroup path
  # @param value [Integer] 0 = normal scheduling, 1 = idle scheduling (only use idle CPU)
  def set_cpu_idle(cgroup, value)
    set_cgroup_value(cgroup, "cpu.idle", value)
  end

  # Set I/O priority class for a cgroup
  # @param cgroup [String] cgroup path
  # @param prio_class [String] Priority class: "idle", "be" (best-effort), "rt" (real-time), "no-change"
  def set_io_prio_class(cgroup, prio_class)
    set_cgroup_value(cgroup, "io.prio.class", prio_class)
  end

  # Set IOPS (I/O operations per second) limits for a cgroup
  # @param cgroup [String] cgroup path
  # @param device [String] Device path ("/dev/nvme0n1", "/", "/home") or major:minor ("259:0")
  # @param read_iops [Integer, String, nil] Read IOPS limit (or "max" for unlimited)
  # @param write_iops [Integer, String, nil] Write IOPS limit (or "max" for unlimited)
  # @raise [ArgumentError] if device cannot be resolved or no limits specified
  # @example
  #   set_io_iops("system.slice/myservice.service", "/", read_iops: 5000, write_iops: 2000)
  #   set_io_iops("system.slice/myservice.service", "/dev/nvme0n1", write_iops: 1000)
  def set_io_iops(cgroup, device, read_iops: nil, write_iops: nil)
    raise ArgumentError, "No IOPS limits specified (need read_iops or write_iops)" unless read_iops || write_iops

    device_majmin = resolve_device_majmin(device)
    parts = ["#{device_majmin}"]
    parts << "riops=#{read_iops}" if read_iops
    parts << "wiops=#{write_iops}" if write_iops

    set_cgroup_value(cgroup, "io.max", parts.join(' '))
  end

  # Set I/O bandwidth limits (bytes per second) for a cgroup
  # @param cgroup [String] cgroup path
  # @param device [String] Device path ("/dev/nvme0n1", "/", "/home") or major:minor ("259:0")
  # @param read_bps [Integer, String, nil] Read bytes per second (or "max" for unlimited)
  # @param write_bps [Integer, String, nil] Write bytes per second (or "max" for unlimited)
  # @raise [ArgumentError] if device cannot be resolved or no limits specified
  # @example
  #   set_io_bps("system.slice/myservice.service", "/", read_bps: 10485760, write_bps: 5242880)
  #   set_io_bps("system.slice/myservice.service", "/dev/nvme0n1", write_bps: 10*1024*1024)
  def set_io_bps(cgroup, device, read_bps: nil, write_bps: nil)
    raise ArgumentError, "No bandwidth limits specified (need read_bps or write_bps)" unless read_bps || write_bps

    device_majmin = resolve_device_majmin(device)
    parts = ["#{device_majmin}"]
    parts << "rbps=#{read_bps}" if read_bps
    parts << "wbps=#{write_bps}" if write_bps

    set_cgroup_value(cgroup, "io.max", parts.join(' '))
  end

  # Resolve device path to major:minor number
  # @param device [String] Device path or major:minor
  # @return [String] major:minor string
  # @raise [ArgumentError] if device cannot be resolved
  private def resolve_device_majmin(device)
    # If already in major:minor format, return as-is
    return device if device =~ /^\d+:\d+$/

    # If it's a filesystem path, get the device for that mount point
    if File.directory?(device) || device == '/'
      output = `findmnt -n -o SOURCE #{device} 2>/dev/null`.strip
      if output.empty?
        raise ArgumentError, "No device found for mount point: #{device}"
      end
      device = output
    end

    # Resolve symlinks to real device path
    device = File.realpath(device) if File.symlink?(device)

    # If it's a block device, get major:minor using stat
    if File.blockdev?(device)
      # stat returns hex format (e.g., "103:0"), convert to decimal
      output = `stat -c '%t:%T' #{device} 2>/dev/null`.strip
      if output && !output.empty?
        major, minor = output.split(':')
        return "#{major.to_i(16)}:#{minor.to_i(16)}"
      else
        raise ArgumentError, "Could not get major:minor for block device: #{device}"
      end
    end

    raise ArgumentError, "Invalid device (not a block device or mount point): #{device}"
  end

  # Set an arbitrary cgroup value
  # @param cgroup_name [String] cgroup path relative to /sys/fs/cgroup
  # @param rel_path [String] file name within the cgroup (e.g., "cpu.max", "io.weight")
  # @param value [String, Integer] value to write
  def set_cgroup_value(cgroup_name, rel_path, value)
    path = File.join('/sys/fs/cgroup', cgroup_name, rel_path)
    if File.exist?(path)
      File.open(path, 'w') do |f|
        f << value
      end
    else
      warn "Missing group? #{path}"
    end
  rescue SystemCallError => e
    raise e.class, "Failed to write to cgroup: path=#{path.inspect}, value=#{value.inspect}: #{e.class}: #{e}", e.backtrace
  end
end
