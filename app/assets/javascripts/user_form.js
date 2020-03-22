window.addEventListener('load', addEventBirthday);

function addEventBirthday()
{
    const days= document.getElementById("user_birthday_day");
    if(days)
    {
        const years = document.getElementById("user_birthday_year");
        const months = document.getElementById("user_birthday_month");
        years.addEventListener("change",user_birthday_selector);
        months.addEventListener("change",user_birthday_selector);
        user_birthday_selector(null);
    }
}

function user_birthday_selector(event)
{
    const days= document.getElementById("user_birthday_day");
    const years = document.getElementById("user_birthday_year");
    const months = document.getElementById("user_birthday_month");

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
