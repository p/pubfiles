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
  end
end
