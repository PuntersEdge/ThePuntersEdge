<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Picks.aspx.vb" Inherits="ThePuntersEdge.Picks" %>

<asp:Content ID="picks" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="/js/main.js"></script>
    <script>
        // Get the Sidebar
        var mySidebar = document.getElementById("mySidebar");

        // Get the DIV with overlay effect
        var overlayBg = document.getElementById("myOverlay");

        // Toggle between showing and hiding the sidebar, and add overlay effect
        function w3_open() {
            if (mySidebar.style.display === 'block') {
                mySidebar.style.display = 'none';
                overlayBg.style.display = "none";
            } else {
                mySidebar.style.display = 'block';
                overlayBg.style.display = "block";
            }
        }

        // Close the sidebar with the close button
        function w3_close() {
            mySidebar.style.display = "none";
            overlayBg.style.display = "none";
        }
    </script>
    <script type="text/javascript">
        // Load google charts
        google.charts.load('current', { 'packages': ['corechart', 'line'] });
        google.charts.setOnLoadCallback(drawChart);

        // Draw the chart and set the chart values
        function drawChart() {
            var data = google.visualization.arrayToDataTable([
            ['Task', 'Points'],
            ['Jan', 88],
            ['Feb', 155],
            ['March', 250],
            ['April', 120],
            ['May', 350]
            ]);

            // Optional; add a title and set the width and height of the chart
            var options = {
               
                'width': 400,
                'height':200,
                'legend': 'none',
                'chartArea': { 'width': '90%', 'height': '65%' },
                vAxis: {
                    gridlines: {
                        color: 'transparent'
                    }
                }
                
            }
            


            // Display the chart inside the <div> element with id="piechart"
            var chart = new google.visualization.LineChart(document.getElementById('piechart'));
            chart.draw(data, options);
        }
    </script>
    <script>
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
    </script>


    <nav class="w3-sidebar w3-bar-block w3-collapse w3-medium w3-theme-l5 w3-animate-left" style="z-index: 3; width: 200px; display: none" id="mySidebar">
        <a href="javascript:void(0)" onclick="w3_close()" class="w3-right w3-xlarge w3-padding-large w3-hover-black w3-hide-large" title="Close Menu">
            <i class="fa fa-remove"></i>
        </a>
        <h4 class="w3-bar-item"><b>Account</b></h4>
        <a class="w3-bar-item" href="#">
            <asp:LinkButton class="w3-bar-item w3-button w3-hover-blue w3-select-blue" ID="btn_unmatched" runat="server">Unmatched</asp:LinkButton>
        </a>
        <a class="w3-bar-item" href="#">
            <asp:LinkButton class="w3-bar-item w3-button w3-hover-blue" ID="btn_matched" runat="server">Matched</asp:LinkButton>
        </a>




    </nav>


    <nav class="w3-sidebar w3-bar-block w3-collapse w3-large w3-theme-l5 w3-animate-right" style="width: 25%; right: 0px !important" id="chatbar">
        <div>
            <div style="width: 100%">

                <h4 class="w3-bar-item" style="padding-left: 0px !important; padding-bottom: 0px !important; padding-top: 0px !important"><b>Stats</b></h4>

            </div>


            <table style="width: 100%">
                <tr>
                    <td><i class="fa fa-bar-chart" aria-hidden="true">
                        <asp:Label ID="lbl_daily_pts" runat="server" Text="Daily"></asp:Label>
                    </i></td>
                    <td><i class="fa fa-gbp" aria-hidden="true">
                        <asp:Label ID="lbl_daily_profit" runat="server" Text="Daily"></asp:Label>
                    </i></td>
                </tr>
                <tr>
                    <td><i class="fa fa-bar-chart" aria-hidden="true">
                        <asp:Label ID="lbl_monthly_pts" runat="server" Text="Monthly"></asp:Label>
                    </i></td>
                    <td><i class="fa fa-gbp" aria-hidden="true">
                        <asp:Label ID="lbl_monthly_profit" runat="server" Text="Monthly"></asp:Label>
                    </i></td>
                </tr>
                <tr>
                    <td><i class="fa fa-bar-chart" aria-hidden="true">
                        <asp:Label ID="lbl_alltime_pts" runat="server" Text="All Time"></asp:Label>
                    </i></td>
                    <td><i class="fa fa-gbp" aria-hidden="true">
                        <asp:Label ID="lbl_alltime_profit" runat="server" Text="All Time"></asp:Label>
                    </i></td>
                </tr>
            </table>

            <div id="piechart"></div>


        </div>


        <h4 class="w3-bar-item" style="padding-left: 0px !important"><b>Chat</b></h4>

    </nav>

    <!-- Overlay effect when opening sidebar on small screens -->
    <div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor: pointer" title="close side menu" id="myOverlay"></div>

    <!-- Main content: shift it to the right by 250 pixels when the sidebar is visible -->
    <div class="w3-main" style="margin-left: 250px; margin-right: 25%">

        <div class="w3-row" style="margin-top: 70px; display: flex; align-items: center;">

            <h1 class="w3-text-black">
                <asp:Label ID="lbl_heading" runat="server" Text="Unmatched"></asp:Label>
            </h1>


            <input type="text" placeholder="What you looking for?" style="width: 35%; height: 35px; margin-left: 44%;" onkeyup="Filter(this, 'ContentPlaceHolder1_gv_matched')">
        </div>
        <div class="w3-row">
            <div>


                <asp:UpdatePanel ID="up_selections" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:GridView ID="gv_unmatched" HeaderStyle-CssClass="header-invisible" runat="server" AutoGenerateColumns="False" class="table table-hover table-bordered results">
                            <Columns>
                                <asp:BoundField DataField="Meeting" HeaderText="Meeting" SortExpression="Meeting">
                                    <ItemStyle Width="150px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="RaceTime" HeaderText="RaceTime" SortExpression="RaceTime">
                                    <ItemStyle Width="100px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Horse" HeaderText="Horse" SortExpression="Horse">
                                    <ItemStyle Width="150px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Bookie" HeaderText="Bookmaker" SortExpression="Bookmaker">
                                    <ItemStyle Width="200px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Odds" HeaderText="Odds" SortExpression="Odds">
                                    <ItemStyle Width="150px" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="MatchHorse" runat="server"
                                            CommandName="MatchTheHorse" OnCommand="MatchHorse_Command" CommandArgument="<%# CType(Container, GridViewRow).RowIndex %>"
                                            Text="Match" Width="50px" CssClass="button-grid" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="header-invisible" />
                            <RowStyle BorderColor="RED" />
                        </asp:GridView>

                        <asp:GridView ID="gv_matched" runat="server" AutoGenerateColumns="false" GridLines="none">
                            <Columns>
                                <asp:BoundField DataField="Meeting" HeaderText="Meeting">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle Width="150px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="RaceTime" HeaderText="Race Time">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle Width="100px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Horse" HeaderText="Horse">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle Width="200px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Bookie" HeaderText="Bookmaker">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle Width="350px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Odds" HeaderText="Odds">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle Width="55px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Result" HeaderText="Result">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle Width="55px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PL" HeaderText="P/L">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle Width="55px" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="DeleteMatch" runat="server"
                                            CommandName="DeleteMatch" OnCommand="DeleteMatch_Command" CommandArgument="<%# CType(Container, GridViewRow).RowIndex %>"
                                            Text="Delete" CssClass="button-grid" />
                                    </ItemTemplate>
                                    <ControlStyle CssClass="button-grid" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="EditOdds" runat="server"
                                            CommandName="EditOdds" OnCommand="EditOdds_Command" CommandArgument="<%# CType(Container, GridViewRow).RowIndex %>"
                                            Text="Edit" />
                                    </ItemTemplate>
                                    <ControlStyle CssClass="button-grid" />
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle CssClass="grid-row-style" />
                        </asp:GridView>
                        <asp:Timer ID="Timer1" OnTick="Timer1_Tick" runat="server" Interval="60000"></asp:Timer>

                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

        </div>

    </div>



</asp:Content>
