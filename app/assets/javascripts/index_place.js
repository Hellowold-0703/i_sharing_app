$(document).on('turbolinks:load', function() {
  var btn = $(".like-link");
  btn.click(function() {
    btn.removeClass('active');
    $(this).addClass('active');
    $('.active .fa-heart').css("color", "red");
  });
 });