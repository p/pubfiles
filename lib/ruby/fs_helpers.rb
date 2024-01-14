module FsHelpers

  module_function def relativize(start, path)
    unless path.start_with?(start)
      raise ArgumentError, "Path '#{path}' does not begin with prefix '#{start}'"
    end
    (path[start.length..] || '').sub(%r,\A/,, '')
  end

  module_function def absolutize(start, path)
    File.join(start, path)
  end

  module Functions
    def entries_in_path(path)
      Dir.entries(path).reject do |entry|
        entry == '.' || entry == '..'
      end.sort
    end

    def relativize_symlink_target(target, link_path)
      unless target.start_with?('/')
        raise "Target must be absolute: #{target}"
      end
      unless link_path.start_with?('/')
        raise "Link path must be absolute: #{link_path}"
      end
      abs_target_comps = File.absolute_path(target).split('/')
      abs_link_comps = File.absolute_path(link_path).split('/')
      loop do
        if abs_target_comps.any? &&
          abs_target_comps.first == abs_link_comps.first
        then
          abs_target_comps.shift
          abs_link_comps.shift
        else
          break
        end
      end
      if abs_target_comps.empty?
        comps = ['..'] * abs_link_comps.length
      else
        comps = ['..'] * (abs_link_comps.length - 1) + abs_target_comps
      end
      File.join(*comps)
    end

    def detect_existent_path(*paths)
      paths.detect do |path|
        File.exist?(path)
      end
    end
  end

  include Functions
  extend Functions

  CHUNK_SIZE = 65536

  def relativize(path)
    FsHelpers.relativize(start_path, path)
  end

  def files_same_contents?(a_path, b_path)
    File.open(a_path, 'rb') do |fa|
      File.open(b_path, 'rb') do |fb|
        while a_chunk = fa.read(CHUNK_SIZE)
          b_chunk = fb.read(CHUNK_SIZE)
          if a_chunk != b_chunk
            return false
          end
        end
        if fb.read(1)
          return false
        end
      end
    end
    true
  end
end
