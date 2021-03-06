  require 'rubygems'
  require 'sinatra'
  require 'launchy'
  require 'socket'
  require 'yaml'

  configure do
    set :port, 41508
    
    @config = YAML.load_file('conf/config.yaml')
    
    set :username, @config['user']
    set :password, @config['pass']
    UKEY = @config['ukey']
    
    enable :sessions
  end
  
  
  before do

  end
  
  helpers do
    
    def protected!
      unless authorized?
        response['WWW-Authenticate'] = %(Basic realm="Testing HTTP Auth")
        throw(:halt, [401, "Not authorized\n"])
      end
    end
    
    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [options.username, options.password]
    end

  end
  
  
  get '/' do
    @hostname = Socket.gethostname.downcase
    erb :home
  end
  
  get "/open/#{UKEY}/*" do
    protected!
    Launchy.open("#{params[:splat]}")
    redirect params[:splat]
  end
  
  
  get '/clients' do
    protected!
    @ukey = UKEY
    @hostname = Socket.gethostname.downcase
    erb :clients
  end

  
  
  