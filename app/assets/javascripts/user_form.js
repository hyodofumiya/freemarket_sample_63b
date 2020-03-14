const ID_JUDGE_FOR_DO_APPLAY = "user_form";//このファイルに記載のあるイベントを適用するかの判断を行うためのID

//=============誕生日入力欄用ID==================
    const ID_INPUT_YEAR = "user_birthday_year";
    const ID_INPUT_MONTH = "user_birthday_month";
    const ID_INPUT_DAY = "user_birthday_day";

//=============フォームスクロール用ID==================
    const ID_SCROLL_AREA = "scroll_form_area";
    const ID_FORM_SCROLL_BUTTON = "next_button";
    //------------CSS適用用クラス---------------------
    const CLASS_CURRENT_SCROLL_IS_UPPER = "scroll_form_area--up";
    const CLASS_CURRENT_SCROLL_IS_LOWER = "scroll_form_area--down";
    //------------文字詳細変更用ID--------------------
    const ID_FORM_AREA_TITLE = "form_area_title";

window.addEventListener('load', addEventUserForm);

function addEventUserForm()
{
    if(document.getElementById(ID_JUDGE_FOR_DO_APPLAY))
    {
        addEventToBirthday();
        if(document.getElementById(ID_FORM_SCROLL_BUTTON))
        {
            addEventToFormScroll();
        }
    }
}

function addEventToBirthday()
{
        //誕生日ボタンのイベント設定
        const years = document.getElementById(ID_INPUT_YEAR);
        const months = document.getElementById(ID_INPUT_MONTH);
        years.addEventListener("change",userBirthdaySelector);
        months.addEventListener("change",userBirthdaySelector);
        userBirthdaySelector(null);
}

function addEventToFormScroll()
{
    //フォームスクロール機能のイベント設定
    const next_button = document.getElementById(ID_FORM_SCROLL_BUTTON);
    next_button.addEventListener("click", userFormScroll);
}

function userBirthdaySelector(event)
{
    const years = document.getElementById(ID_INPUT_YEAR);
    const months = document.getElementById(ID_INPUT_MONTH);
    const days= document.getElementById(ID_INPUT_DAY);

    const user_birthday = Number(days.getAttribute('data-birthday'));
    let last_day = new Date(years.value, months.value, 0);
    while(days.firstChild)
    {
        days.removeChild(days.firstChild);
    }
    for(i = 1; i <= last_day.getDate(); i++)
    {
        let option = document.createElement("option");
        option.value = i;
        option.text = i;
        if(user_birthday == option.value)
        {
            option.selected = true;
        }
        days.append(option);
    }
}

function userFormScroll(event)
{
    let scroll_area_classList = document.getElementById(ID_SCROLL_AREA).classList;
    if(scroll_area_classList.contains(CLASS_CURRENT_SCROLL_IS_LOWER))//現在地が下なら
    {//上へスクロールする処理
        scroll_area_classList.remove(CLASS_CURRENT_SCROLL_IS_LOWER);
        scroll_area_classList.add(CLASS_CURRENT_SCROLL_IS_UPPER);
        document.getElementById(ID_FORM_SCROLL_BUTTON).textContent = "次へ";
        document.getElementById(ID_FORM_AREA_TITLE).textContent = "新規会員登録";
    }
    else
    {//下へスクロールする処理
        scroll_area_classList.remove(CLASS_CURRENT_SCROLL_IS_UPPER);
        scroll_area_classList.add(CLASS_CURRENT_SCROLL_IS_LOWER);
        document.getElementById(ID_FORM_SCROLL_BUTTON).textContent = "前へ";
        document.getElementById(ID_FORM_AREA_TITLE).textContent = "発送先住所登録";
    }
    
}