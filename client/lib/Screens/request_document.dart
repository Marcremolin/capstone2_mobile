import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import '../../Screens/ProfilePage.dart';

final List<String> dropdownOptions = [
  'Barangay Clearance',
  'Business Permit',
  'Installation Permit',
  'Certificate of Indulgency',
  'Construction Permit',
];

class Documentation extends StatefulWidget {
  const Documentation({super.key});

  @override
  _DocumentationState createState() => _DocumentationState();
}

class _DocumentationState extends State<Documentation>
    with SingleTickerProviderStateMixin {
  late String _selectedCategory;
  bool isCashPayment = false;
  bool isGcashPayment = false;
  final dateController = TextEditingController();
  final fileUploadController = TextEditingController();
  String? selectedFilePath;
  String? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 95, 170),
      appBar: AppBar(
        title: const Text('Request Document'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // -------------------------------------------TYPE OF DOCUMENTS ---------------------------
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: 'Type of Documents',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(color: Colors.black),
              dropdownColor: Colors.white,
              items: dropdownOptions.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedCategory = value ?? '';
                });
              },
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            ),

            // ------------------------------------------- DATE OF PICK-UP ---------------------------
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: const Color.fromARGB(255, 245, 245, 245),
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
                      'Date of Pick-up',
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

            // ------------------------------------------- REASON FOR REQUESTING ---------------------------
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: TextFormField(
                maxLines: 5,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Reason for Requesting',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a description';
                  }
                  return null;
                },
              ),
            ),

            // ------------------------------------------- PAYMENT METHOD CHECKBOX ---------------------------
            const SizedBox(height: 16.0),
            ListTile(
              title: const Text(
                'Pay with Cash',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              leading: Checkbox(
                value: isCashPayment,
                onChanged: (bool? value) {
                  setState(() {
                    isCashPayment = value ?? false;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text(
                'Pay with GCash',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              leading: Checkbox(
                value: isGcashPayment,
                onChanged: (bool? value) {
                  setState(() {
                    isGcashPayment = value ?? false;
                  });
                },
              ),
            ),
            // ------------------------------------------- PAYMENT REFERENCE NUMBER ---------------------------
            Visibility(
              visible: isGcashPayment,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Payment Reference Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the payment reference number';
                    }
                    return null;
                  },
                ),
              ),
            ),

            // -------------------------------------------  UPLOAD GCASH Receipt  ---------------------------
            Visibility(
              visible: isGcashPayment,
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color.fromARGB(255, 245, 245, 245),
                      ),
                      child: InkWell(
                        onTap: () async {
                          final result = await FilePicker.platform.pickFiles();
                          if (result != null && result.files.isNotEmpty) {
                            final file = result.files.first;
                            final filePath = file.path;
                            final fileName = path.basename(filePath!);

                            setState(() {
                              selectedFilePath = filePath;
                              fileUploadController.text = fileName;
                            });
                          }
                        },
                        child: const ListTile(
                          title: Text(
                            'Upload GCASH Receipt',
                            style: TextStyle(fontSize: 12.0),
                          ),
                          trailing: Icon(
                            Icons.cloud_upload,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // -------------------------------------------  SUBMIT BUTTON ---------------------------
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Success',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              const Text(
                                'Request submitted successfully.',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                                child: const Text(
                                  'OK',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 9, 33, 152)),
                ),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
