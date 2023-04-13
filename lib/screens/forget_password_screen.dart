import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetodoapps/screens/login_screen.dart';
import 'package:flutter/material.dart';
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final _formKey=GlobalKey<FormState>();

  FirebaseAuth _auth=FirebaseAuth.instance;


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),

      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your Email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return 'Email is required';
                  }
                  return null;
                },
                controller: _emailController,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 40),
                maximumSize: Size(200, 40)
              ),
                onPressed: ()async{
              _formKey.currentState!.validate();
              await _auth.sendPasswordResetEmail(email: _emailController.text.trim()).then((value) {
                Navigator.of(context).pushReplacementNamed(LoginScreen.id);
                var snackbar= SnackBar(content: Text('Check your email',style: TextStyle(color: Colors.white),),
                backgroundColor: Colors.green,
                duration: Duration(milliseconds: 1000),);
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }).onError((error, stackTrace) {
                var snackbar= SnackBar(content: Text('There is an error',style: TextStyle(color: Colors.white),),
                  backgroundColor: Colors.brown,
                  duration: Duration(milliseconds: 1000),);
                ScaffoldMessenger.of(context).showSnackBar(snackbar);

              });
            }, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.mail_outline),
                SizedBox(width: 10,),
                Text('Reset Password')
              ],
            ))
          ],
        ),
      ),
    );
  }
}
