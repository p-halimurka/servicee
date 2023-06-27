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

  def calendar_disabled_days(month = nil)
    previous_month_last_day = if month
                                Date.new(Date.today.year, month) - 1.day
                              else
                                Date.today.at_beginning_of_month - 1.day
                              end
    last_disabled_day = Date.today - 1.day
    first_monday_to_display = previous_month_last_day.at_beginning_of_week
    disabled_days = if Date.today.month == month
                      first_monday_to_display..last_disabled_day
                    else
                      first_monday_to_display..previous_month_last_day
                    end
    if disabled_days.map(&:day).size == 7
      disabled_days = []
    end
    disabled_days
  end

  def calendar_active_dates(**args)
    today = Date.today
    first_month_day = Date.new(today.year, args[:month])
    last_month_day = first_month_day.at_end_of_month
    if args[:month] == today.month
      today..last_month_day
    else
      first_month_day..last_month_day
    end
  end

  def following_months
    Date::MONTHNAMES.map.with_index { |m, i| [m, i] }.reject { |arr| arr[1] < Date.today.month }
  end
end
