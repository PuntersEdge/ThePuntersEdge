﻿
        function beep() {

            if (document.getElementById('ContentPlaceHolder1_notify_unmatched').style.display == 'inline') {
                var audio = document.getElementById('beep');
                audio.setAttribute('src', 'audio/beep-06.mp3');
                audio.play(audio);

            } else {
                document.getElementById('beep').setAttribute('src', '');

            }


        }; setInterval(beep, 30000);




 // Load the Visualization API and the piechart package.
google.charts.load('current', { 'packages': ['corechart'] });
// Set a callback to run when the Google Visualization API is loaded.
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
    $.ajax({
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        url: 'GoogleCharts.aspx/GetChartData',
        data: '{}',
        success: function (response) {


            var data = new google.visualization.DataTable();
            var arr = $.parseJSON(response.d);
            data.addColumn('date', 'Date');
            data.addColumn('number', 'Points');

            $.each(arr, function (i, row) {
                data.addRow([
                  (new Date(row.Date)),
                  parseFloat(row.ProfitLoss)

                ]);
            });

            var chart = new google.visualization.AreaChart(document.getElementById('piechart'));

            chart.draw(data,
            {
                title: "Last 7 days",
                position: "left",
                fontsize: "10px",
                float: "left",
                legend: "none",
                chartArea: { width: '90%' }

            });
        } // calling method

                  ,

        error: function () {
            alert("Error loading data! Please try again.");
        }
    });
}





    function Filter(strKey, strGV) {

        var strData = strKey.value.toLowerCase().split(" ");
        var tblData = document.getElementById(strGV);
        var rowData;
        for (var i = 1; i < tblData.rows.length; i++) {
            rowData = tblData.rows[i].innerHTML;
            var styleDisplay = 'none';
            for (var j = 0; j < strData.length; j++) {
                if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                    styleDisplay = '';
                else {
                    styleDisplay = 'none';
                    break;
                }
            }
            tblData.rows[i].style.display = styleDisplay;
        }

    };


    function StatsToggle(toggle) {

        if (toggle == 'hide') {

            document.getElementById("StatsInfo").style.display = "none";
            document.getElementById("piechart").style.display = "none";
            document.getElementById("HideShowStats").className = "fa fa-external-link-square";
            document.getElementById("HideShowStats").onclick = function () { StatsToggle('show'); };

        } else if (toggle == 'show') {

            document.getElementById("StatsInfo").style.display = "flex";
            document.getElementById("piechart").style.display = "flex";
            document.getElementById("HideShowStats").className = "fa fa-times-circle";
            document.getElementById("HideShowStats").onclick = function () { StatsToggle('hide'); };

        }
    };





    function SendChat(message) {

        if (window.event.keyCode == 13) {
            var msg = message.value;
            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: 'Picks.aspx/SendChat',
                data: "{'message':'" + msg + "'}",

                success: function (response) {

                    if (response.d == 'success') {

                        document.getElementById('chatinput').value = "";


                    } else if (response.d == 'blank') {

                        document.getElementById('chatinput').focus;

                    }



                },
                error: function () {
                    alert("Error sending chat! Please refresh the page.");
                }
            });
            event.preventDefault();
            return false;

        }


    };

    function loadusersettings() {

        document.getElementById('usersettings').style.display = "block"
    };


    function UpdateUserSettings() {

        var stake = document.getElementById("ContentPlaceHolder1_tb_stake").value;
        var pwd = document.getElementById("tb_pwd").value;

        if (document.getElementById("passwordchange").checked.value = true) {


            var pwd_new = document.getElementById("tb_pwd_new").value;
            var pwd_confirm = document.getElementById("tb_pwd_confirm_new").value;

            if (pwd_new !== pwd_confirm) {

                document.getElementById("tb_pwd_confirm_new").style.borderColor = "red";
                document.getElementById("lbl_error").style.display = "inline-block";
                document.getElementById("lbl_error").innerHTML = "Passwords do not match!"
                document.getElementById("tb_pwd_confirm_new").focus;
            } else {

                $.ajax({
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    url: 'default.aspx/UpdateSettings',
                    data: "{'stake':" + stake + ", 'pwd':'" + pwd + "', 'pwd_new':'" + pwd_new + "'}",

                    success: function (response) {

                        if (response.d == 'Invalid password!') {

                            document.getElementById('tb_pwd').style.borderColor = "red";
                            document.getElementById("lbl_error").innerHTML = response.d;
                            document.getElementById("lbl_error").style.display = "inline-block";

                        } else if (response.d.includes('Updated stake to')) {

                            document.getElementById('lbl_error').style.color = "green";
                            document.getElementById("lbl_error").innerHTML = response.d;
                            document.getElementById("lbl_error").style.display = "block"

                        } else {

                            document.getElementById('lbl_error').style.color = "green";
                            document.getElementById("lbl_error").innerHTML = response.d;
                            document.getElementById("lbl_error").style.display = "block"

                        };

                    },
                    error: function () {
                        alert(response.d)
                    }
                });

            }

        }




    };

    function togglepwd() {

        $('#div_pwd_change').toggle();

    };


    function EditOdds(row) {


        var index = row.parentNode.parentNode;//to get row containing image
        var rowIndex = index.rowIndex;//row index of that row.
        var meeting = document.getElementById('ContentPlaceHolder1_gv_matched').rows[rowIndex].cells[0].innerHTML;
        var racetime = document.getElementById('ContentPlaceHolder1_gv_matched').rows[rowIndex].cells[1].innerHTML;
        var horse = document.getElementById('ContentPlaceHolder1_gv_matched').rows[rowIndex].cells[2].innerHTML;
        var odds = document.getElementById('ContentPlaceHolder1_gv_matched').rows[rowIndex].cells[4].innerHTML;

        document.getElementById('lbl_meeting').innerHTML = meeting;
        document.getElementById('lbl_racetime').innerHTML = racetime;
        document.getElementById('lbl_horse').innerHTML = horse;
        document.getElementById('tb_odds').value = odds;

        document.getElementById('EditHorse').style.display = "block";
    };

    function ConfirmInvoice(row) {


        var index = row.parentNode.parentNode;//to get row containing image
        var rowIndex = index.rowIndex;//row index of that row.
        var period = document.getElementById('ContentPlaceHolder1_gv_invoices').rows[rowIndex].cells[0].innerHTML;
        var balance = document.getElementById('ContentPlaceHolder1_gv_invoices').rows[rowIndex].cells[4].innerHTML;

        document.getElementById('lbl_period').innerHTML = period;
        document.getElementById('lbl_balancedue').innerHTML = balance;


        document.getElementById('PayInvoice').style.display = "block";
    };

    function UpdateHorse() {

        var meeting = document.getElementById('lbl_meeting').innerHTML;
        var horse = document.getElementById('lbl_horse').innerHTML;
        var odds = document.getElementById('tb_odds').value;
        var reason = document.getElementById('tb_reason').value;
        var racetime = document.getElementById('lbl_racetime').innerHTML

        if (reason == "") {

            document.getElementById('tb_reason').style.borderColor = "red";

            document.getElementById('tb_reason').focus;

        } else {

            alertify.confirm("Updating odds to " + odds + " for " + horse + ". Reason: " + reason,
     function () {


         $.ajax({
             type: 'POST',
             dataType: 'json',
             contentType: 'application/json',
             url: 'Picks.aspx/UpdateHorse',

             data: "{'meeting':'" + meeting + "', 'horse':'" + horse + "', 'odds':" + odds + ", 'time':'" + racetime + "', 'reason':'" + reason + "'}",

             success: function (result) {

                 javascript: __doPostBack('ctl00$ContentPlaceHolder1$btn_matched', '');
                 document.getElementById('tb_reason').value = "";
                 document.getElementById('EditHorse').style.display = "none";
                 var msg = alertify.message("Odds updated to " + odds + " for " + horse, 0);
                 $('body').one('click', function () {
                     msg.dismiss();
                 });

             },
             error: function () {
                 alert(Error);
             }
         });



     }
     ).setHeader('<em> Update Odds? </em>').set('movable', true);


        };

    };

    function ConfirmDelete(row) {


        var index = row.parentNode.parentNode;//to get row containing image
        var rowIndex = index.rowIndex;//row index of that row.
        var meeting = document.getElementById('ContentPlaceHolder1_gv_matched').rows[rowIndex].cells[0].innerHTML;
        var racetime = document.getElementById('ContentPlaceHolder1_gv_matched').rows[rowIndex].cells[1].innerHTML;
        var horse = document.getElementById('ContentPlaceHolder1_gv_matched').rows[rowIndex].cells[2].innerHTML;
        var bookie = document.getElementById('ContentPlaceHolder1_gv_matched').rows[rowIndex].cells[3].innerHTML;


        alertify.confirm("Are you sure you want to delete selection: " + horse + "?",
        function () {


            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: 'Picks.aspx/DeleteHorse',

                data: "{'meeting':'" + meeting + "', 'horse':'" + horse + "', 'time':'" + racetime + "', 'bookie':'" + bookie + "'}",

                success: function (result) {

                    javascript: __doPostBack('ctl00$ContentPlaceHolder1$btn_matched', '');
                    var msg = alertify.message(horse + " deleted.", 0);
                    $('body').one('click', function () {
                        msg.dismiss();
                    });

                },
                error: function () {
                    alert(Error);
                }
            });



        }
        ).setHeader('<em> Delete selection? </em>').set('movable', true);




    };

    function MatchHorse(row) {


        var index = row.parentNode.parentNode;//to get row containing image
        var rowIndex = index.rowIndex;//row index of that row.
        var meeting = document.getElementById('ContentPlaceHolder1_gv_unmatched').rows[rowIndex].cells[0].innerHTML;
        var racetime = document.getElementById('ContentPlaceHolder1_gv_unmatched').rows[rowIndex].cells[1].innerHTML;
        var horse = document.getElementById('ContentPlaceHolder1_gv_unmatched').rows[rowIndex].cells[2].innerHTML;
        var bookie = document.getElementById('ContentPlaceHolder1_gv_unmatched').rows[rowIndex].cells[3].innerHTML;



        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'Picks.aspx/MatchHorse',

            data: "{'meeting':'" + meeting + "', 'horse':'" + horse + "', 'time':'" + racetime + "', 'bookie':'" + bookie + "'}",

            success: function (result) {

                javascript: __doPostBack('ctl00$ContentPlaceHolder1$btn_unmatched', '');
                var msg = alertify.message(horse + " matched.", 0);
                $('body').one('click', function () {
                    msg.dismiss();
                });

            },
            error: function () {
                alert(Error);
            }
        });

    };

    function GoneHorse(row) {


        var index = row.parentNode.parentNode;//to get row containing image
        var rowIndex = index.rowIndex;//row index of that row.
        var meeting = document.getElementById('ContentPlaceHolder1_gv_unmatched').rows[rowIndex].cells[0].innerHTML;
        var racetime = document.getElementById('ContentPlaceHolder1_gv_unmatched').rows[rowIndex].cells[1].innerHTML;
        var horse = document.getElementById('ContentPlaceHolder1_gv_unmatched').rows[rowIndex].cells[2].innerHTML;
        var bookie = document.getElementById('ContentPlaceHolder1_gv_unmatched').rows[rowIndex].cells[3].innerHTML;



        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'Picks.aspx/GoneHorse',

            data: "{'meeting':'" + meeting + "', 'horse':'" + horse + "', 'time':'" + racetime + "', 'bookie':'" + bookie + "'}",

            success: function (result) {

                javascript: __doPostBack('ctl00$ContentPlaceHolder1$btn_unmatched', '');
                var msg = alertify.message(horse + " dismissed.", 0);
                $('body').one('click', function () {
                    msg.dismiss();
                });

            },
            error: function () {
                alert(Error);
            }
        });

    };

    function color(key) {

        if (key == "Matched") {
            $("#ContentPlaceHolder1_gv_matched tr").each(function () {

                var thisCell = $(this).find("td").eq(6);
                var cellValue = parseInt(thisCell.text());

                if (cellValue < 0) {
                    thisCell.css("background-color", "#FF5733");

                } else if (cellValue > 0) {
                    thisCell.css("background-color", "#66ff66");

                } else {

                    thisCell.css("background-color", "white");

                }
            });

        } else if (key == "Invoice") {
            $("#ContentPlaceHolder1_gv_invoices tr").each(function () {

                var thisCell = $(this).find("td").eq(5);
                var cellValue = thisCell.text();

                if (cellValue == 'No') {
                    thisCell.css("background-color", "red");

                } else if (cellValue == 'YES') {
                    thisCell.css("background-color", "#66ff66");
                    var buttonindex = "ContentPlaceHolder1_gv_invoices_MarkPaid_" + (parseInt($(this).index() - 1).toString())

                    document.getElementById(buttonindex).style.display = 'none';
                } else {

                    thisCell.css("background-color", "white");

                }
            }
)
        }
    };

    function RestoreHorse(row) {

        var index = row.parentNode.parentNode;//to get row containing image
        var rowIndex = index.rowIndex;//row index of that row.
        var meeting = document.getElementById('ContentPlaceHolder1_gv_gone').rows[rowIndex].cells[0].innerHTML;
        var racetime = document.getElementById('ContentPlaceHolder1_gv_gone').rows[rowIndex].cells[1].innerHTML;
        var horse = document.getElementById('ContentPlaceHolder1_gv_gone').rows[rowIndex].cells[2].innerHTML;
        var bookie = document.getElementById('ContentPlaceHolder1_gv_gone').rows[rowIndex].cells[3].innerHTML;



        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'Picks.aspx/RestoreHorse',

            data: "{'meeting':'" + meeting + "', 'horse':'" + horse + "', 'time':'" + racetime + "', 'bookie':'" + bookie + "'}",

            success: function (result) {

                javascript: __doPostBack('ctl00$ContentPlaceHolder1$btn_gone', '');
                var msg = alertify.message(horse + " restored.", 0);
                $('body').one('click', function () {
                    msg.dismiss();
                });

            },
            error: function () {
                alert(Error);
            }
        });

    };

    function ReMatch(row) {
        var index = row.parentNode.parentNode;//to get row containing image
        var rowIndex = index.rowIndex;//row index of that row.
        var meeting = document.getElementById('ContentPlaceHolder1_gv_deleted').rows[rowIndex].cells[0].innerHTML;
        var racetime = document.getElementById('ContentPlaceHolder1_gv_deleted').rows[rowIndex].cells[1].innerHTML;
        var horse = document.getElementById('ContentPlaceHolder1_gv_deleted').rows[rowIndex].cells[2].innerHTML;
        var bookie = document.getElementById('ContentPlaceHolder1_gv_deleted').rows[rowIndex].cells[3].innerHTML;



        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'Picks.aspx/ReMatch',

            data: "{'meeting':'" + meeting + "', 'horse':'" + horse + "', 'time':'" + racetime + "', 'bookie':'" + bookie + "'}",

            success: function (result) {

                javascript: __doPostBack('ctl00$ContentPlaceHolder1$btn_deleted', '');
                var msg = alertify.message(horse + " restored to matched.", 0);
                $('body').one('click', function () {
                    msg.dismiss();
                });

            },
            error: function () {
                alert(Error);
            }
        });

    };

    function notifications() {

        var visible = document.getElementById('ContentPlaceHolder1_notify_unmatched').style.display


        if (visible == "inline") {

            document.getElementById('ContentPlaceHolder1_btn_unmatched').classList.add('pulse');



        } else {


            document.getElementById('ContentPlaceHolder1_btn_unmatched').classList.remove('pulse');
        }

        if (document.getElementById("ContentPlaceHolder1_lbl_heading").innerHTML == "Matched") {

            color("Matched");
        } else if (document.getElementById("ContentPlaceHolder1_lbl_heading").innerHTML == "Invoices") {

            color("Invoice");
        }

    };

   
            
       
      
    function MarkPaid() {

        if (document.getElementById('tb_method').value == "") {

            document.getElementById('tb_method').style.borderColor = 'red'
            document.getElementById('tb_method').focus;

        } else {

            var period = document.getElementById('lbl_period').innerHTML
            var method = document.getElementById('tb_method').value
            var balance = document.getElementById('lbl_balancedue').innerHTML


            alertify.confirm("Mark payment of £" + balance + " as sent by " + method + ".",
function () {



    $.ajax({
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        url: 'Picks.aspx/MarkPaid',



        data: "{'period':'" + period + "', 'method':'" + method + "'}",

        success: function (result) {

            javascript: __doPostBack('ctl00$ContentPlaceHolder1$btn_invoices', '');
            var msg = alertify.alert("Thanks! We will confirm your payment as soon as possible! Congratulations on your winnings!", 0);
            $('body').one('click', function () {
                document.getElementById('PayInvoice').style.display = 'none';
            });

        },
        error: function () {
            alert(Error);
        }
    });
}
).setHeader('<em> Update Odds? </em>').set('movable', true);

        }
    };
      
    function portfolio() {

        if (document.getElementById("ContentPlaceHolder1_lbl_heading").textContent == 'Portfolio') {

            document.getElementById("ContentPlaceHolder1_div_portfolio").style.display = 'flex';

        } else {

            document.getElementById("ContentPlaceHolder1_div_portfolio").style.display = 'none';
        }


    };

       

    $(document).ready(function () {

        portfolio


    });

        