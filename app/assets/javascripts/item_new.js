function buildCategoryForm(select, form_id){                                  //jsonで受け取ったparamsをselectとして中身を順にセレクトボックスに追加していく
  $.each(select, function(index, val){
    var html = `<option value="${val.id}">${val.name}</option>`
    $(form_id).append(html);
  });
};

function hideSizeForm(){                                                      //サイズ選択のフォームを非表示にして選択不可能にする
  $('.main__showmain__detail__size').hide();
  $('.main__showmain__detail__sizearea').hide();
  document.getElementById('form_size_area').setAttribute("disabled", "true");
}

$(document).on ('turbolinks:load',function(){
  //大カテゴリーが選択された時の動作
  $(function(){ 
    $("#category_parent_area").click(function() {                             //大カテゴリーの選択ボックスをクリックすると選択肢が追加される
      hideSizeForm();
      $.each(gon.roots, function(index, val){
        var html = `<option value="${val.id}">${val.name}</option>`
        $("#category_parent_area").append(html);
      });
    });
    $("#category_parent_area").change(function(){                           //大カテゴリーの内容が変更された時、中カテゴリーの中身を削除する
      $("#category_child_area").empty();                                    //中カテゴリーフォームの中身を削除
      $(".main__showmain__detail__categoryarea__grandchild").hide();        //小カテゴリーを非表示にする
      $("#category_grandchild_area").empty();                               //小カテゴリーフォームの中身を削除
      var parentId = $(this).val();                                         //選択された大カテゴリーのidを”parentID”として宣言
      var url = location.href;                                              //ajaxで戻る時に必要なurlを”url”として宣言
      $.ajax({                                                              //ajaxで交信
        url: url,
        type: "GET",
        data: {category_id: parentId},
        dataType: 'json',
      })
      .done(function(p){
        $('#category_child_area').append(`<option value="">---選択してください---</option>`)
        $('.main__showmain__detail__categoryarea__child').show();
        $('#category_grandchild_area').append(`<option value="">---選択してください---</option>`)
        var html = buildCategoryForm(p.child, "#category_child_area");        //ajaxで送られてきた値を元に中カテゴリーフォームの選択肢を作成
      })
      .fail(function(){
        alart("エラー");
      })
    });
  });

  //中カテゴリーが選択された時の動作
  $(function(){
    $("#category_child_area").change(function(){
      hideSizeForm();
      $("#category_grandchild_area").empty();
      var childId = $(this).val();
      var url = location.href;
      $.ajax({
        url: url,
        type: "GET",
        data: {category_id: childId},
        dataType: 'json',
      })
      .done(function(c){
        $('#category_grandchild_area').append(`<option value="">---選択してください---</option>`)
        $('.main__showmain__detail__categoryarea__grandchild').show();
        var html = buildCategoryForm(c.child, "#category_grandchild_area");
      })
      .fail(function(){
        alart("エラー");
      })
    });
  });

  //小カテゴリーが選択された時の動作
  $(function(){
    $('#category_grandchild_area').change(function(){
      var grandchildId = $(this).val();
      var url = location.href;
      $.ajax({
        url: url,
        type: "GET",
        data: {category_id: grandchildId},
        dataType: 'json',
      })
      .done(function(g){                                                        //ajaxで小カテゴリーで選択されたカテゴリー情報を受け取る
        var selfcategory = g.selfcategory                                       //小カテゴリーで選択したカテゴリーの情報を"selfcategory"として宣言
        if (selfcategory.size){                                                 //小カテゴリーで選択したカテゴリーがsize:trueだった場合、サイズ入力フォームを表示させる
          $('.main__showmain__detail__size').show();
          $('.main__showmain__detail__sizearea').show();
          document.getElementById('form_size_area').removeAttribute("disabled");
        };
      })
      .fail(function(){
        alart("エラー");
      })
    });
  });
});