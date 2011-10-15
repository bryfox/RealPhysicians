class Controller < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/physicians' do
    @physicians = Physician.all
    erb :'physicians/list'
  end

  get '/physicians/search' do
    query = clean(params['physician'])
puts query.inspect
    @physicians = query ? Physician.all(query) : nil
    erb :'physicians/search'
  end

  private
  def clean(params)
    params ? params.symbolize_keys!.delete_if{|k, v| v.empty?} : nil
    params[:can_volunteer] = true if params && params[:can_volunteer] == 'on'
    params
  end

end