﻿
$(document).ready(function () {
  
    $("#step-login").mouseenter(function () {
        $("#info1").css("display", "inline-block");
        $("#icoLogin").css("color", "white");
        $("#info-box").animate({
          
            height: '200px'
            
        });
    }).mouseleave(function () {
        $("#info1").css("display", "none");
        $("#icoLogin").css("color", "black");
        $("#info-box").animate({
            height: "0px"
        });
    });
});
$(document).ready(function () {

    $("#step-listen").mouseenter(function () {
        $("#icoLogin").css("color", "black");
        $("#info-box").animate({
            height: "0px"
        });
        $("#info1").css("display", "none");
        $("#info2").css("display", "inline-block");
        $("#icoListen").css("color", "white");
        $("#info-box2").animate({
            height: "200px"


        });
    }).mouseleave(function () {
        $("#info2").css("display", "none");
        $("#icoListen").css("color", "black");
        $("#info-box2").animate({
            height: "0px"
        });
    });
});
$(document).ready(function () {

    $("#step-bet").mouseenter(function () {
        $("#icoLogin").css("color", "black");
        $("#info-box").animate({
            height: "0px"
        });
        $("#info1").css("display", "none");
        $("#info3").css("display", "inline-block");
        $("#icoBet").css("color", "white");
        $("#info-box3").animate({
            height: "200px"

        });
    }).mouseleave(function () {
        $("#info3").css("display", "none");
        $("#icoBet").css("color", "black");
        $("#info-box3").animate({
            height: "0px"
        });
    });
});

