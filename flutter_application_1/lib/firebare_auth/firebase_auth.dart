import 'package:firebase_auth/firebase_auth.dart';

// Firebase 인증 서비스 인스턴스 생성
final FirebaseAuth _auth = FirebaseAuth.instance;

mixin instance {
}

class MyFirebaseAuth {
  createUserWithEmailAndPassword({required String email, required String password}) {}
  
  signOut() {}
  
  signInWithEmailAndPassword({required String email, required String password}) {}
}

// 이메일 중복 검사 함수
Future<bool> isEmailAlreadyExist(String email) async {
  try {
    UserCredential userCredential = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: 'dummyPassword', // 비밀번호는 임시로 지정해도 됩니다.
    )) as UserCredential;
    // 회원가입 성공 시, 생성된 사용자 정보를 삭제하여 중복 검사를 위해 회원가입 시도를 취소합니다.
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

class MyFirebaseAuthException {
  get code => null;
}

class UserCredential {
  get user => null;
}

// 회원가입 함수
Future<void> signUpWithEmailPassword(String email, String password) async {
  try {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } catch (e) {
    throw e;
  }
}

// 이메일과 비밀번호를 이용한 로그인 함수
Future<void> signInWithEmailPassword(String email, String password) async {
  try {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } catch (e) {
    throw e;
  }
}

// 로그아웃 함수
Future<void> signOut() async {
  await _auth.signOut();
}
