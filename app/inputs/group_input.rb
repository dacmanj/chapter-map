class GroupInput < SimpleForm::Inputs::CollectionInput
  def input(wrapper_options = nil)
    input_html_options[:class].push(:select).push("form-control".to_sym)
    @builder.select @attribute_name, grouped_collection, input_options, input_html_options
  end

  private

  def grouped_collection
    collection.group_by{ |d| d[group_method]}.map{|k,v| [k,v.map{|l| [l.name,l.id]}]}.sort_by{|k,v| k || "" }
  end

  def group_method
    @group_method ||= options.delete(:group_method)
  end

end
