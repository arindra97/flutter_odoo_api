import 'package:flutter/material.dart';
import 'package:flutter_crud/models/res_partner.dart';
import 'package:flutter_crud/services/res_partner_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();

  List<ResPartner> resPartners = [];
  bool isLoading = false;

  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });
    final result = await ResPartnerService.fetchResPartner();
    resPartners = result;
    setState(() {
      isLoading = false;
    });
  }

  void clearRecord() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    streetController.clear();
    cityController.clear();
    zipController.clear();
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Res Partner API"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[600],
        foregroundColor: Colors.white,
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: resPartners.length,
                itemBuilder: (context, index) {
                  final resPartner = resPartners[index];
                  return InkWell(
                    onTap: () {
                      formData(resPartners[index]);
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(resPartner.name),
                        subtitle: Text(resPartner.email),
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          formData(null);
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey[600],
        child: const Icon(Icons.add),
      ),
    );
  }

  void formData(ResPartner? data) async {
    if (data != null) {
      nameController.text = data.name;
      emailController.text = data.email;
      phoneController.text = data.phone;
      streetController.text = data.street;
      cityController.text = data.city;
      zipController.text = data.zip;
    } else {
      clearRecord();
    }
    bool confirm = false;
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(data == null ? "Add Partner" : "Update Partner"),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 5,
                children: <Widget>[
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nama'),
                    onChanged: (value) {},
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'This field is required'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    onChanged: (value) {},
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      if (!value.contains('@')) {
                        return 'Email not valid';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Nomor Telepon',
                    ),
                    onChanged: (value) {},
                  ),
                  TextFormField(
                    controller: streetController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(labelText: 'Alamat'),
                    onChanged: (value) {},
                  ),
                  TextFormField(
                    controller: cityController,
                    decoration: const InputDecoration(labelText: 'Kota'),
                    onChanged: (value) {},
                  ),
                  TextFormField(
                    controller: zipController,
                    decoration: const InputDecoration(labelText: 'Kode Pos'),
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            if (data != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  iconColor: Colors.white,
                ),
                onPressed: () async {
                  await ResPartnerService.deleteResPartner(data.id);
                  await refreshData();
                  Navigator.pop(context);
                },
                child: const Icon(Icons.delete),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
                iconColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.cancel),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[600],
                iconColor: Colors.white,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  confirm = true;
                  Navigator.pop(context);
                }
              },
              child: Icon(Icons.check),
            ),
          ],
        );
      },
    );

    if (confirm) {
      ResPartner request = ResPartner(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        street: streetController.text,
        city: cityController.text,
        zip: zipController.text,
      );
      if (data == null) {
        await ResPartnerService.createResPatner(request);
      } else {
        await ResPartnerService.updateResPartner(data.id, request);
      }
      await refreshData();
    }
  }
}
