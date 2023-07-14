import "package:flutter/material.dart";

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedCurrency = '';
  String selectedPaymentMode = '';
  String paymentDetails = '';
  bool isFormValid() {
    return selectedCurrency.isNotEmpty &&
        selectedPaymentMode.isNotEmpty &&
        paymentDetails.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(8),
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 16.0, 8, 16),
            child: DropdownButtonFormField<String>(
              value: selectedCurrency.isNotEmpty ? selectedCurrency : null,
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value!;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Currency 1',
                  child: Text('Currency 1'),
                ),
                DropdownMenuItem(
                  value: 'Currency 2',
                  child: Text('Currency 2'),
                ),
                // Add more currency options as needed
              ],
              decoration: InputDecoration(labelText: 'Currency'),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Card(
          margin: EdgeInsets.all(8),
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 16.0, 8, 16),
            child: DropdownButtonFormField<String>(
              value:
                  selectedPaymentMode.isNotEmpty ? selectedPaymentMode : null,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMode = value!;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Payment Mode 1',
                  child: Text('Payment Mode 1'),
                ),
                DropdownMenuItem(
                  value: 'Payment Mode 2',
                  child: Text('Payment Mode 2'),
                ),
                // Add more payment mode options as needed
              ],
              decoration: InputDecoration(labelText: 'Payment Mode'),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Card(
          margin: EdgeInsets.all(8),
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16, 8, 16),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Payment Details'),
              onChanged: (value) {
                setState(() {
                  paymentDetails = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
