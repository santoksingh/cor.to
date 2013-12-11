Corto::Application.routes.draw do
  # segun si el usuario esta identificado o no la ruta raiz apuntara a
  # 'home/index' o a 'links/index'
  devise_scope :user do
    authenticated :user do
      root :to => 'links#index', :as => :authenticated_root
    end
    unauthenticated :user do
      root :to => 'home#index', :as => :unauthenticated_root
    end
  end

  # rutas para usuarios, gestionadas a traves de Devise (inicio de sesion,
  # recuperacion de password, etc...) y proporcionando todos las rutas basicas
  # de resources salvo index y show (esto es: new, create, edit, update y
  # destroy)
  devise_for :users
  resources  :users, :except => [:index, :show]

  # rutas para links (resources genera las 7 comunes: index, new, create, show,
  # edit, update y destroy), ademas se incluye un GET a favorites para el
  # listado de links favoritos, un PATCH a favorite/unfavorite para el
  # "marcado/desmarcado" como favorito y un get a search para realizacion de
  # busquedas
  resources :links do
    collection do
      get 'search'        # busqueda de links
      get 'favorites'     # listado de links favoritos
    end
    member do
      patch 'favorite'    # marca el link como favorito
      patch 'unfavorite'  # elimina el link de favoritos
    end
  end

  # rutas para clicks, todas devolveran un json
  get '/clicks/all/:id'     => 'clicks#all'     , :as => 'all_clicks'      # todos los clicks para un link concreto
  get '/clicks/week/:id'    => 'clicks#week'    , :as => 'week_clicks'     # clicks de la ultima semana agrupados por dias
  get '/clicks/month/:id'   => 'clicks#month'   , :as => 'month_clicks'    # clicks del ultimo mes agrupados por semanas
  get '/clicks/year/:id'    => 'clicks#year'    , :as => 'year_clicks'     # clicks del ultimo año agrupados por meses
  get '/clicks/browser/:id' => 'clicks#browser' , :as => 'browser_clicks'  # clicks totales agrupados por navegador
  get '/clicks/country/:id' => 'clicks#country' , :as => 'country_clicks'  # clicks totales agrupados por pais
  get '/clicks/referer/:id' => 'clicks#referer' , :as => 'referer_clicks'  # clicks totales agrupados por referer

  # ruta para redireccionamiento de links, toda peticion no gestionada por las
  # rutas anteriores caera en esta y se almacenara el recurso solicitado en el
  # parametro :in_url, accesible en los controladores "desde params[:in_url]",
  # todas ellas se redireccionaran a 'links/go', asi una peticion a "/asd" se
  # redigira a "links/go" con el parametro :in_url = "asd", para que la
  # gestione de forma adecuada
  get '/:in_url' => 'links#go', :as => 'link_go'
end
