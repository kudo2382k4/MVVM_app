import 'package:flutter/material.dart';
import '../../domain/entities/managed_user.dart';


class UserItemCard extends StatelessWidget {
  final ManagedUser user;
  final VoidCallback onTap;

  const UserItemCard({
    Key? key,
    required this.user,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Text(
            user.fullName.substring(0, 1).toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF1554A1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          user.fullName,
          style: const TextStyle(
            color: Color(0xFF1554A1),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            '${user.dob} • ${user.address}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Color(0xFF1554A1)),
      ),
    );
  }
}