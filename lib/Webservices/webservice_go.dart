import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class WebServiceGO {
  static String getBaseURL() {
    // Box sett = Hive.box('settings');
    //String url = sett.get('url');
    String url = 'https://31.220.109.198:9091/';
    print('Url : $url/');
    return '$url/';
  }

  static Future<dynamic> getReport({required List<String> query}) async {
    String fullURl = '${getBaseURL()}execute-sql-query';
    String dBName = Hive.box('settings').get('DBName', defaultValue: 'aawater');
    dBName = 'cake_studio_balusseri';
    Dio dio = Dio(); //BaseOptions(headers: {'dbname': dBName}));
    dio.options.headers['dbname'] = dBName;
    print('Url : $fullURl');

    dynamic data;
    try {
      final Response response = await dio
          .get(
            fullURl,
            // headers: {"Accept": "application/json"},
          )
          .timeout(const Duration(
            seconds: 10,
          ));
      // data = json.decode(response.body);
      data = response.data;
      // print('Inv grp : $data');
    } catch (ex) {
      print('Inv Group fetch error caught : $ex}');
      return '$ex$fullURl is the link';
    }
    if (data['success'] == 1 || data['success'] == '1') {
      return data['data'];
    } else {
      return false;
    }
  }
}
