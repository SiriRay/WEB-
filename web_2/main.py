from flask import Flask, request, jsonify
from datetime import datetime, timedelta
import requests
from dateutil.relativedelta import relativedelta

app = Flask(__name__,
            static_folder='static',)

@app.route('/')
def index():
    return app.send_static_file('index.html')

@app.route('/quote')
def search():
    symbol = request.args.get('symbol')
    if not symbol:
        return jsonify({'error': 'Please provide a stock symbol'}), 400

    response = requests.get(f'https://finnhub.io/api/v1/quote?symbol={symbol}&token=cn3v1kpr01qtsta48iugcn3v1kpr01qtsta48iv0')
    if response.ok:
        data = response.json()
        if all(value in [0, None] for value in data.values()):
            return jsonify({'error': 'No records found'}), 404
        return jsonify(data)
    else:
        #this error handles any non-OK response from Finnhub API, like network errors, server errors, invalid API token 
        return jsonify({'error': 'Failed to fetch data'}), response.status_code


@app.route('/company')
def company():
    symbol = request.args.get('symbol')
    if not symbol:
        return jsonify({'error': 'Please provide a stock symbol'}), 400

    response = requests.get(f'https://finnhub.io/api/v1/stock/profile2?symbol={symbol}&token=cn3v1kpr01qtsta48iugcn3v1kpr01qtsta48iv0')
    if response.ok:
        data = response.json()
        if not data:
            return jsonify({'error': 'No records found'}), 404
        return jsonify(data)
    else:
        return jsonify({'error': 'Failed to fetch company data'}), response.status_code


@app.route('/recommendation')
def recommendation():
    symbol = request.args.get('symbol')
    if not symbol:
        return jsonify({'error': 'Please provide a stock symbol'}), 400

    response = requests.get(f'https://finnhub.io/api/v1/stock/recommendation?symbol={symbol}&token=cn3v1kpr01qtsta48iugcn3v1kpr01qtsta48iv0')
    if response.ok:
        data = response.json()
        latest_data = data[0]
        recommendation_trend = {
            'strongSell': latest_data['strongSell'],
            'sell': latest_data['sell'],
            'hold': latest_data['hold'],
            'buy': latest_data['buy'],
            'strongBuy': latest_data['strongBuy']
        }
        if not data:
            return jsonify({'error': 'No records found'}), 404
        return jsonify(recommendation_trend)
    else:
        return jsonify({'error': 'Failed to fetch recommendation data'}), response.status_code


@app.route('/chart-data')
def chart_data():
    symbol = request.args.get('symbol')
    if not symbol:
        return jsonify({'error': 'Please provide a stock symbol'}), 400

    six_months_ago = datetime.now() - timedelta(days=6*30)  
    from_date = six_months_ago.strftime('%Y-%m-%d')
    to_date = datetime.now().strftime('%Y-%m-%d')

    polygon_api_key = 'isBmHEJgemdosTdv8dleBiMg3Nb_UPXd'
    url = f'https://api.polygon.io/v2/aggs/ticker/{symbol}/range/1/day/{from_date}/{to_date}?adjusted=true&sort=asc&apiKey={polygon_api_key}'
    print(url)
    response = requests.get(url)
    if response.ok:
        data = response.json()
        chart_data = {
            'price_data': [[entry['t'], entry['c']] for entry in data['results']],
            'volume_data': [[entry['t'], entry['v']] for entry in data['results']],
        }
        return jsonify(chart_data)
    else:
        return jsonify({'error': 'Failed to fetch chart data'}), response.status_code

@app.route('/company-news')
def company_news():
    symbol = request.args.get('symbol')
    if not symbol:
        return jsonify({'error': 'Please provide a stock symbol'}), 400

    to_date = datetime.now().strftime('%Y-%m-%d')
    from_date = (datetime.now() - relativedelta(days=30)).strftime('%Y-%m-%d')

    finnhub_api_key = 'cn3v1kpr01qtsta48iugcn3v1kpr01qtsta48iv0'
    url = f'https://finnhub.io/api/v1/company-news?symbol={symbol}&from={from_date}&to={to_date}&token={finnhub_api_key}'

    response = requests.get(url)
    if response.ok:
        news_items = response.json()
        valid_news_items = [
            item for item in news_items 
            if all(key in item and item[key] for key in ['image', 'url', 'headline', 'datetime'])
        ]
        return jsonify(valid_news_items[:5])
    else:
        return jsonify({'error': 'Failed to fetch company news'}), response.status_code



if __name__ == '__main__':
    app.run(debug=True, port=5001)