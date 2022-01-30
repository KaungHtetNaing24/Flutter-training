import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_day10/main.dart';

class Login extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const Login({ Key? key, required this.onClickedSignUp }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
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
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: emailController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Email',labelStyle: TextStyle(color: Colors.white54)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email)=>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          :null,
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: passwordController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password',labelStyle: TextStyle(color: Colors.white54)),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: signIn, 
                  icon: const Icon(Icons.lock_open,size: 32,), 
                  label: const Text('Sign In',style: TextStyle(fontSize: 24),),
                ),
                const SizedBox(height: 24),
                RichText(
                  text: TextSpan(
                    text: 'No account?..',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                        text: 'Sign Up',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary
                        )
                      ) 
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async{
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context)=>const Center(child: CircularProgressIndicator(),)
      );
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim()
    );
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);

  }
}