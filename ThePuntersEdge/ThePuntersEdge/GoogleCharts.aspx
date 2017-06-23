<%@ Page Title="" Language="vb" AutoEventWireup="false" CodeBehind="GoogleCharts.aspx.vb" Inherits="ThePuntersEdge.GoogleCharts" %>

<!--Load the AJAX API-->

<script type="text/javascript" src="//www.google.com/jsapi"></script>
<%--<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>--%>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
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
#pastresultsdata tr td{
    width: 130px;
    text-align: left;
    padding: 8px 0px;
}
#pastresultsdata tr td:nth-child(5){
    width: 80px;
    padding: 8px;
}
#pastresultsdata tr td:nth-child(3), #pastresultsdata tr th:nth-child(3), #pastresultsdata tr td:nth-child(2), #pastresultsdata tr th:nth-child(2) ,#pastresultsdata tr td:nth-child(4), #pastresultsdata tr th:nth-child(4), #pastresultsdata tr td:nth-child(5), #pastresultsdata tr th:nth-child(5){
    text-align: center;
}
#pastresultsdata tr td:nth-child(1), #pastresultsdata tr th:nth-child(1){
    text-align:left;

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
                        $("#pastresultsdata").prepend("<tr><th>Meeting</th><th>Racetime</th><th>Horse</th><th>Odds</th><th>Result</th></tr>");
                        for (var i = 0; i < arr.length; i++) {
                            tr = $('<tr/>');
                            tr.append("<td>" + arr[i].Meeting + "</td>");
                            tr.append("<td>" + arr[i].Racetime + "</td>");
                            tr.append("<td>" + arr[i].Horse + "</td>");
                            tr.append("<td>" + arr[i].Odds + "</td>");
                            tr.append("<td class=" + "text-center" + ">" + arr[i].Result + "</td>");
                            $('#pastresultsdata').append(tr);
                        }


                    }

                    //alert(response.d);
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

<form runat="server">
    <div class="w3-main" style="width: 100%; margin-top: 25px">
        <div class="w3-content">
            <div class="w3-row w3-half w3-left">
                <div id="pointsbyday" style="width: 45%; display: inline-block; padding-left: 20px;"></div>
                <div style="width: 45%; float: right; margin-right: 20px; margin-left: 10px; display: inline-block;">
                    <div id='datetimepicker'>
                        <input id='datepicker' class='form-control' type='date' onchange="showResult('change')" />
                        <i class="fa fa-calendar" aria-hidden="true"></i>
                        <br />
                        <table runat="server" id="pastresultsdata" style="font-family: sans-serif; width: 100%; margin-top:10px "></table>
                        <div id="noresults" style="display: none;">
                            <h3>No results to display</h3>
                        </div>
                    </div>


                </div>
            </div>

        </div>
    </div>
    <div class="w3-main" style="width: 100%">
        <div class="w3-content">
            <div class="w3-row">
                <div id="profitbyday" style="width: 100%"></div>
            </div>
        </div>
    </div>
</form>

