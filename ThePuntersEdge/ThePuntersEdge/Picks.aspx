<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Picks.aspx.vb" Inherits="ThePuntersEdge.Picks" %>

<asp:Content ID="picks" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   



    <script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU="  crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
    <script type="text/javascript" src="//www.google.com/jsapi"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//cdn.jsdelivr.net/alertifyjs/1.10.0/alertify.min.js" async></script>  
    <script src="/js/notify.min.js" async></script>
    <script src="/js/tablepager.js" async></script>
    <script src="/js/Picks.js"></script>
    <script> $('#menu-bar').css("background", "#337ab7");</script>
    <script>$(document).ready(function () { beep(); })</script>
    <script>$(document).ready(notifications)</script>
     
   
    
    <audio id="beep" src="."></audio>


    <nav class="w3-sidebar w3-bar-block w3-collapse w3-large w3-theme-l5" style="width: 25%; right: 10px !important; margin-top: 10px !important" id="chatbar">
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
    <div class="w3-main" style="margin-left: 0px; margin-right: 28%;">

        <div class="w3-row" style="max-height: 700px; margin-top: 70px; overflow: auto">
            <div runat="server" id="div_portfolio" class="w3-row" style="margin-left: 150px; padding-right: 150px; display: none; position: fixed; width: 72%; background-color: white; height: 100%; top: 150px !important">
                <iframe src="GoogleCharts.aspx" style="border: none; width: 100%"></iframe>
            </div>
            <div class=".invisible-scrollbar">

                <asp:UpdatePanel ID="up_selections" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>

                        <nav class="w3-sidebar w3-bar-block w3-collapse w3-medium w3-theme-l5" style="z-index: 1; width: 150px; display: none; margin-top: 10px !important" id="mySidebar">
                            <a href="javascript:void(0)" onclick="w3_close()" class="w3-right w3-xlarge w3-padding-large w3-hover-black w3-hide-large" title="Close Menu">
                                <i class="fa fa-remove"></i>
                            </a>
                            <h4 class="w3-bar-item" style="text-align: center !important"><i class="fa fa-user-circle-o fa-5x" aria-hidden="true" onclick="alertify.notify('winner', 'success', 5, function () { console.log('dismissed'); });"></i></h4>
                            <a class="w3-bar-item">
                                <asp:LinkButton cssclass="w3-bar-item w3-button w3-hover-blue w3-select-blue" ID="btn_unmatched" runat="server" Style="text-align: center !important" CausesValidation="False">
                                    Unmatched
                                    
                                   

                                    <span runat="server" id="notify_unmatched" class="badge" style="background: red; display: none; vertical-align: initial;">5</span>
                                </asp:LinkButton>
                            </a>
                            <a class="w3-bar-item">
                                <asp:LinkButton cssclass="w3-bar-item w3-button w3-hover-blue" ID="btn_matched" runat="server" CausesValidation="False" Style="text-align: center !important">
                                    Matched
                                    
                                   

                                    <span runat="server" id="notify_matched" class="badge" style="background: #22b334; display: none; vertical-align: initial;">5</span>
                                </asp:LinkButton>

                            </a>
                            <a class="w3-bar-item">
                                <asp:LinkButton cssclass="w3-bar-item w3-button w3-hover-blue" ID="btn_gone" runat="server" CausesValidation="False" Style="text-align: center !important">
                                    Dismissed
                                   
                                   

                                    <span runat="server" id="notify_dismissed" class="badge" style="background: #71808c; display: none; vertical-align: initial;">5</span>
                                </asp:LinkButton>
                            </a>
                            <a class="w3-bar-item">
                                <asp:LinkButton cssclass="w3-bar-item w3-button w3-hover-blue" ID="btn_deleted" runat="server" CausesValidation="False" Style="text-align: center !important">
                                    Deleted
                                   
                                   

                                    <span runat="server" id="notify_deleted" class="badge" style="background: #71808c; display: none; vertical-align: initial;">5</span>
                                </asp:LinkButton>
                            </a>
                            <a class="w3-bar-item">
                                <asp:LinkButton cssclass="w3-bar-item w3-button w3-hover-blue" ID="btn_invoices" runat="server" CausesValidation="False" Style="text-align: center !important">
                                    Invoices
                                   
                                   

                                    <span runat="server" id="notify_invoices" class="badge" style="background: red; display: none; vertical-align: initial;">5</span>
                                </asp:LinkButton>
                            </a>
                            <a class="w3-bar-item">
                                <asp:LinkButton cssclass="w3-bar-item w3-button w3-hover-blue" ID="btn_portfolio" runat="server" CausesValidation="False" Style="text-align: center !important">
                                    Portfolio
                                    <i class="fa fa-line-chart" aria-hidden="true"></i>
                                </asp:LinkButton>
                            </a>
                            <a class="w3-bar-item">
                                <h4 class="w3-bar-item" style="text-align: center !important"><i class="fa fa-cog" aria-hidden="true" onclick="loadusersettings()"></i></h4>
                            </a>
                        </nav>

                        <div class="w3-row" style="margin-left: 170px; padding-right: 150px; display: flex; align-items: center; position: fixed; width: 72%; background-color: white; height: 100px; top: 70px !important">

                            <h1 class="w3-text-black">
                                <asp:Label ID="lbl_heading" runat="server" Text="Unmatched"></asp:Label>
                            </h1>


                            <input runat="server" id="search_box" type="text" placeholder="What you looking for?" style="height: 35px; margin-left: 15%; display: inline-flex" onkeyup="Filter(this, 'ContentPlaceHolder1_gv_matched')">
                        </div>


                        <div id="grids" style="display: inline-block; padding-top: 75px">
                            <asp:GridView ID="gv_invoices" runat="server" AutoGenerateColumns="False" GridLines="none" Style="margin-left: 170px">
                                <Columns>
                                    <asp:BoundField DataField="Period" HeaderText="Period" SortExpression="Period">

                                        <ItemStyle Width="150px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Stake" HeaderText="Stake" SortExpression="Stake">
                                        <ItemStyle Width="150px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Profit" HeaderText="Profit" SortExpression="Profit">
                                        <ItemStyle Width="150px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Commission" HeaderText="Commission" SortExpression="Commission">
                                        <ItemStyle Width="150px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BalanceDue" HeaderText="Balance" SortExpression="BalanceDue">
                                        <ItemStyle Width="150px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Paid" HeaderText="Paid" SortExpression="Paid">
                                        <ItemStyle Width="150px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes">
                                        <ItemStyle Width="150px" />
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="MarkPaid" runat="server" OnClientClick="ConfirmInvoice(this)" Text="Mark as payment sent." Style="margin-left: 25px" />
                                        </ItemTemplate>
                                        <ControlStyle CssClass="w3-button w3-blue w3-small" />
                                    </asp:TemplateField>

                                </Columns>
                                <RowStyle CssClass="grid-row-style" />

                            </asp:GridView>
                            <asp:GridView ID="gv_gone" runat="server" AutoGenerateColumns="False" GridLines="none" Style="margin-left: 170px">
                                <Columns>
                                    <asp:BoundField DataField="Meeting" HeaderText="Meeting" SortExpression="Meeting">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RaceTime" HeaderText="RaceTime" SortExpression="RaceTime">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Horse" HeaderText="Horse" SortExpression="Horse">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Bookmaker" HeaderText="Bookmaker" SortExpression="Bookmaker">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle Width="350px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Odds" HeaderText="Odds" SortExpression="Odds">
                                        <HeaderStyle HorizontalAlign="center" />
                                        <ItemStyle Width="55px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="RestoreHorse" runat="server" OnClientClick="RestoreHorse(this)" Text="Restore" Style="margin-left: 25px" />
                                        </ItemTemplate>
                                        <ControlStyle CssClass="w3-button w3-blue w3-small" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="grid-row-style" />
                            </asp:GridView>
                            <asp:GridView ID="gv_deleted" runat="server" AutoGenerateColumns="False" GridLines="none" Style="margin-left: 170px">
                                <Columns>
                                    <asp:BoundField DataField="Meeting" HeaderText="Meeting" SortExpression="Meeting">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RaceTime" HeaderText="RaceTime" SortExpression="RaceTime">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Horse" HeaderText="Horse" SortExpression="Horse">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Bookmaker" HeaderText="Bookmaker" SortExpression="Bookmaker">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle Width="350px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Odds" HeaderText="Odds" SortExpression="Odds">
                                        <HeaderStyle HorizontalAlign="center" />
                                        <ItemStyle Width="55px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="RestoreHorse" runat="server" OnClientClick="ReMatch(this)" Text="Restore to matched" Style="margin-left: 25px" />
                                        </ItemTemplate>
                                        <ControlStyle CssClass="w3-button w3-blue w3-small" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="grid-row-style" />
                            </asp:GridView>
                            <asp:GridView ID="gv_unmatched" runat="server" AutoGenerateColumns="False" GridLines="none" Style="margin-left: 170px">
                                <Columns>
                                    <asp:BoundField DataField="Meeting" HeaderText="Meeting" SortExpression="Meeting">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RaceTime" HeaderText="RaceTime" SortExpression="RaceTime">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Horse" HeaderText="Horse" SortExpression="Horse">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle Width="200px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Bookie" HeaderText="Bookmaker" SortExpression="Bookmaker">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle Width="350px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Odds" HeaderText="Odds" SortExpression="Odds">
                                        <HeaderStyle HorizontalAlign="center" />
                                        <ItemStyle Width="55px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="MatchHorse" runat="server" OnClientClick="MatchHorse(this)" Text="Match" Style="margin-left: 25px" />
                                        </ItemTemplate>
                                        <ControlStyle CssClass="w3-button w3-blue w3-small" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="GoneHorse" runat="server" OnClientClick="GoneHorse(this)" Text="Gone" />
                                        </ItemTemplate>
                                        <ControlStyle CssClass="w3-button w3-blue w3-small" />
                                    </asp:TemplateField>
                                </Columns>

                                <RowStyle CssClass="grid-row-style" />
                            </asp:GridView>

                            <asp:GridView ID="gv_matched" runat="server" AutoGenerateColumns="false" GridLines="none" Style="margin-left: 170px">
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
                                        <ItemStyle Width="55px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Result" HeaderText="Result">
                                        <HeaderStyle HorizontalAlign="center" />
                                        <ItemStyle Width="55px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PL" HeaderText="P/L">
                                        <HeaderStyle HorizontalAlign="center" />
                                        <ItemStyle Width="55px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button UseSubmitBehavior="false" ID="btn_delete_horse" runat="server" Text="Delete" OnClientClick="ConfirmDelete(this)" Style="margin-left: 25px" />
                                        </ItemTemplate>
                                        <ControlStyle CssClass="w3-button w3-blue w3-small" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button UseSubmitBehavior="false" ID="btn_EditODds" runat="server" Text="Edit" OnClientClick="EditOdds(this)" />
                                        </ItemTemplate>
                                        <ControlStyle CssClass="w3-button w3-blue w3-small" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="grid-row-style" />
                            </asp:GridView>
                            <asp:Timer ID="Timer1" OnTick="Timer1_Tick" runat="server" Interval="60000"></asp:Timer>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

        </div>

    </div>
    <div id="usersettings" class="modal">

        <div class="modal-content animate" style="width: 30% !important; height: auto !important">
            <div class="imgcontainer">
                <span onclick="document.getElementById('usersettings').style.display='none'" class="close" title="Close Modal">&times;</span>
                <img src="Images/img_avatar2.png" alt="Avatar" class="avatar">
            </div>

            <div class="container" style="width: 100% !important">

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


                <label style="display: inline-block">Selection: </label>
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
    <div id="PayInvoice" class="modal" style="text-align: right">
        <div class="modal-content animate" style="width: 300px; height: 450px; border-color: none; padding: 10px !important">
            <i class="fa fa-times fa-2x" style="float: right" aria-hidden="true" onclick="document.getElementById('PayInvoice').style.display='none'"></i>
            <div style="text-align: left">
                <h3 id="lbl_period" style="display: inline-flex;"></h3>

                <hr style="width: 100%;" />

            </div>

            <div class="imgcontainer" style="text-align: right; padding-top: 20px; padding-right: 0px">
                <h4 style="margin: 0px; display: inline-block">Balance due:</h4>
                <h3 id="lbl_balancedue" style="text-align: right; margin: 0px; display: inline-block"></h3>

                <br />
                <br />
                <hr style="width: 100%; color: black" />
                <label style="float: left">Payment Method:</label>
                <input id="tb_method" type="text" />

            </div>

            <input id="btn_confirm_invoice" type="button" value="confirm" class="w3-button w3-blue w3-small" style="float: right" onclick="MarkPaid();" />


        </div>

    </div>


</asp:Content>
