module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-info'
    else
      flash_type.to_s
    end
  end

  def calendar_disabled_days
    first_month_day = Date.today.at_beginning_of_month - 1.day
    first_monday_to_display = first_month_day.at_beginning_of_week
    first_monday_to_display..first_month_day
  end

  def calendar_active_dates
    first_month_day = Date.today.at_beginning_of_month
    last_month_day = Date.today.at_end_of_month
    first_month_day..last_month_day
  end
end
