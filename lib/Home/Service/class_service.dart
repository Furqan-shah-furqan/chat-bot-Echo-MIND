import 'package:flutter/material.dart';
import 'package:gemini_api/gemini_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ClassService with ChangeNotifier {
  final controller = TextEditingController();
  final scrollController = ScrollController();
  final geminiService = GeminiService();
  List<Message> messages = [];
  String botTypingMessage = '';
  bool isBotTyping = false;
  // HIVE.
  late Box box;

  Future<void> init() async {
    box = await Hive.openBox('mybox');
    loadData();
  }

  void loadData() {
    messages = List<Message>.from(box.get('items', defaultValue: []));
    notifyListeners();
  }

  savedata() {
    box.put('items', messages);
  }

  void sendMessage() async {
    final input = controller.text;
    if (input.trim().isEmpty) return;
    messages.add(Message(sender: 'user', text: input));
    isBotTyping = true;
    botTypingMessage = '';
    controller.clear();
    savedata();
    notifyListeners();

    try {
      final response = await geminiService.sendMessage(input);

      for (int i = 0; i < response.length; i++) {
        await Future.delayed(Duration(microseconds: 0));
        botTypingMessage += response[i];
        notifyListeners();
      }
      messages.add(Message(sender: "bot", text: botTypingMessage));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
        isBotTyping = false;
        botTypingMessage = '';
        savedata();
        notifyListeners();
      });
    } catch (e) {
      messages.add(
        Message(
          sender: "bot",
          text: "Error: Please check your Internet connection",
        ),
      );
      isBotTyping = false;
      botTypingMessage = '';
      savedata();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
