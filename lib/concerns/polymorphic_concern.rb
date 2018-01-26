# Module to get the current and available class and its instance
module PolymorphicConcern
  extend ActiveSupport::Concern

  included do
    attr_reader :klasses
  end

  def model
    current_klass.find(current_id)
  end

  def current_klass
    get_klass(params[:kind])
  end

  def current_id
    params[get_class_id_attribute]
  end

  def check_type!
    return if params[:kind].present? && defined_model?
    raise_kind_not_found
  end

  def current_status
    status = params.fetch(:status)
    status.blank? ? 'all' : status
  end

  def get_klass(klass)
    raise_kind_not_found unless defined_model?
    klasses.at(klasses.index(klass)).constantize
  end

  def get_class_id_attribute
    defined_model? ? "#{params[:kind].underscore}_id" : raise_kind_not_found
  end

  def defined_model?
    klasses.include?(params[:kind])
  end

  def raise_kind_not_found
    kinds = klasses.to_sentence(two_words_connector: ', ', last_word_connector: ' e ')
    message = I18n.t('exceptions.model_not_found', kinds: kinds)
    raise Exceptions::Simple.build(message: message, field: :Tipo)
  end
end
