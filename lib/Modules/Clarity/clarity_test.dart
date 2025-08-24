import 'package:flutter/material.dart';
import 'package:clarity_flutter/clarity_flutter.dart';

class ClarityTestScreen extends StatelessWidget {
  static const routeName="clar";
  const ClarityTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Clarity Test")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1️⃣ تسجيل حدث مخصص
            ElevatedButton(
              onPressed: () {
                //throw Exception("Test Crash from Button!");
                Clarity.sendCustomEvent("Button_Clicked");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Button Click event sent!")),
                );
              },
              child: const Text("Send Custom Event"),
            ),

            const SizedBox(height: 20),

            // 2️⃣ TextField مع إخفاء النص
            const Text("Sensitive Field:"),
            const ClarityMask(
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Type your password",
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 3️⃣ TextField عادي
            const Text("Normal Field:"),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type your name",
              ),
            ),

            const SizedBox(height: 20),

            // 4️⃣ تغيير الشاشة
            ElevatedButton(
              onPressed: () {
                Clarity.setCurrentScreenName("SecondScreen");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SecondScreen()),
                );
              },
              child: const Text("Go to Second Screen"),
            ),

            const SizedBox(height: 20),

            // 5️⃣ إرسال User ID مخصص
            ElevatedButton(
              onPressed: () {
                Clarity.setCustomUserId("User_12345");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Custom User ID set!")),
                );
              },
              child: const Text("Set Custom User ID"),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second Screen")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Back"),
        ),
      ),
    );
  }
}
