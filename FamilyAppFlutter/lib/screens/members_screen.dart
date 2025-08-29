import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/family_data_v001.dart';
import '../models/family_member_v001.dart';
import 'add_member_screen_v001.dart';

/// Screen displaying a list of family members with extended details.
class MembersScreenV001 extends StatelessWidget {
  const MembersScreenV001({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FamilyDataV001>(
      builder: (context, data, _) {
        final members = data.members;
        return Scaffold(
          appBar: AppBar(title: const Text('Members')),
          body: members.isEmpty
              ? const Center(child: Text('No members added yet.'))
              : ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    final List<String> details = [];
                    if (member.relationship.isNotEmpty) {
                      details.add(member.relationship);
                    }
                    if (member.phone != null && member.phone!.isNotEmpty) {
                      details.add('Phone: ${member.phone}');
                    }
                    if (member.email != null && member.email!.isNotEmpty) {
                      details.add('Email: ${member.email}');
                    }
                    if (member.socialMedia != null &&
                        member.socialMedia!.isNotEmpty) {
                      details.add('Social: ${member.socialMedia}');
                    }
                    if (member.hobbies != null && member.hobbies!.isNotEmpty) {
                      details.add('Hobbies: ${member.hobbies}');
                    }
                    if (member.documents != null &&
                        member.documents!.isNotEmpty) {
                      details.add('Docs: ${member.documents}');
                    }
                    final subtitle = details.join('\n');
                    return ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(member.name),
                      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          data.removeMember(member);
                        },
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => const AddMemberScreenV001()),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
