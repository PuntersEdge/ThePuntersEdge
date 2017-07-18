<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="default.aspx.vb" Inherits="ThePuntersEdge._default" %>

<asp:Content ID="content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        @import url('/css/homepage.css');
    </style>
  
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script src="js/homepage.js"></script>
    <script src="js/scrollify.js"></script>
    <script src="js/main.js"></script>
    <script src="js/contact_me.js"></script>
    <script src="js/jqBootstrapValidation.js"></script>
    <script type="text/javascript">
  <!--
    $(document).ready(function () {

        if (screen.width >= 1000) {


            $('#scrollprompt').show;

            var s = document.createElement("script");
            s.type = "text/javascript";
            s.src = "js/scroll.js";
            $("body").append(s);


        } else {
            
            $('#ContentPlaceHolder1_imghome').attr("src", "Images/backmob.jpg");           
            $('#panelhome').css("margin-top", "50px");
            $('#ContentPlaceHolder1_imghome').css("height", "60%");
            $('#ContentPlaceHolder1_imghome').css("margin-top", "10%");
            $("#info1").css("display", "inline-block");
            $("#icoLogin").css("color", "white");
            $("#info-box").animate({

                height: '200px'

            });
            $('#headline').css("display", "inline-block");
            $('img#ContentPlaceHolder1_imghome').height('45%');
            $('img#ContentPlaceHolder1_imghome').css('margin-top', '100px');
            $('#donutchart').css('display', 'none');
            $('#bankico').css('display', 'block');
            $('#paperico').css('disaply', 'none');

        }



    })

    //-->
    </script>
    <style>
        table {
            font-family: arial, sans-serif !important;
        }
    </style>

    <%--    <script>
            $(window).bind('hashchange', function () {

                var active = window.location.href.substring(window.location.href.indexOf("#") + 1);
              
               
            });
        </script>--%>



    <section class="panel home" data-section-name="home" style="height: 100vh; margin-bottom: 0px!important; background-color: #cdeeff; opacity: 1">
       
            <div style="height: 100vh; width: 100%">
                <asp:Image ID="imghome" runat="server" ImageUrl="~/Images/4652492-horse-racing-wallpapers.jpg" Style="width: 100% !important; height: 100%; border:none" />
                <div id="headline" class="col-md-6 col-xs-12" style="display: none; width: 100vw; height:50vh; text-align: center; margin-left: auto; margin-right: auto; background-color: #cdeeff;">
                    <h2 class="w3-justify">The Horse Racing Algo that makes £3k+ a month!</h2>
             
                    <p class="w3-text-grey w3-justify">
                        Make a living betting the horses! Our algo has become better than we could ever imagine and has allowed our clients to make a average 150pts each month over the year.
                        That equates to 1800+ pts a year... at £10 a point that would yeild £18,000+ TAX FREE!
                    </p>
                </div>
                <a id="scrollprompt" href="#overview" class="button scroll" style="display: none">
                    <span class="scroll-down-arrow"></span>
                </a>
            </div>

              <div id="homeimgmob" style="height: 50vh; width: 100%">
               
               
            </div>
          




       
    </section>
    <section class="panel overview" data-section-name="overview" style="height: 100vh; background-color: white; margin-bottom: 0px!important">
        <div class="inner">
            <div class="container" style="padding-top: 64px !important">
                <div class="row w65">




                    <div class="col-md-6 col-xs-12">
                        <h2 style="padding-top: 0px !important">Algorithmic horse betting</h2>

                        <p class="w3-text-grey w3-justify">
                            Here at The Punters Edge we've put together the best horse racing system you could imagine. Our algorithm constantly monitors and analyzes the horse racing markets
                and automatically suggests bets at specific bookmakers.
                           
                        </p>
                        <br />
                        <p class="w3-text-grey w3-justify">
                            Since putting our algorithm live we have yet to see a month in the negative. In fact, our average points return is 150 per month!
                           
                        </p>
                    </div>
                    <div class="col-md-6 col-xs-12">

                        <asp:Image CssClass="img" ID="phone" runat="server" src="/Images/phonecog.png" />
                    </div>




                </div>
            </div>
        </div>
    </section>
    <section class="panel configuration" data-section-name="configuration" style="margin-bottom: 0px!important; height: 100vh; background-color: hsl(550,60%,55%)">
        <div class="inner">
            <div class="w3-row w3-center">
                <h1>3 steps to success</h1>
            </div>

            <div class="w3-row" id="strip">

                <div class="row" style="width: 80%; margin-left: auto; margin-right: auto;">
                    <div id="step-login" class="col-md-3 col-xs-12 infoico" style="width: 33.33%">
                        <h3>Log in...</h3>


                        <i id="icoLogin" class="circle-large fa fa-sign-in fa-5x" aria-hidden="true"></i>

                    </div>

                    <div id="step-listen" class="col-md-3 col-xs-12 infoico" style="width: 33.33%">
                        <h3>Listen out...</h3>


                        <i id="icoListen" class="circle-large fa fa-volume-up fa-5x" aria-hidden="true"></i>

                    </div>



                    <div id="step-bet" class="col-md-3 col-xs-12 infoico" style="width: 33.33%">
                        <h3>Place bets</h3>


                        <i id="icoBet" class="circle-large fa fa-handshake-o fa-5x" aria-hidden="true"></i>

                    </div>
                </div>

                <div id="stepbox" class="col-md-3 col-xs-12" style="width: 100%; display: block">
                    <div id="info-box" class="w3-center">
                        <h3 id="info1">The system switches on automatically at 10am every day so make sure to log in at least 10 minutes before.</h3>
                    </div>
                    <div id="info-box2" class="w3-center">
                        <h3 id="info2">Listen out for the unmatched bet notification. You can also see how many unmatched bets you currently have on your list by checking the quick access bar on the left of the system dashboard.</h3>
                    </div>
                    <div id="info-box3" class="w3-center">
                        <h3 id="info3">Action! Speed and consistancy is key to making the most out of The Punters Edge. Be sure to have your bookmakers pre-loaded for speedy bet placement.</h3>
                    </div>
                </div>
            </div>

        </div>

    </section>
    <section class="panel options" data-section-name="options" style="height: 100vh; margin-bottom: 0px!important">
        <div class="inner">
            <div class="container" style="padding-top: 64px !important">
                <div class="row w65">

                    <div class="col-md-6 col-xs-12">
                        <h2>Trial Run</h2>
                        <h3>The proof is in the pudding, and practice makes perfect. </h3>
                        <p>
                            We reccommend that all our new clients paper trade for 1-2 weeks to get them used to the system. This also allows them to see just how profitable the system is without laying out any money to begin with.
                        </p>
                    </div>
                    <div id="paperico" class="col-md-6 col-xs-12" style="margin:auto; text-align:center; display:block">
                       <%-- <asp:Image CssClass="img" ID="img_system" runat="server" src="/Images/mac.png" />--%>

                        <i  class="fa fa-pencil-square" aria-hidden="true" style="font-size:20vw"></i>
                    </div>
                    <div class="col-md-6 col-xs-12" style="display:block; margin-left:auto; margin-right:auto; width: 100%; padding-top:50px">
                        <asp:Image ID="img_oddsmove" runat="server" src="/Images/betfairoddstrimmed.gif" Width="100%" />

                    </div>




                </div>

            </div>
        </div>

    </section>
    <section class="panel methods" data-section-name="methods" style="height: auto !important; margin-bottom: 0px!important; background-color:lightgrey">
        <div class="inner" style="height:auto !important">
            <div class="container" style="padding-top: 64px !important">
                <div class="row w65">




                    <div class="col-md-6 col-xs-12">
                        <h2 style="padding-top: 0px !important">The Points System</h2>

                        <p class="w3-text-black w3-justify">
                            Every system has its up and down days which means it's important to have good bankroll managemnet in place.
                           
                        </p>
                        <br />
                        <p class="w3-text-black w3-justify">
                            Your bankroll - whaetever it may be - is split into a minumum of 200 points. Each point is what you bet on the suggestions produced by the algo.
                           
                        </p>
                        <br />
                        <i id="bankico" class="fa fa-money fa-5x" aria-hidden="true" style="display:none; text-align: -webkit-center"></i>
                        <br />
                        <p class="w3-text-black w3-justify">
                            So, if your bankroll is £1000, you divide that by 200 to get £5. This is the amount you bet each time. At the end of the month, you recalculate your 
                            point value based on your new bankroll. For example, if you start with a £1000 bankroll and make £500 profit after commission, your new bankroll for the following 
                            month will be £1500, and so your new point value is £7.50.
                           
                        </p>
                        <br />
                        <p class="w3-text-black w3-justify">
                            It is very important that you increase your stake each month up to a maximum of £30. Anyone who is actively making a profit from the system but has not increased 
                            their stake accordingly will be at risk of losing their account. Once you are at £30 per point it is then up to you if you increase your stake. You do not have to 
                            register this on the system, so if you do increase, it will be commission free.
                           
                        </p>
                    </div>
                    <div class="col-md-6 col-xs-12" style="max-height:550px">

               
                        <div id="donutchart" style="height: 100%; width:100%; background-color : lightgrey"></div>
                    </div>




                </div>
            </div>
        </div>
    </section>
      <section class="panel enquire" data-section-name="enquire" style="height: auto !important; margin-bottom: 0px!important; background-color: white">
        <div class="inner" style="height:auto !important">
            <div class="container" style="padding-top: 64px !important">
                <div class="row w65">




                    <div class="col-md-6 col-xs-12">
                        <h2 style="padding-top: 0px !important">Sign Up/Enquire</h2>

                        <p class="w3-text-black w3-justify">
                           Our system is only for the serious user who wants to make a full time living from the horses. As a result, our user base is limited in numbers as we only wan't long term clients focused
                            on creating themselves consistent profit all year round. We have put a lot of time and effort into the system and can't afford to have time wasters on board.
                           
                        </p>
                        <br />
                         <h2 style="padding-top: 0px !important">System hours</h2>
                        <p class="w3-text-black w3-justify">
                            <i class="fa fa-clock-o" aria-hidden="true"></i>
                           Mon - Sat:
                            <br />
                            <br />
                            System switches on at 10am sharp and finishes between 6-9pm dependant on the time of year.
                            <br />
                            <i class="fa fa-clock-o" aria-hidden="true"></i>
                            Sun:
                            <br />
                            <br />
                            Switches on at 10am and runs to about 5pm.
                           
                        </p>
                       
                    </div>
                    <div class="col-md-6 col-xs-12" style="padding:50px">

               
                        
              
               
                    </div>




                </div>
            </div>
        </div>
    </section>





</asp:Content>
