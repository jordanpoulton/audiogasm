(function(){

    $(document).ready(function(){

        // fetch all bg images
        var $bgs = $(".bg-img"),

            // keep track of our current slide
            currentSlide = 0,

            // check how many bg images there are
            slideCount = $bgs.length,

            // change the background every x milliseconds (1000 = 1 second)
            interval = 12000;


        // change the background!
        setTimeout(changeBG, interval);


        // change the background!
        function changeBG() {

            // set which slide to transition to next
            currentSlide++;

            // reset the slide when we reach the end
            if (currentSlide === slideCount) {
                currentSlide = 0;
            }

            // transition!
            $bgs.not(":eq("+currentSlide+")").fadeOut(3000);
            $bgs.eq(currentSlide).fadeIn(3000);

            // change the background every x seconds
            setTimeout(changeBG, interval);

            // debug
            console.log("transitioning to slide ", currentSlide);
        };

        
    });
// $('.album').on('mouseenter', function (){
//     $('.player').fadeIn();
//     $('.playing-text').fadeIn();
//   });

// $('.album').on('mouseleave', function (){
//     $('.player').fadeOut();
//     $('.playing-text').fadeOut();
   
//   });
})();

// $(function() {

// 



// })
