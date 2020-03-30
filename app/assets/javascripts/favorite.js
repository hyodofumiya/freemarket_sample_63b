window.addEventListener('turbolinks:load', addEventFavoriteWithAjax);

function addEventFavoriteWithAjax()
{
    const favorite_button= document.getElementById("favorite_button_for_js");
    if(favorite_button)
    {
        favorite_button.addEventListener("click", toggleFavorite);
    }
}

function toggleFavorite(event)
{
    
}