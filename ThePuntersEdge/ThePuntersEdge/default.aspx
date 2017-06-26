<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="default.aspx.vb" Inherits="ThePuntersEdge._default" %>

<asp:Content ID="content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        @import url('/css/homepage.css');
    </style>
  
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    <script src="js/scrollify.js"></script>

    <style>
        table {
            font-family: arial, sans-serif !important;
        }
    </style>


  
 
    <section class="panel home" data-section-name="home" style="height: 100vh; background-color:black; opacity:1">
        <div class="inner" style="width:100% !important; height:100% !important">
      
            <div style="height:80%; width:100%">
                                  <asp:Image ID="home" runat="server" ImageUrl="~/Images/4652492-horse-racing-wallpapers.jpg" style="Width:100% !important; Height:100% !important" />
            </div>
          
            <div style="color:white; width:100%; text-align:center; margin-top:0px; display:inline;"><h1 style="display:inline">Make £25,000 - £45,000 a year, tax free!</h1></div>
        </div>
    </section>
    <section class="panel overview" data-section-name="overview" style="height: 638px; background-color:#cecece">
        <div class="inner">
           <div class="w3-row-padding w3-padding-32 w3-container">
    <div class="w3-content">
        <div class="w3-row">
            <div style="display:inline-block">
            <h1>Algorithmic horse betting</h1>

            <p class="w3-text-grey">
               Here at The Punters Edge we've put together the best horse racing system you could imagine. Our algorithm constantly monitors and analyzes the horse racing markets
                and automatically suggests bets at specific bookmakers.
            </p>
            <br />
              <p class="w3-text-grey">
              Since putting our algorithm live we have yet to see a month in the negative. In fact, our average points return is 150 per month!
            </p>
                </div>
             <div style="display:inline-block">
            <i class="fa fa-anchor w3-padding-64 w3-text-red"></i>
        </div>
        </div>

       
    </div>
</div>
        </div>
    </section>
    <section class="panel configuration" data-section-name="configuration" style="height: 100vh; background-color:hsl(550,60%,55%)">
        <div class="inner">
            
        </div>
    </section>
    <section class="panel options" data-section-name="options" style="height: 100vh;">
        <div class="inner">
            <h2>This is section 4</h2>
        </div>
    </section>
    <section class="panel methods" data-section-name="methods" style="height: 100vh;">
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
