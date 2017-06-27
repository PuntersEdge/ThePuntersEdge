﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="default.aspx.vb" Inherits="ThePuntersEdge._default" %>

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




    <section class="panel home" data-section-name="home" style="height: 100vh; background-color: black; opacity: 1">
        <div class="inner" style="width: 100% !important; height: 100% !important">

            <div style="height: 78%; width: 100%">
                <asp:Image ID="home" runat="server" ImageUrl="~/Images/4652492-horse-racing-wallpapers.jpg" Style="width: 100% !important; height: 100% !important" />
            </div>


            <div style="color: white; width: 100%; height: 22%; text-align: center; margin-top: 0px; display: inline;">
                <h1 style="display: block; padding: 0px !important; font-size: 5vw">Make £25,000 - £45,000 a year, tax free!</h1>

                <a href="#personalStatement" class="button scroll" style="margin-top: 0px">
                    <span class="scroll-down-arrow"></span>
                </a>

            </div>
        </div>
    </section>
    <section class="panel overview" data-section-name="overview" style="height: 638px; background-color: #cecece">
        <div class="inner">
            <div class="w3-row-padding w3-padding-32 w3-container">
                <div class="w3-content">
                    <div class="w3-row" style="width: 100%">
                        <div style="display: inline-block; width: 48%">
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
                        <div style="display: inline-block; width: 48%">
                            <svg version="1.1" id="development_icon" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="200px" height="200px" viewBox="0 0 67 67" enable-background="new 0 0 67 67" xml:space="preserve">
                                <g id="Layer_3">
                                    <g id="Development">
                                        <circle fill="#65B2C2" cx="33.521" cy="33.574" r="33.26" />
                                        <g>
                                            <g>
                                                <defs>
                                                    <circle id="SVGID_1_" cx="33.521" cy="33.574" r="33.26" />
                                                </defs>
                                                <clipPath id="SVGID_2_">
                                                    <use xlink:href="#SVGID_1_" overflow="visible" />
                                                </clipPath>
                                            </g>
                                        </g>
                                        <g>
                                            <path fill="#FFFFFF" id="large-cog" d="M26.154,25.215c-1.152,0.296-2.248,0.712-3.285,1.126c0.865,4.027-2.535,5.329-4.955,3.612
                c-0.922,0.652-1.614,1.541-1.902,2.785c2.535,1.716,1.268,6.275-2.189,5.861c0,1.303,0,2.604,0,3.91
                c3.688-0.357,4.494,4.204,2.189,6.157c0.635,0.947,0.922,2.252,2.189,2.547c2.189-1.835,5.531-0.178,4.667,3.613
                c1.038,0.414,2.132,0.83,3.284,1.124c0.463-3.198,5.244-3.198,5.763,0c1.153-0.294,2.247-0.71,3.286-1.124
                c-0.864-4.027,2.533-5.332,4.955-3.613c0.922-0.65,1.61-1.541,1.9-2.784c-2.535-1.716-1.267-6.275,2.19-5.862
                c0-1.302,0-2.605,0-3.908c-3.687,0.298-4.495-4.203-2.19-6.159c-0.635-0.948-0.865-2.251-2.189-2.487
                c-2.191,1.836-5.53,0.178-4.666-3.614c-1.039-0.413-2.133-0.829-3.286-1.124C31.109,28.531,26.961,28.531,26.154,25.215z
                 M34.74,40.613c0,3.196-2.536,5.804-5.705,5.804c-3.17,0-5.705-2.607-5.705-5.804c0-3.197,2.535-5.805,5.705-5.805
                C32.205,34.751,34.74,37.356,34.74,40.613z" />
                                            <g>
                                                <path fill="#FFFFFF" id="small-cog" d="M40.646,11.596c-0.627,0.114-1.199,0.23-1.769,0.404c0.227,2.135-1.655,2.596-2.795,1.559
                    c-0.514,0.288-0.914,0.692-1.199,1.327c1.199,1.038,0.285,3.29-1.484,2.886c-0.057,0.691-0.17,1.326-0.229,2.019
                    c1.94,0.058,2.111,2.481,0.801,3.29c0.284,0.52,0.342,1.213,0.969,1.442c1.256-0.806,2.91,0.232,2.225,2.136
                    c0.514,0.287,1.083,0.577,1.654,0.75c0.457-1.615,2.969-1.327,3.025,0.346c0.629-0.115,1.199-0.23,1.77-0.403
                    c-0.228-2.135,1.654-2.598,2.795-1.558c0.514-0.29,0.914-0.693,1.199-1.328c-1.199-1.038-0.285-3.29,1.484-2.886
                    c0.057-0.692,0.173-1.327,0.228-2.02c-1.939-0.057-2.111-2.48-0.799-3.29c-0.284-0.519-0.343-1.212-0.97-1.442
                    c-1.254,0.807-2.91-0.231-2.225-2.135c-0.514-0.289-1.084-0.52-1.655-0.75C43.043,13.616,40.876,13.385,40.646,11.596z
                     M44.242,20.078c-0.172,1.674-1.713,2.827-3.366,2.655c-1.655-0.173-2.853-1.674-2.626-3.348c0.171-1.673,1.712-2.827,3.367-2.654
                    C43.214,16.905,44.413,18.405,44.242,20.078z" />
                                            </g>
                                        </g>
                                    </g>
                                </g>
                            </svg>
                        </div>

                    </div>


                </div>
            </div>
        </div>
    </section>
    <section class="panel configuration" data-section-name="configuration" style="height: 100vh; background-color: hsl(550,60%,55%)">
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
