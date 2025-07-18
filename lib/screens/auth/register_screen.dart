import 'package:flutter/material.dart';
import 'package:tell_am/screens/auth/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tell_am/models/country.dart';
import 'package:tell_am/models/country_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final List<String> country = [
    'One',
    'Two',
    'Free',
    'Four',
  ];
  bool isChecked = false;
  Country? selectedCountry;
  List<Country> countryList = [];
  List<String> countryNames = [];
  final TextEditingController countrySearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    final countries = await CountryService.loadCountries();
    setState(() {
      countryList = countries;
      countryNames = countries.map((c) => c.name).toList();
    });
  }

  @override
  void dispose() {
    countrySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/Logo/1.svg',
                  semanticsLabel: 'TellAm Logo',
                  fit: BoxFit.cover,
                  height: 100,
                  // width: 100,
                  width: 100,
                ),
                // const Image(
                //     image: AssetImage('assets/Logo/TellAm (Light)16x9.png')),
                // const SizedBox(height: .0),
                Text(
                  'Welcome',
                  style: GoogleFonts.quicksand(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4.0),
                const Text(
                  "Let's create your account to get started",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 14),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 3, // Smaller width for dropdown
                              child: DropdownButtonFormField2<Country>(
                                value: selectedCountry,
                                decoration: InputDecoration(
                                  labelText: 'Country',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                isExpanded: true,
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 300,
                                  width: 300,
                                ),
                                items: countryList.map((country) {
                                  return DropdownMenuItem<Country>(
                                    value: country,
                                    child: Text(
                                      '${country.flagEmoji} ${country.name} (${country.dialCode})',
                                      style:
                                          GoogleFonts.quicksand(fontSize: 16),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (Country? value) {
                                  setState(() {
                                    selectedCountry = value;
                                  });
                                },
                                selectedItemBuilder: (BuildContext context) {
                                  return countryList.map((country) {
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${country.flagEmoji}  ${country.dialCode}',
                                        style:
                                            GoogleFonts.quicksand(fontSize: 16),
                                      ),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ), // Space between dropdown and text field
                            Flexible(
                              flex: 5, // Larger width for text field
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  hintText: 'Enter your phone number',
                                  prefixIcon: const Icon(Icons.phone),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            hintText: 'Enter your full name',
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            hintText: 'Enter your email address',
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: 'Re-enter your password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            // Checkbox(
                            //   value: isChecked,
                            //   activeColor: Color.fromARGB(255, 255, 145, 77),
                            //   onChanged: (value) {
                            //     setState(() {
                            //       isChecked = value ?? false;
                            //     });
                            //   },
                            // ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: 'By signing up, you agree to our ',
                                  style: GoogleFonts.leagueSpartan(
                                      fontSize: 18, color: Colors.black45),
                                  children: [
                                    TextSpan(
                                      text: 'Terms & Conditions',
                                      style: GoogleFonts.leagueSpartan(
                                        // decoration: TextDecoration.underline,
                                        color:
                                            Color.fromARGB(200, 255, 145, 77),
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(text: ' and'),
                                    TextSpan(
                                      text: ' Privacy Policy',
                                      style: GoogleFonts.leagueSpartan(
                                        // decoration: TextDecoration.underline,
                                        color:
                                            Color.fromARGB(200, 255, 145, 77),
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => (),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 145, 77),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(
                            'Create Account',
                            style: GoogleFonts.quicksand(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: GoogleFonts.quicksand(fontSize: 15),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Login',
                                  style: GoogleFonts.leagueSpartan(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    )));
  }
}

