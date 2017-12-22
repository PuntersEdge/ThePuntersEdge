var chartVars = "KoolOnLoadCallFunction=chartReadyHandler";

KoolChart.create("chart1", "chartHolder", chartVars, "100%", "100%");

function chartReadyHandler(id) {
    document.getElementById(id).setLayout(layoutStr);
    document.getElementById(id).setData(chartData);
}

var layoutStr =
  '<KoolChart backgroundColor="#FFFFFF"  borderStyle="none">'
   + '<Options>'
    + '<Caption text=""/>'
    + '<Legend useVisibleCheck="false"/>'
   + '</Options>'
   + '<Pie2DChart id="chart" innerRadius="0.5" showDataTips="true" selectionMode="single">'
    + '<series>'
     + '<Pie2DSeries nameField="Month" field="Profit" startAngle="20" renderDirection="clockwise" labelPosition="none" color="#ffffff">'
      + '<fills>'
       + '<SolidColor color="#20cbc2"/>'
       + '<SolidColor color="#074d81"/>'
       + '<SolidColor color="#40b2e6"/>'
      + '</fills>'
      + '<showDataEffect>'
       + '<SeriesZoom duration="1300"/>'
      + '</showDataEffect>'
     + '</Pie2DSeries>'
    + '</series>'
    + '<backgroundElements>'
     + '<CanvasElement>'
      + '<Label text="2017" id="widget_pts_month" height="24" horizontalCenter="0" verticalCenter="-10" fontSize="19" color="#333333" backgroundAlpha="0"/>'
     + '</CanvasElement>'
    + '</backgroundElements>'
   + '</Pie2DChart>'
  + '</KoolChart>';

var chartData =
  [{ "Month": "Points", "Profit": 900 }];