import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetodoapps/screens/forget_password_screen.dart';
import 'package:firebasetodoapps/screens/register_screen.dart';
import 'package:firebasetodoapps/screens/tabs_screens.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const id='login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey=GlobalKey<FormState>();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final FirebaseAuth _auth=FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(child: Text('Login',style: TextStyle(fontSize: 31,fontWeight: FontWeight.bold),)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Insert Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return 'Email is Required';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordController,
                  decoration:  const InputDecoration(labelText: 'Insert Password'),
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return 'Password is required';
                    }else if(value.length<6){
                      return 'Password should be at least 6 character long';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(onPressed: (){
                final isValid=_formKey.currentState!.validate();
                _auth.signInWithEmailAndPassword(email: _emailController.text, password:_passwordController.text).then((value) {
                  GetStorage().write('token', value.user!.uid);
                  GetStorage().write('email', value.user!.email);
                  print('user id from storage: ${GetStorage().read('token')}');
                  Navigator.pushReplacementNamed(context, TabsScreen.id);

                }).onError((error, stackTrace) {
                  var snackBar= const SnackBar(content: Text('There is an error',style: TextStyle(color: Colors.white),),
                  backgroundColor: Colors.red,
                  duration: Duration(milliseconds: 1000),);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });

              }, child: const Text('Login')),
              TextButton(onPressed: (){
                Navigator.of(context).pushNamed(RegisterScreen.id);
              }, child: const Text('Don\'t have an Account?')),
              TextButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ForgetPasswordScreen(),));
              }, child: const Text('Forget Password'))
            ],
          ),
        ),
      ),
    );
  }
}
