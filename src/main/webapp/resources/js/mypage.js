$(document).ready(function () {

    $("#myReviewBtn").click(function (){
        $("#mypageReview").css("display", "flex");
        $("#mypageBoard").css("display", "none");
        $(this).addClass("active");
        $("#myBoardBtn").removeClass("active");
    })
    $("#myBoardBtn").click(function (){
        $("#mypageReview").css("display", "none");
        $("#mypageBoard").css("display", "flex");
        $(this).addClass("active");
        $("#myReviewBtn").removeClass("active");
    })
});