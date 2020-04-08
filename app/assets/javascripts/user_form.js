const ID_JUDGE_FOR_DO_APPLAY = "user_form";//このファイルに記載のあるイベントを適用するかの判断を行うためのID

//=============誕生日入力欄用ID==================
    const ID_INPUT_YEAR = "user_birthday_year";
    const ID_INPUT_MONTH = "user_birthday_month";
    const ID_INPUT_DAY = "user_birthday_day";

window.addEventListener('turbolinks:load', addEventUserForm);

function addEventUserForm()
{
    if(document.getElementById(ID_JUDGE_FOR_DO_APPLAY))
    {
        addEventToBirthday();
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
