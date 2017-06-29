
$(document).ready(function () {
  
    $("#step-login").mouseenter(function () {
        $("#info1").css("display", "inline-block");
        $("#info-box").animate({
          
            height: '200px'
            
        });
    }).mouseleave(function () {
        $("#info1").css("display", "none");
        $("#info-box").animate({
            height: "0px"
        });
    });
});
$(document).ready(function () {

    $("#step-listen").mouseenter(function () {
        $("#info2").css("display", "inline-block");
        $("#info-box2").animate({
            height: "200px"


        });
    }).mouseleave(function () {
        $("#info2").css("display", "none");
        $("#info-box2").animate({
            height: "0px"
        });
    });
});
$(document).ready(function () {

    $("#step-bet").mouseenter(function () {
        $("#info3").css("display", "inline-block");
        $("#info-box3").animate({
            height: "200px"

        });
    }).mouseleave(function () {
        $("#info3").css("display", "none");
        $("#info-box3").animate({
            height: "0px"
        });
    });
});

