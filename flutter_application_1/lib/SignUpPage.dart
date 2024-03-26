import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                labelText: 'Nickname',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    try {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        // 이메일 또는 비밀번호가 비어있는 경우 처리
        return;
      }

      bool isExist = await isEmailAlreadyExist(email);
      if (isExist) {
        // 이미 존재하는 이메일인 경우 처리
        return;
      }

      UserCredential userCredential = await signUpWithEmailPassword(email, password);
      // 회원가입 성공 시, 추가적인 작업 수행
      print('Signed up: ${userCredential.user!.email}');
    } catch (e) {
      // 회원가입 실패 시, 에러 메시지 출력
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  Future<bool> isEmailAlreadyExist(String email) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: 'dummyPassword', // 임시 비밀번호
      );
      // 회원가입 성공 시, 생성된 사용자 정보를 삭제하여 중복 검사를 위해 회원가입 시도를 취소
      await userCredential.user?.delete();
      return false; // 중복되지 않은 이메일
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        return true; // 중복된 이메일
      } else {
        throw e; // 그 외의 오류는 예외 처리
      }
    }
  }

  Future<UserCredential> signUpWithEmailPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw e;
    }
  }
}
