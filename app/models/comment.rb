class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :item

    validates :comment, presence: true

    def created_at#今日なら時間を、昨日以降なら何日前かを返す。
        time = super
        diff_today = Date.today.day - time.day
        if diff_today == 0
            return time.strftime("%H:%M")
        else
            return "#{diff_today}日前"
        end
    end
end
