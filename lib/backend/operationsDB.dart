import 'package:docs_manager/backend/create_db.dart';
import 'package:docs_manager/backend/delete_db.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/update_db.dart';

class OperationsDB {
  final UpdateDB updateDB = UpdateDB();
  final DeleteDB deleteDB = DeleteDB();
  final CreateDB createDB = CreateDB();
  final ReadDB readDB = ReadDB();
}
