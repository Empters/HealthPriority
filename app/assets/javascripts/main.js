function initGallery() {
    $("#hpGallery").royalSlider({
        autoPlay : {
            enabled : true,
            pauseOnHover : true,
            stopAtAction: false
        },
        autoHeight : true,
        controlNavigation : 'bullets',
        keyboardNavEnabled : false,
        controlsInside : false,
        arrowsNavAutoHide: false,
        startSlideId : 0,
        transitionType : 'move',
        loop : true,
        loopRewind : true,
        navigateByClick : false
    });
}

function initSearchDropdown() {
    $(".dropdown-menu li").click(function(){
        $("#chosen_category").text($(this).text());
    });
}

function initStarRatings() {
    $('.star-rating').each(function() {
        var currentRating = parseInt($('.rating-value', this).text());
        $('.star', this).each(function() {
            if ( currentRating >= parseInt($(this).data('rating'))) {
                $(this).addClass('active');
            } else {
                $(this).removeClass('active');
            }
        });
    });
}

$(function() {
    initGallery();
    initSearchDropdown();
    initStarRatings();
});
