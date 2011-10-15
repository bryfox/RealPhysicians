class Sinatra::Base
  helpers do

    def h(text)
      Rack::Utils.escape_html(text)
    end
  
    def partial(template, options={})
      options.merge!(:layout => false)
      if collection = options.delete(:collection) then
        collection.inject([]) do |buffer, member|
          buffer << haml(template, options.merge(:layout => false, :locals => {template.to_sym => member}))
        end.join("\n")
      else
        haml(template, options)
      end
    end

  end
end