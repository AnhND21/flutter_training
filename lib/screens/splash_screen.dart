import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _isLoading = true;
    });
    onNavigateToMain();
  }

  Future<void> onNavigateToMain() async {
    Future.delayed(const Duration(seconds: 3),
        () => {Navigator.pushNamed(context, '/root')});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator(
                strokeWidth: 1.5,
                backgroundColor: Colors.pink,
              )
            : Container(),
      ),
    );
  }
}
