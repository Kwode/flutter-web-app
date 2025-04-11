import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    Future<void> signin(String email, String password) async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        String uid = userCredential.user!.uid; // Get user ID

        print("Logged in successfully: $uid");
        Navigator.pushNamed(context, "home");
      } catch (e) {
        print("Error during sign-in: $e");
      }
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/images/agriculturalsilo.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 238, 238, 238),
            ),
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: 500,
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Login text
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 50),

                //textfield for email
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 0, 74, 134),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: const Color.fromARGB(255, 0, 74, 134),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                //textfield for password
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter Password",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 0, 74, 134),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 0, 74, 134),
                        width: 2,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 74, 134),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                //button
                GestureDetector(
                  onTap: () => signin(email.text, password.text),
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 74, 134),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                //Already a member?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),

                    SizedBox(width: 4),

                    GestureDetector(
                      child: Text("Sign Up", style: TextStyle(
                        color: const Color.fromARGB(255, 0, 74, 134),
                        fontWeight: FontWeight.bold
                      ),),
                      onTap: () {
                        Navigator.pushNamed(context, "signup");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
