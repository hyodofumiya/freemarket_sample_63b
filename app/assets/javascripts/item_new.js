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
    $("#category_parent_area").change(function(){
      var parentId = $(this).val();
      var url = location.href;
      $.ajax({
        url: url,
        type: "GET",
        data: {category_id: parentId},
        dataType: 'json',
      })
      .done(function(p){
        var html = buildCategoryForm(p.child, "#category_child_area");
      })
      .fail(function(){
        console.log("カテゴリーの取得に失敗");
      })
    });
  });

  //中カテゴリーが選択された時の動作
  $(function(){
    $("#category_child_area").change(function(){
      var childId = $(this).val();
      var url = location.href;
      $.ajax({
        url: url,
        type: "GET",
        data: {category_id: childId},
        dataType: 'json',
      })
      .done(function(c){
        var html = buildCategoryForm(c.child, "#category_groundchild_area");
      })
      .fail(function(){
        console.log("カテゴリーの取得に失敗");
      })
    });
  });
});