#!/usr/bin/env ruby

autoload :CGI, 'cgi'
autoload :URI, 'uri'
autoload :Find, 'find'

class LinkCleaner
  def run_in_path(start)
    Find.find(start) do |path|
      if path.end_with?('.md')
        clean_file_in_place(path)
      end
    end
  end

  def clean(contents)
    cleaned = contents.gsub(%r,(https://www.amazon.com/[^/]+/dp/\w+)/ref=\w+(?:/[-\d]+)?\?\S+,, '\1')
    cleaned.gsub!(%r,(https://www.amazon.com/gp/product/\w+)/ref=\w+(?:/[-\d]+)?\?\S+,, '\1')
    cleaned.gsub!(%r,(https://www.ebay.com/itm(?:/[^/]+)?/\d+)\?\S+,) do |m|
      uri = URI.parse(m)
      if uri.query
        params = CGI.parse(uri.query)
        params.select! do |key, value|
          # _skw: search keyword
          # _nkw: also some type of search keyword?
          # fits: vehicle fitment
          %w(_skw _nkw fits).include?(key)
        end
        uri.query = params.map do |key, value|
          "#{key}=#{CGI.escape(value.first)}"
        end.join('&')
        uri.query = nil if uri.query.empty?
      end
      uri.to_s
    end

    cleaned.gsub!(/ +$/, '')
  end

  def clean_file_in_place(path)
    contents = File.read(path)

    cleaned_contents = clean(contents)

    if cleaned_contents != contents
      puts "Writing #{path}"
      File.open(path, 'w') do |f|
        f << cleaned_contents
      end
    end
  end
end
