
//dynamic_image_zoneの表示画像切り替え機能
$(function(){
  $(".static_images__an_item_image_zone--image").click(function(){
    //ユーザーがクリックした画像のURLを取得
    var itemImagesUrl = $(this).attr("src");
    //画像を大きく表示するエリアの画像URLを置き換える
    $(".dynamic_image_zone--selected_image").attr("src", itemImagesUrl);
  });
});