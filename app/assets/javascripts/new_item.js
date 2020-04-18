$(document).on ('turbolinks:load',function(){
  const buildFileField = (index)=> {
    const html = `<div data-index="${index}" class="input-area">
                    <input id="img-file-${index}" type= 'file' class="js-file"
                    name="item[images_attributes][${index}][photo]"style="display:none">
                  </div>`;
    return html;
  }
  var fileIndex = [1,2,3,4,5,6,7,8,9]
  
  $('#image-box-1').on('change', '.js-file', function(e) {
    // fileIndexの先頭の数字を使ってinputを作る
    $('#image-box-1').append(buildFileField(fileIndex[0]));
    $('.img-label').prop('for', `img-file-${fileIndex[0]}`)
    fileIndex.shift();
     // 末尾の数に1足した数を追加する
     fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
    });
    
  //DataTransferオブジェクトで、データを格納する箱を作る
  var dataBox = new DataTransfer();
  //querySelectorでfile_fieldを取得
  var file_field = document.querySelector('input[type=file]')
  //fileが選択された時に発火するイベント
  $('#image-box-1').on('change', '.js-file', function(e) {
  
    //選択したfileのオブジェクトをpropで取得
    var file = $('input[type="file"]').prop('files')[0];
    $.each(this.files, function(i, file){
      //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
      var fileReader = new FileReader();

      //DataTransferオブジェクトに対して、fileを追加
      dataBox.items.add(file)
      //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
      file_field.files = dataBox.files

      var num = $('.item-image').length + 1 + i
      fileReader.readAsDataURL(file);
     //画像が5枚になったら超えたらドロップボックスを削除する
      if (num == 5){
        $('#image-box__container').css('display', 'none')   
      }

      fileReader.onloadend = function() {
        var src = fileReader.result
        var html= `
                  <div class="item-image" data-image="${file.name}">
                    <div class="item-image__content">
                      <div class="item-image__content--icon">
                        <img src=${src} width="114" height="80" >
                      </div>
                      <div class="item-image__operetion">
                        <div class="item-image__operetion--delete">
                        削除
                        </div>
                      </div>
                    </div>
                  </div>
                  `
        //image_box__container要素の前にhtmlを差し込む
        $('#image-box__container').before(html);
      };
      //image-box__containerのクラスを変更し、CSSでドロップボックスの大きさを変えてやる。
      $('#image-box__container').attr('class', `item-num-${num}`)
    });
  });

//削除ボタンをクリックすると発火するイベント
$(document).on("click", '.item-image__operetion--delete', function(){
  //削除を押されたプレビュー要素を取得
  var target_image = $(this).parent().parent().parent()
  //削除を押されたプレビューimageのfile名を取得
  var target_name = $(target_image).data('image')
  //プレビューがひとつだけの場合、file_fieldをクリア
  var preview_images = document.getElementsByClassName("item-image").lenght
  if(preview_images==1){
    //inputタグに入ったファイルを削除
    $('input[type=file]').val(null)
    dataBox.clearData();
    console.log(dataBox)
  }else{
    //プレビューが複数の場合
    $.each( preview_images, function(i,input){
      //削除を押された要素と一致した時、index番号に基づいてdataBoxに格納された要素を削除する
      if(input.name==target_name){
        dataBox.items.remove(i) 
      }
    })
    //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に再度代入
    if(dataBox.files.length > 0){
    file_field.files = dataBox.files
    }
  }
  //プレビューを削除
  target_image.remove()
  //image-box__containerクラスをもつdivタグのクラスを削除のたびに変更
  var num = $('.item-image').length
  $('#image-box__container').show()
  $('#image-box__container').attr('class', `item-num-${num}`)
})


// $(document).on("click", '.item-image__operetion--delete', function(){
//   //プレビュー要素を取得
//   var target_image = $(this).parent().parent()
//   //プレビューを削除
//   target_image.remove();
//   //inputタグに入ったファイルを削除
//   file_field.val("")
// })
});