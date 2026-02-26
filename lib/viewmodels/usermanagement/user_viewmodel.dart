import 'package:flutter/cupertino.dart';
import 'package:mvvm_project/data/interfaces/repositories/imanaged_user_repository.dart';
import 'package:mvvm_project/domain/entities/managed_user.dart';

class UserViewmodel extends ChangeNotifier {
  final IManagedUserRepository repo;
  UserViewmodel({required this.repo});

  bool loading = false;
  String? error;

  List<ManagedUser> users = [];
  ManagedUser? selected;

  Future<void> init() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      await repo.seedDemoIfEmpty();
      users = await repo.getAll();
      if (users.isNotEmpty) selected ??= users.first;
    } catch (e) {
      error = e.toString().replaceFirst('Exception', '');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void select(ManagedUser u) {
    selected = u;
    notifyListeners();
  }

  Future<void> refresh() async {
    try {
      users = await repo.getAll();
      if (selected != null) {
        selected = users.firstWhere(
          (x) => x.id == selected!.id,
          orElse: () => users.isNotEmpty ? users.first : selected!,
        );
      }
      notifyListeners();
    } catch (_) {}
  }

  Future<void> add(String fullName, String dob, String address) async {
    final created = await repo.create(fullName, dob, address);
    users = [created, ...users];
    selected = created;
    notifyListeners();
  }

  Future<void> update(int id, String fullName, String dob, String address) async {
    final updated = await repo.update(id, fullName, dob, address);
    users = users.map((u) => u.id == id ? updated : u).toList();
    if (selected?.id == id) selected = updated;
    notifyListeners();
  }

  Future<void> delete(int id) async {
    await repo.delete(id);
    users = users.where((u) => u.id != id).toList();
    if (selected?.id == id) selected = users.isNotEmpty ? users.first : null;
    notifyListeners();
  }
}