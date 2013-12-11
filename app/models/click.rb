class Click < ActiveRecord::Base
  # TODO: utilizar el "geocoded_by" de RubyGeocoder, y asi no almacenar el pais
  # solamente, sino tambien latitud y longitud de forma sencilla (sin tener que
  # meterlos "a mano", que lo haga geogoder por su cuenta) y poder realizar una
  # representacion mas correcta con los datos en un WebGL Globe
  # (http://www.chromeexperiments.com/globe), que queda mas chulo que unas
  # graficas simplotas

  # cada click pertenece a un link
  belongs_to :link

  # valida que el par (ip, created_at) debe sea unico
  validates_uniqueness_of :ip, :scope => [:created_at]

  # valida que ip y navegador esten presentes siempre
  validates :ip, :browser, :presence => true

  # valida que IP, navegador, pais y referer sean inmutables
  validates :ip, :browser, :country, :referer, :immutable => true

  # devuelve los clicks realizados en la ultima semana
  def self.created_last_week
    where('created_at >= ?', 1.week.ago)
  end

  # devuelve los clicks realizados en el ultimo mes
  def self.created_last_month
    where('created_at >= ?', 1.month.ago)
  end

  # devuelve los clicks realizados en el ultimo año
  def self.created_last_year
    where('created_at >= ?', 1.year.ago)
  end

end
