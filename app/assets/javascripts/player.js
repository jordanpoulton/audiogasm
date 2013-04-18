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

// $('.album').on('mouseenter', function (){
    
//   });

// $('.album').on('mouseleave', function (){
    
// });