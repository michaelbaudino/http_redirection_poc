class App
  attr_reader :req

  def initialize(env)
    @req = Rack::Request.new(env)
  end

  def self.call(env)
    new(env).call
  end

  def call
    case req.path
    when "/"
      return_html(
        button("GET",  "/detector")               +
        button("POST", "/detector")               +
        button("GET",  "/redirector", code: 301)  +
        button("POST", "/redirector", code: 301)  +
        button("GET",  "/redirector", code: 307)  +
        button("POST", "/redirector", code: 307)
      )
    when "/detector"
      return_html(home_link + display_request)
    when "/redirector"
      redirect(params["code"], "/detector")
    end
  end

private

  def return_html(content)
    [200, {"Content-Type" => "text/html"}, layout(content)]
  end

  def redirect(code, target)
    [code, {"Location" => target}, []]
  end

  def layout(content)
    ["<html><head></head><body>#{content}#{"<hr>#{req.inspect}" if params["debug"]}</body></html>"]
  end

  def button(method, action, options = {})
    <<-EOS
      <form method="#{method}" action="#{action}">
        #{hidden_fields(options)}
        <button type="submit">
          #{method} #{action}#{" (#{options[:code]})" if options[:code]}
        </button>
      </form>
    EOS
  end

  def hidden_fields(options)
    options.map do |key, value|
      "<input name=\"#{key}\" hidden=\"true\" value=\"#{value}\">"
    end.join
  end

  def home_link
    "<a href=\"/\">&lt;&lt; home</a><hr>"
  end

  def display_request
    "This is a #{req.request_method} request."
  end

  def params
    @params ||= req.GET.merge(req.POST)
  end
end
