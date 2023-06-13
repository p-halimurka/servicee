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
    first_monday_to_display = previous_month_last_day.at_beginning_of_week
    disabled_days = first_monday_to_display..previous_month_last_day
    if disabled_days.map(&:day).size == 7
      disabled_days = []
    end
    disabled_days
  end

  def calendar_active_dates(**args)
    first_month_day = if args[:month]
                        Date.new(Date.today.year, args[:month])
                      else
                        Date.today.at_beginning_of_month
                      end
    last_month_day = first_month_day.at_end_of_month
    first_month_day..last_month_day
  end

  def following_months
    Date::MONTHNAMES.map.with_index { |m, i| [m, i] }.reject { |arr| arr[1] < Date.today.month }
  end
end
