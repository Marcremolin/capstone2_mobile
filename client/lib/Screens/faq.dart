import 'package:client/Screens/Homepage/Homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messages = [];

  void addMessage(String message) {
    setState(() {
      messages.add(message);
      if (message == 'What is your working hours?') {
        messages.add('OUR WORKING HOURS START AT 10AM TO 10PM');
      } else if (message == "What's the barangay's Mission and Vision") {
        messages.add(
            'Lorem ipsum dolor sit amet. Et tenetur iusto est deserunt rerum sit voluptatibus nihil.');
      } else if (message == 'How to request a document') {
        messages.add(
            'You can request a document through the documents tab or go to the barangay hall');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 95, 170),
      appBar: AppBar(
        title: const Text('Chat'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AnnouncementPage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return MessageBubble(
                  message: messages[index],
                  isSent: index % 2 == 0,
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => addMessage('What is your working hours?'),
                child: const Text('What is your working hours?'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () =>
                    addMessage("What's the barangay's Mission and Vision"),
                child: const Text("What's the barangay's Mission and Vision"),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => addMessage('How to request a document'),
                child: const Text('How to request a document'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSent;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isSent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final alignment = isSent ? Alignment.topRight : Alignment.topLeft;
    final color = isSent ? Colors.green : Colors.blue;

    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
