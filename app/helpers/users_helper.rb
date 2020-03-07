module UsersHelper

    def option_birthday_years(years_ago = 100)
        current_year = Date.today.year - years_ago + 1
        years_ago.times do |i|
            yield( i + current_year )
        end
    end
end
