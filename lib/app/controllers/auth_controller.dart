import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  String? uid; // untuk cek ada auth atau tidak

  late FirebaseAuth auth = FirebaseAuth.instance;

  // AuthController() {
  //   // Initialize FirebaseAuth instance
  //   auth = FirebaseAuth.instance;
  // }

  Future<Map<String, dynamic>> login(String email, String pass) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      return {
        "error": false,
        "message": "Berhasil Login",
      };
    } on FirebaseAuthException catch (e) {
      return {
        "error": true,
        "message": "${e.message}",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "${e}",
      };
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      await auth.signOut();
      return {
        "error": false,
        "message": "Berhasil Logout",
      };
    } on FirebaseAuthException catch (e) {
      return {
        "error": true,
        "message": "${e.message}",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Tidak Dapat Logout",
      };
    }
  }
}
