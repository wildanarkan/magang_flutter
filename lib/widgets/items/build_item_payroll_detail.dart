import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildItemPayrollDetail extends StatelessWidget {
  const BuildItemPayrollDetail({
    super.key,
    this.masterCategory,
    this.nominal,
    this.note,
  });

  final String? masterCategory;
  final int? nominal;
  final String? note;

  @override
  Widget build(BuildContext context) {
    // Format nominal
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID', // Menggunakan locale Indonesia
      symbol: '',
      decimalDigits: 0,
    );
    final formattedNominal =
        nominal != null ? formatCurrency.format(nominal) : 'null';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    masterCategory ?? 'null',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  Text(
                    formattedNominal,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Text(
                note ?? 'null',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
