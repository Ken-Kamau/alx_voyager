import "dart:developer";

import "package:alx_voyager/screens/authentication/signup.dart";
import "package:alx_voyager/services/auth.dart";
import "package:alx_voyager/shared/loading.dart";
import "package:flutter/material.dart";

class SignIn extends StatefulWidget {
  final Function toggleScreen;
  SignIn({required this.toggleScreen, super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String error = '';
  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;

  void _loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      // Perform login logic here
      dynamic result = await _authService.signInWithEmail(
          _emailController.text, _passwordController.text);

      if (result == null) {
        setState(() {
          error = 'Error While Signing In';
          loading = false;
          log(error);
        });
      } else {}

      // Navigate to the home screen
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).canPop()) {
          // If there is a previous screen, navigate back
          Navigator.of(context).pop();
          return true;
        } else {
          // Show exit confirmation dialog
          return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Are you sure you want to exit?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Exit'),
                ),
              ],
            ),
          );
        }
      },
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40.0),
                  Text(
                    'Welcome back, Voyager',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            labelStyle: TextStyle(
                              color:
                                  _isEmailFocused ? Colors.blue : Colors.grey,
                            ),
                          ),
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              _isEmailFocused = true;
                              _isPasswordFocused = false;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            labelStyle: TextStyle(
                              color: _isPasswordFocused
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              _isEmailFocused = false;
                              _isPasswordFocused = true;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () async {
                            _loginUser();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.zero,
                            minimumSize: Size(double.infinity, 50.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Center(child: Text('Or')),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () async {
                      // Perform anonymous sign-in logic here
                      // Navigate to the registration screen
                      dynamic result = await _authService.signInAnon();
                      if (result == null) {
                        print('Error Signing In');
                      } else {
                        print('Signed In');
                        print(result.uid);
                      }
                    },
                    child: Text('Continue as Anonymous'),
                  ),
                  SizedBox(height: 16.0),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Perform Google sign-in logic here
                    },
                    icon: Icon(Icons.g_mobiledata),
                    label: Text('Sign in with Google'),
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      // Navigate to the registration screen
                      widget.toggleScreen();
                    },
                    child: Text('Not a Voyager yet? Sign up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    /*Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
            onPressed: () async {
              dynamic result = await _authService.signInAnon();
              if (result == null) {
                print('Error Signing In');
              } else {
                print('Signed In');
                print(result.uid);
              }
            },
            child: Text('Sign In Anon')),
      ),
    );*/
  }
}
