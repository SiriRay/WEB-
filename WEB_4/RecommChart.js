// This function will be called from your Swift code with the necessary data.
function loadChartData(recommendationData) {
    Highcharts.chart('container', {
        chart: {
            type: 'column',
            backgroundColor: '#f5f5f5'
        },
        title: {
            text: 'Recommendation trends'
        },
        xAxis: {
            type: 'category'
        },
        yAxis: {
            allowDecimals: false,
            min: 0,
            title: {
                text: '#Analysis'
            }
        },
        tooltip: {
            formatter: function() {
                return '<b>' + this.key + '</b><br/>' +
                    this.series.name + ': ' + this.y + '<br />' +
                    'Total: ' + this.point.stackTotal;
            }
        },
        plotOptions: {
            column: {
                stacking: 'normal',
                dataLabels: {
                    enabled: true
                }
            }
        },
        series: [{
            name: 'Strong Buy',
            data: recommendationData.map(data => data.strongBuy),
            color: '#195f32'
        }, {
            name: 'Buy',
            data: recommendationData.map(data => data.buy),
            color: '#23af50'
        }, {
            name: 'Hold',
            data: recommendationData.map(data => data.hold),
            color: '#af7d28'
        }, {
            name: 'Sell',
            data: recommendationData.map(data => data.sell),
            color: '#f05050'
        }, {
            name: 'Strong Sell',
            data: recommendationData.map(data => data.strongSell),
            color: '#732828'
        }]
    });
}

// This would be a placeholder call - you'll replace it with actual data passed from Swift.
loadChartData([]);
