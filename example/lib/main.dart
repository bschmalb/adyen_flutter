import 'dart:convert';
import 'dart:developer';

import 'package:adyen_flutter_dropin/adyen_flutter_dropin.dart';
import 'package:adyen_flutter_dropin/enums/adyen_response.dart';
import 'package:adyen_flutter_dropin/exceptions/adyen_exception.dart';
import 'package:flutter/material.dart';

import 'mock_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? paymentResult;

  AdyenResponse? dropInResponse;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            try {
              dropInResponse = await FlutterAdyen.openDropIn(
                  paymentMethods: jsonEncode(examplePaymentMethods),
                  baseUrl: '$baseUrl/',
                  clientKey: clientKey,
                  locale: locale,
                  shopperReference: '',
                  returnUrl: 'adyendropin://',
                  amount: '100',
                  lineItem: {},
                  currency: currency,
                  additionalData: {},
                  headers: headers);
              setState(() {
                paymentResult = dropInResponse?.name;
              });
            } on AdyenException catch (e) {
              setState(() {
                paymentResult = e.error.name;
              });
            } catch (e) {
              log(e.toString());
            }
          },
        ),
        appBar: AppBar(
          title: const Text('Flutter Adyen'),
        ),
        body: Center(
          child: Text('Payment Result: $paymentResult\n'),
        ),
      ),
    );
  }
}
