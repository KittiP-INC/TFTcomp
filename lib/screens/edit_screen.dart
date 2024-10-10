import 'package:account/main.dart';
import 'package:account/models/transactions.dart';
import 'package:account/provider/transaction_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  Transactions statement;

  EditScreen({super.key, required this.statement});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  final compnameController = TextEditingController();
  final characterController = TextEditingController();
  final augmentController = TextEditingController();
  final emblemController = TextEditingController();
  final playstyleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    compnameController.text = widget.statement.compname;
    characterController.text = widget.statement.character;
    augmentController.text = widget.statement.augment;
    emblemController.text = widget.statement.emblem;
    playstyleController.text = widget.statement.playstyle;

    return Scaffold(
      appBar: AppBar(
        title: const Text('แบบฟอร์มแก้ไขข้อมูล'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField(compnameController, 'ชื่อComp'),
              _buildTextField(characterController, 'ชื่อตัวละคร'),
              _buildTextField(augmentController, 'ชื่อAugment'),
              _buildTextField(emblemController, 'ชื่อEmblem'),
              _buildTextField(playstyleController, 'วิธีเล่น'),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color.fromARGB(255, 255, 116, 3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'บันทึก',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // create transaction data object
                    var statement = Transactions(
                      keyID: widget.statement.keyID,
                      compname: compnameController.text,
                      character: characterController.text,
                      augment: augmentController.text,
                      emblem: emblemController.text,
                      playstyle: playstyleController.text,
                    );
                    // add transaction data object to provider
                    var provider = Provider.of<TransactionProvider>(context,
                        listen: false);
                    provider.updateTransaction(statement);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) {
                          return MyHomePage();
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
