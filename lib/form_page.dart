import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahPengguna extends StatefulWidget {
  const TambahPengguna({super.key});

  @override
  State<TambahPengguna> createState() => _TambahPenggunaState();
}

class _TambahPenggunaState extends State<TambahPengguna> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? job;

  Future<void> submitData() async {
    var response = await http.post(
      Uri.parse('https://reqres.in/api/users'),
      body: {
        'name': name,
        'job': job,
      },
    );

    if (!mounted) return;
    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text('$name \nBerhasil Ditambahkan !'));
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Error'),
            content: Text('Gagal menambahkan '),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Users'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Job',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '';
                  }
                  return null;
                },
                onSaved: (value) {
                  job = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                        Color.fromARGB(255, 3, 37, 115)),
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(16.0)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      submitData();
                    }
                  },
                  child: const Text('Tambahkan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
