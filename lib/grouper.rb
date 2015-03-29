# by David Pedersen (github: davidpdrsn)
class Grouper
  def initialize(things)
    @things = things
  end

  def group_by(*methods)
    first_method = methods.first
    rest_of_methods = methods[1..-1]

    partial_grouping = make_partial_grouping(first_method)

    if grouping_left_todo(rest_of_methods)
      group_by_remaining_methods(partial_grouping, *rest_of_methods)
    else
      partial_grouping
    end
  end

  private

  def make_partial_grouping(method)
    if @things.is_a? Hash
      group_each_value_by_method(method)
    else
      @things.group_by &method
    end
  end

  def group_by_remaining_methods grouping, *methods
    self.class.new(grouping).group_by(*methods)
  end

  def grouping_left_todo methods
    !methods.empty?
  end

  def group_each_value_by_method(method)
    @things.each do |key, values|
      @things[key] = group_by_remaining_methods(values, method)
    end
  end
end