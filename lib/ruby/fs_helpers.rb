module FsHelpers

  module_function def relativize(start, path)
    (path[start.length..] || '').sub(%r,\A/,, '')
  end

  module_function def absolutize(start, path)
    File.join(start, path)
  end

  module_function def entries_in_path(path)
    Dir.entries(path).reject do |entry|
      entry == '.' || entry == '..'
    end.sort
  end

  CHUNK_SIZE = 65536

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
