import 'package:booknest_fe/screen/loginscreen.dart';
import 'package:booknest_fe/screen/registration.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class Splashscreensec extends StatefulWidget {
  const Splashscreensec({super.key});

  @override
  State<Splashscreensec> createState() => _SplashscreensecState();
}

class _SplashscreensecState extends State<Splashscreensec> {
  bool firstswitchValue = false;

  @override
  void initState() {
    super.initState();
  }

  void _onTap() {
    if (!firstswitchValue) {
      // If the current value is false (Register), toggle to true (Login)
      _onToggleChanged(true);
    } else {
      // If the current value is true (Login), navigate to the registration screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegisScreen()),
      );
    }
  }

  void _onToggleChanged(bool value) {
    setState(() {
      firstswitchValue = value;
    });

    if (kDebugMode) {
      print("Switch value: $value");
    }

    if (value) {
      // If the switch is toggled to true (Login), navigate to LoginScreen
      if (kDebugMode) {
        print('Navigating to LoginScreen');
      }
      // Navigator.pushReplacement(
      //   context,
      //   PageRouteBuilder(
      //     // pageBuilder: (context, animation1, animation2) => const LoginScreen(),
      //     transitionDuration: const Duration(seconds: 0),
      //     reverseTransitionDuration: const Duration(seconds: 0),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.1,
                0.6,
                0.8,
              ],
              colors: [
                Color(0xFF0A2C22),
                Color(0XFF175844),
                Color(0XFFFFFFFF),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 90.0,
                left: 40.0,
                child: Text(
                  'BookNest',
                  style: GoogleFonts.mulish(
                    fontSize: 28.0, // Adjusted font size
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 70,
                left: 300,
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset('assets/Rectangle 75.png'),
                ),
              ),
              Positioned(
                top: 300,
                left: 20,
                child: Text(
                  'Every page a new \n home, every book is a \n new adventure.',
                  style: GoogleFonts.mulish(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Positioned(
                top: 580,
                left: 45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _onTap,
                      child: AnimatedToggleSwitch<bool>.size(
                        current: firstswitchValue,
                        values: const [false, true],
                        iconOpacity: 150.0,
                        indicatorSize: const Size.fromWidth(150),
                        customIconBuilder: (context, local, global) => Text(
                          local.value ? 'Login' : 'Register',
                          style: GoogleFonts.mulish(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Color.lerp(Colors.white70, Colors.black,
                                local.animationValue),
                          ),
                        ),
                        height: 60,
                        borderWidth: 5.0,
                        iconAnimationType: AnimationType.onHover,
                        style: ToggleStyle(
                          indicatorColor: const Color(0xFFFFFFFF),
                          backgroundColor: const Color(0xFFC5C5C5),
                          borderColor: const Color(0xFFC5C5C5),
                          indicatorBorderRadius: BorderRadius.circular(60),
                          borderRadius: BorderRadius.circular(43),
                        ),
                        selectedIconScale: 1.0,
                        onChanged: _onToggleChanged,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
