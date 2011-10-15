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
    @physicians = query ? Physician.all(query) : nil
    erb :'physicians/search'
  end

  private
  def clean(params)
    params ? params.symbolize_keys!.delete_if{|k, v| v.empty?} : nil
  end

end