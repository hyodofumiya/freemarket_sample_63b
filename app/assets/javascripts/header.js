//カーソルがカテゴリーボタンに乗った時大カテゴリーを表示
$(document).on ('turbolinks:load',function(){
  $(function(){
    $(".header_zone_left_btns__category").hover(
    function(){
      $(this).children("a").css("color", "#2483ff").css("font-weight", "bolder");
      $(".parent_category_list").show();
    },
    function(){
      $(".parent_category_list").hide();
      $(this).children("a").css("color","").css("font-weight", "");
    });
  });

  //カーソルが大カテゴリーに乗った時中カテゴリーを表示
  $(function(){
    $(".parent_category_name").hover(function(){
      child = $(this).children("ul");
      $(this).css("background-color", "#66ccff");
      $(this).children("a").css("color", "#fff").css("font-weight", "bold");
      child.show();
    },function(){
      $(this).css("background-color", "");
      $(this).children("a").css("color", "").css("font-weight", "");
      child.hide();
    });
  });

  //カーソルが中カテゴリーにのった時に小カテゴリーを表示
  $(function(){
    $(".child_category_name").hover(function(){
      child = ($(this).children("ul"));
      $(this).css("background-color", "#cceeff"); 
      child.show();
    },function(){
      $(this).css("background-color", "");
      child.hide();
    });
  });

  //カーソルが小カテゴリーにのった時の表示切り替え
  $(function(){
    $(".grandchild_category_name").hover(function(){
      $(this).css("background-color", "#cceeff");
    },function(){
      $(this).css("background-color", "");
    });
  });
});