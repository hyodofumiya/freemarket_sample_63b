const ID_COMMENT_FIELD = "comment_field_for_js"//コメントフィールドがあると判断するためのid。このidにイベントハンドラを設定
const ID_COMMENT_SEND_BUTTON = "comment_send_button_for_js"//コメント送信ボタンのid。イベント発生時にこのボタンの有効無効を切り替えする。

window.addEventListener('turbolinks:load', addEventComment);

function addEventComment()
{
    const comment_field= document.getElementById(ID_COMMENT_FIELD);
    if(comment_field)
    {
        comment_field.addEventListener("input", commentSendButtonToggle);//テキストボックスの入力に対してハンドラを設定
    }
}

function commentSendButtonToggle()
{
    const comment_field = document.getElementById(ID_COMMENT_FIELD);
    const send_button = document.getElementById(ID_COMMENT_SEND_BUTTON);
    if(comment_field.value)//テキストボックス内が空ならボタンを押せないようにする。(disabled属性を付与)
    {
        console.log("button is not disabled");
        send_button.disabled = false;
    }
    else
    {
        console.log("button is disabled");
        send_button.disabled = true;
    }
}