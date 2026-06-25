import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/bank_model.dart';

class BankListTile extends StatelessWidget {
  final BankModel bank;
  final VoidCallback onTap;

  const BankListTile({
    super.key,
    required this.bank,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Hero(
          tag: 'bank-logo-${bank.name}',
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.indigo.shade50,
            ),
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              bank.logoAsset,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          bank.name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        subtitle: Text(bank.slogan),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
        onTap: onTap,
      ),
    );
  }
}
