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

$(function() {
    initGallery();

    $(".dropdown-menu li").click(function(){
        $("#chosen_category").text($(this).text());
    });
});
