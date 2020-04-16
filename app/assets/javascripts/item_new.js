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
      $(".main__showmain__detail__categoryarea__grandchild").hide();
      $("#category_grandchild_area").empty();
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
        $('.main__showmain__detail__categoryarea__child').show();
        $('#category_grandchild_area').append(`<option value="">---選択してください---</option>`)
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
  
});