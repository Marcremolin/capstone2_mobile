import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';
import '../../../Screens/Homepage/Homepage.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  String? selectedDate;
  bool _checkBoxValue1 = false;
  bool _checkBoxValue2 = false;
  bool _checkBoxValue3 = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'RESIDENCE PROFILE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Last Name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Last Name is required';
                }
                return null;
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "First Name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'First Name is required';
                }
                return null;
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Middle Initial",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Middle Initial is required';
                }
                return null;
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Suffix",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'COMPLETE ADDRESS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 8), // Adjust the spacing here
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: "House #",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.home),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'House # is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: "City",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.home),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'City is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: "Street",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.home),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Street is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),

              // 2ND COLUMN
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: "Barangay",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.home),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Barangay';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: "District",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.home),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'District is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: "Region",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.home),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Region is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ],
          ),

          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'PERSONAL INFORMATION',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          //GENDER
          const SizedBox(height: defaultPadding),
          const Text(
            'GENDER',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: _checkBoxValue1,
                onChanged: (value) {
                  setState(() {
                    _checkBoxValue1 = value ?? false;
                  });
                },
              ),
              const Text('Male'),
              Checkbox(
                value: _checkBoxValue2,
                onChanged: (value) {
                  setState(() {
                    _checkBoxValue2 = value ?? false;
                  });
                },
              ),
              const Text('Female'),
            ],
          ),

          //  CIVIL STATUS
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Civil Status',
                hintStyle: TextStyle(fontSize: 12),
              ),
              value: null,
              icon: const Icon(Icons.arrow_drop_down),
              items: const [
                DropdownMenuItem<String>(
                  value: 'Single',
                  child: Text('Single'),
                ),
                DropdownMenuItem<String>(
                  value: 'Married',
                  child: Text('Married'),
                ),
                DropdownMenuItem<String>(
                  value: 'Widowed',
                  child: Text('Widowed'),
                ),
                DropdownMenuItem<String>(
                  value: 'Separated',
                  child: Text('Separated'),
                ),
              ],
              onChanged: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Civil Status is Required';
                }
                return null;
              },
            ),
          ),
// NATIONALITY
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Nationality",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nationality is required';
                }
                return null;
              },
            ),
          ),

          // DATE OF BIRTH
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color.fromARGB(255, 152, 191, 223),
              ),
              child: InkWell(
                onTap: () async {
                  final currentDate = DateTime.now();
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: currentDate,
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                    });
                  }
                },
                child: ListTile(
                  title: const Text(
                    'Date of Birth',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  trailing: Text(
                    selectedDate ?? 'Select date',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),
// BIRTHPLACE
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Birthplace",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Birthplace is required';
                }
                return null;
              },
            ),
          ),

          // AGE
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Age",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Age is required';
                }
                return null;
              },
            ),
          ),

          //  Highest Educational Attaintment
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Highest Educational Attaintment',
                hintStyle: TextStyle(fontSize: 12),
              ),
              value: null,
              icon: const Icon(Icons.arrow_drop_down),
              items: const [
                DropdownMenuItem<String>(
                  value: 'NFE',
                  child: Text('No Formal Education'),
                ),
                DropdownMenuItem<String>(
                  value: 'Elementary Level',
                  child: Text('Elementary Level'),
                ),
                DropdownMenuItem<String>(
                  value: 'High School Level',
                  child: Text('High School Level'),
                ),
                DropdownMenuItem<String>(
                  value: 'Vocational or Technical Course',
                  child: Text('Technical Course'),
                ),
                DropdownMenuItem<String>(
                  value: 'Bachelors Degree',
                  child: Text('Bachelors Degree'),
                ),
                DropdownMenuItem<String>(
                  value: 'Masters Degree',
                  child: Text('Masters Degree'),
                ),
                DropdownMenuItem<String>(
                  value: 'Doctorate or PhD',
                  child: Text('Doctorate or PhD'),
                ),
              ],
              onChanged: (value) {},
            ),
          ),

          //  Employment Status
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Employment Status',
                hintStyle: TextStyle(fontSize: 16),
              ),
              value: null,
              icon: const Icon(Icons.arrow_drop_down),
              items: const [
                DropdownMenuItem<String>(
                  value: 'Regular Employee',
                  child: Text('Permanent Employee'),
                ),
                DropdownMenuItem<String>(
                  value: 'Volunteer',
                  child: Text('Volunteer'),
                ),
                DropdownMenuItem<String>(
                  value: 'Self-Employed',
                  child: Text('Self-Employed'),
                ),
                DropdownMenuItem<String>(
                  value: 'Freelancer',
                  child: Text('Freelancer'),
                ),
                DropdownMenuItem<String>(
                  value: 'Part-Time Employee',
                  child: Text('Part-Time Employee'),
                ),
                DropdownMenuItem<String>(
                  value: 'Contractual/Project-Based Employee',
                  child: Text('Project-Based Employee'),
                ),
              ],
              onChanged: (value) {},
            ),
          ),

          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Company Name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Position",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),

          //HOME OWNERSHIP
          const SizedBox(height: defaultPadding),
          const Text(
            'HOME OWNERSHIP',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: _checkBoxValue1,
                onChanged: (value) {
                  setState(() {
                    _checkBoxValue1 = value ?? false;
                  });
                },
              ),
              const Text('Owner'),
              Checkbox(
                value: _checkBoxValue2,
                onChanged: (value) {
                  setState(() {
                    _checkBoxValue2 = value ?? false;
                  });
                },
              ),
              const Text('Renting'),
            ],
          ),

// CONTACT INFORMATION  ----------------------------------------------------------
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'CONTACT DETAILS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ), // PHONE NUMBER
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Phone Number",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone Number is required';
                }
                return null;
              },
            ),
          ),

// 2ND NUMBER OPTIONAL
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "2nd Number (Optional)",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),

// EMAIL ADDRESS
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Email Address",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email Address is required';
                }
                return null;
              },
            ),
          ),

// OTHER INFORMATION ----------------------------------------------------------
          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'OTHER INFORMATION',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Divider(
            color: Color.fromARGB(255, 152, 191, 223),
            thickness: 2,
            height: 1,
          ),
          // PENSIONER
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Pensioner',
                hintStyle: TextStyle(fontSize: 16),
              ),
              value: null,
              icon: const Icon(Icons.arrow_drop_down),
              items: const [
                DropdownMenuItem<String>(
                  value: 'Opt1',
                  child: Text('SSS'),
                ),
                DropdownMenuItem<String>(
                  value: 'Opt2',
                  child: Text('GSIS'),
                ),
                DropdownMenuItem<String>(
                  value: 'Opt3',
                  child: Text('AFP'),
                ),
                DropdownMenuItem<String>(
                  value: 'Opt4',
                  child: Text('PNP'),
                ),
                DropdownMenuItem<String>(
                  value: 'Opt5',
                  child: Text('DOLE'),
                ),
                DropdownMenuItem<String>(
                  value: 'Opt6',
                  child: Text('Others'),
                ),
              ],
              onChanged: (value) {},
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Gender is Required';
              //   }
              //   return null;
              // },
            ),
          ),
          const SizedBox(height: defaultPadding),
          //RESIDENT CLASS
          const Text(
            'RESIDENT CLASS',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: defaultPadding),
              Wrap(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _checkBoxValue1,
                        onChanged: (value) {
                          setState(() {
                            _checkBoxValue1 = value ?? false;
                          });
                        },
                      ),
                      const Text('PWD'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _checkBoxValue2,
                        onChanged: (value) {
                          setState(() {
                            _checkBoxValue2 = value ?? false;
                          });
                        },
                      ),
                      const Text('Solo Parent'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _checkBoxValue3,
                        onChanged: (value) {
                          setState(() {
                            _checkBoxValue3 = value ?? false;
                          });
                        },
                      ),
                      const Text('Out of School Youth'),
                    ],
                  ),
                ],
              ),
            ],
          ),

// --------------------------------- PASSWORD -------------------------------
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              obscureText: !isPasswordVisible,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: defaultPadding / 2),
                  child: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ),

// CONFIRM PASSWORD
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              obscureText: !isConfirmPasswordVisible,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Confirm password",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: defaultPadding / 2),
                  child: IconButton(
                    icon: Icon(
                      isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Announcement();
                  },
                ),
              );
            },
            child: Text("Save".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
