# ClicksController solo devolvera contenido via JSON, para ser procesado por
# cualquier cliente que lo desee. En el caso de la aplicacion web, la vista
# links/show.html realiza peticiones GET que seran procesadas por este
# controlador, y mostrar las graficas con los JSON obtenidos, se evita asi que
# la pagina tarde en cargar cando se manejan muchos datos para el
# procesamiento, puesto que estos seran solicitados tras la carga "basica".
class ClicksController < ApplicationController
  # todas las acciones requieren que el usuario este identificado
  before_action :authenticate_user!

  # todas las cciones requieren un link almacenado en @link, que sera creado a
  # partir del parametro recibido
  before_action :set_link

  # devuelve todos los clicks asociados a un link concreto
  def all
    render :json => @link.clicks, :except => [ :id, :updated_at, :link_id ]
  end

  # devuelve el numero de clicks que un enlace concreto ha recibido en la
  # ultima semana, agrupados por dia de semana
  def week
    render :json => @link.clicks.created_last_week.group_by_day_of_week(:created_at).count
  end

  # devuelve el numero de clicks que un enlace concreto ha recibido en el
  # ultimo mes, agrupados por semana
  def month
    render :json => @link.clicks.created_last_month.group_by_week(:created_at).count
  end

  # devuelve el numero de clicks que un enlace concreto ha recibido en el
  # ultimo año, agrupados por meses
  def year
    render :json => @link.clicks.created_last_year.group_by_month(:created_at).count
  end

  # devuelve el numero de clicks que un link concreto ha recibido a lo largo
  # de su existencia, agrupados por navegador
  def browser
    render :json => @link.clicks.group(:browser).count
  end

  # devuelve el numero de clicks que un link concreto ha recibido a lo largo
  # de su existencia, agrupados por pais
  def country
    render :json => @link.clicks.group(:country).count
  end

  # devuelve el numero de clicks que un link concreto ha recibido a lo largo
  # de su existencia, agrupados por referer
  def referer
    render :json => @link.clicks.group(:referer).count
  end

  private

    # carga en @link el link identificado por el id recibido como parametro, si
    # no se encuentra devuelve al cliente un JSON vacio
    def set_link
      unless @link = current_user.links.where(:id => params[:id]).first
        render json: :no_content
      end
    end
end
