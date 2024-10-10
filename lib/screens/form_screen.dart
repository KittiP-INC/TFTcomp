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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _buildTextField(compnameController, 'ชื่อComp'),
              _buildTextField(characterController, 'ชื่อตัวละคร'),
              _buildTextField(augmentController, 'ชื่อAugment'),
              _buildTextField(emblemController, 'ชื่อEmblem'),
              _buildTextField(playstyleController, 'PlayStyle'),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color.fromARGB(255, 252, 115, 3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'บันทึก',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
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
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            border: const OutlineInputBorder(),
          ),
          autofocus: false,
          controller: controller,
          validator: (String? str) {
            if (str!.isEmpty) {
              return 'กรุณากรอกข้อมูล';
            }
            return null; // แก้ไขเมื่อไม่พบข้อผิดพลาด
          },
        ),
      ),
    );
  }
}
