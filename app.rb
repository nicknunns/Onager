  require 'rubygems'
  require 'sinatra'
  require 'launchy'
  require 'socket'
  
  configure do
    set :port, 41508
  end
  
  before do

  end
  
  helpers do
    def keygen
      rand.to_s[2..5].to_i
    end

  end
  
  
  get '/' do
    @hostname = Socket.gethostname.downcase
    erb :home
  end
  
  get '/open/*' do
    Launchy.open("#{params[:splat]}")
    redirect params[:splat]
  end
  
  get '/authorize' do
    # endpoint to get key generated on desktop side
  end
  
  get '/authorize/client' do
    # url where the mobile device will input the key
  end
  
  get '/clients' do
    # manage existing mobile devices
  end

  
  
  