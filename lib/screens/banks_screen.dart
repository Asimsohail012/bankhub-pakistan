import 'package:flutter/material.dart';

import '../data/banks_data.dart';
import '../models/bank_model.dart';
import 'bank_detail_screen.dart';

class BanksScreen extends StatefulWidget {
  const BanksScreen({super.key});

  @override
  State<BanksScreen> createState() => _BanksScreenState();
}

class _BanksScreenState extends State<BanksScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final List<BankModel> filteredBanks =
        pakistanBanks.where((bank) {
      return bank.name
          .toLowerCase()
          .contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Banks Directory",
        ),
      ),
      body: Column(
        children: [

          Container(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Bank...",
                prefixIcon:
                    const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filteredBanks.length,
              itemBuilder: (context, index) {

                final bank =
                    filteredBanks[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  elevation: 4,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            15),
                  ),

                  child: ListTile(

                    leading:
                        CircleAvatar(
                      backgroundColor:
                          Colors.indigo.shade100,
                      child: const Icon(
                        Icons.account_balance,
                        color: Colors.indigo,
                      ),
                    ),

                    title: Text(
                      bank.name,
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      bank.slogan,
                    ),

                    trailing:
                        const Icon(
                      Icons.arrow_forward_ios,
                    ),

                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              BankDetailScreen(
                            bank: bank,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}