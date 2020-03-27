//カーソルがカテゴリーボタンに乗った時親カテゴリーを表示
$(function(){
  $(".header_zone_left_btns__category").hover(
    function(){
      $(".parent_category_list").show();
      $(this).css("color", "#2483ff");
    },
    function(){
      $(".parent_category_list").hide();
      $(this).css("color","black");
    }
  );
});
//カーソルが親カテゴリーに乗った時子カテゴリーを表示
$(function(){
  $(".parent_category_name").hover(function(){
    child = $(this).children("ul");
    $(this).children("a").css("color", "#fff").css("font-weight", "bold");
    child.show();
  },function(){
    $(this).css("background-color", "");
    $(this).children("a").css("color", "");
    child.hide();
  });
});
//カーソルが小カテゴリーにのった時に孫カテゴリーを表示
$(function(){
  $(".child_category_name").hover(function(){
    child = ($(this).children("ul"));
    $(this).children("a").css("color","#66ccff").css("font-weight", "bold");    
    child.show();
  },function(){
    $(this).children("a").css("color", "");
    child.hide();
  });
});
//カーソルが孫カテゴリーにのった時の表示切り替え
$(function(){
  $(".grandchild_category_name").hover(function(){
    $(this).children("a").css("color", "#66ccff").css("font-weight", "bold");
  },function(){
    $(this).children("a").css("color","").css("font-weight","");
  })
})