import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInWithEmailScreen extends StatefulWidget {
  const SignInWithEmailScreen({super.key});

  @override
  State<SignInWithEmailScreen> createState() => _SignInWithEmailScreen();
}

class _SignInWithEmailScreen extends State<SignInWithEmailScreen> {
  bool _isLoading = false;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        title: const Text('Sign in'),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(CupertinoIcons.chevron_back),
        ),
      ),
      body: SafeArea(
          child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: const BoxDecoration(
                            color: Color(0xFFF7F7FC),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          initialValue: email,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          decoration: const InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: 22,
                            ),
                            hintStyle: TextStyle(height: 1),
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: const BoxDecoration(
                            color: Color(0xFFF7F7FC),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: TextFormField(
                          obscureText: true,
                          textAlignVertical: TextAlignVertical.center,
                          initialValue: password,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          decoration: const InputDecoration(
                            isDense: true,
                            suffixIcon: Icon(Icons.remove_red_eye),
                            filled: false,
                            focusColor: Colors.transparent,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: 22,
                            ),
                            hintStyle: TextStyle(height: 1),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(32),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            TextButton(
                                style: const ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.all(0))),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/sigin_email');
                                },
                                child: const Text('Sign up now'))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login_phone');
                  },
                  child: const Text(
                    'Sign up with phone number',
                    style: TextStyle(
                      color: Color(0xFF002DE3),
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              InkWell(
                onTap: () async {},
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Color(0xFF002DE3),
                      borderRadius: BorderRadius.all(Radius.circular(32))),
                  child: _isLoading
                      ? const SizedBox(
                          height: 19,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
