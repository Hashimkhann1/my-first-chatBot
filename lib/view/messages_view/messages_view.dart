import 'package:flutter/material.dart';

class MessagesView extends StatefulWidget {
  final List message;
  const MessagesView({super.key, required this.message});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (context, index) {
            // print("messga from >>>>?///////// ${widget.message[index]['message']}");
            return Row(
              mainAxisAlignment: widget.message[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(
                          widget.message[index]['isUserMessage'] ? 20 : 0),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(
                          widget.message[index]['isUserMessage'] ? 0 : 20),
                    ),
                    color: widget.message[index]['isUserMessage']
                        ? Colors.grey.shade800
                        : Colors.deepPurple
                  ),
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 2/3),
                  child: Text(widget.message[index]['message'].text.text[0],style: TextStyle(color: Colors.white,fontSize: 17),),
                )
              ],
            );
          },
          separatorBuilder: (_, i) =>
              Padding(padding: EdgeInsets.only(top: 10)),
          itemCount: widget.message.length),
    );
  }
}
