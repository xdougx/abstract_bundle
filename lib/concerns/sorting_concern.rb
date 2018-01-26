# Module to sort controller indexes
module SortingConcern
  extend ActiveSupport::Concern

  ORDER = 'name'.freeze
  SORT = 'ASC'.freeze
  CASE = true
  UNACCENT = true

  def setup_sorting
    current_order
    current_sort
    define_order
  end

  def ignore_case
    @ignore_case ||= params.key?(:ignore) ? get_boolean(params[:ignore]) : CASE
  end

  def ignore_unaccent
    @ignore_unaccent ||= params.key?(:unaccent) ? get_boolean(params[:unaccent]) : UNACCENT
  end

  def current_order
    @current_order ||= params.key?(:ord) ? params[:ord] : ORDER
  end

  def current_sort
    @current_sort ||= params.key?(:srt) ? params[:srt] : SORT
  end

  def define_order
    @current_order = "unaccent(#{@current_order})" if ignore_unaccent
    @current_order = "lower(#{@current_order})" if ignore_case
    @current_order
  end

  def current_ordenation
    "#{@current_order} #{@current_sort}"
  end

  def get_boolean(string)
    string == 'true' ? true : false
  end
end
