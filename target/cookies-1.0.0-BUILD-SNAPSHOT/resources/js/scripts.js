// depth2 메뉴
$(function () {
    $(".gnb > li").hover(function () {
            $(this).children(".depth2").css("display", "inline-flex");
        }, function () {
            $(this).children(".depth2").css("display", "none");
        }
    );
    // $(".gnb > li").hover(function () {
    //         $(this).children(".depth2").stop().slideDown();
    //     }, function () {
    //         $(this).children(".depth2").stop().slideUp();
    //     }
    // );

    $(window).scroll(function () {
        if ($(window).scrollTop()) {
            $(".header").css("border", "1px solid #F9F5F2");
        } else {
            $(".header").css("border", "none");
        }
    });
});