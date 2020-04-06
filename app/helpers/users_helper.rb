module UsersHelper

    def option_birthday_years(years_ago = 100)
        current_year = Date.today.year - years_ago + 1
        years_ago.times do |i|
            yield( i + current_year )
        end
    end

    def birthday_selector_of_year(user, year)
        if user.persisted?
            return "selected" if user.birthday_year == year
        else
            return "selected" if (Date.today.year - 30) == year
        end
    end
        
end
