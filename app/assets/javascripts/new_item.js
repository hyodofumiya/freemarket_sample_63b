$(function(){
  //querySelectorでfile_fieldを取得
  var file_field = document.querySelector('input[type=file]')
  //fileが選択された時に発火するイベント
  $('#img-file').change(function(){
    //選択したfileのオブジェクトをpropで取得
    var file = $('input[type="file"]').prop('files')[0];
    //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
    var fileReader = new FileReader();
    //読み込みが完了すると、srcにfileのURLを格納
    fileReader.onloadend = function() {
      var src = fileReader.result      
      var html= `<div class='item-image' data-image="${file.name}">
             <div class=' item-image__content'>
               <div class='item-image__content--icon'>
                 <img src=${src} width="114" height="80" >
               </div>
             </div>
             <div class='item-image__operetion'>
               <div class='item-image__operetion--delete'>削除</div>
             </div>
           </div>`
      //image_box__container要素の前にhtmlを差し込む
      $('#image-box__container').before(html);
    }
    fileReader.readAsDataURL(file);
  });
});

$(document).on("click", '.item-image__operetion--delete', function(){
  //プレビュー要素を取得
  var target_image = $(this).parent().parent()
  //プレビューを削除
  target_image.remove();
  //inputタグに入ったファイルを削除
  file_field.val("")
})

