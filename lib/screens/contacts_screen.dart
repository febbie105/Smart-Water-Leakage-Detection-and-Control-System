import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'message_screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  static const List<Map<String, String>> _staffList = [
    {
      'name': 'Kumar',
      'role': 'Maintenance Engineer',
      'phone': '+15551234567',
    },
    {
      'name': 'Meena',
      'role': 'Plumbing Staff',
      'phone': '+15551234568',
    },
    {
      'name': 'Ravi',
      'role': 'Supervisor',
      'phone': '+15551234569',
    },
  ];

  Future<void> _pickFileForStaff(String staffName) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.isEmpty) return;

    final selectedFile = result.files.first;
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected ${selectedFile.name} for $staffName'),
      ),
    );
  }

  Future<void> _callStaff(String staffName, String phoneNumber) async {
    final phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    final launched = await launchUrl(phoneUri);

    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to call $staffName right now')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintenance Contacts'),
      ),
      body: ListView.builder(
        itemCount: _staffList.length,
        itemBuilder: (context, index) {
          final staff = _staffList[index];
          final staffName = staff['name']!;
          final staffRole = staff['role']!;
          final staffPhone = staff['phone']!;

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(staffName),
              subtitle: Text(staffRole),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chat),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessageScreen(
                            staffName: staffName,
                            staffRole: staffRole,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _pickFileForStaff(staffName),
                  ),
                  IconButton(
                    icon: const Icon(Icons.phone),
                    onPressed: () => _callStaff(staffName, staffPhone),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
