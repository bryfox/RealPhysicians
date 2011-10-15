class Controller < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/physicians' do
    @physicians = Physician.all
    erb :'physicians/list'
  end

end