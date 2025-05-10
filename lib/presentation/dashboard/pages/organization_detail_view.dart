import 'package:flutter/material.dart';

class OrganizationDetailView extends StatelessWidget {
  final String organizationId;
  const OrganizationDetailView({super.key, required this.organizationId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organization Details: $organizationId'),
      ),
      body: Center(
        child: Text('Details for organization with ID: $organizationId'),
        // You'll likely fetch and display actual details here
      ),
    );
  }
}
