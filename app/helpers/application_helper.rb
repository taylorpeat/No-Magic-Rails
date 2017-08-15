module ApplicationHelper

  def my_hidden_field_tag(name, value)
    "<input type='hidden' name='#{name}' value='#{value}' >".html_safe
  end

  def my_label_tag(txt)
    "<label>#{txt}</label>".html_safe
  end

  def my_text_field_tag(name, value)
    "<input name='#{name}' value='#{value}' type=text >".html_safe
  end

  def my_text_area_tag(name, value)
    "<textarea name='#{name}' value='#{value}'></textarea>".html_safe
  end

  def my_submit_tag(txt="Submit")
    "<input type='submit' value='#{txt}'>".html_safe
  end

  def my_form_tag(path, &block)
    attrs = "method='post' action='#{path}'"
    fields = capture(&block)
    "<form #{attrs}> #{my_authenticity_token_field} #{fields} </form>".html_safe
  end

  def my_authenticity_token_field
    my_hidden_field_tag('authenticity_token', form_authenticity_token)
  end

  def my_form_for(records, &block)
    @record = records.is_a?(Array) ? records.last : records
    fields = capture(self, &block)
    
    unless @record.new_record?
      fields += my_hidden_field_tag('_method', 'patch')
    end

    path  = url_for(records)
    attrs = "method='post' action='#{path}'"
    "<form #{attrs}> #{my_authenticity_token_field} #{fields} </form>".html_safe
  end

end

