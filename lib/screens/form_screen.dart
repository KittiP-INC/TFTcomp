import 'package:account/main.dart';
import 'package:account/models/transactions.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  final compnameController = TextEditingController();
  final characterController = TextEditingController();
  final augmentController = TextEditingController();
  final emblemController = TextEditingController();
  final playstyleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('แบบฟอร์มเพิ่มข้อมูล'),
        ),
        body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ชื่อComp',
                  ),
                  autofocus: false,
                  controller: compnameController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ชื่อตัวละคร',
                  ),
                  autofocus: false,
                  controller: characterController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ชื่อAugment',
                  ),
                  autofocus: false,
                  controller: augmentController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ชื่อEmblem',
                  ),
                  autofocus: false,
                  controller: emblemController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'PlayStyle',
                  ),
                  autofocus: false,
                  controller: playstyleController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
                TextButton(
                    child: const Text(
                      'บันทึก',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color.fromARGB(255, 5, 255, 255)),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // create transaction data object
                        var statement = Transactions(
                          keyID: null,
                          compname: compnameController.text,
                          character: characterController.text,
                          augment: augmentController.text,
                          emblem: emblemController.text,
                          playstyle: playstyleController.text,
                        );
                        // add transaction data object to provider
                        var provider = Provider.of<TransactionProvider>(context,
                            listen: false);
                        provider.addTransaction(statement);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) {
                                  return const MyHomePage();
                                }));
                      }
                    })
              ],
            )));
  }
}
