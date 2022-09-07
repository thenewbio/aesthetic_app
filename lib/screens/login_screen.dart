import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../providers/auth_providers.dart';
import '../widgets/loading_widget.dart';
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.authError:
        Fluttertoast.showToast(msg: "Sign In failed");
        break;
      case Status.authCanceled:
        Fluttertoast.showToast(msg: "Sign in canceled");
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: "Sign in successfully");
        break;
      default:
        break;
    }
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Image.asset('assets/video.png'),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () async {
                bool isSuccess = await authProvider.handleSignIn();
                if (isSuccess) {
                  Route newRoute =
                      MaterialPageRoute(builder: (_) => const MyHomePage());
                  Navigator.pushReplacement(context, newRoute);
                }
              },
              child: Image.asset('assets/google_login.jpg'),
            ),
          ),
          Positioned(
              child: authProvider.status == Status.authenticating
                  ? const LoadingView()
                  : const SizedBox.shrink())
        ],
      ),
    );
  }
}
