class LinksController < ApplicationController
  # todas las acciones requiere que el usuario este identificado, salvo la
  # realizada por el metodo "go" (el redireccionamiento)
  before_action :authenticate_user!, except: :go

  # cuasi-AOP para cargar el link especificado en el parametro ID de la
  # peticion (params[:id]) en la variable de instancia (atributo) @link,
  # "antes" de ejecutar los metodos "show", "edit", "update", "destroy",
  # "favorite" y "unfavorite"
  before_action :set_link, only: [:show, :edit, :update, :destroy, :favorite, :unfavorite]

  # carga en @base la url base de la peticion y en @highlight la palabra o
  # palabras buscadas (para marcarlas en el listado)
  before_action :set_base, only: [:index, :favorites, :show, :search]
  before_action :set_highlight, only: [:index, :favorites, :show, :search]

  # GET /1
  # GET /1.json
  # implementa el redireccionamiento de una direccion corta a la direccion
  # laga, se recibe en parametro "in_url" en la peticion y se redirecciona a la
  # direccion almacenada en la base de datos para dicho identificador de
  # direccion, ademas de almacenar toda la informacion necesaria del cliente en
  # la base de datos como un nuevo click para dicho link
  def go
    # busca el link con la direccion corta recibida en la peticion
    @link = Link.find_by_in_url(params[:in_url])

    # segun el formato de la peticion (html o json) responde, bien realizando
    # un redireccionamiento 301 a la direccion almacenada en la base de datos
    # para dicho link (@link.out_url), o devuelve un json con dicha direccion
    # si el link no ha sido encontrado, redirecciona a raiz (html) o devuelve
    # una respuesta HTTP vacia (json)
    respond_to do |format|
      if @link
        save_click
        format.html { redirect_to @link.out_url, status: :moved_permanently }
        format.json { render :json => @link, :only => 'out_url' }
      else
        format.html { redirect_to :authenticated_root }
        format.json { head :no_content }
      end
    end
  end

  # GET /links
  # GET /links.json
  # obtiene un listado de todos los links en posesion por el usuario
  # identificado en la aplicacion (current_user), y los pagina de 10 en 10,
  # para devolverlos segun la pagina solicitada en el parametro "page" de la
  # peticion
  def index
    # carga los links del usuario actual, de 10 en 10 y segun la pagina
    # solicitada, y ordenados de forma descendiente segun la fecha de creacion
    @links = current_user.links.paginate(:page => params[:page], :per_page => 10).order('created_at DESC');
  end

  # GET /favorites
  # GET /favorites.json
  def favorites
    @links = current_user.links.where(:favorited => true).paginate(:page => params[:page], :per_page => 10).order('created_at DESC');
  end

  # GET /links/search
  # GET /links/search?term='asd'
  # realiza una busqueda sobre los enlaces del propio usuario que contengan en
  # su titulo o descripcion la cadena especificada en el parametro "term", sino
  # se proporciona la cadena, devolvera todos los enlaces del usuario
  def search
    @links = current_user.links.search(params[:term]).paginate(:page => params[:page], :per_page => 10).order('created_at DESC');
  end

  # GET /links/1
  # GET /links/1.json
  # muestra el enlace actual, en la variable de instancia @link ya estara
  # cargado el link solicitado, gracias al before_action :set_link
  def show
  end

  # GET /links/new
  # carga en la variable de instancia @link un nuevo link a ser "rellenado"
  # desde el formulario de la vista (ver en app/views/links/new.html.haml)
  def new
    @link = current_user.links.new
  end

  # GET /links/1/edit
  # lo unico que debe hacer el metodo es cargar en la variable de instancia
  # @link el link que se desea editar, y ya lo hace por nosotros el
  # "before-action" de la linea 4, por tanto el metodo realmente no hara nada
  def edit
  end

  # POST /links
  # POST /links.json
  # almacena un nuevo link en la base de datos segun los parametros recibidos
  # desde el formulario renderizado en "new"
  def create
    # crea un nuevo link en base a los parametros recibidos
    @link = current_user.links.new(link_params)

    # segun el formato de la peticion (html o json) responde, bien realizando
    # un redireccionamiento al link (a "show") recien creado, añadiendo un
    # mensaje en el "flash" indicando que el link se ha creadi
    # satisfactoriamente, o muestra el json de la vista "show" (ver
    # app/views/links/show.json.jbuilder), devolviendolo con un HTTP 201
    # Created
    # si se produce algun error almacenando el nuevo link, no redirecciona sino
    # que "renderiza" de nuevo la vista "new" para mostrar los errores
    # ocurridos; si json, devuelve un json con los errores encontrados en un
    # HTTP 422 Unprocessable Entity
    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: I18n.t('links.create_ok') }
        format.json { render action: 'show', status: :created, location: @link }
      else
        format.html { render action: 'new' }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  # modifica los datos de un link concreto segun los nuevos datos que haya
  # recibido como parametros
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: I18n.t('links.update_ok') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1/favorite
  # PATCH/PUT /links/1/favorite.json
  # marca un link concreto como favorito, redireccionando acordemente tras ello
  def favorite
    @link.favorite
    respond_to do |format|
      format.html { redirect_to :back, notice: I18n.t('links.favorite_ok') }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /links/1/unfavorite
  # PATCH/PUT /links/1/unfavorite.json
  # desmarca un link concreto como favorito, redireccionadno acordemente tras
  # ello
  def unfavorite
    @link.unfavorite
    respond_to do |format|
        format.html { redirect_to :back, notice: I18n.t('links.unfavorite_ok') }
        format.json { head :no_content }
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  # realiza la eliminacion de un link, en @link estara cargado el link a
  # liminar (via before_action :set_link)
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url }
      format.json { head :no_content }
    end
  end

  private
    # carga en la variable de instancia @base la URL base actual, es decir, si
    # se recibe una llamada a index desde "http://localhost:3000/links/show/1",
    # @base almacenara "http://localhost:3000", si se realiza desde
    # "http://cor.to/links/show/1", almacenara "http://cor.to/"
    def set_base
      @base  = "#{request.protocol}#{request.host_with_port}/"
    end

    # guarda los terminos de busqueda en @highlight para poder marcarlos en el
    # listado de enlaces, si no se han proporcionado terminos de busqueda, sera
    # nulo
    def set_highlight
      @hilight   = nil
      @highlight = params[:term] if params[:term]
    end

    # carga en @link el link identificado por el id recibido como parametro,
    # si no se encuentra redirecciona al listado de enlaces con un mensaje de
    # error (alerta) en flash
    def set_link
      unless @link = current_user.links.where(:id => params[:id]).first
        redirect_to links_url, :alert => I18n.t('links.not_found_err')
      end
    end

    # marca como requerido el parametro link y como permitidos los parametros
    # title, description, out_url y favorited
    # ver http://edgeapi.rubyonrails.org/classes/ActionController/Parameters.html
    def link_params
      params.require(:link).permit(:title, :description, :out_url, :favorited)
    end

    # almacena los datos de un nuevo click para el link proporcionado en la
    # base de datos, obteniendo la informacion necesaria desde los datos de la
    # peticion recibida (almacenada en request) y parseando lo necesario
    # request.location.country es proporcionado por RubyGeocoder
    # (http://www.rubygeocoder.com/)
    # el parseo de request.user_agent a una cadena que identifique el navegador
    # correcto es proporcionado por el modulo UserAgent
    # (https://github.com/josh/useragent)
    def save_click
      ip      = request.remote_ip
      country = request.location.country
      browser = UserAgent.parse(request.user_agent).browser
      referer = URI(request.referer).host if request.referer
      click   = @link.clicks.new(:ip => ip, :country => country, :browser => browser, :referer => referer)
      click.save
    end
end
