import 'package:customer/gridView.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _packageController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _remainingController = TextEditingController();
  bool isLoading = false;
  DateTime _selectedDate = DateTime.now();
  //TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _dateController.text =
        "${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}";
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  bool _isPaid = false;

  String _selectedPackage = '3 MB';

  CollectionReference _customersCollection =
      FirebaseFirestore.instance.collection('customers');

  bool _isAdding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 122, 152, 133),
      appBar: AppBar(
        backgroundColor: Color(0xff00c853),
        title: Text('Customer Billing'),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Grid()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg6.jpg"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: _nameController,
                    onChanged: (_) {
                      // Perform live search when search field changes
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: Color(0x00ffffff), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: Color(0x00ffffff), width: 3),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: Color(0x00ffffff), width: 3),
                      ),
                      hintText: "Name",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff9f9d9d),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 236, 232, 195),
                      isDense: false,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      suffixIcon:
                          Icon(Icons.edit, color: Color(0xff00c853), size: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: Color(0x00ffffff), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: Color(0x00ffffff), width: 3),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: Color(0x00ffffff), width: 3),
                      ),
                      hintText: "Address",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff9f9d9d),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 236, 232, 195),
                      isDense: false,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      suffixIcon: Icon(Icons.location_pin,
                          color: Color(0xff00c853), size: 18),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DropdownButtonFormField<String>(
                      value: _selectedPackage,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedPackage = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              BorderSide(color: Color(0x00ffffff), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              BorderSide(color: Color(0x00ffffff), width: 3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              BorderSide(color: Color(0x00ffffff), width: 3),
                        ),
                        hintText: "Package",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff9f9d9d),
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 236, 232, 195),
                        isDense: false,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        suffixIcon: Icon(Icons.wifi,
                            color: Color(0xff00c853), size: 18),
                      ),
                      items: [
                        '3 MB',
                        '5 MB',
                        '10 MB',
                        '15 MB',
                        '20 MB',
                        '30 MB',
                        '50 MB'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: _dateController,
                    onTap: () {
                      _selectDate;
                    },
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: Color(0x00ffffff), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: Color(0x00ffffff), width: 3),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: Color(0x00ffffff), width: 3),
                      ),
                      hintText: "dd-mm-yyyy",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff9f9d9d),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 236, 232, 195),
                      isDense: false,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      suffixIcon: Icon(Icons.date_range,
                          color: Color(0xff00c853), size: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _priceController,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: Color(0x00ffffff), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: Color(0x00ffffff), width: 3),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: Color(0x00ffffff), width: 3),
                      ),
                      hintText: "Price",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff9f9d9d),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 236, 232, 195),
                      isDense: false,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      suffixIcon: Icon(Icons.attach_money_sharp,
                          color: Color(0xff00c853), size: 18),
                    ),
                  ),
                ),
                // CheckboxListTile(
                //   checkboxShape: CircleBorder(),
                //   side: BorderSide(color: Colors.white),
                //   activeColor: Colors.green,
                //   value: _isPaid,
                //   title: Text(
                //     'Paid',
                //     style: TextStyle(
                //         backgroundColor: Color.fromARGB(255, 236, 232, 195),
                //         color: const Color.fromARGB(255, 47, 44, 44)),
                //   ),
                //   onChanged: (value) {
                //     setState(() {
                //       _isPaid = value ?? false;
                //     });
                //   },
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(19.0),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Color(
                              0xFF00796B); // Color when the button is pressed
                        }
                        return Color(0xFF00C853); // Default color
                      }),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: isLoading
                        ? null
                        : () {
                            _addCustomer(context);
                            Container(
                                child: Center(
                              child: Lottie.network(
                                'https://lottie.host/6b0657a1-1b92-4ae2-881c-25e779137738/zoOszmZXUY.json',
                                height: 150,
                                repeat: true,
                                animate: true,
                                width: 150,
                              ),
                            ));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()));
                          },
                    child: isLoading
                        ? Container(
                            child: Center(
                              child: Lottie.network(
                                'https://lottie.host/6b0657a1-1b92-4ae2-881c-25e779137738/zoOszmZXUY.json',
                                height: 150,
                                repeat: true,
                                animate: true,
                                width: 150,
                              ),
                            ),
                          )
                        : Text(
                            'Add Customer',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addCustomer(BuildContext context) async {
    String name = _nameController.text.trim();
    String address = _addressController.text.trim();
    String package = _selectedPackage.trim();
    String date = _dateController.text.trim();
    String price = _priceController.text.trim();
    String remaining = _remainingController.text.trim();

    if (name.isEmpty || address.isEmpty || price.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Fill the Fields'),
        ),
      );

      return;
    }

    DateTime subscriptionDate = DateFormat("dd-MM-yyyy").parse(date);
    DateTime expirationDate = subscriptionDate
        .add(Duration(days: 30)); // Adding 30 days to the subscription date
    setState(() {
      _isAdding = true;
      isLoading = true;
    });

    bool isExpired = DateTime.now().isAfter(expirationDate);
    try {
      await _customersCollection.add({
        'name': name,
        'address': address,
        'package': package,
        'date': date,
        'price': price,
        // 'paid': _isPaid,
        'paid': !isExpired,
        'remaining': remaining,
      });

      _clearTextFields();
      Navigator.pop(context); // Close the dialog after adding.
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 19,
          backgroundColor: Colors.white,
          title: Text('Success'),
          content: Text('Customer added successfully!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 19,
          backgroundColor: Colors.white,
          title: Text('Error'),
          content: Text('Failed to add customer.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isAdding = false;
        isLoading = false;
      });
    }
  }

  void _clearTextFields() {
    _nameController.clear();
    _addressController.clear();
    _packageController.clear();
    _dateController.clear();
    _priceController.clear();
    _remainingController.clear();
  }
}

// ignore: must_be_immutable
class CustomerListScreen extends StatelessWidget {
  CollectionReference _customersCollection =
      FirebaseFirestore.instance.collection('customers');

  Stream<List<QueryDocumentSnapshot>> _getCustomersStream(String searchTerm) {
    if (searchTerm.isEmpty) {
      return _customersCollection.snapshots().map((snapshot) => snapshot.docs);
    } else {
      return _customersCollection
          .where('name', isGreaterThanOrEqualTo: searchTerm)
          .where('name', isLessThanOrEqualTo: searchTerm + '\uf8ff')
          .snapshots()
          .map((snapshot) => snapshot.docs);
    }
  }

  void _showCustomerDetails(
      BuildContext context, QueryDocumentSnapshot customerData) {
    bool isExpired = DateFormat("dd-MM-yyyy")
        .parse(customerData['date'])
        .isAfter(DateTime.now());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 19,
          backgroundColor: Colors.white,
          title: Text('Customer Details'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Name: ${customerData['name']}'),
                Text('Address: ${customerData['address']}'),
                Text('Package: ${customerData['package']}'),
                Text('Date: ${customerData['date']}'),
                Text('Price: ${customerData['price']}'),
                //  Text('Paid: ${customerData['paid'] ? 'Paid' : 'UnPaid'}'),
                Text('Remaining: ${customerData['remaining']}'),
                Text(
                    'Paid: ${isExpired ? 'UnPaid' : (customerData['paid'] ? 'Paid' : 'UnPaid')}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showNotFoundDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 19,
          backgroundColor: Colors.white,
          title: Text('Customer Not Found'),
          content: Text('No customer found with the given name.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void _editCustomer(BuildContext context, QueryDocumentSnapshot customerData) {
    String name = customerData['name'];
    String address = customerData['address'];
    String package = customerData['package'];
    String date = customerData['date'];
    String price = customerData['price'];
    bool isPaid = customerData['paid'] ?? false;
    String remaining = customerData['remaining'];
    String give = remaining + price;
    TextEditingController _editNameController =
        TextEditingController(text: name);
    TextEditingController _editAddressController =
        TextEditingController(text: address);
    TextEditingController _editPackageController =
        TextEditingController(text: package);
    TextEditingController _editDateController =
        TextEditingController(text: date);
    TextEditingController _editPriceController =
        TextEditingController(text: price);
    TextEditingController _editRemainingController =
        TextEditingController(text: remaining);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 19,
          backgroundColor: Colors.white,
          title: Text('Edit Customer'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _editNameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: _editAddressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                TextFormField(
                  controller: _editPackageController,
                  decoration: InputDecoration(labelText: 'Package'),
                ),
                TextFormField(
                  controller: _editDateController,
                  decoration: InputDecoration(labelText: 'Date'),
                ),
                TextFormField(
                  controller: _editPriceController,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                TextFormField(
                  controller: _editRemainingController,
                  decoration: InputDecoration(labelText: 'Remaining'),
                ),
                CheckboxListTile(
                    checkboxShape: CircleBorder(),
                    activeColor: Colors.green,
                    value: isPaid,
                    title: Text(
                      'Paid',
                      style: TextStyle(
                          backgroundColor: Color.fromARGB(255, 236, 232, 195),
                          color: const Color.fromARGB(255, 47, 44, 44)),
                    ),
                    onChanged: (value) {
                      isPaid = value ?? false;
                    }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await _customersCollection.doc(customerData.id).update({
                    'name': _editNameController.text,
                    'address': _editAddressController.text,
                    'package': _editPackageController.text,
                    'date': _editDateController.text,
                    "price": _editPriceController.text,
                    "paid": isPaid,
                    "remaining": _editRemainingController.text,
                  });

                  DateTime customerDate =
                      DateFormat("dd-MM-yyyy").parse(_editDateController.text);
                  DateTime currentDate = DateTime.now();
                  if (customerDate.isBefore(currentDate) &&
                      customerData['paid'] != true) {
                    // Customer is expired and not marked as paid

                    // Calculate next expiration date
                    DateTime nextExpirationDate =
                        customerDate.add(Duration(days: 30));

                    // Check if the next expiration date is in the future
                    if (nextExpirationDate.isAfter(currentDate)) {
                      String collectionName =
                          nextExpirationDate.toLocal().toString().split(' ')[0];
                      CollectionReference expiredCustomersCollection =
                          FirebaseFirestore.instance.collection(collectionName);

                      await expiredCustomersCollection.add({
                        'name': _editNameController.text,
                        'address': _editAddressController.text,
                        'package': _editPackageController.text,
                        'date': nextExpirationDate.toLocal().toString(),
                        'price': _editPriceController.text,
                        'paid': false,
                        'remaining': (_editRemainingController.text ?? "0"),
                      });
                    }
                  }

                  Navigator.pop(context); // Close the edit dialog
                  _showCustomerDetails(
                      context, customerData); // Show updated details
                } catch (error) {
                  // Handle error if any
                  print('Failed to update customer: $error');
                }
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteCustomer(
      BuildContext context, QueryDocumentSnapshot customerData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 19,
          backgroundColor: Colors.white,
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this customer?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await _customersCollection.doc(customerData.id).delete();
                  Navigator.pop(
                      context); // Close the delete confirmation dialog
                  Navigator.pop(context); // Close the customer details dialog

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerListScreen()));
                } catch (error) {
                  // Handle error if any
                  print('Failed to delete customer: $error');
                }
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 122, 152, 133),
      appBar: AppBar(
        backgroundColor: Color(0xff00c853),
        title: Text('All Customers'),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Grid()),
              );
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<QueryDocumentSnapshot>>(
              stream: _getCustomersStream(''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Lottie.network(
                      'https://lottie.host/6b0657a1-1b92-4ae2-881c-25e779137738/zoOszmZXUY.json',
                      height: 150,
                      repeat: true,
                      animate: true,
                      width: 150,
                    ),
                  );
                }

                final List<QueryDocumentSnapshot> customers =
                    snapshot.data ?? [];
                final searchTerm = '';

                if (customers.isEmpty && searchTerm.isNotEmpty) {
                  return Center(
                      child: Text('No customers found for "$searchTerm".'));
                }

                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    var customerData = customers[index];
                    bool isExpired = customerData['paid'] ?? false;
                    Color tileColor = isExpired
                        ? Colors.white
                        : const Color.fromARGB(255, 175, 69, 62);
                    return Column(
                      children: [
                        ListTile(
                          title: Text('Name:  ${customerData['name']}'),
                          subtitle: Text(
                            'Address:  ${customerData['address']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () =>
                              _showCustomerDetails(context, customerData),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  'Remaining:  ${customerData['remaining']}            ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Color(0xFF00C853),
                                ),
                                onPressed: () =>
                                    _editCustomer(context, customerData),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () =>
                                    _deleteCustomer(context, customerData),
                              ),
                            ],
                          ),
                          tileColor: tileColor,
                        ),
                        Divider(
                          color: Color(0xFF00C853),
                          height: 2,
                          thickness: 2,
                        ), // Add Divider here
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                elevation: MaterialStateProperty.all(19.0),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0)),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Color(
                        0xFF00796B); // Color when the button is pressed
                  }
                  return Color(0xFF00C853); // Default color
                }),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {
                final searchTerm = await _getNameFromDialog(context);
                if (searchTerm != null) {
                  final querySnapshot = await _customersCollection
                      .where('name', isEqualTo: searchTerm)
                      .get();
                  if (querySnapshot.docs.isNotEmpty) {
                    final customerData = querySnapshot.docs.first;
                    _showCustomerDetails(context, customerData);
                  } else {
                    _showNotFoundDialog(context);
                  }
                }
              },
              child: Text('Search Customer by Name'),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _getNameFromDialog(BuildContext context) async {
    TextEditingController _nameSearchController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 19,
          backgroundColor: Colors.white,
          title: Text('Search Customer by Name'),
          content: TextFormField(
            controller: _nameSearchController,
            decoration: InputDecoration(
              labelText: 'Enter customer name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, _nameSearchController.text);
              },
              child: Text(
                'Search',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
