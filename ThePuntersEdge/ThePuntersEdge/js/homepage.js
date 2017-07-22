
google.load("visualization", "1", { packages: ["corechart"] });
google.setOnLoadCallback(drawChart);

function drawChart() {
    var data = new google.visualization.DataTable();

    data.addColumn('string', 'Tag');
    data.addColumn('number', 'Points');
    data.addColumn({ type: 'string', role: 'tooltip' });
    data.addRows([
      ['Minimum balance', 200, "Bankroll: £2000"],
      ['Points in play', 15, "Outstanding bets: £150"],
      ['Points won this month', 55, "Profit: £550"]
    ]);

   


    var options = {
        title: 'My Points - £10 per point - Current value: 270pts (£2,700)',
        slices: { 2: { color: 'green' } },
        pieHole: 0.4,
        tooltip: { trigger: 'selection' },
        chartArea: { left: '0' },
        chartArea: { width: '100%'},
        pieSliceText: 'value',
        legend: "none",
        backgroundColor: 'lightgrey',
        'height': 550,
        'width':550,
        pieStartAngle: 0,
        pieSliceTextStyle: { color: 'white', fontName: 'arial', fontSize: 10 }
    };

    var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
    google.visualization.events.addListener(chart, 'ready', readyHandler);
    chart.draw(data, options);

    function readyHandler(e) {
        chart.setSelection([{ "row": 0 }]);
    }


}

function SendEnquiry() {
    var name = $('#form_name').val();
    var email = $('#form_email').val();
    var telephone = $('#form_phone').val();
    var msg = $('#form_message').val();

    if (name == "") {

        $('#form_name').css('border-color', 'red');
        $('#form_name').val = 'Please enter your name!';

    } else {
        $('#form_name').css('border-color', 'none');
        if (/^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/.test(email)) {
            $('#form_email').css('border-color', 'green');
          

                if (msg == "") {

                    $('#form_message').css('border-color', 'red');
                } else
                {
                    // Everything is valid, send message
                   

                    $.ajax({
                        type: 'POST',
                        dataType: 'json',
                        contentType: 'application/json',
                        url: 'default.aspx/enquire',
                        data: "{'name':'" + name + "', 'email':'" + email + "', 'tel':'" + telephone + "', 'msg':'" + msg + "'}",

                        success: function (response) {

                            if (response.d == 'success') {

                             alertify.alert('Enquiry successfully sent. We will be in contact soon.', 0);


                            } else if (response.d == 'fail') {

                                alertify.alert('Your message could not be sent at this time, please try again later.', 0);

                            }
                           


                        },
                        error: function () {
                            
                            alertify.alert('Your message could not be sent at this time, please try again later.', 0);
                        }
                    });
                    
                }
            
        } else {
            $('#form_email').val = 'Invalid Email';
            $('#form_email').css('border-color', 'red');
        }
    }


}