import 'package:capef/screens-cubits/add-member-screen/add_member_body.dart';
import 'package:capef/widgets/appbar.dart';
import 'package:flutter/material.dart';

class AddMemberScreen extends StatelessWidget {
  const AddMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        top: true,
        child: Scaffold(
          appBar: BuildAppBar(title: 'Ajouter un Ressortissant'),
          body: AddMemberBody(),
        ));
  }
}
