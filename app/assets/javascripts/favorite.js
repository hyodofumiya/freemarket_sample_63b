// const ID_FAVORITE_BUTTON = "favorite_button_for_js";
// const ID_FAVORITE_COUNT = "favorite_count";
// const CLASS_CLICKED_FAVORITE = "btns__favorite__link--favorited";


// window.addEventListener('turbolinks:load', addEventFavoriteWithAjax);

// function addEventFavoriteWithAjax()
// {
//     const favorite_button = document.getElementById(ID_FAVORITE_BUTTON);
//     if(favorite_button)
//     {
//         favorite_button.addEventListener("click", toggleFavorite);
//     }
// }

// function toggleFavorite(event)
// {
//     const favorite_button_classList = document.getElementById(ID_FAVORITE_BUTTON).classList;//ボタンに定義されているクラス一覧
//     favorite_button_classList.contains(CLASS_CLICKED_FAVORITE) ? removeFavorite() : addFavorite() ;//既にfavoritedクラスが付与されていたら削除、なければ付与
// }

// function addFavorite()//お気に入りを追加する処理
// {
//     sendFavorite({type: "post"});
// }

// function removeFavorite()//お気に入りを削除する処理
// {
//     let delete_data = {}
//     delete_data.beforeSend = function(xhr)
//     {
//         xhr.setRequestHeader("X-CSRF-Token", $('meta[name="csrf-token"]').attr('content'))
//     }
//     delete_data.type = "delete";
//     sendFavorite(delete_data);
// }

// function sendFavorite(ajax_data)//非同期通信処理
// {
//     ajax_data.url = `${location.pathname}/favorite`;
//     ajax_data.dataType = "json";
//     $.ajax(ajax_data).done(favoriteSendSuccess).fail(favoriteSendError);
// }

// function favoriteSendSuccess(data)
// {
//     console.log(data);
//     const favorite_button_classList = document.getElementById(ID_FAVORITE_BUTTON).classList;
//     const count = document.getElementById(ID_FAVORITE_COUNT);
//     count.textContent = data.count;
//     if(data.current_users_favorite)
//     {
//         favorite_button_classList.add(CLASS_CLICKED_FAVORITE);
//     }
//     else
//     {
//         favorite_button_classList.remove(CLASS_CLICKED_FAVORITE);
//     }
// }

// function favoriteSendError()
// {

// }