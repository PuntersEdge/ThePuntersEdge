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
<script>
   
    function showResult(date) {

        var DateSelected = new Date()


        if (date == 'load') {

            DateSelected = new Date(document.getElementById('datepicker').value).toISOString().slice(0, 10);

            //DateSelected = DateSelected.setDate(DateSelected.getDate() - 1);
            //DateSelected = new Date(DateSelected).toISOString().slice(0, 10);

        } else if (date == 'change') {

            DateSelected = new Date(document.getElementById('datepicker').value).toISOString().slice(0, 10);

        }


        var todaysdate = new Date().toISOString().slice(0, 10);


        if (DateSelected > todaysdate) {
            $("#pastresultsdata tr").remove();
            //$('#noresults').show();
        }

        else {
            //$("#noresults").hide();
            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: 'GoogleCharts.aspx/DaysResults',
                data: "{'DateSelected':'" + DateSelected + "'}",

                success: function (response) {
                    $("#pastresultsdata tr").remove();
                    //$('#noresults').hide();

                    if (response.d == 'none') {
                        $('#noresults').show();

                    } else {

                        var arr = $.parseJSON(response.d)
                        var tr;
                        $("#pastresultsdata").prepend("<tr><th>Racetime</th><th>Horse</th><th>LastTradedPrice</th><th>MarketName</th><th>Result</th></tr>");
                        for (var i = 0; i < arr.length; i++) {
                            tr = $('<tr/>');
                            tr.append("<td>" + arr[i].Racetime + "</td>");
                            tr.append("<td>" + arr[i].Horse + "</td>");
                            tr.append("<td>" + arr[i].LastTradedPrice + "</td>");
                            tr.append("<td>" + arr[i].MarketName + "</td>");
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
<div class="w3-main" style="width:100%">
    <div class="w3-content">
        <div class="w3-row w3-half w3-right">
            <div id="pointsbyday" style="width:100%"></div>
        </div>
        <div>
              <div id='datetimepicker'>
                    <input id='datepicker' class='form-control' type='date' onchange="showResult('change')" />
                    <span class='input-group-addon'>
                        <span class='icon-calendar' data-time-icon='icon-time' data-date-icon='icon-calendar'></span>
                    </span>
                </div>
            <asp:gridview runat="server" id="gv_results"></asp:gridview>
               
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
 </form>     
          
