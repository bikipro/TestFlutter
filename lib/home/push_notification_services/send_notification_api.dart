import 'package:http/http.dart' as http;
import 'dart:convert';

class SendNotification {
  send(String massage, String title, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAmJgDVzI:APA91bEI0Y0vlzqGMFjX8bcF9nd5PHVMjfWldO_e2_AOj69UC8JfTmBeSh0Qy48q4KmVmhiHdKFzkJpmzOrt_PcpIIbzPYF1K5ENrnbgQW8CoREHCeBbTGwxZSIz8DBtu1ln5cC4lZZI'
    };
    var request =
        http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));

    request.body = json.encode({
      "registration_ids": [token],
      "notification": {
        "body": massage,
        "title": title,
        "android_channel_id": "pay",
        "sound": false
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
