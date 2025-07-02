import 'package:drift/drift.dart';
import 'package:keuanganku/app/data/database/db.dart';
import 'package:keuanganku/app/data/database/tables/transactions.dart';

part 'transactions_dao.g.dart';

@DriftAccessor(tables: [Transactions])
class TransactionsDao extends DatabaseAccessor<AppDb> with _$TransactionsDaoMixin {
  TransactionsDao(super.db);
}
