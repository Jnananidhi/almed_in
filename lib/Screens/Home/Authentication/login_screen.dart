
import 'package:almed_in/Screens/Home/Authentication/forgot1.dart';
import 'package:almed_in/Screens/Home/Authentication/register_screen.dart';
import 'package:almed_in/Screens/Home/widgets/bottomnav.dart';
import 'package:almed_in/Screens/Home/widgets/custom_button.dart';
import 'package:almed_in/Screens/Home/widgets/menu.dart';
import 'package:almed_in/Screens/Home/widgets/search_bar.dart';
import 'package:almed_in/constants.dart';
import 'package:almed_in/responsive.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  const LoginPage(
      {
        super.key}
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,

      body: ListView(
        children: [
      Container(
      constraints: const BoxConstraints(
      maxWidth: kMaxWidth,
      ),
        child: Column(
            children: [
        Padding(
        padding:
        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
            children: [
        const Navigation(),
        Responsive.isMobile(context)?MobileBody(): Body(),
          const BottomNav()
            ],),),
        ],
      ),
        )]));
  }
}

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool obscureText = true;

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 360,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'DMSans Bold',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "If you don't have an account",
                  style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'DMSans Bold'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                     CustomButton(
                          label: 'Register',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  const RegistrationScreen()),
                            );
                          },
                        )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery
                    .of(context)
                    .size
                    .height / 6),
            child: Column(
                children: [
                  Container(
                  width: 320,
                    child: _formLogin() ,
            ),
            ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _formLogin() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter email or Phone number',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kDarkgreyColor),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kDarkgreyColor),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(height: 30),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: 'Password',
            suffixIcon: InkWell(
              onTap: togglePasswordVisibility,
              child: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility,
                color: Colors.grey,
              ),
            ),
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kDarkgreyColor),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kDarkgreyColor),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => forgot1()),
          );
        },
        child: Text(
        'Forgot Password?',textAlign: TextAlign.right,
        style: TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
        ),
        ),
        ),
        const SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              const BoxShadow(
                color: kPrimaryColor,
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 50,
                child: const Center(child: Text("Sign In"))),
            onPressed: () => print("it's pressed"),
            style: ElevatedButton.styleFrom(
              foregroundColor: kWhiteColor, backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



//________________________________________________Mobile Part___________________________________________________________
class MobileBody extends StatefulWidget {
  const MobileBody({super.key});
  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  bool obscureText = true;

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: TextStyle(
              fontSize: 45,
              fontFamily: 'DMSans Bold',
            ),
          ),
          SizedBox(height: 30),
          Text(
            "If you don't have an account",
            style: TextStyle(
              color: Colors.black54,
              fontFamily: 'DMSans Bold',
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              CustomButton(
                label: 'Register',
                onPressed: () {
                  // Add your registration logic here
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6,
            ),
            child: Container(
              width: 320,
              child: _formLogin(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formLogin() {
    return Column(
      children: [
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Enter email or Phone number',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kDarkgreyColor),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kDarkgreyColor),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(height: 30),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: 'Password',
            counterText: 'Forgot password?',
            suffixIcon: InkWell(
              onTap: togglePasswordVisibility,
              child: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility,
                color: Colors.grey,
              ),
            ),
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kDarkgreyColor),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kDarkgreyColor),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              const BoxShadow(
                color: kPrimaryColor,
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 50,
                child: const Center(child: Text("Sign In"))),
            onPressed: () => print("it's pressed"),
            style: ElevatedButton.styleFrom(
              foregroundColor: kWhiteColor, backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}