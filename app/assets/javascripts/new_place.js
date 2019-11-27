$(document).on('turbolinks:load', function() {
   
  $(".file").on('change', function(){
    var fileprop = $(this).prop('files')[0],
        find_img = $(this).parent().find('img'),
        filereader = new FileReader(),
        view_box = $(this).parent('.view_box');
    
  if(find_img.length ){
      find_img.nextAll().remove();
      find_img.remove();
  }
  var img = '<div class="img_view"><img alt="" class="img"><p><a href="#" class="img_del">削除</a></p></div>';
  
  view_box.append(img);

  filereader.onload = function() {
    view_box.find('img').attr('src', filereader.result);
    img_del(view_box);
  }
  filereader.readAsDataURL(fileprop);
  });
    
  if(window.gon != null) {

    var img = $('<div class="img_view"><img alt="" class="img"><p><a href="#" class="img_del">削除</a></p></div>');
    
    var binary_data1 = gon.image1
    
    img.find("img").attr({
      src: "data:image/jpeg;base64," + binary_data1
    });
    $(".view_box:first").append(img);
    img_del($(".view_box:first"));
  
    var img = $('<div class="img_view"><img alt="" class="img"><p><a href="#" class="img_del">削除</a></p></div>');
    
    if(gon.image2){
    var binary_data2 = gon.image2
    img.find("img").attr({
      src: "data:image/jpeg;base64," + binary_data2
    });
    $(".view_box:nth-child(2)").append(img);
    img_del($(".view_box:nth-child(2)"));
    }

    var img = $('<div class="img_view"><img alt="" class="img"><p><a href="#" class="img_del">削除</a></p></div>');
    
    if(gon.image3){
    var binary_data3 = gon.image3
    img.find("img").attr({
      src: "data:image/jpeg;base64," + binary_data3
    });
    $(".view_box:nth-child(3)").append(img);
    img_del($(".view_box:nth-child(3)"));
    }

    var img = $('<div class="img_view"><img alt="" class="img"><p><a href="#" class="img_del">削除</a></p></div>');
    
    if(gon.image4){
    var binary_data4 = gon.image4
    img.find("img").attr({
      src: "data:image/jpeg;base64," + binary_data4
    });
    $(".view_box:nth-child(4)").append(img);
    img_del($(".view_box:nth-child(4)"));
    }
  }
  
  function img_del(target){
  target.find("a.img_del").on('click',function(){
    var self = $(this),
        parentBox = self.parent().parent().parent();
    if(window.confirm('画像を削除します。\nよろしいですか？')){
      setTimeout(function(){
        parentBox.find('input[type=file]').val('');
        parentBox.find('.img_view').remove();
      } , 0);            
    }
    return false;
  });
  } 
}); 