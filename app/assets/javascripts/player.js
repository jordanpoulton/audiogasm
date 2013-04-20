$(function() {

$('.album').on('mouseenter', function (){
    $('.player').fadeIn();
    $('.playing-text').fadeIn();
  });

$('.album').on('mouseleave', function (){
    $('.player').fadeOut();
    $('.playing-text').fadeOut();
   
  });

})
