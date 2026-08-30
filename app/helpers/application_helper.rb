module ApplicationHelper
  def bootstrap_alert_class(key)
    case key
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-info'
    else
      'alert-info' # Default to info if the flash message type is unknown
    end
  end
end
