$(document).on("turbolinks:load", function(){
  $('.delete-btn').on('click', function(e) {
    e.preventDefault()
    if(window.confirm('画像を削除します。\nよろしいですか？')){
      var Click = $(this);
      var image_id = $(this).data('imgid');
      $.ajax({
        type: "DELETE",
        url: '/api/destroy/image_destroy',
        data: {img_id: image_id},
        dataType: 'json'
      })
      .done(function() {
        Click.parent('.img_view').next('input[type="hidden"]').remove('');
        Click.parent().remove();
      })
      .fail(function() {
        alert('削除に失敗しました');
      })
    }
  });
});