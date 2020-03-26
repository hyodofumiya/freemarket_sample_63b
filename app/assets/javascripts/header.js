//カーソルがカテゴリーボタンに乗った時親カテゴリーを表示
$(function(){
  $(".header_zone_left_btns__category").mouseover(function(){
    $(".parent_category_list").appendTo(".header_category_list__parent");
  });
});
//カーソルが親カテゴリーに乗った時子カテゴリーを表示
$(function(){
  $(".parent_category_name").mouseover(function(){
    child = ($(this).children("ul"));
    child.appendTo(".header_category_list__child");
  });
});
//カーソルが小カテゴリーにのった時に孫カテゴリーを表示
$(function(){
  $(".child_category_name").mouseover(function(){
    grandchild = ($(this).children("ul"));
    grandchild.appendTo(".header_category_list__grandchild");
  })
})