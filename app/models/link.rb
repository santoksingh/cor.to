class Link < ActiveRecord::Base
  # cada link pertenece a un usuario
  belongs_to :user

  # cada link tiene 0..N clicks
  has_many :clicks

  # crea la direccion corta siempre que se cree un nuevo link y, si no se ha
  # introductio un titulo, obtiene el de la direccion introducida
  before_create :create_inurl, :create_title

  # valida que la direccion original sea una URL existente
  validate  :out_url_exists

  # valida presencia de atributos obligatorios (url original e identificador de
  # usuario en posesion del link)
  validates :out_url, :user_id, :presence => true

  # valida que no existan dos direcciones cortas iguales
  validates :in_url, :uniqueness => true

  # valida que el propietario, la direccion corta y la direccion original no
  # sean modificables, permitiendo asi que de cada link se pueda solo modificar
  # el titulo y la descripcion
  validates :in_url, :out_url, :user_id, :immutable => true

  # marca como favorito el link actual (pone a true el atributo favorited) y
  # almacena el cambio en la base de datos
  def favorite
    self.favorited = true
    self.save!
  end

  # desmarca de favoritos el link actual (pone a false el atributo favorited) y
  # almacena el cambio en la base de datos
  def unfavorite
    self.favorited = false
    self.save!
  end

  # realiza una busqueda por titulo y descripcion, segun un termino (o
  # terminos) especificados, si no se proporciona terminos de busqueda,
  # devuelve todos los links
  def self.search(term)
    links = all
    links = where('title LIKE ? OR description LIKE ?', "%#{term}%", "%#{term}%") if term.present?
    links
  end


  private

    # crea direccion corta via SecureRandom, cada vez que se produzca una
    # colision aumenta @@nchars (atributo de clase/estatico) en 1
    def create_inurl
      @@nchars = 3
      begin
        self.in_url = SecureRandom.urlsafe_base64(@@nchars)
        @@nchars += 1
      end while Link.exists?(:in_url => in_url)
    end

    # si no se ha proporcionado un titulo, obtiene el del documento
    # especificado en :out_url, via Mechanize
    def create_title
      if title.blank?
        self.title = Mechanize.new.get(out_url).title
      end
    end

    # valida, via Mechanize, que la direccion proporcionada en out_url exista
    # de verdad
    def out_url_exists
      # si no se ha proporcionado protocolo, añade 'http://' delante de la
      # cadena de direccion introducida
      url = URI.parse(out_url)
      self.out_url = out_url.insert(0, 'http://') if url.scheme.nil?

      # intenta hacer un GET a la direccion, si no se obtiene respuesta o se
      # produce un error, Mechanize lanzara una excepcion que se capturara para
      # indicar al ususario que la direccion es incorrecta
      begin
        Mechanize.new.get(out_url)
      rescue ArgumentError, SocketError, Net::HTTPNotFound, Mechanize::ResponseCodeError, Mechanize::UnsupportedSchemeError
        errors[:out_url] << I18n.t(:not_valid_url, :default => I18n.t('links.not_url_err') )
      end
    end

end

