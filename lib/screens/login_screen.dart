import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/monstar_logo_grey.png',
                    width: 300,
                  )),
              Container(
                margin: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                      ),
                      onPressed: signIn,
                      child: const Text("Sign In")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found!'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password!'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Try again.'),
            backgroundColor: Colors.grey,
          ),
        );
      }
    }
  }
}
