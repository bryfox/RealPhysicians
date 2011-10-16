class Controller < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/about' do
    erb :about
  end

  get '/physicians' do
    @physicians = Physician.find clean(params['physician'])
    erb :'physicians/list'
  end

  get '/physicians/search' do
    erb :'physicians/search'
  end

  private
  def clean(params)
    params ? params.symbolize_keys!.delete_if{|k, v| v.empty?} : nil
    params[:can_volunteer] = true if params && params[:can_volunteer] == 'on'
    params[:hourly_fee] = params[:hourly_fee].match(/\d+/)[0] if params[:hourly_fee]
    params
  end

end