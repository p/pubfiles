autoload :ERB, 'erb'
autoload :Slim, 'slim'

class Context
  include Helpers

  def initialize(**opts)
    @options = opts.dup.freeze
  end

  attr_reader :options

  def network?
    options[:network] != false
  end

  def render(template_path)
    content = File.read(template_path)
    ext = File.extname(template_path)
    case ext
    when '.erb'
      template = ERB.new(content)
      template.result(binding)
    when '.slim'
      template = Slim::Template.new(template_path)
      template.render(self)
    else
      raise "Unknown extension: #{ext}"
    end
  end

  def partial(path)
    %w(erb slim).each do |suffix|
      template_path = src_base.join(path + '.' + suffix)
      if File.exist?(template_path)
        return render(template_path)
      end
    end
    raise "Missing template: #{path}"
  end

  def rc_keyboard_partials
    generated = []
    rc_d_path = File.join(File.dirname(__FILE__), '..', 'rc.keyboard.d')
    if File.exist?(rc_d_path)
      ::FsHelpers.entries_in_path(rc_d_path).each do |basename|
        path = File.join(rc_d_path, basename)
        generated << render(path)
      end
      generated.join("\n\n")
    else
      ''
    end
  end

  def defined_menus
    generated = []
    menu_d_path = File.join(File.dirname(__FILE__), '..', 'menu.d')
    if File.exist?(menu_d_path)
      ::FsHelpers.entries_in_path(menu_d_path).each do |basename|
        path = File.join(menu_d_path, basename)
        generated << Context.new(**options).render(path)
      end
      generated.join("\n\n")
    else
      ''
    end
  end
end
