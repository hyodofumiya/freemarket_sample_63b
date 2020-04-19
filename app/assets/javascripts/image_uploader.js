//========================定数定義===========================
//頭にCLASSが入っていない物はIDとする。
//実際のhtmlに合わせてわかりやすいようにインデントしてある
const IMAGE_UPLOADER = "image_area_for_js";//画像とインプット要素が入るdiv要素
    const IMAGE_FIELDS = "image_input_field_for_js"//一つの画像のインプット要素と隠しフィールドが入っている単位。画像追加時にこのクラスが追加される
    const CLASS_IMAGE_FIELDS = "image_input_fields";//上記のクラス名
    const CLASS_FILE_FIELDS = "file_field@"//上記のクラス名。置き換えよう
    const FILE_FIELDS_NUMBER = "data-field-number"//上記フィールド番号。

        const FILE_AND_IMAGE_AREA = "image_input_fields_for_js@";
            //==============image_input_fields===========
                const CLASS_IMAGE_FILE_FIELD = "image_field_for_js";//ファイルフィールドのクラス名
                const IMAGE_FILE_FIELD = "item_images_attributes_@_photo"//上記のid。@は入れ替える
                const IMAGE_FILE_FIELD_NAME = "item[images_attributes][@][photo]";//上記のname属性。@は入れ替える

                const HIDDEN_FIELD = "item_images_attributes_@_photo_cache";//隠しフィールドのid。@は入れ替える
                const HIDDEN_FIELD_NAME = "item[images_attributes][@][photo_cache]";//上記のname属性。@は入れ替える
            //============item_image__content============
                const CLASS_IMAGE_AREA = "item-image__content";//画像タグと削除ボタンが入っているdivのクラス
                //======================画像=====================================
                const CLASS_DELETE_IMAGE_BUTTON = "item-image__operetion--delete";//削除ボタンのクラス
                const ATTR_FIELD_NUMBER = "data-field-number"//削除ボタンのカスタム属性

            const HIDDEN_IMAGE_FIELD = "item_images_attributes_@_id"//railsが標準で用意している隠しフィールド？
        //======file_and_field_area=================
            const IMAGE_FIELD_LABEL = "image_field_label_for_js";//イメージフィールドを指しているラベル

const IMAGE_FIELDS_COUNT = 5;
//===========================================================



var current_file_area = "";//画像の読み込み完了時にここの要素の子要素として画像を挿入する。グローバル変数
var field_numbers = [];


//onloadイベント
window.addEventListener('turbolinks:load', addEventImageUploader);

function addEventImageUploader()//イベントの定義をしているメソッド
{
    const image_uploader= document.getElementById(IMAGE_UPLOADER);
    if(image_uploader)
    {
        image_uploader.addEventListener("change", changedImageUploader);
        image_uploader.addEventListener("click", clickedDeleteButton);
        updateFieldNumber();
    }
}

function changedImageUploader(e)//input要素が変更されたときに呼び出されるイベント
{
    if (e.target.classList.contains(CLASS_IMAGE_FILE_FIELD))//クリックされた要素の中にFILE_FIELDのクラスが含まれていたら
    {
        let i = addImageFileField();//inputフィールドの追加。追加したフィールドのインデックスを返す       
        displayImageOfField(readLastFieldNumber());//画像フィールドの追加。インデックスがマイナス1なのは追加するイベントを起こした要素を指したいため
    }
}
//===============================画像追加ボタン押下時==============================================

function addImageFileField()//画像のinput要素を追加する関数
{
    let image_label = document.getElementById(IMAGE_FIELD_LABEL);//画像フィールドのラベルを取得
    let image_fields = document.getElementsByClassName(CLASS_IMAGE_FIELDS);//現状ページ内に存在している画像ファイルフィールドをクラス名からすべて取得
    let image_fields_counter = image_fields.length;

    if (image_fields_counter < IMAGE_FIELDS_COUNT)//イメージフィールドの個数が指定内なら
    {//指定の数-1までは追加動作。指定の数以上は追加しない&ラベル削除
        let html = create_image_input_fields(createFieldNumber());//追加する要素を取得。引数では現在の個数をわたしている(inputのidは0から始まっているので丁度いい)
        image_label.before(html);
        document.getElementById(IMAGE_FIELD_LABEL).classList.remove("display_none");
        image_label.setAttribute("for", html.firstElementChild.getAttribute("id"));//ラベルの指すフィールドの変更。追加した要素の最初のオブジェクトを指しているのでimage_input_fields関数の変更時注意
    }
    else
    {
        document.getElementById(IMAGE_FIELD_LABEL).classList.add("display_none");
    }
    return image_fields_counter//追加したフィールドのインデックスを返す(0から)
}

function displayImageOfField(num)//受け取った数値に対応する画像を表示
{
    const reader = new FileReader();//ファイルを読むためのクラスインスタンス生成。
    reader.addEventListener("load", displayImage);//ファイルの読み込み完了後に呼び出すイベント

    
    let file_and_image_area = document.getElementsByClassName(CLASS_FILE_FIELDS.replace(/@/, num))[0];
    let image_area = create_image_tag("");//画像なしのイメージタグ作成
    file_and_image_area.appendChild(image_area);//ファイルフィールドに追加しておく
    image_area.lastElementChild.setAttribute(ATTR_FIELD_NUMBER, num);
    current_file_area = image_area.firstElementChild;//イメージタグをグローバル変数に入れる。
    //このグローバル変数は画像読み込み完了時に画像を設定する要素

    let file_field = document.getElementById(IMAGE_FILE_FIELD.replace(/@/, num - 1));//ファイルフィールドを取得
    reader.readAsDataURL(file_field.files[0]);//読み込み
    //(上の引数について)ファイルを取得。返り値が配列で返ってくるため最初の要素を選択   
}

function displayImage(reader)
{
    current_file_area.src = reader.target.result;
}

//================削除ボタン押下時==============================================

function clickedDeleteButton(e)//削除ボタンが押されたときに呼ばれるイベント
{
    if (e.target.classList.contains(CLASS_DELETE_IMAGE_BUTTON) )
    {//クリックされた要素が削除ボタンなら
        let field_number = Number(e.target.getAttribute(ATTR_FIELD_NUMBER));//削除ボタンについているカスタム属性を数値にキャストして取得
        document.getElementsByClassName(CLASS_FILE_FIELDS.replace(/@/, field_number))[0].remove();
        let hidden_field = document.getElementById(HIDDEN_IMAGE_FIELD.replace(/@/, field_number));
        if(hidden_field)
        {
            hidden_field.remove();
        }
        addImageFileField();
    }
}

//================================その他関数==============================================

function updateFieldNumber()
{
    let image_fields = document.getElementsByClassName(CLASS_IMAGE_FIELDS);
    field_numbers = [];
    for(const image_field of image_fields)
    {
        field_numbers.push(Number(image_field.getAttribute(ATTR_FIELD_NUMBER)));
    }
    field_numbers.sort();
}

function createFieldNumber()//グローバル変数から判断して、追加すべき番号を返す
{
    result_number = readLastFieldNumber() + 1;//グローバル変数の配列の最後の値 + 1を返す
    field_numbers.push(result_number);
    return result_number;
}

function readLastFieldNumber()
{
    return field_numbers[field_numbers.length - 1]
}

function deleteFieldNumber(num)
{

}


//以下htmlの生成======================================================================================================

function create_image_input_fields(num)//inputフィールドの一つの単位を作成。定数でいうIMAGE_FIELDSを追加。
{//inputフィールドのnameとidはnumをもとに生成
    //IMAGE_FIELDSを作成。この中にinputが二つ入る。(file,hidden)
    let image_fields = document.createElement("div");
    image_fields.classList.add(CLASS_IMAGE_FIELDS);
    image_fields.setAttribute("id", IMAGE_FIELDS);

    //ファイルフィールドの定義
    let file_field = document.createElement("input");
    file_field.setAttribute("type", "file");
    file_field.setAttribute("style", "display:none");
    file_field.setAttribute("id", IMAGE_FILE_FIELD.replace(/@/, num));
    file_field.setAttribute("name", IMAGE_FILE_FIELD_NAME.replace(/@/, num));
    file_field.classList.add(CLASS_IMAGE_FILE_FIELD);

    //隠しフィールドの定義
    let hidden_field = document.createElement("input");
    hidden_field.setAttribute("type", "hidden");
    hidden_field.setAttribute("id", HIDDEN_FIELD.replace(/@/, num));
    hidden_field.setAttribute("name", HIDDEN_FIELD_NAME.replace(/@/, num));



    image_fields.appendChild(file_field);
    image_fields.appendChild(hidden_field);
    image_fields.classList.add(CLASS_FILE_FIELDS.replace(/@/, num));



    return image_fields;
}

function create_image_tag(image_url)
{
    //画像と削除ボタンのコンテナ
    let image_area = document.createElement("div");
    image_area.classList.add(CLASS_IMAGE_AREA);

    //image_tag
    let image_tag = document.createElement("img");
    image_tag.setAttribute("src", image_url);
    image_tag.setAttribute("width", "114");
    image_tag.setAttribute("height", "80");

    //削除ボタン
    let delete_button = document.createElement("div");
    delete_button.classList.add(CLASS_DELETE_IMAGE_BUTTON);
    delete_button.textContent = "削除";

    image_area.appendChild(image_tag);
    image_area.appendChild(delete_button);

    return image_area;
}