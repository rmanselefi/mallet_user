import 'package:mallet_user/models/user.dart';
import 'package:mallet_user/scoped_models/connected_models.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin AuthModel on ConnectedModels {
  UserData? authenticatedUser;
  bool hasError = true;
  bool isDone = false;

  //Login function in the scoped model
  Future<Map<String, dynamic>> login(String email, String password) async {
    String errorMessage;
    try {
      isLoading = true;
      notifyListeners();
      notifyListeners();
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      var token = await user.user!.getIdToken();
      if (token != "") {
        hasError = false;
      }
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      prefs.setString('email', email);
      isLoading = false;
      notifyListeners();
    } catch (error) {
      hasError = true;
      switch (error) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Invalid Email or Password.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "Invalid Email or Password.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }
    return {'success': !hasError, 'message': "errorMessage"};
  }

  //Sign up method in the scoped model
  Future<Map<String, dynamic>> sigup(String email, String password) async {
    String errorMessage;
    try {
      isLoading = true;
      notifyListeners();
      final user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var token = await user.user!.getIdToken();
      if (token != "") {
        hasError = false;
      }
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      prefs.setString('email', email);
      isLoading = false;
      notifyListeners();
    } catch (error) {
      hasError = true;
      switch (error) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }
    return {'success': !hasError, 'message': "errorMessage"};
  }

  //Sign in with Phone Number
  // Future<Map<String, dynamic>> signInWithPhone(
  //     String verId, String smsCode) async {
  //   String errorMessage;
  //   try {
  //     // AuthCredential _authCredential = PhoneAuthProvider.getCredential(verificationId: verId, smsCode: smsCode);
  //     var user = await FirebaseAuth.instance
  //         .signInWithPhoneNumber(smsCode: smsCode, verificationId: verId);
  //     if (user != null) {
  //       var result = await user.getIdToken(refresh: true);
  //       var token = result;
  //       if (token != "") {
  //         hasError = false;
  //         SharedPreferences.getInstance().then((prefs) {
  //           prefs.setString('token', token);
  //           notifyListeners();
  //         });
  //       }
  //     }
  //   } catch (error) {
  //     hasError = true;
  //     print(error);
  //   }
  //   return {'success': !hasError, 'message': "errorMessage"};
  // }

  // this is a function to auto authenticate user
  Future autoAuthenticate() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? token = pref.getString('token');
    if (token != null) {
      authenticatedUser = UserData(token: token);
      notifyListeners();
      return authenticatedUser;
    }
  }

  // a getter to get the currently authenticated user
  UserData? get user {
    return authenticatedUser;
  }

  // a function to log a user out
  void logout() async {
    isLoading = false;
    authenticatedUser = null;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
    pref.remove('email');
    pref.remove('userId');
  }
}
