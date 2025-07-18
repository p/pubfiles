#!/usr/bin/env ruby

autoload :CGI, 'cgi'
autoload :URI, 'uri'
autoload :Find, 'find'

class LinkCleaner
  def initialize(method: nil)
    unless [nil, :regexp, :nokogiri].include?(method)
      raise "Invalid method: #{method}"
    end
    if method == :nokogiri
      require 'nokogiri'
    end
    @method = method
  end

  attr_reader :method

  def run_in_path(start)
    Find.find(start) do |path|
      if path.end_with?('.md')
        clean_file_in_place(path)
      end
    end
  end

  def clean(contents)
    case method
    when :nokogiri
      clean_via_nokogiri(contents)
    else
      clean_via_regexp(contents)
    end
  end

  def clean_file_in_place(path)
    contents = case path
    when IO
      path.read
    else
      File.read(path)
    end

    cleaned_contents = clean(contents)

    if cleaned_contents != contents
      puts "Writing #{path}"
      File.open(path, 'w') do |f|
        f << cleaned_contents
      end
    end
  end

  private

  def clean_via_regexp(contents)
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
    cleaned
  end

  def clean_via_nokogiri(contents)
    doc = Nokogiri::HTML(contents)
    doc.xpath('//a').each do |a|
      href = a.attr('href')
      if href
        cleaned_href = clean_url(href)
        if href != cleaned_href
          a.set_attribute('href', cleaned_href)
        end
      end
    end
    doc.to_s
  end

  def clean_url(url)
    if url.start_with?('https://www.google.com/url')
      url = uri_class.parse(url)
      q = url.query_values.fetch('q')
      q
    elsif url.start_with?('https://l.facebook.com/l.php')
      url = uri_class.parse(url)
      q = url.query_values.fetch('u')
      q
    else
      url
    end
  end

  def uri_class
    @uri_class ||= begin
      require 'addressable'
      Addressable::URI
    rescue LoadError
      URI
    end
  end
end
