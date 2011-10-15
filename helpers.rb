class Sinatra::Base
  helpers do

    def h(text)
      Rack::Utils.escape_html(text)
    end
  
    def partial (template, locals = {})
      erb(template, :layout => false, :locals => locals)
    end

  end
end