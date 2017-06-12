<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Picks.aspx.vb" Inherits="ThePuntersEdge.Picks" %>

<asp:Content ID="picks" ContentPlaceHolderID="ContentPlaceHolder1" runat="server" class="SmallerPage">
    <script src="/js/main.js"></script>
    <script src="/js/notify.min.js"></script>

    <!-- JavaScript -->
    <script src="//cdn.jsdelivr.net/alertifyjs/1.10.0/alertify.min.js"></script>

    <!-- CSS -->
    <link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.10.0/css/alertify.min.css" />
    <!-- Default theme -->
    <link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.10.0/css/themes/default.min.css" />
    <!-- Semantic UI theme -->
    <link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.10.0/css/themes/semantic.min.css" />
    <!-- Bootstrap theme -->
    <link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.10.0/css/themes/bootstrap.min.css" />
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
    <script>
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
        }

    </script>


    <script>
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


        }
    </script>
    <script>
        function loadusersettings() {

            document.getElementById('usersettings').style.display = "block"
        }
    </script>
    <script>

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




        }
    </script>

    <script>
        function togglepwd() {

            $('#div_pwd_change').toggle();

        };

    </script>
    <script>
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
        }
    </script>
    <script>
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

        }
    </script>
     
     <script>
        function ConfirmDelete(row) {


            var index = row.parentNode.parentNode;//to get row containing image
            var rowIndex = index.rowIndex;//row index of that row.
            var meeting = document.getElementById('ContentPlaceHolder1_gv_matched').rows[rowIndex].cells[0].innerHTML;
            var racetime = document.getElementById('ContentPlaceHolder1_gv_matched').rows[rowIndex].cells[1].innerHTML;
            var horse = document.getElementById('ContentPlaceHolder1_gv_matched').rows[rowIndex].cells[2].innerHTML;


            alertify.confirm("Are you sure you want to delete selection: " + horse + "?",
         function () {

            
                 $.ajax({
                     type: 'POST',
                     dataType: 'json',
                     contentType: 'application/json',
                     url: 'Picks.aspx/DeleteHorse',                
             
                     data: "{'meeting':'" + meeting + "', 'horse':'" + horse + "', 'time':'" + racetime + "'}",

                     success: function (result) {

                       
                         var msg = alertify.success(horse + " deleted.", 0);
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


            

        }
    </script>
    
    <script>
        function color() {

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
            }
)

        }
    </script>
    <script>
        $(document).ready(color)      
    </script>

    <nav class="w3-sidebar w3-bar-block w3-collapse w3-medium w3-theme-l5" style="z-index: 1; width: 150px; display: none" id="mySidebar">
        <a href="javascript:void(0)" onclick="w3_close()" class="w3-right w3-xlarge w3-padding-large w3-hover-black w3-hide-large" title="Close Menu">
            <i class="fa fa-remove"></i>
        </a>
        <h4 class="w3-bar-item" style="text-align: center !important"><i class="fa fa-user-circle-o fa-5x" aria-hidden="true" onclick="alertify.notify('winner', 'success', 5, function () { console.log('dismissed'); });"></i></h4>
        <a class="w3-bar-item">
            <asp:LinkButton class="w3-bar-item w3-button w3-hover-blue w3-select-blue" ID="btn_unmatched" runat="server" Style="text-align: center !important">Unmatched</asp:LinkButton>
        </a>
        <a class="w3-bar-item">
            <asp:LinkButton class="w3-bar-item w3-button w3-hover-blue" ID="btn_matched" runat="server" Style="text-align: center !important">Matched</asp:LinkButton>
        </a>
        <a class="w3-bar-item">
            <h4 class="w3-bar-item" style="text-align: center !important"><i class="fa fa-cog" aria-hidden="true" onclick="loadusersettings()"></i></h4>
        </a>



    </nav>


    <nav class="w3-sidebar w3-bar-block w3-collapse w3-large w3-theme-l5" style="width: 25%; right: 10px !important" id="chatbar">
        <div>
            <div style="width: 100%">

                <h4 class="w3-bar-item" style="padding-left: 0px !important; padding-bottom: 0px !important; padding-top: 0px !important"><b>Stats</b>
                    <i class="fa fa-times-circle" id="HideShowStats" aria-hidden="true" onclick="StatsToggle('hide')"></i>
                </h4>

            </div>

            <div id="StatsInfo" style="display: flex">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <table style="width: 100%">
                            <tr>
                                <td><i class="fa fa-bar-chart" aria-hidden="true">
                                    <asp:Label ID="lbl_daily_pts" runat="server" Text="Daily" Style="font-family: sans-serif; font-size: small"></asp:Label>
                                </i></td>
                                <td><i class="fa fa-gbp" aria-hidden="true">
                                    <asp:Label ID="lbl_daily_profit" runat="server" Text="Daily" Style="font-family: sans-serif; font-size: small"></asp:Label>
                                </i></td>
                            </tr>
                            <tr>
                                <td><i class="fa fa-bar-chart" aria-hidden="true">
                                    <asp:Label ID="lbl_monthly_pts" runat="server" Text="Monthly" Style="font-family: sans-serif; font-size: small"></asp:Label>
                                </i></td>
                                <td><i class="fa fa-gbp" aria-hidden="true">
                                    <asp:Label ID="lbl_monthly_profit" runat="server" Text="Monthly" Style="font-family: sans-serif; font-size: small"></asp:Label>
                                </i></td>
                            </tr>
                            <tr>
                                <td><i class="fa fa-bar-chart" aria-hidden="true">
                                    <asp:Label ID="lbl_alltime_pts" runat="server" Text="All Time" Style="font-family: sans-serif; font-size: small"></asp:Label>
                                </i></td>
                                <td><i class="fa fa-gbp" aria-hidden="true">
                                    <asp:Label ID="lbl_alltime_profit" runat="server" Text="All Time" Style="font-family: sans-serif; font-size: small"></asp:Label>
                                </i></td>
                            </tr>
                        </table>
                        <asp:Timer ID="Stats_timer" runat="server" Interval="30000"></asp:Timer>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </div>


            <div id="piechart" style="display: flex"></div>


        </div>
        <%-- Chat begin--%>
        <h4 class="w3-bar-item" style="padding-left: 0px !important"><b>Chat</b></h4>
        <div style="display: inline-block; float: left; width: 100%; position: relative; height: 50%; text-align: left; top: 0px; left: 0px;">
            <input type="text" placeholder="Enter text" id="chatinput" onkeydown="SendChat(this)">
            <br />
            <asp:Panel ID="Panel1" runat="server">
                <asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" runat="server">

                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="Timer2" EventName="Tick" />
                    </Triggers>

                    <ContentTemplate>

                        <asp:DataList ID="DataList1" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" CellPadding="4" Width="100%" Height="300px" ShowFooter="False" DataSourceID="SQLCHAT" Style="display: block; float: left; overflow-y: scroll;" BorderWidth="1px" ForeColor="Black" Font-Size="Small">


                            <ItemTemplate>

                                <asp:Label ID="UsernameLabel" runat="server" Text='<%# Eval("Username") %>' />
                                <label>:</label>
                                <asp:Label ID="MessageLabel" runat="server" Text='<%# Eval("Message") %>' />




                            </ItemTemplate>

                            <SelectedItemStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />

                        </asp:DataList>
                        <asp:SqlDataSource ID="SQLCHAT" runat="server" ConnectionString="<%$ ConnectionStrings:PuntersEdgeDB %>" SelectCommand="SELECT * FROM [ChatLog] ORDER BY MessageTime DESC"></asp:SqlDataSource>
                        <asp:Timer ID="Timer2" OnTick="Timer2_Tick" runat="server" Interval="1000"></asp:Timer>

                    </ContentTemplate>

                </asp:UpdatePanel>
            </asp:Panel>
            <br />

            <asp:SqlDataSource ID="ChatSource" runat="server" ConnectionString="<%$ ConnectionStrings:ChatSource %>" ProviderName="<%$ ConnectionStrings:ChatSource.ProviderName %>" SelectCommand="SELECT TOP 10 Username, Message, MessageTime FROM ChatLog ORDER BY MessageTime DESC"></asp:SqlDataSource>
        </div>



    </nav>

    <!-- Overlay effect when opening sidebar on small screens -->
    <div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor: pointer" title="close side menu" id="myOverlay"></div>

    <!-- Main content: shift it to the right by 250 pixels when the sidebar is visible -->
    <div class="w3-main" style="margin-left: 150px; margin-right: 28%;">

        <div class="w3-row" style="margin-top: 70px; display: flex; align-items: center;">

            <h1 class="w3-text-black">
                <asp:Label ID="lbl_heading" runat="server" Text="Unmatched"></asp:Label>
            </h1>


            <input type="text" placeholder="What you looking for?" style="width: 35%; height: 35px; margin-left: 55%;" onkeyup="Filter(this, 'ContentPlaceHolder1_gv_matched')">
        </div>
        <div class="w3-row" style="max-height: 700px; overflow: auto">
            <div class=".invisible-scrollbar">


                <asp:UpdatePanel ID="up_selections" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:GridView ID="gv_unmatched" HeaderStyle-CssClass="header-invisible" runat="server" AutoGenerateColumns="False" class="table table-hover table-bordered results" Style="width: auto !important">
                            <Columns>
                                <asp:BoundField DataField="Meeting" HeaderText="Meeting" SortExpression="Meeting">
                                    <ItemStyle Width="200px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="RaceTime" HeaderText="RaceTime" SortExpression="RaceTime">
                                    <ItemStyle Width="200px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Horse" HeaderText="Horse" SortExpression="Horse">
                                    <ItemStyle Width="200px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Bookie" HeaderText="Bookmaker" SortExpression="Bookmaker">
                                    <ItemStyle Width="350px" />
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
                                    <ItemStyle Width="200px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="RaceTime" HeaderText="Race Time">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle Width="200px" />
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
                                    <HeaderStyle HorizontalAlign="center" />
                                    <ItemStyle Width="55px"  HorizontalAlign="Center"/>
                                </asp:BoundField>
                                <asp:BoundField DataField="Result" HeaderText="Result">
                                    <HeaderStyle HorizontalAlign="center" />
                                    <ItemStyle Width="55px"  HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PL" HeaderText="P/L">
                                    <HeaderStyle HorizontalAlign="center" />
                                    <ItemStyle Width="55px" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                           <asp:Button ID="btn_delete_horse" runat="server" Text="Delete" OnClientClick="ConfirmDelete(this)" style="margin-left:25px" />
                                    </ItemTemplate>
                                    <ControlStyle CssClass="w3-button w3-blue w3-small"/>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="btn_EditODds" runat="server" Text="Edit" OnClientClick="EditOdds(this)" />
                                    </ItemTemplate>
                                    <ControlStyle CssClass="w3-button w3-blue w3-small" />
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
    <div id="usersettings" class="modal">

        <div class="modal-content animate" style="width: 20% !important;">
            <div class="imgcontainer">
                <span onclick="document.getElementById('usersettings').style.display='none'" class="close" title="Close Modal">&times;</span>
                <img src="Images/img_avatar2.png" alt="Avatar" class="avatar">
            </div>

            <div class="container">

                <label>Stake</label>
                <asp:TextBox ID="tb_stake" runat="server"></asp:TextBox>

                <label>Password</label>
                <input id="tb_pwd" type="Password" placeholder="Enter old password" />
                Change Password? 
               
                <input type="checkbox" id="passwordchange" onchange="togglepwd()">

                <div style="display: none" id="div_pwd_change">
                    <label>New Password</label>
                    <input id="tb_pwd_new" type="Password" placeholder="Enter new password" />
                    <label>Confirm New Password</label>
                    <input id="tb_pwd_confirm_new" type="Password" placeholder="Confirm new password" />
                </div>

                <input id="btn_save" type="button" value="Save" class="w3-button w3-blue" onclick="UpdateUserSettings();" />

                <label id="lbl_error" style="display: none; color: red">Text here</label>


            </div>


        </div>
    </div>
    <div id="EditHorse" class="modal" style="text-align: right">
        <div class="modal-content animate" style="width: 300px; height: 450px; border-color: none; padding: 10px !important">
            <i class="fa fa-times fa-2x" style="float: right" aria-hidden="true" onclick="document.getElementById('EditHorse').style.display='none'"></i>
            <div style="text-align: left">
                <h3 id="lbl_meeting" style="float: left; width: 100%; margin: 0px"></h3>
                <h5 id="lbl_racetime" style="float: left; margin: 0px; width: 100%"></h5>
                <hr style="width: 100%;" />
            </div>

            <div class="imgcontainer" style="text-align: right; padding-top: 20px; padding-right: 0px">


                <label style="display:inline-block">Selection: </label>
                <label id="lbl_horse" style="display: inline-block">Horse</label>
                <br />
                <br />
                <label>Odds</label>
                <input id="tb_odds" type="number" step="any" style="width: 50px;" />
                <br />
                <br />
                <hr style="width: 100%; color: black" />
                <label style="float: left">Reason:</label>
                <input id="tb_reason" type="text" />

            </div>

            <input id="btn_update_horse_odds" type="button" value="Save" class="w3-button w3-blue w3-small" style="float: right" onclick="UpdateHorse();" />


        </div>

    </div>
     




</asp:Content>
