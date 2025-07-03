import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:keuanganku/app/data/database/db.dart';
import 'package:keuanganku/app/data/database/tables/transactions.dart';
import 'package:keuanganku/app/widgets/custom_button.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardView'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          CustomButton(
            onPressed: () {
              //
            },
            icon: Icons.logout_rounded,
            textColor: Colors.black,
            buttonType: ButtonType.icon,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Saldo Bersih',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder<List<Transaction>>(
                      stream: controller.database.watchAllTransactions(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Text(
                            'Rp 0',
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
                          );
                        }
                        final totalIncome = snapshot.data!
                            .where((t) => t.type == TransactionType.income)
                            .fold(0.0, (sum, item) => sum + item.amount);
                        final totalExpense = snapshot.data!
                            .where((t) => t.type == TransactionType.expense)
                            .fold(0.0, (sum, item) => sum + item.amount);
                        final netBalance = totalIncome - totalExpense;
                        return Text(
                          'Rp ${netBalance.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: netBalance >= 0 ? Colors.green.shade700 : Colors.red.shade700,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildBalanceItem(
                          icon: Icons.arrow_downward_rounded,
                          label: 'Pemasukan',
                          stream: controller.database.watchTransactionsByType(TransactionType.income),
                          color: Colors.blue.shade700,
                        ),
                        _buildBalanceItem(
                          icon: Icons.arrow_upward_rounded,
                          label: 'Pengeluaran',
                          stream: controller.database.watchTransactionsByType(TransactionType.expense),
                          color: Colors.orange.shade700,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildCategorySummary('Pengeluaran Utama', controller.database),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceItem({
    required IconData icon,
    required String label,
    required Stream<List<Transaction>> stream,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, size: 30, color: color),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
        StreamBuilder<List<Transaction>>(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('Rp 0', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color));
            }
            final total = snapshot.data!.fold(0.0, (sum, item) => sum + item.amount);
            return Text(
              'Rp ${total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategorySummary(String title, AppDb database) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 15),
            _buildCategoryRow('PDAM', database.watchTransactionsByCategory('PDAM')),
            _buildCategoryRow('Top-up Listrik', database.watchTransactionsByCategory('Top-up Listrik')),
            _buildCategoryRow('Makanan', database.watchTransactionsByCategory('Makanan')),
            _buildCategoryRow('Transportasi', database.watchTransactionsByCategory('Transportasi')),
            _buildCategoryRow('Lain-lain', database.watchTransactionsByCategory('Lain-lain')),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow(String category, Stream<List<Transaction>> stream) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(category, style: const TextStyle(fontSize: 16, color: Colors.black54)),
          StreamBuilder<List<Transaction>>(
            stream: stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('Rp 0', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
              }
              final total = snapshot.data!.fold(0.0, (sum, item) => sum + item.amount);
              return Text(
                'Rp ${total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
              );
            },
          ),
        ],
      ),
    );
  }
}
