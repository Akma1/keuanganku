import 'package:drift/drift.dart';

@DataClassName('Transaction')
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text().withLength(min: 1, max: 255)();
  RealColumn get amount => real()();
  TextColumn get type => textEnum<TransactionType>()(); // INCOME or EXPENSE
  TextColumn get category => text().withLength(min: 1, max: 50)();
  DateTimeColumn get date => dateTime()();
}

enum TransactionType { income, expense }
