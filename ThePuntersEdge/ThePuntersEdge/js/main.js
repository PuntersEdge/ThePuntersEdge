
$(document).ready(function () {
  
    $("#step-login").mouseenter(function () {
        $("#info1").css("display", "block");
        $("#info-box").animate({
            height: "140px"
            
        });
    }).mouseleave(function () {
        $("#info1").css("display", "none");
        $("#info-box").animate({
            height: "1px"
        });
    });
});
$(document).ready(function () {

    $("#step-listen").mouseenter(function () {
        $("#info2").css("display", "block");
        $("#info-box2").animate({
            height: "140px"


        });
    }).mouseleave(function () {
        $("#info2").css("display", "none");
        $("#info-box2").animate({
            height: "1px"
        });
    });
});
$(document).ready(function () {

    $("#step-bet").mouseenter(function () {
        $("#info3").css("display", "block");
        $("#info-box3").animate({
            height: "140px"

        });
    }).mouseleave(function () {
        $("#info3").css("display", "none");
        $("#info-box3").animate({
            height: "1px"
        });
    });
});