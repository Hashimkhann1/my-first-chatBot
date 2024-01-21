import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:firstchatbot/view/messages_view/messages_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late DialogFlowtter dialogFlowtter;

  final TextEditingController _dialogController = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Bot"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: MessagesView(
              message: messages,
            )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _dialogController,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    decoration: const InputDecoration(
                        hintText: "Enter Your Dialog",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: InputBorder.none),
                  )),
                  IconButton(
                      onPressed: () {
                        sendMessage(_dialogController.text);
                        _dialogController.clear();
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
