
//ページが読み込まれた時、画像リストの最初の要素に"selected_image"クラスを追加
$(document).on ('turbolinks:load',function(){
  $(".static_images__an_item_image_zone--image:first").addClass("selected_image");
});

//dynamic_image_zoneの表示画像切り替え機能
$(document).on ('turbolinks:load',function(){
  $(".static_images__an_item_image_zone--image").click(function(){
    //選択された画像の要素を取得
    var selectedImage = $(this);
    //ユーザーがクリックした画像のURLを取得
    var itemImagesUrl = $(this).attr("src");

    //直前まで選択されていた画像から”selected_image”クラスを消す
    $(".selected_image").removeClass("selected_image");
    //選択された画像に"selected_image"クラスを追加し、画像を大きく表示するエリアの画像URLを置き換える
    $(selectedImage).addClass("selected_image");
    $(".dynamic_image_zone--selected_image").attr("src", itemImagesUrl);
  });
});