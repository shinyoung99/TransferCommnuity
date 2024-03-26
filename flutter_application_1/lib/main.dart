import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  // 이메일 또는 비밀번호가 비어있는 경우 처리
                  return null;
                }

                bool isExist = await isEmailAlreadyExist(email);
                if (isExist) {
                  // 이미 존재하는 이메일인 경우 처리
                  return null;
                }

                try {
                  await signUpWithEmailPassword(email, password);
                  // 회원가입 성공 시, 로그인 페이지로 이동하거나 다음 동작 수행
                } catch (e) {
                  // 회원가입 실패 시, 처리
                  print('Failed to sign up: $e');
                }
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  isEmailAlreadyExist(String email) {}

  signUpWithEmailPassword(String email, String password) {}
}
