import 'package:alx_voyager/screens/authentication/sign_in.dart';
import "package:flutter/material.dart";
import 'package:alx_voyager/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleScreen;
  Register({required this.toggleScreen, super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _passwordsMatch = true;
  bool _isUsernameFocused = false;
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;
  bool _isConfirmPasswordFocused = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).canPop()) {
          // If there is a previous screen, navigate back
          Navigator.of(context).pop();
          return false;
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
                    'To Register, we only need your',
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
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            labelStyle: TextStyle(
                              color: _isUsernameFocused
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              _isUsernameFocused = true;
                              _isEmailFocused = false;
                              _isPasswordFocused = false;
                              _isConfirmPasswordFocused = false;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              _isUsernameFocused = false;
                              _isEmailFocused = true;
                              _isPasswordFocused = false;
                              _isConfirmPasswordFocused = false;
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
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              _isUsernameFocused = false;
                              _isEmailFocused = false;
                              _isPasswordFocused = true;
                              _isConfirmPasswordFocused = false;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            labelStyle: TextStyle(
                              color: _isConfirmPasswordFocused
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                          controller: _confirmPasswordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          onTap: () {
                            setState(() {
                              _isUsernameFocused = false;
                              _isEmailFocused = false;
                              _isPasswordFocused = false;
                              _isConfirmPasswordFocused = true;
                            });
                          },
                        ),
                        if (!_passwordsMatch)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Passwords do not match',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Become A Voyager'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(double.infinity, 50.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text('Or'),
                        SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () async {
                            // Perform anonymous sign-in logic here
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
                            // Navigate to the login screen
                            widget.toggleScreen();
                          },
                          child: Text('Already a Voyager? Log in'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
