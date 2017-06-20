<%@ Page Title="" Language="vb" AutoEventWireup="false" CodeBehind="GoogleCharts.aspx.vb" Inherits="ThePuntersEdge.GoogleCharts" %>

<!--Load the AJAX API-->
<script type="text/javascript" src="//www.google.com/jsapi"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
<div class="w3-main" style="width:100%">
    <div class="w3-content">
        <div class="w3-row">
            <div id="pointsbyday" style="width:100%"></div>
        </div>
    </div>
</div>
<div class="w3-main" style="width:100%">
    <div class="w3-content">
        <div class="w3-row">
            <div id="profitbyday" style="width:100%"></div>
        </div>
    </div>
</div>

