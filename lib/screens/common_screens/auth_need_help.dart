import 'package:flutter/material.dart';

class AuthNeedHelp extends StatelessWidget {
  const AuthNeedHelp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Authentication",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        leading: const Icon(
          Icons.arrow_back,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
            ),

            child: Container(
              child: Image.asset(
                'images/aupng.png',
                height: 200,
                width: 300,
              ),
            ),

            // const Text(
            //   'Terms and conditons \n to be followed',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   //  TextStyle(fontWeight: FontWeight.bold,
            // ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            height: 500,
            width: 400,
            decoration: const BoxDecoration(
              color: Color.fromARGB(200, 255, 255, 255),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                      'In order to use the application, the user needs to create his/her account in the app. On registration form for security purpose whenever we register for first time you need to fill OTP i.e One Time Password which is autogenerated if you have same number sim with you otherwise you need to fill manually within 2 min . You can resend it if time limit ends from Bottom Resend option. You need to go through same  process for both Donor and NGO side. Both restaurant and users who have the food must register using registration form. During registration, some information about the users is saved to the real-time database such as address, name and gender under the unique user id. So, each user profile information is saved into the database and next time user can directly jump to there profile and edit the information. ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        // fontWeight: FontWeight.bold,
                      )),
                  Container(
                      width: 500,
                      height: 50,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Go Back',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
