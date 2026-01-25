# frozen_string_literal: true

autoload :Find, 'find'

module FsHelpers

  def self.relativize(start, path)
    unless path.start_with?(start)
      raise ArgumentError, "Path '#{path}' does not begin with prefix '#{start}'"
    end
    (path[start.length..] || '').sub(%r,\A/,, '')
  end

  def relativize(path)
    FsHelpers.relativize(start_path, path)
  end

  module_function def absolutize(start, path)
    File.join(start, path)
  end

  module_function def entries_in_path(path)
    Dir.entries(path).reject do |entry|
      entry == '.' || entry == '..'
    end.sort
  end

  module_function def single_child!(path)
    entries = entries_in_path(path)
    if entries.length != 1
      raise "Expected one child in #{path} but have: #{entries}"
    end
    File.join(path, entries.first)
  end

  module_function def relativize_symlink_target(target, link_path)
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

  module_function def detect_existent_path(*paths)
    paths.detect do |path|
      File.exist?(path)
    end
  end

  CHUNK_SIZE = 65536

  module_function def files_same_contents?(a_path, b_path)
    File.open(a_path, 'rb') do |fa|
      File.open(b_path, 'rb') do |fb|
        while a_chunk = fa.read(CHUNK_SIZE)
          b_chunk = fb.read(a_chunk.length)
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

  # Not disk usage - we do not account for waste in filesystem clusters
  module_function def path_total_size(path)
    total = 0
    Find.find(path) do |path|
      if File.file?(path)
        total += File.stat(path).size
      end
    end
    total
  end
end
