<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Picks.aspx.vb" Inherits="ThePuntersEdge.Picks" %>

<asp:Content ID="picks" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
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


    <nav class="w3-sidebar w3-bar-block w3-collapse w3-medium w3-theme-l5 w3-animate-left" style="z-index: 3; width: 200px; margin-top: 55px; display: none" id="mySidebar">
        <a href="javascript:void(0)" onclick="w3_close()" class="w3-right w3-xlarge w3-padding-large w3-hover-black w3-hide-large" title="Close Menu">
            <i class="fa fa-remove"></i>
        </a>
        <h4 class="w3-bar-item"><b>Account</b></h4>
        <a class="w3-bar-item" href="#">
            <asp:LinkButton class="w3-bar-item w3-button w3-hover-blue" ID="btn_unmatched" runat="server">Unmatched</asp:LinkButton>
        </a>
         <a class="w3-bar-item" href="#">
            <asp:LinkButton class="w3-bar-item w3-button w3-hover-blue" ID="btn_matched" runat="server">Matched</asp:LinkButton>
        </a>
         <a class="w3-bar-item" href="#">
            <asp:LinkButton class="w3-bar-item w3-button w3-hover-blue" ID="btn_portfolio" runat="server">Portfolio</asp:LinkButton>
        </a>  

    </nav>


    <nav class="w3-sidebar w3-bar-block w3-collapse w3-large w3-theme-l5 w3-animate-right" style="width: 25%; margin-top: 55px; right: 0px !important" id="chatbar">
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






        </div>

        <h4 class="w3-bar-item" style="padding-left: 0px !important"><b>Chat</b></h4>

    </nav>

    <!-- Overlay effect when opening sidebar on small screens -->
    <div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor: pointer" title="close side menu" id="myOverlay"></div>

    <!-- Main content: shift it to the right by 250 pixels when the sidebar is visible -->
    <div class="w3-main" style="margin-left: 250px; margin-right: 25%">

        <div class="w3-row w3-padding-64">
            <div class="w3-twothird w3-container">
                <h1 class="w3-text-black">
                    <asp:Label ID="lbl_heading" runat="server" Text="Heading"></asp:Label></h1>
                <asp:UpdatePanel ID="up_selections" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gv_data" runat="server"></asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

        </div>   
            
    </div>



</asp:Content>
