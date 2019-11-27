$(document).on('turbolinks:load', function() {
  $(".place__list").animate({ scrollTop: $(".place__list")[0].scrollHeight});
});