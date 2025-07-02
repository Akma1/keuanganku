import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:get/get.dart' hide Value;
import 'package:keuanganku/app/data/database/daos/transactions_dao.dart';
import 'package:keuanganku/app/data/database/tables/transactions.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';

const List<Type> tables = [Transactions];
const List<Type> daos = [TransactionsDao];

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'local.db'));

    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: tables, daos: daos)
class AppDb extends _$AppDb {
  static AppDb get to => Get.find();
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Value nullValue = const Value(null);

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from != schemaVersion) {
          for (final table in allTables) {
            await m.deleteTable(table.actualTableName);
          }
        }
      },
    );
  }

  Future<bool> truncateAll() async {
    for (final table in allTables) {
      await (delete(table).go());
    }
    return true;
  }

  // Query all transactions
  Future<List<Transaction>> getAllTransactions() => select(transactions).get();

  // Stream all transactions (for real-time updates)
  Stream<List<Transaction>> watchAllTransactions() => select(transactions).watch();

  // Add a new transaction
  Future<int> insertTransaction(TransactionsCompanion entry) {
    return into(transactions).insert(entry);
  }

  // Update a transaction
  Future<bool> updateTransaction(Transaction entry) {
    return update(transactions).replace(entry);
  }

  // Delete a transaction
  // Future<int> deleteTransaction(Transaction entry) {
  //   return delete(transactions).where((t) => t.id.equals(entry.id)).go();
  // }

  // Query transactions by type (income/expense)
  Stream<List<Transaction>> watchTransactionsByType(TransactionType type) {
    return (select(transactions)..where((t) => t.type.equals(type.name))).watch();
  }

  // Query transactions by category
  Stream<List<Transaction>> watchTransactionsByCategory(String category) {
    return (select(transactions)..where((t) => t.category.equals(category))).watch();
  }

  // Calculate total income
  Future<double?> getTotalIncome() async {
    final result =
        await (select(transactions)
          ..where((t) => t.type.equals(TransactionType.income.name))).map((t) => t.amount).get();
    // return result.fold(0.0, (previous, current) => (previous ?? 0.0) + (current));
    return 0.0;
  }

  // Calculate total expense
  Future<double> getTotalExpense() async {
    final result =
        await (select(transactions)
          ..where((t) => t.type.equals(TransactionType.expense.name))).map((t) => t.amount).get();
    // return result.fold(0.0, (previous, current) => previous + current);
    return 0.0;
  }
}
