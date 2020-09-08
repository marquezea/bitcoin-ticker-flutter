import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const String apiKey = '6B8A49F8-E47F-45EB-9E2D-B037CABBC20E';
const String baseUrl = 'https://rest.coinapi.io/v1/exchangerate';
const List<String> currenciesList = ['AUD', 'BRL', 'CAD', 'EUR', 'ILS', 'INR', 'JPY', 'RUB', 'SEK', 'USD'];
const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

class CoinData {
  Future getQuotes(String selectedCurrency) async {
    Map<String, String> quotes = {};
    Map<String, String> userHeader = {'x-CoinAPI-Key': apiKey};

    for (String crypto in cryptoList) {
      String url = '$baseUrl/$crypto/$selectedCurrency';
      http.Response response = await http.get(url, headers: userHeader);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];
        quotes[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return quotes;
  }
}
