import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gemini_api/Home/Service/class_service.dart';
import 'package:gemini_api/Widgets/costu_btn.dart';
import 'package:gemini_api/Widgets/costum_txtfield.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ClassService>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    final minWidth = MediaQuery.of(context).size.width;
    final minHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          image: DecorationImage(
            image: AssetImage('assets/image/chip.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<ClassService>(
          builder: (context, value, child) {
            return Column(
              children: [
                title(),
                Expanded(
                  child: Stack(
                    children: [
                      if (value.messages.isEmpty) mainText(),
                      Theme(
                        data: Theme.of(context).copyWith(
                          scrollbarTheme: ScrollbarThemeData(
                            thumbColor: WidgetStatePropertyAll(
                              Colors.grey[500],
                            ),
                            radius: Radius.circular(10),
                            thickness: WidgetStatePropertyAll(6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Scrollbar(
                            trackVisibility: true,
                            thickness: 6,
                            controller: value.scrollController,
                            thumbVisibility: true,
                            interactive: true,
                            child: ListView(
                              controller: value.scrollController,
                              children: [
                                ...value.messages.map((msg) {
                                  final isUser = msg.sender == 'user';
                                  return Align(
                                    alignment:
                                        isUser
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 20,
                                      ),
                                      margin: EdgeInsets.all(18),
                                      decoration: BoxDecoration(
                                        color:
                                            isUser
                                                ? Colors.grey.withOpacity(0.7)
                                                : const Color.fromRGBO(
                                                  73,
                                                  73,
                                                  73,
                                                  1,
                                                ).withOpacity(0.8),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                            isUser ? 30 : 0,
                                          ),
                                          bottomLeft: Radius.circular(30),
                                          topRight: Radius.circular(
                                            isUser ? 0 : 30,
                                          ),
                                          bottomRight: Radius.circular(30),
                                        ),
                                      ),
                                      child: AutoSizeText(
                                        isUser
                                            ? 'User: ${msg.text}'
                                            : 'Echo MIND: ${msg.text}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                if (value.isBotTyping)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 10,
                                      ),
                                      margin: EdgeInsets.all(18),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(
                                          255,
                                          73,
                                          73,
                                          73,
                                        ).withOpacity(0.8),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          bottomLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                        ),
                                      ),
                                      child: AutoSizeText(
                                        'Echo MIND:  ${value.botTypingMessage}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: minHeight * 0.1,
                  width: minWidth * .8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: CostumTxtfield(controller: value.controller),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CostumBtn(
                          height: minHeight > 500 ? 55 : 56,
                          onPressed: () => value.sendMessage(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          AutoSizeText.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Echo ',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 25,
                    shadows: [
                      Shadow(
                        offset: Offset(4, 4),
                        blurRadius: 5,
                        color: const Color.fromARGB(221, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                TextSpan(
                  text: 'MIND',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(4, 4),
                        blurRadius: 5,
                        color: const Color.fromARGB(221, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Center mainText() {
    return Center(
      child: Text(
        'What can I help with?',
        style: TextStyle(
          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
          fontSize: 38,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(offset: Offset(3, 3), blurRadius: 4, color: Colors.black87),
          ],
        ),
      ),
    );
  }
}
