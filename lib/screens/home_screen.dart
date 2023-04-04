import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:g10mart/providers/home_provider.dart';
import 'package:g10mart/screens/product_screen.dart';
import 'package:g10mart/widgets/colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  @override
  void initState() {
    getConnectivity();
    super.initState();
    context.read<HomeProvider>().fetchProductsDetails();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: primaryColor.withOpacity(0.9),
        title: Text("G10Mart"),
        centerTitle: true,
      ),
      body: Consumer<HomeProvider>(builder: (context, value, child) {
        if (value.productList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.separated(
            padding: EdgeInsets.only(top: 10),
            itemCount: value.productList.length,
            itemBuilder: (context, index) {
              return ProductScreen(product: value.productList[index]);
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 5,
              );
            },
          );
        }
      }),
    );
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('No Connection'),
            content: const Text('Please check your internet connectivity'),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                  setState(() => isAlertSet = false);
                  isDeviceConnected =
                      await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnected && isAlertSet == false) {
                    showDialogBox();
                    setState(() => isAlertSet = true);
                  }
                },
                child: const Text('OK'),
              ),
            ],
          ));
}
