import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_day10/main.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const SignUpWidget({ Key? key, required this.onClickedSignIn }) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value)=>
                    value != null && value.length < 6
                        ? 'Enter min 6 characters'
                        :null,
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Confirm Password',labelStyle: TextStyle(color: Colors.white54)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value)=>
                    value != null && value != passwordController.text
                        ? 'Password not match'
                        :null,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: signUp, 
                  icon: const Icon(Icons.arrow_forward,size: 32,), 
                  label: const Text('Sign Up',style: TextStyle(fontSize: 24),),
                ),
                const SizedBox(height: 24),
                RichText(
                  text: TextSpan(
                    text: 'Already have account..',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignIn,
                        text: 'Sign in',
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
  
  Future signUp() async{
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context)=>const Center(child: CircularProgressIndicator(),)
      );
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim()
    );
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);

  }
}