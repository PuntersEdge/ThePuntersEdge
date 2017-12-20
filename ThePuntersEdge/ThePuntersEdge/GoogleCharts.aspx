<%@ Page Title="" Language="vb" AutoEventWireup="false" CodeBehind="GoogleCharts.aspx.vb" Inherits="ThePuntersEdge.GoogleCharts" %>

<style>
    @import url('/css/main.css');
</style>
<script
    src="https://code.jquery.com/jquery-2.2.4.min.js"
    integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
    crossorigin="anonymous"></script>
<script
  src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
  integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU="
  crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">


<script src="/js/tablepager.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">



<script type="text/javascript" src="//www.google.com/jsapi"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
    #pastresultsdata tr {
        border-left: none;
        border-right: none;
        border-top: none;
        border-bottom: solid 1px black !important;
        height: 25px;
    }

        #pastresultsdata tr td {
            width: 130px;
            text-align: left;
            padding: 8px 0px;
        }

            #pastresultsdata tr td:nth-child(5) {
                width: 80px;
                padding: 8px;
            }

            #pastresultsdata tr td:nth-child(3), #pastresultsdata tr th:nth-child(3), #pastresultsdata tr td:nth-child(2), #pastresultsdata tr th:nth-child(2), #pastresultsdata tr td:nth-child(4), #pastresultsdata tr th:nth-child(4), #pastresultsdata tr td:nth-child(5), #pastresultsdata tr th:nth-child(5) {
                text-align: center;
            }

            #pastresultsdata tr td:nth-child(1), #pastresultsdata tr th:nth-child(1) {
                text-align: left;
            }
</style>
<script type="text/javascript">


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

                var chart = new google.visualization.AreaChart(document.getElementById('pointsbyday'));

                chart.draw(data,
                {
                    title: "Last 7 days of points",
                    position: "left",
                    fontsize: "10px",
                    float: "left",
                    legend: "none",
                    chartArea: { width: '100%' }

                });
            } // calling method

                      ,

            error: function () {
                alert("Error loading data! Please try again.");
            }
        });
    }

    </script>
<script>

    function showResult(date) {

        var DateSelected = new Date()


        if (date == 'load') {

            document.getElementById("datepicker").valueAsDate = new Date();
            DateSelected = new Date().toISOString().slice(0, 10);

            //DateSelected = DateSelected.setDate(DateSelected.getDate() - 1);
            //DateSelected = new Date(DateSelected).toISOString().slice(0, 10);

        } else if (date == 'change') {

            DateSelected = new Date(document.getElementById('datepicker').value).toISOString().slice(0, 10);

        }


        var todaysdate = new Date().toISOString().slice(0, 10);


        if (DateSelected > todaysdate) {
            $("#pastresultsdata tr").remove();
            $('#noresults').show();
        }

        else {
            $("#noresults").hide();
            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: 'GoogleCharts.aspx/DaysResults',
                data: "{'DateSelected':'" + DateSelected + "'}",

                success: function (response) {
                    $("#pastresultsdata tr").remove();
                    $('#noresults').hide();

                    if (response.d == 'none') {
                        $('#noresults').show();

                    } else if (response.d == 'no user') {

                        return;


                    } else {

                        var arr = $.parseJSON(response.d)
                        var tr;
                        $("#pastresultsdata").prepend("<thead><tr><th>Horse</th><th>Odds</th><th>Result</th></tr></thead>");
                        for (var i = 0; i < arr.length; i++) {
                            tr = $('<tr/>');
                            tr.append("<td>" + arr[i].Horse + "</td>");
                            tr.append("<td>" + arr[i].Odds + "</td>");
                            tr.append("<td class=" + "text-center" + ">" + arr[i].Result + "</td>");
                            $('#pastresultsdata').append(tr);
                        };

                        // $('#pastresultsdata').paging({ limit: 12 });

                        if ($("#pager").length) {

                            $("#pager").remove();

                        }
                    
                        $(".pagenation").pagination();



                    };




                    $("#pastresultsdata tr").each(function () {

                        var thisCell = $(this).find("td").eq(2);
                        var cellValue = thisCell.text();

                        if (cellValue < 0) {
                            thisCell.css("background-color", "#FF5733");

                        } else if (cellValue == 0) {
                            thisCell.css("background-color", "white");

                        } else {

                            thisCell.css("background-color", "#66ff66");

                        }
                    }
        );




                },
                error: function () {
                    alert(response.d);
                }
            });

        }


    };


</script>
<script>
    $(document).ready(function () {

        showResult('load')

    })
</script>
<script type="text/javascript">


    // Load the Visualization API and the piechart package.
    google.charts.load('current', { 'packages': ['corechart'] });

    // Set a callback to run when the Google Visualization API is loaded.
    google.charts.setOnLoadCallback(GetBookieSpread);

    function GetBookieSpread() {
        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'GoogleCharts.aspx/GetBookieSpread',            
            success: function (response) {

                if (response.d == 'admin') {
                    return
                } else {

                var data = new google.visualization.DataTable();
                var arr = $.parseJSON(response.d);
                data.addColumn('string', 'Bookmaker');
                data.addColumn('number', 'Bets');

                $.each(arr, function (i, row) {
                    data.addRow([
                      (row.Bookie),
                      (row.COUNT)

                    ]);
                });

                    var options = {
                        title: 'Bookie Spread',
                        pieHole: 0.4,
                    };

                    var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
                    chart.draw(data, {
                       
                        chartArea: { width: '100%' },
                        chartArea: { height: '100%' },
                        backgroundColor: '#e1eaea'
                    });
                
                }
            } // calling method

                      ,

            error: function () {
                alert("Error loading data! Please try again.");
            }
        });
    }

    </script>

<form runat="server">
    <div class="w3-main" style="width: 100%; margin-top: 25px">
        <div class="w3-content">
            <div class="w3-row w3-half w3-left">
                <div id="pointsbyday" style="width: 48%; display: inline-block; padding-left: 20px;"></div>
                
                <div style="width: 40%; float: right; margin-right: 20px; margin-left: 10px; display: inline-block;">
                    <div id='datetimepicker'>
                        <input id='datepicker' class='form-control' type='date' onchange="showResult('change')" style="width: 80%; display: inline-block" />
                        <i class="fa fa-calendar fa-2x" aria-hidden="true" style="vertical-align: middle; margin-left: 10px"></i>
                        <br />
                        <div>
                            <table runat="server" allowpaging="True" id="pastresultsdata" style="font-family: sans-serif; width: 100%; margin-top: 10px" class="pagenation" number-per-page="7" current-page="0">
                                <tbody id="pastresultsbody"></tbody>
                            </table>
                            <div class="col-md-12 text-center">
                                <ul class="pagination pagination-lg pager" id="myPager"></ul>
                            </div>
                        </div>

                        <div id="noresults" style="display: none;">
                            <h3>No results to display</h3>
                        </div>
                    </div>


                </div>
                 <div id="donutchart" style="width: 48%; display: inline-block; padding-left: 20px;"></div>
            </div>

        </div>
    </div>
    <div class="w3-main" style="width: 100%">
        <div class="w3-content">
            <div class="w3-row">
               
            </div>
        </div>
    </div>
</form>

