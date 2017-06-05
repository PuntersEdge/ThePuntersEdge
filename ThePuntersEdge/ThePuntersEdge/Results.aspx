﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Results.aspx.vb" Inherits="ThePuntersEdge.Results" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!--Load the AJAX API-->
    <script type="text/javascript" src="//www.google.com/jsapi"></script>

    <script
        src="https://code.jquery.com/jquery-3.2.1.min.js"
        integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
        crossorigin="anonymous"></script>
    <script type="text/javascript">

        // Load the Visualization API and the piechart package.
        google.charts.load('current', { 'packages': ['corechart'] });

        // Set a callback to run when the Google Visualization API is loaded.
        google.charts.setOnLoadCallback(drawChart);

        //Chart 1 - Daily Points
        function drawChart() {
            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: 'GoogleCharts.aspx/GetPointsData',
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

                    var chart = new google.visualization.ColumnChart(document.getElementById('pointschart'));

                    chart.draw(data,
                    {
                        title: "Daily algo points",
                        position: "middle",
                        fontsize: "10px",
                        chartArea: { left: 0, top: 0, bottom: 0, width: "100%", height: "80%" },
                        hAxis: { gridlines: { color: 'none' } },
                        vAxis: { gridlines: { color: 'none' } }
                    });
                } // calling method

                          ,

                error: function () {
                    alert("Error loading data! Please try again.");
                }
            });
        };


    </script>
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
                url: 'GoogleCharts.aspx/GetGrowthData',
                data: '{}',
                success: function (response) {


                    var data = new google.visualization.DataTable();
                    var arr = $.parseJSON(response.d);
                    data.addColumn('string', 'Week');
                    data.addColumn('number', 'Points');

                    $.each(arr, function (i, row) {
                        data.addRow([
                          (row.Week),
                          parseFloat(row.ProfitLoss)

                        ]);
                    });

                    var chart = new google.visualization.AreaChart(document.getElementById('growthchart'));

                    chart.draw(data,
                    {
                        title: "Profit By Day",
                        position: "top",
                        fontsize: "10px",
                        legend: 'none',
                        vAxis: { title: 'Points' },
                        hAxis: { title: 'Week' },
                        chartArea: { width: '90%' }
                    });
                } // calling method

                          ,

                error: function () {
                    alert("Error loading data! Please try again.");
                }
            });
        }

    </script>
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
                url: 'GoogleCharts.aspx/GetBalanceData',
                data: "{'Stake': 25}",
                success: function (response) {

                    //alert(response.d);
                    var data = new google.visualization.DataTable();
                    var arr = $.parseJSON(response.d);
                    data.addColumn('date', 'Date');
                    data.addColumn('number', 'Balance');

                    $.each(arr, function (i, row) {
                        data.addRow([
                          (new Date(row.Date)),
                          parseFloat(row.Balance)

                        ]);
                    });

                    var chart = new google.visualization.AreaChart(document.getElementById('runningbalancechart'));

                    chart.draw(data,
                    {
                        title: "Running Bankroll for 6 months",
                        position: "top",
                        fontsize: "10px",
                        legend: 'none',
                        chartArea: { width: '90%' },
                        vAxis: { title: '£' },
                        hAxis: { title: 'Date' }
                        

                    });
                } // calling method

                      ,

                error: function () {
                    alert("Error loading data! Please try again.");
                }
            });
        }

    </script>

    <div class="w3-row w3-container" style="padding-top: 100px !important">
        <div class="w3-content">
            <div class="w3-half w3-left">
                <div id="runningbalancechart"></div>
            </div>
            <div class="w3-half">
                <h1>Running Balance</h1>
                <h5 class="w3-padding-32" style="text-align: justify; margin-right: 20px">Take a look at what kind of bankroll you could be looking at had you started 6 months ago!</h5>
            </div>
        </div>
    </div>
    <div class="w3-row w3-container" style="padding-top: 100px !important">
        <div class="w3-content">
            <div class="w3-half">
                <h1>Daily Point Tracker</h1>
                <h5 class="w3-padding-32" style="text-align: justify; margin-right: 20px">We don't hide our performance, instead we lay it all out for you to see! Just take a look at our Algo's performance over the last 7 days.</h5>
            </div>

            <div class="w3-half w3-right" style="padding-top: 50px">
                <div id="pointschart"></div>
            </div>
        </div>
    </div>

    <div class="w3-row w3-container" style="padding-top: 100px !important">
        <div class="w3-content">
            <div class="w3-half w3-left">
                <div id="growthchart"></div>
            </div>
            <div class="w3-half">
                <h1>Running Bankroll</h1>
                <h5 class="w3-padding-32" style="text-align: justify; margin-right: 20px">Check out just how much you could be sitting on if you had matched our algo with £25 stakes!</h5>
            </div>
        </div>
    </div>

</asp:Content>