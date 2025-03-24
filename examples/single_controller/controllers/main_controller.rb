class MainController < Sinatra::Staged::AppController

    get "/" do
        view :index
    end
   
end
