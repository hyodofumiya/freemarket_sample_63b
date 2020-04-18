function buildCategoryForm(select, form_id){                                  //jsonで受け取ったparamsをselectとして中身を順にセレクトボックスに追加していく
  $(form_id).empty();
  var normalMessage = `<option value="">---選択してください---</option>`;
  $(form_id).append(normalMessage);
  $.each(select, function(index, val){
    var html = `<option value="${val.id}">${val.name}</option>`;
    $(form_id).append(html);
  });
};

function hideSizeForm(){                                                      //サイズ選択のフォームを非表示
  $('#size_form_label').hide();
  $('#form_size_area').hide();
}

$(document).on ('turbolinks:load',function(){
  //大カテゴリーが選択された時の動作
  $(function(){ 
    $("#category_parent_area").click(function() {                             //大カテゴリーの選択ボックスをクリックすると選択肢が追加される
      var html = buildCategoryForm(gon.roots, "#category_parent_area");        //ajaxで送られてきた値を元に中カテゴリーフォームの選択肢を作成
    });
    $("#category_parent_area").change(function(){                           //大カテゴリーの内容が変更された時、中カテゴリーの中身を削除する
      hideSizeForm();
      $("#category_grandchild_area").hide();        //小カテゴリーを非表示にする
      $("#category_grandchild_area").empty();                               //小カテゴリーフォームの中身を削除
      var parentId = $(this).val();                                         //選択された大カテゴリーのidを”parentID”として宣言
      var url = location.href;                                              //ajaxで戻る時に必要なurlを”url”として宣言
      $.ajax({                                                              //ajaxで交信
        url: url,
        type: "GET",
        data: {category_id: parentId},
        dataType: "json"

      })
      .done(function(p){
        $('#category_child_area').show();
        $('#category_grandchild_area').append(`<option value="">---選択してください---</option>`)
        var html = buildCategoryForm(p.child, "#category_child_area");        //ajaxで送られてきた値を元に中カテゴリーフォームの選択肢を作成
      })
      .fail(function(jqXHR, textStatus, errorThrown){
        console.log("ajax通信に失敗しました");
        console.log("jqXHR          : " + jqXHR.status); // HTTPステータスが取得
        console.log("textStatus     : " + textStatus);    // タイムアウト、パースエラー
        console.log("errorThrown    : " + errorThrown.message); // 例外情報
        console.log("URL            : " + url);
      })
    });
  });

  //中カテゴリーが選択された時の動作
  $(function(){
    $("#category_child_area").click(function(){
      if (gon.p_category != null){
        var html = buildCategoryForm(gon.p_category, "#category_child_area");        //editアクションで中カテゴリーフォームの選択肢を作成
      }
    });

    $("#category_child_area").change(function(){
      hideSizeForm();
      var childId = $(this).val();
      var url = location.href;
      $.ajax({
        url: url,
        type: "GET",
        data: {category_id: childId},
        dataType: 'json',
      })
      .done(function(c){
        $('#category_grandchild_area').show();
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
          $('#size_form_label').show();
          $('#form_size_area').show();
        };
      })
      .fail(function(){
        alart("エラー");
      })
    });
  });
});