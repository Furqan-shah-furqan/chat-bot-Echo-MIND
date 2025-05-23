import 'dart:convert';
import 'package:gemini_api/consts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
part 'gemini_service.g.dart';



class GeminiService {
  final String apiKey = gemini_api_key;

  Future<String> sendMessage(String userMessage) async {
    const url =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

    final headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
    };

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": userMessage},
          ],
        },
      ],
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        return 'Error: ${response.statusCode}\n${response.body}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}

@HiveType(typeId: 0)
class Message extends HiveObject {
  @HiveField(0)
  final String sender;
  @HiveField(1)
  final String text;

  Message({required this.sender, required this.text});
}
