# añade validacion para preservar la inmutabilidad de atributos en modelos
# uso, dentro del modelo:
#     validates :atr1, :atr2, :atr3, ..., :immutable => true
class ImmutableValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << I18n.t(:cannot_change) if record.send("#{attribute}_changed?") && !record.new_record?
  end
end
