import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:munju_mpo/database/config.dart';
import 'package:munju_mpo/page/customer.dart';
import 'package:munju_mpo/page/nic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class customer_add extends StatefulWidget {
  const customer_add({super.key});

  @override
  State<customer_add> createState() => _customer_addState();
}

class _customer_addState extends State<customer_add> {
  TextEditingController emailcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _nicController = TextEditingController();
  final _phone_noController = TextEditingController();
  final _tdsController = TextEditingController();
  final _schedulController = TextEditingController();
  final _productController = TextEditingController();

  double _currentSliderValue = 3;
  var cusNic = '';
  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> _employee = [];
  String? type_id; // Selected type ID

  int emp_id = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      cusNic = prefs.getString('cus_nic') ?? '';

      final List<Map<String, dynamic>> cusdata =
          await DatabaseHelper.Query("SELECT id, name FROM customer");
      final List<Map<String, dynamic>> empdata =
          await DatabaseHelper.Query("SELECT id, name FROM employee");

      setState(() {
        _items = cusdata; // Ensure the query returns id and name
        _employee = empdata;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void datePick() {
    var formatter = DateFormat('yyyy-MM-dd');
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime(2050))
        .then((value) {
      setState(() {
        _schedulController.text = formatter.format(value!);
      });
    });
  }

  @override
  void dispose() async {
    _firstNameController.dispose();
    _addressController.dispose();
    _nicController.dispose();
    _phone_noController.dispose();
    _tdsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                const Center(
                  child: Image(
                    image: AssetImage('assets/customer form.png'),
                    width: 250,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                      child: Text(
                    cusNic,
                    style: TextStyle(fontSize: 26),
                  )),
                ),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'නම හිස්ව තැබිය නොහැක';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ලිපිනය හිස්ව තැබිය නොහැක';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _phone_noController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'දුරකතන අංක​ය හිස්ව තැබිය නොහැක';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _tdsController,
                  decoration: const InputDecoration(
                    labelText: 'TDS Value',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  onTap: () {
                    datePick();
                  },
                  keyboardType: TextInputType.none,
                  controller: _schedulController,
                  decoration: const InputDecoration(
                    labelText: 'Schedule Date',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                  ),
                ),
                const SizedBox(height: 29.0),
                const Text(
                  'Indicate the level of customer interest.',
                  style: TextStyle(color: Color.fromARGB(255, 127, 127, 127)),
                ),
                const Text(
                  'පාරිබෝගිකයාගේ උනන්දුවේ ප්‍රමානය සදහන් කරන්න',
                  style: TextStyle(
                      color: Color.fromARGB(255, 127, 127, 127), fontSize: 11),
                ),
                Slider(
                  value: _currentSliderValue,
                  max: 5,
                  divisions: 5,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
                const Text(
                  'Choose a Product type',
                  style: TextStyle(
                    color: Color.fromARGB(255, 127, 127, 127),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ), // Add some spacing
                DropdownButtonFormField<dynamic>(
                  items: _items.map<DropdownMenuItem<dynamic>>((item) {
                    return DropdownMenuItem<dynamic>(
                      value: item['id'], // Ensure 'id' exists in the data
                      child: Text(item['name']
                          .toString()), // Ensure 'name' exists in the data
                    );
                  }).toList(),
                  onChanged: (dynamic newValue) {
                    setState(() {
                      type_id = newValue;
                    });

                    print("Selected Type ID: $type_id");
                  },
                  decoration: const InputDecoration(
                    labelText: 'Customer type',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10.0),

                const SizedBox(height: 10.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 101, 102, 102)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => nic(),
                            ),
                          );
                        },
                        child: const Text(
                          "Back",
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 3, 189, 251)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Process data
                            var now = DateTime.now();
                            var formatter = DateFormat('yyyy-MM-dd');
                            var tformatter = DateFormat('HH:mm:ss');
                            String date = formatter.format(now);
                            String time = tformatter.format(now);
                            await DatabaseHelper.SQL(
                                "INSERT INTO visit (name, address, nic, phone, tds_value, positive, schedule_date, date, time)" +
                                    "VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                                [
                                  _firstNameController.text,
                                  _addressController.text,
                                  cusNic,
                                  _phone_noController.text,
                                  _tdsController.text,
                                  _currentSliderValue,
                                  _schedulController.text,
                                  date,
                                  time
                                ]);
                            await DatabaseHelper.getData('visit');

                            // TODO: Implement registration logic here
                            // (e.g., send data to server, save to database)

                            // Example: Display a success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Registration successful!')),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => customer(),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    )
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
