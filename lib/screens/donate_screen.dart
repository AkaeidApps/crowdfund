import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/cyan_button.dart';
import '../widgets/custom_bottom_navigation.dart';

class DonateScreen extends StatefulWidget {
  final VoidCallback onBack;
  final ValueChanged<int> onNavTap;

  const DonateScreen({super.key, required this.onBack, required this.onNavTap});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  String selectedPayment = 'Credit card';
  final amountController = TextEditingController(text: '20.00');
  final List<String> paymentMethods = ['Credit card', 'Bank transfer', 'Other'];

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void donate() {
    final amount = double.tryParse(amountController.text);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid donation amount')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Donation Summary'),
        content: Text(
          'Amount: \$${amount.toStringAsFixed(2)}\n'
          'Payment: $selectedPayment\n\n'
          'This is a demo. No actual payment has been made.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(minHeight: 100, maxHeight: 130),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: const BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(38)),
          ),
          child: SafeArea(
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: widget.onBack,
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                ),
                const Text(
                  'CROWDFUND',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu, color: Colors.white, size: 22),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                bottomRight: Radius.circular(38),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'YOUR DONATION',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 240,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '\$',
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 130,
                          child: TextField(
                            controller: amountController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.primaryBlue,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select Payment Method',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: paymentMethods.map((method) {
                      final selected = selectedPayment == method;

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPayment = method;
                            });
                          },
                          child: Container(
                            height: 85,
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              color: selected ? AppColors.primaryBlue.withOpacity(0.05) : AppColors.lightGrey,
                              border: Border.all(
                                color: selected ? AppColors.primaryBlue : Colors.transparent,
                                width: selected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                method == 'Credit card'
                                    ? 'Credit\nCard'
                                    : method == 'Bank transfer'
                                        ? 'Bank\nTransfer'
                                        : 'Other\n•••',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: selected ? AppColors.primaryBlue : AppColors.textMuted,
                                  fontSize: 12,
                                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 40),
                  CyanButton(text: 'Complete Donation', onPressed: donate),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
        CustomBottomNavigation(selectedIndex: 1, onTap: widget.onNavTap),
      ],
    );
  }
}
