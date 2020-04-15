function buildCategoryForm(select, form_id){
  $.each(select, function(index, val){
    var html = `<option value="${val.id}">${val.name}</option>`
    console.log(html);
    console.log(form_id);
    $(form_id).append(html);
  });
}


$(document).on ('turbolinks:load',function(){
  //大カテゴリーが選択された時の動作
  $(function(){
    $("#category_parent_area").click(function() { //大カテゴリーの選択ボックスをクリックすると選択肢が追加される
      $.each(gon.roots, function(index, val){
        var html = `<option value="${val.id}">${val.name}</option>`
        $("#category_parent_area").append(html);
      });
    });
    $("#category_parent_area").change(function(){
      $("#category_child_area").empty();
      $("#category_groundchild_area").empty();
      var parentId = $(this).val();
      var url = location.href;
      $.ajax({
        url: url,
        type: "GET",
        data: {category_id: parentId},
        dataType: 'json',
      })
      .done(function(p){
        $('#category_child_area').append(`<option value="">---選択してください---</option>`)
        $('#category_groundchild_area').append(`<option value="">---選択してください---</option>`)
        var html = buildCategoryForm(p.child, "#category_child_area");
      })
      .fail(function(){
        alart("エラー");
      })
    });
  });

  //中カテゴリーが選択された時の動作
  $(function(){
    $("#category_child_area").change(function(){
      $("#category_groundchild_area").empty();
      var childId = $(this).val();
      var url = location.href;
      $.ajax({
        url: url,
        type: "GET",
        data: {category_id: childId},
        dataType: 'json',
      })
      .done(function(c){
        $('#category_groundchild_area').append(`<option value="">---選択してください---</option>`)
        var html = buildCategoryForm(c.child, "#category_groundchild_area");
      })
      .fail(function(){
        console.log("カテゴリーの取得に失敗");
      })
    });
  });

  //小カテゴリーが選択された時の動作

});