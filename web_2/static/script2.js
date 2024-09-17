document.addEventListener('DOMContentLoaded', function() {

    document.getElementById('stock-search-form').addEventListener('submit', submitfunction);
    document.getElementById('company-details-button').addEventListener('click', showCompanyDetails);
    document.getElementById('quote-details-button').addEventListener('click', showQuoteDetails);
    document.getElementById('chart-details-button').addEventListener('click', showChartDetails);
    document.getElementById('clear-button').addEventListener('click', clearFunction);
    document.getElementById('news-details-button').addEventListener('click', showNewsDetails);

});

function submitfunction(e) {
    e.preventDefault();

    document.getElementById('company-details').innerHTML = '';
        document.getElementById('news-details').innerHTML = '';
        document.getElementById('error-message').style.display = 'none';
        document.getElementById('search-results').textContent = '';

        document.getElementById('company-details-button').style.display = 'none';
        document.getElementById('quote-details-button').style.display = 'none';
        document.getElementById('chart-details-button').style.display = 'none';
        document.getElementById('news-details-button').style.display = 'none';
    
        const symbol = document.getElementById('stock-symbol').value.toUpperCase();
    
    if (!symbol) {
        alert('Please fill out this field');
        return;
    }

    Promise.all([
        fetch(`https://starlight-5642.nw.r.appspot.com/company?symbol=${symbol}`).then(response => response.ok ? response.json() : Promise.reject('Failed to fetch company data')),
        fetch(`https://starlight-5642.nw.r.appspot.com/quote?symbol=${symbol}`).then(response => response.ok ? response.json() : Promise.reject('Failed to fetch quote data')),
        fetch(`https://starlight-5642.nw.r.appspot.com/recommendation?symbol=${symbol}`).then(response => response.ok ? response.json() : Promise.reject('Failed to fetch recommendation data')),
        fetch(`https://starlight-5642.nw.r.appspot.com/chart-data?symbol=${symbol}`).then(response => response.ok ? response.json() : Promise.reject('Failed to fetch chart data')),
        fetch(`https://starlight-5642.nw.r.appspot.com/company-news?symbol=${symbol}`).then(response => response.ok ? response.json() : Promise.reject('Failed to fetch company news'))
    ])
    .then(([companyData, quoteData, recommendationData, chartData, newsData]) => {
        if (companyData.error) {
            document.getElementById('search-results').textContent = companyData.error;
            throw new Error('Company data error');
        }
        document.getElementById('company-details').innerHTML = `
                        <img src="${companyData.logo}" alt="Company Logo" style="width: 100px; height: auto;">
                        <table>
                          <tr>
                            <td><strong>Company Name</strong></td>
                            <td>${companyData.name}</td>
                          </tr>
                          <tr>
                            <td><strong>Stock Ticker Symbol</strong></td>
                            <td>${companyData.ticker}</td>
                          </tr>
                          <tr>
                            <td><strong>Stock Exchange Code</strong></td>
                            <td>${companyData.exchange}</td>
                          </tr>
                          <tr>
                            <td><strong>Company Start Date</strong></td>
                            <td>${companyData.ipo}</td>
                          </tr>
                          <tr>
                            <td><strong>Category</strong></td>
                            <td>${companyData.finnhubIndustry}</td>
                          </tr>
                        </table>
                        
                        `;
        document.getElementById('company-details-button').style.display = 'inline';
        showCompanyDetails();

        if (quoteData.error) {
            document.getElementById('search-results').textContent = quoteData.error;
            throw new Error('Quote data error');
        }
        const tradingDay = formatDate(quoteData.t);
                        const upArrowImg = '<img src="static/img/GreenArrowUp.png" alt="Up" style="height: 18px; width: 18px;" align="center" />';
                        const downArrowImg = '<img src="static/img/RedArrowDown.png" alt="Down" style="height: 18px; width: 18px; align="center"" />';
                        const changeArrowImg = quoteData.d > 0 ? upArrowImg : quoteData.d < 0 ? downArrowImg : '';

                        const changeArrow = quoteData.d > 0 ? '↑' : quoteData.d < 0 ? '↓' : '';
                        document.getElementById('quote-details').innerHTML = `
                        <table id="quote-table">
                        <tr><td><strong>Stock Ticker Symbol</strong></td><td>${symbol}</td></tr>
                        <tr><td><strong>Trading Day</strong></td><td>${tradingDay}</td></tr>
                        <tr><td><strong>Previous Closing Price</strong></td><td>${quoteData.pc}</td></tr>
                        <tr><td><strong>Opening Price</strong></td><td>${quoteData.o}</td></tr>
                        <tr><td><strong>High Price</strong></td><td>${quoteData.h}</td></tr>
                        <tr><td><strong>Low Price</strong></td><td>${quoteData.l}</td></tr>
                        <tr><td><strong>Change</strong></td><td>${quoteData.d} ${changeArrowImg}</td></tr>
                        <tr><td><strong>Change Percent</strong></td><td>${quoteData.dp} ${changeArrowImg}</td></tr>
                    </table>
                        `;
        document.getElementById('quote-details-button').style.display = 'inline';

        if (recommendationData.error) {
            document.getElementById('search-results').textContent = recommendationData.error;
        } else {
            document.getElementById('quote-details').innerHTML += `
                        <div id="recommendation-trends">
                        <div class=" strong-sell-text">Strong <br>Sell</div>
                        <div class="trend strong-sell">${recommendationData.strongSell}</div>
                        <div class="trend sell">${recommendationData.sell}</div>
                        <div class="trend hold">${recommendationData.hold}</div>
                        <div class="trend buy">${recommendationData.buy}</div>
                        <div class="trend strong-buy">${recommendationData.strongBuy}</div>
                        <div class=" strong-buy-text">Strong <br>Buy</div>
                        <div class="trend-heading">Recommendation Trends</div>
                    </div>
                        `;
        }

        const maxVolume = Math.max(...chartData.volume_data.map(item => item[1]));
                    const yAxisMaxVolume = maxVolume * 2;

                    Highcharts.stockChart('highcharts-container', {
                        rangeSelector: {
                            buttons: [{
                                type: 'day',
                                count: 7,
                                text: '7d'
                            }, {
                                type: 'day',
                                count: 15,
                                text: '15d'
                            }, {
                                type: 'month',
                                count: 1,
                                text: '1m'
                            }, {
                                type: 'month',
                                count: 3,
                                text: '3m'
                            }, {
                                type: 'all',
                                count: 6,
                                text: '6m'
                            }],
                            selected: 4,
                            inputEnabled: false
                        },
                        chart: {
                            zoomType: 'x',
                            height: 550,
                            width: 900,
                            marginRight:70,
                            marginLeft:70,
                          },
                        title: {
                            text: `Stock Price ${symbol} ${new Date().toISOString().split('T')[0]}`
                            
                        },
                        subtitle: {
                            useHTML: true,
                            text: '<a href="https://polygon.io/" target="_blank">Source: Polygon.io</a>',
                            style:{
                                color:'blue'
                            },
                        },
                        plotOptions:{
                            series:{
                                pointRange:1
                            }
                        },
                          yAxis: [{
                            labels: {
                                align: 'right',
                                x: -3
                            },
                            title: {
                                text: 'Stock Price'
                            },
                            lineWidth: 0,
                            height: '100%',
                            resize: {
                                enabled: true
                            },
                            opposite: false
                        }, {
                            labels: {
                                align: 'left',
                                x: 3
                            },
                            title: {
                                text: 'Volume'
                            },
                            lineWidth: 0,
                            height: '100%',
                            resize: {
                                enabled: true
                            },
                            max: yAxisMaxVolume
                        }],
                        tooltip:{
                            split:true
                        },
                
                          series: [{
                            type: 'area',
                            name: 'Stock Price',
                            data: chartData.price_data,
                            tooltip:{
                                valueDecimals:2
                            },
                            fillColor: {
                              linearGradient: {
                                x1: 0,
                                y1: 0,
                                x2: 0,
                                y2: 1
                              },
                              stops: [
                                [0, Highcharts.getOptions().colors[0]],
                                [1, Highcharts.color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                              ]
                            },
                            threshold: null
                          }, {
                            type: 'column',
                            name: 'Volume',
                            data: chartData.volume_data,
                            color: '#000000',
                            yAxis: 1,
                            tooltip: {
                                valueDecimals: 0
                            },
                            pointPlacement: "on"
                          }],
                          plotOptions: {
                            column: {
                                pointWidth: 4,   
                            }
                        },
                        });
        document.getElementById('chart-details-button').style.display = 'inline';

        if (Array.isArray(newsData) && newsData.length === 0) {
            throw new Error('No news records found');
        }
        let newsHTML = '';
        newsData.forEach(item => {
            const formattedDate = formatDate(item.datetime);
            newsHTML += `
                <div class="news-item">
                    <img src="${item.image}" alt="News Image">
                    <div class="news-content">
                        <h3>${item.headline}</h3>
                        <p>${formattedDate}</p>
                        <p><a href="${item.url}" target="_blank">See original post</a></p>
                    </div>
                </div>`;
        });
        document.getElementById('news-details').innerHTML = newsHTML;
        document.getElementById('news-details-button').style.display = 'inline';

    })
    .catch(error => {
        console.error('Error:', error);
        showErrorMessage('No records found');
        document.getElementById('company-details-button').style.display = 'none';
        document.getElementById('quote-details-button').style.display = 'none';
        document.getElementById('chart-details-button').style.display = 'none';
        document.getElementById('news-details-button').style.display = 'none';
    });
    document.getElementById('company-details-button').click();
}

function formatDate(timestamp) {
    const options = { day: 'numeric', month: 'long', year: 'numeric' };
    const date = new Date(timestamp * 1000);
    return date.toLocaleDateString('en-US', options);
}

function showErrorMessage(message) {
    const errorMessageDiv = document.getElementById('error-message');
    errorMessageDiv.textContent = 'Error: No record has been found, please enter a valid symbol'; 
    errorMessageDiv.style.display = 'block'; 
    
}

function showCompanyDetails() {
    document.getElementById('company-details').style.display = 'block';
    document.getElementById('quote-details').style.display = 'none';
    document.getElementById('highcharts-container').style.display = 'none';
    document.getElementById('news-details').style.display = 'none';
}

function showQuoteDetails() {
    document.getElementById('company-details').style.display = 'none';
    document.getElementById('quote-details').style.display = 'block';
    document.getElementById('highcharts-container').style.display = 'none';
    document.getElementById('news-details').style.display = 'none';
}

function showChartDetails() {
    document.getElementById('company-details').style.display = 'none';
    document.getElementById('quote-details').style.display = 'none';
    document.getElementById('highcharts-container').style.display = 'block';
    document.getElementById('news-details').style.display = 'none';
}

function showNewsDetails() {
    document.getElementById('company-details').style.display = 'none';
    document.getElementById('quote-details').style.display = 'none';
    document.getElementById('highcharts-container').style.display = 'none';
    document.getElementById('news-details').style.display = 'block';
}

function clearFunction() {
    document.getElementById('stock-symbol').value = '';
    document.getElementById('search-results').textContent = '';
    document.getElementById('company-details').innerHTML = '';
    document.getElementById('quote-details').innerHTML = '';
    document.getElementById('news-details').innerHTML = '';
    document.getElementById('highcharts-container').innerHTML = '';
    document.getElementById('company-details-button').style.display = 'none';
    document.getElementById('quote-details-button').style.display = 'none';
    document.getElementById('chart-details-button').style.display = 'none';
    document.getElementById('news-details-button').style.display = 'none';
    document.getElementById('error-message').style.display = 'none';
}

document.addEventListener('DOMContentLoaded', function() {
    const buttons = document.querySelectorAll('.tab-container button');
    buttons.forEach(button => {
        button.addEventListener('click', () => {
            buttons.forEach(btn => btn.classList.remove('default'));
            button.classList.add('default');
        });
    });
});

