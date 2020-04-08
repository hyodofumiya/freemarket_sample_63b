class Prefectures
    require "csv"
    @@list = []

    #メソッドはオプションの引数でブロック変数の形式を選択できる。
    #形式はid→　都道府県コード, none_prefecture→　県なし, default→　県あり, kana→　かな, alphabet→　ローマ字
    VALUE_KIND = {id: 0, none_prefecture: 1, default: 2, kana: 3, alphabet: 4}


    def self.each_prefectures(value_kind: "default")#北海道から順にすべての都道府県をブロック変数としてブロックを実行する
        self.list.each do |prefecture_record|
            yield(prefecture_record[option_kind(value_kind)])
        end
    end
    def self.each_prefectures_with_index(value_kind: "default")#北海道から順にすべての都道府県をブロック変数としてブロックを実行する
        self.list.each_with_index do |prefecture_record, i|
            yield(prefecture_record[option_kind(value_kind)], i)
        end
    end

    def self.find(num, value_kind: "default")#引数で受け取った数値に該当する都道府県を返す。
        return nil if num.to_i < 0
        begin
            return self.list[num][option_kind(value_kind)]
        rescue NoMethodError, TypeError
            return nil
        end
    end

    def self.find_by(serch_hash)#受け取った引数に対するidを返す
        #kana: "ぐんま"のような形で呼び出す。引数はハッシュの一つ目以外は無視するので注意
        list = serch_list(serch_hash.first[0])
        id_from_list(list, serch_hash.first[1])
    end

    def self.array(value_kind: "default")
        result_array = []
        self.each_prefectures(value_kind: value_kind) do |prefecture|
            result_array << prefecture
        end
        return result_array
    end

    private
    def self.list#クラス変数用のアクセサ。最初に呼び出されたときだけcsvを読みだす。
        @@list = self.create_list if @@list.length == 0
        @@list
    end

    def self.create_list#csvを読みだしてCSV::ROW型の配列にして返す
        list = []
        CSV.open("#{Rails.root}/app/lib/todouhuken.csv", "r:BOM:UTF-8", headers: true) do |csv|
            csv.each do |record|
                list << record
            end
        end
        return list
    end

    def self.option_kind(value_kind)
        VALUE_KIND.fetch(value_kind.to_sym)
    end

    def self.serch_list(value_kind)
        list = []
        self.list.each do |record|
            list << record[option_kind(value_kind)]
        end
        return list
    end

    def self.id_from_list(list, value)
        list.each_with_index do |list_value, id|
            if list_value == value
                return id.to_i
            end
        end
        return nil
    end
end