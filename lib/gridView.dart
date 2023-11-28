import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'allData.dart';
import 'loginUser.dart';

class Grid extends StatelessWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 122, 152, 133),
      appBar: AppBar(
        backgroundColor: Color(0xff00c853),
        title: Text('Customer Billing'),
        leading: IconButton(
          icon: Icon(
            Icons.logout_outlined,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg6.jpg'), fit: BoxFit.cover)),
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 150),
            child: Center(
                child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 247, 251, 6),
                        Colors.lightGreen,
                      ]),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 213, 92, 92),
                            blurRadius: 2.0,
                            offset: Offset(5.0, 5.0))
                      ]),
                  child: IconButton(
                      icon: Icon(
                        Icons.man,
                        size: 100,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    MyApp(),
                            transitionDuration: Duration(
                                seconds: 2), // Change the duration as needed
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(0.0, 1.0);
                              const end = Offset.zero;
                              const curve = Curves.bounceInOut;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      tooltip: 'Add Customer',
                      hoverColor: Colors.blue),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 247, 251, 6),
                        Colors.lightGreen,
                      ]),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 213, 92, 92),
                            blurRadius: 2.0,
                            offset: Offset(5.0, 5.0))
                      ]),
                  child: IconButton(
                      icon: Icon(
                        Icons.family_restroom,
                        size: 100,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    CustomerListScreen(),
                            transitionDuration: Duration(
                                seconds: 2), // Change the duration as needed
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(0.0, 1.0);
                              const end = Offset.zero;
                              const curve = Curves.bounceInOut;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                        // _displayAllCustomers(context);
                      },
                      tooltip: 'Display Customer',
                      hoverColor: Colors.blue),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 247, 251, 6),
                        Colors.lightGreen,
                      ]),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 213, 92, 92),
                            blurRadius: 2.0,
                            offset: Offset(5.0, 5.0))
                      ]),
                  child: IconButton(
                      icon: Icon(
                        Icons.money,
                        size: 100,
                      ),
                      onPressed: () {
                        _calculateTotalPaid(context);
                      },
                      tooltip: 'Paid Customer',
                      hoverColor: Colors.blue),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 247, 251, 6),
                        Colors.lightGreen,
                      ]),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 213, 92, 92),
                            blurRadius: 2.0,
                            offset: Offset(5.0, 5.0))
                      ]),
                  child: IconButton(
                      icon: Icon(
                        Icons.money_off_csred_rounded,
                        size: 100,
                      ),
                      onPressed: () {
                        _calculateTotalUnPaid(context);
                      },
                      tooltip: 'UnPaid Customer',
                      hoverColor: Colors.blue),
                ),
              ],
            )),
          ),
        ]),
      ),
    );
  }
}

void _calculateTotalUnPaid(BuildContext context) async {
  final snapshot =
      await _customersCollection.where('paid', isEqualTo: false).get();
  int totalUnPaid = 0;
  int totalUnPaidCustomer = 0;
  try {
    for (var customer in snapshot.docs) {
      totalUnPaid += int.parse(customer['price'] ?? '0');
      totalUnPaidCustomer += 1;
    }
  } catch (e) {
    print(e);
  }
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            elevation: 19,
            backgroundColor: Colors.white,
            title: Text('Total Paid Customer'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Total UnPaid Customer Price: ${totalUnPaid.toStringAsFixed(2)}'),
                Text('Total UnPaid Customers: ${totalUnPaidCustomer}'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ));
}

void _calculateTotalPaid(BuildContext context) async {
  final snapshot =
      await _customersCollection.where('paid', isEqualTo: true).get();

  int totalPaid = 0;
  int totalPaidCustomer = 0;
  try {
    for (var customer in snapshot.docs) {
      totalPaid += int.parse(customer['price'] ?? '0');
      totalPaidCustomer += 1;
    }
  } catch (e) {
    print(e);
  }

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            elevation: 19,
            backgroundColor: Colors.white,
            title: Text('Total Paid Customer'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Total Paid Customer Price: ${totalPaid.toStringAsFixed(2)}'),
                Text('Total Paid Customers: ${totalPaidCustomer}'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ));
}

CollectionReference _customersCollection =
    FirebaseFirestore.instance.collection('customers');

bool _isAdding = false;
