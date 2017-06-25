<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="default.aspx.vb" Inherits="ThePuntersEdge._default" %>

<asp:Content ID="content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        @import url('/css/main.css');
    </style>
  
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    <script src="js/scrollify.js"></script>

    <style>
        table {
            font-family: arial, sans-serif !important;
        }
    </style>


  
 
    <section class="panel home" data-section-name="home" style="height: 638px; background-color:black; opacity:1">
        <div class="inner">
      

            <asp:Image ID="home" runat="server" ImageUrl="~/Images/4652492-horse-racing-wallpapers.jpg" Width="100%" Height="625px" />
            <div class="inner" style="color:white; width:100%; text-align:center; margin-top:0px"><h1>Make £25,000 - £45,000 a year, tax free!</h1></div>
        </div>
    </section>
    <section class="panel overview" data-section-name="overview" style="height: 638px; background-color:#cecece">
        <div class="inner">
           <div class="w3-row-padding w3-padding-64 w3-container" style="padding-top:200px !important">
    <div class="w3-content">
        <div class="w3-twothird">
            <h1>Lorem Ipsum</h1>
            <h5 class="w3-padding-32">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</h5>

            <p class="w3-text-grey">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Excepteur sint
                occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
                laboris nisi ut aliquip ex ea commodo consequat.
            </p>
        </div>

        <div class="w3-third w3-center">
            <i class="fa fa-anchor w3-padding-64 w3-text-red"></i>
        </div>
    </div>
</div>
        </div>
    </section>
    <section class="panel configuration" data-section-name="configuration" style="height: 638px; background-color:hsl(550,60%,55%)">
        <div class="inner">
            
        </div>
    </section>
    <section class="panel options" data-section-name="options" style="height: 638px;">
        <div class="inner">
            <h2>This is section 4</h2>
        </div>
    </section>
    <section class="panel methods" data-section-name="methods" style="height: 638px;">
        <div class="inner">
            <h2>This is section 5</h2>
        </div>
    </section>

    <script>
        $(function () {
            $(".panel").css({ "height": $(window).height() });
            $.scrollify({
                section: ".panel"
            });


            $(".scroll").click(function (e) {
                e.preventDefault();
                $.scrollify("move", $(this).attr("href"));
            });
        });
    </script>
    <script type="text/javascript">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-36251023-1']);
        _gaq.push(['_setDomainName', 'jqueryscript.net']);
        _gaq.push(['_trackPageview']);

        (function () {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();

    </script>



</asp:Content>
