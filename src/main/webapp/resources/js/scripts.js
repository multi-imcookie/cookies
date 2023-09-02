$(document).ready(function () {

    // depth2 메뉴
    $(".gnb > li").hover(function () {
            $(this).children(".depth2").css("display", "inline-flex");
        }, function () {
            $(this).children(".depth2").css("display", "none");
        }
    );

    // 스크롤 내렸을 때 header 보더 생성
    $(window).scroll(function () {
        if ($(window).scrollTop()) {
            $("#header").css("border-bottom", "1px solid #E9E2D9");
        } else {
            $("#header").css("border-bottom", "none");
        }
    });

    // // index 페이지 첫번째 슬라이더 (캐러셀)
    // let movePoint = $(".v-r-box").width(); // 박스 가로 크기 값
    // $(window).on("resize",function(){
    //
    //     movePoint = $(".v-r-box").width();
    //     /* 웹브라우저 화면창 크기를 조절했을 때 li태그 가로크기 값 다시 받아오기 */
    //     $(".v-right-warp").css("margin-left", -movePoint);
    // });
    //
    // $(".prev-btn").click(function () {
    //     $(".v-right-warp").stop().animate({"margin-left": -movePoint * 2}, 300, function () {
    //         $(".v-r-box:first-child").appendTo(".v-right-warp");
    //         $(".v-right-warp").css({"margin-left": -movePoint});
    //     });
    // });
    //
    // $(".next-btn").click(function () {
    //     $(".v-right-warp").stop().animate({"margin-left": 0}, 300, function () {
    //         $(".v-r-box:last-child").prependTo(".v-right-warp");
    //         $(".v-right-warp").css({"margin-left": -movePoint});
    //
    //     });
    // });
});

// modal창 띄우는 함수
function modalShow() {
    $(".modal-overlay").fadeIn();
    $(".modal-box").addClass("active");
}

function modalHide() {
    $(".modal-overlay").fadeOut();
    $(".modal-box").removeClass("active");
}

// 핸드폰번호 입력 가이드창
function phoneHelp() {
    // 도움말 창
    $(".help-content").show();

    $(document).mouseup(function (e) {
        let helpPopup = $(".help-content");
        if (helpPopup.has(e.target).length === 0) {
            helpPopup.css("display", "none");
        }
    })
}

// 입력창에 영어 숫자 제외 다른 문자 입력 불가
let numberAndEngExp = (target) => {
    target.value = target.value
        .replace(/[^0-9a-zA-Z]/g, '');
}

// 입력창에 영어와 점 제외 다른 문자 입력 불가
let emailExp = (target) => {
    target.value = target.value
        .replace(/[^a-zA-Z.]/g, '');
}

// input 입력 가이드
function inputRuleGuide(element, message, color) {
    $(element).text(message).css("color", color);
}