import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import '../../Screens/ProfilePage.dart';

final List<String> dropdownOptions = [
  'Noise Disturbance',
  'Property Disputes',
  'Illegal Activities',
  'Animal Control Issues',
  'Safety and Security Concerns',
];

class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaints>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String _selectedCategory;

  final dateController = TextEditingController();
  final fileUploadController = TextEditingController();
  String? selectedFilePath;
  String? selectedDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _selectedCategory = 'General Report';
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      _selectedCategory = _tabController.index == 0
          ? 'General Blotter'
          : _tabController.index == 1
              ? 'Blotter Report '
              : '';
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    dateController.dispose();
    fileUploadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['General Report', 'Blotter Report '];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 239, 246),
      appBar: AppBar(
        title: Text(_selectedCategory),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle), // Profile Icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Color.fromARGB(255, 8, 123, 218),
            tabs: tabs.map((String tab) {
              return Tab(
                text: tab,
              );
            }).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
// -------------------------------------- GENERAL REPORT TAB--------------------------------------------------------------------------
// --------------------------------- REASON FOR FILING -----------------------------
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Reason for Filing',
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
// --------------------------------- LOCATION OF REPORT-----------------------------
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Location of Incident',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Location of the Incident';
                          }
                          return null;
                        },
                      ),
                    ),

// --------------------------------- DATE OF INCIDENT-----------------------------
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
                            title: Text(
                              selectedDate ?? 'Report Date',
                              style: const TextStyle(fontSize: 12.0),
                            ),
                            trailing: const Icon(
                              Icons.calendar_today,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),

// ------------------------------- DESCRIPTION OF THE INCIDENT  -----------------------------------------
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: TextFormField(
                        maxLines: 5,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Description of the Incident',
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

                    // --------------------------------------- FILE SUPPORTING DOCUMENTS -------------------
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
                            final result =
                                await FilePicker.platform.pickFiles();
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
                              'Upload Supporting Documents',
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

// --------------------------------- SUBMIT BUTTON ---------------------------------
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
                                        'Report submitted successfully.',
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
                    )
                  ],
                ),

// -------------------------------------- BLOTTER REPORT TAB--------------------------------------------------------------------------

                ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Reason for Filing',
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
// --------------------------------- LOCATION OF REPORT-----------------------------
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Location Report',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the Location of the Incident';
                          }
                          return null;
                        },
                      ),
                    ),

                    // --------------------------------- WITNESS ----------------------------
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Witness',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Witness in your Report';
                          }
                          return null;
                        },
                      ),
                    ),
// --------------------------------- DATE OF INCIDENT-----------------------------
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
                            title: Text(
                              selectedDate ?? 'Date of Incident',
                              style: const TextStyle(fontSize: 12.0),
                            ),
                            trailing: const Icon(
                              Icons.calendar_today,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),

// ------------------------------- DESCRIPTION OF THE REPORT -----------------------------------------
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: TextFormField(
                        maxLines: 5,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Description of the Report',
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

                    // --------------------------------------- FILE SUPPORTING DOCUMENTS -------------------
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
                            final result =
                                await FilePicker.platform.pickFiles();
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
                              'Upload Supporting Documents',
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

// --------------------------------- SUBMIT BUTTON ---------------------------------
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
                                        'Report submitted successfully.',
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
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
