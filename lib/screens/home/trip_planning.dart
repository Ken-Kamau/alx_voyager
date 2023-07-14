import 'package:alx_voyager/screens/home/destination_picker.dart';
import 'package:alx_voyager/screens/home/payment_screen.dart';
import 'package:alx_voyager/screens/home/startpoint_picker.dart';
import 'package:animated_number/animated_number.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TripPlanningScreen extends StatefulWidget {
  @override
  _TripPlanningScreenState createState() => _TripPlanningScreenState();
}

class _TripPlanningScreenState extends State<TripPlanningScreen> {
  final DateFormat _dateFormat = DateFormat('EEE, d MMMM, y');
  final DateFormat _timeFormat = DateFormat('h:mm a');

  String selectedStartingCountry = '';
  String selectedStartingCity = '';
  String selectedDestinationCountry = '';
  String selectedDestinationCity = '';

  String startingLocation = '';
  String destination = '';
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  String selectedTransportation = '';
  List<String> selectedActivities = [];
  bool agreeToTerms = false;
  String selectedCurrency = '';
  String selectedPaymentMode = '';
  String paymentDetails = '';

  bool isFormValid() {
    return 
        //startingLocation.isNotEmpty &&
        //destination.isNotEmpty &&
        selectedStartDate != null &&
        selectedEndDate != null &&
        selectedTransportation.isNotEmpty &&
        selectedActivities.isNotEmpty &&
        //selectedCurrency.isNotEmpty &&
        //selectedPaymentMode.isNotEmpty &&
        //paymentDetails.isNotEmpty &&
        agreeToTerms;
  }

  List<String> fetchCountryList() {
    // Replace this with your code to fetch the country list
    return ['Country 1', 'Country 2', 'Country 3'];
  }

  List<String> fetchCityList(String country) {
    // Replace this with your code to fetch the city list based on the selected country
    return ['City 1', 'City 2', 'City 3'];
  }

  void saveTrip() {
    if (isFormValid()) {
      // Save the trip details and show a success message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Booking Successful'),
          content: Text(
            'Your trip has been successfully planned.\n\nStart Date: ${_dateFormat.format(selectedStartDate)}\nEnd Date: ${_dateFormat.format(selectedEndDate)}\n\nTime: ${_timeFormat.format(selectedStartDate)}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Proceed to Payment'),
            ),
          ],
        ),
      );
    } else {
      // Show an error message if the form is not complete
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Form Incomplete'),
          content: Text(
              'Please fill in all sections and agree to the terms and conditions.'),
          actions: [
            TextButton(
              onPressed: () {
                
                
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => PaymentScreen()));
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Trip Planning',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: EdgeInsets.all(8),
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 16.0, 8, 16),
                child: Column(
                  children: [
                    Text(
                      'Trip Start:',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    StartPointPicker(),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8),
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 16.0, 8, 16),
                child: Column(
                  children: [
                    Text(
                      'Destination:',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    DestinationPicker(),
                  ],
                ),
              ),
            ),

            /*DropdownButtonFormField<String>(
              value: startingLocation.isNotEmpty ? startingLocation : null,
              onChanged: (value) {
                setState(() {
                  startingLocation = value!;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'Location 1',
                  child: Text('Location 1'),
                ),
                DropdownMenuItem(
                  value: 'Location 2',
                  child: Text('Location 2'),
                ),
                // Add more dropdown items as needed
              ],
              decoration: InputDecoration(labelText: 'Starting Location'),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: destination.isNotEmpty ? destination : null,
              onChanged: (value) {
                setState(() {
                  destination = value!;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'Destination 1',
                  child: Text('Destination 1'),
                ),
                DropdownMenuItem(
                  value: 'Destination 2',
                  child: Text('Destination 2'),
                ),
                // Add more dropdown items as needed
              ],
              decoration: InputDecoration(labelText: 'Destination'),
            ),*/
            SizedBox(height: 16.0),
            Card(
              elevation: 2,
              margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Column(
                  children: [
                    Text(
                      'Pick Your Travel Dates:',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        final selectedDates = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                          initialDateRange: DateTimeRange(
                            start: selectedStartDate,
                            end: selectedEndDate,
                          ),
                        );
                        if (selectedDates != null) {
                          setState(() {
                            selectedStartDate = selectedDates.start;
                            selectedEndDate = selectedDates.end;
                          });
                        }
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime:
                              TimeOfDay.fromDateTime(selectedStartDate),
                        );
                        if (selectedTime != null) {
                          setState(() {
                            selectedStartDate = DateTime(
                              selectedStartDate.year,
                              selectedStartDate.month,
                              selectedStartDate.day,
                              selectedTime.hour,
                              selectedTime.minute,
                            );
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Travel Dates',
                          border: OutlineInputBorder(),
                        ),
                        child: Center(
                          child: Text(
                            'From: ${_dateFormat.format(selectedStartDate)}\t || \tTo: ${_dateFormat.format(selectedEndDate)}',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Transportation',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2.0),
            Card(
              elevation: 2,
              child: Column(
                children: [
                  RadioListTile(
                    title: Text('Plane'),
                    value: 'Option 1',
                    groupValue: selectedTransportation,
                    onChanged: (value) {
                      setState(() {
                        selectedTransportation = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Roadtrip'),
                    value: 'Option 2',
                    groupValue: selectedTransportation,
                    onChanged: (value) {
                      setState(() {
                        selectedTransportation = value.toString();
                      });
                    },
                  ),
                  // Add more transportation options as needed
                ],
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 8.0),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8.0,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Activities',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value:
                                      selectedActivities.contains('Activity 1'),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        selectedActivities.add('Activity 1');
                                      } else {
                                        selectedActivities.remove('Activity 1');
                                      }
                                    });
                                  },
                                ),
                                Text('Water Skiing'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value:
                                      selectedActivities.contains('Activity 2'),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        selectedActivities.add('Activity 2');
                                      } else {
                                        selectedActivities.remove('Activity 2');
                                      }
                                    });
                                  },
                                ),
                                Text('Sky Diving'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value:
                                      selectedActivities.contains('Activity 3'),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        selectedActivities.add('Activity 3');
                                      } else {
                                        selectedActivities.remove('Activity 3');
                                      }
                                    });
                                  },
                                ),
                                Text('Safari'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Add more activity checkboxes as needed
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Total Amount:',
                        style: TextStyle(color: Colors.blue[900], fontSize: 20),
                      ),
                      AnimatedNumber(
                        startValue: 0,
                        endValue: 5000,
                        duration: Duration(seconds: 4),
                        isFloatingPoint: false,
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Row(
                children: [
                  Checkbox(
                    value: agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        agreeToTerms = value ?? false;
                      });
                    },
                  ),
                  Text('I agree to the terms and conditions'),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (isFormValid()) {
                  saveTrip();
                } else {
                  print('Missing Info');
                }
              },
              child: Text('Save & Proceed to Payment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isFormValid() ? Colors.blue : Colors.grey,
                foregroundColor: Colors.white,
                //enabled: isFormValid(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
