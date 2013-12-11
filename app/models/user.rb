class User < ActiveRecord::Base
  # un usuario tiene muchos links
  has_many :links

  # modulos de Devise, ver:
  # http://rubydoc.info/github/plataformatec/devise/master/Devise/Models
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # los emails de los usuarios no puedan ser modificados tras la
  # creacion
  validates :email, :immutable => true
end
