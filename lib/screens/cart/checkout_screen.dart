import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cart_item.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/cart_item_image.dart';

enum DeliveryOption { standard, express }

enum PaymentMethod { cash, card, wallet }

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  static Route<bool> route() {
    return PageRouteBuilder<bool>(
      pageBuilder: (_, animation, secondaryAnimation) => const CheckoutScreen(),
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 220),
      transitionsBuilder: (_, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return FadeTransition(
          opacity: curvedAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.08),
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  DeliveryOption _deliveryOption = DeliveryOption.standard;
  PaymentMethod _paymentMethod = PaymentMethod.cash;
  bool _isPlacingOrder = false;

  int get _deliveryFee =>
      _deliveryOption == DeliveryOption.standard ? 120 : 250;

  Future<void> _placeOrder(CartProvider cart) async {
    if (cart.items.isEmpty) {
      _showMessage("Your cart is empty.", isError: true);
      Navigator.pop(context, false);
      return;
    }

    setState(() => _isPlacingOrder = true);
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) {
      return;
    }

    cart.clearCart();
    Navigator.pop(context, true);
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  String _deliveryLabel(DeliveryOption option) {
    switch (option) {
      case DeliveryOption.standard:
        return "Standard Delivery";
      case DeliveryOption.express:
        return "Express Delivery";
    }
  }

  String _deliverySubtitle(DeliveryOption option) {
    switch (option) {
      case DeliveryOption.standard:
        return "Reliable delivery in 30 to 45 minutes";
      case DeliveryOption.express:
        return "Priority delivery in 15 to 20 minutes";
    }
  }

  IconData _deliveryIcon(DeliveryOption option) {
    switch (option) {
      case DeliveryOption.standard:
        return Icons.local_shipping_outlined;
      case DeliveryOption.express:
        return Icons.flash_on_outlined;
    }
  }

  String _paymentLabel(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return "Cash on Delivery";
      case PaymentMethod.card:
        return "Debit / Credit Card";
      case PaymentMethod.wallet:
        return "Wallet Balance";
    }
  }

  String _paymentSubtitle(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return "Pay when your order reaches you";
      case PaymentMethod.card:
        return "Pay securely with your saved or new card";
      case PaymentMethod.wallet:
        return "Use your wallet balance for a faster checkout";
    }
  }

  IconData _paymentIcon(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return Icons.payments_outlined;
      case PaymentMethod.card:
        return Icons.credit_card_outlined;
      case PaymentMethod.wallet:
        return Icons.account_balance_wallet_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final subtotal = cart.totalPrice;
    final total = subtotal + _deliveryFee;

    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CheckoutSection(
                      title: "Order Summary",
                      child: Column(
                        children: [
                          for (var index = 0;
                              index < cart.items.length;
                              index++)
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: index == cart.items.length - 1 ? 0 : 12,
                              ),
                              child: Column(
                                children: [
                                  _SummaryItemRow(item: cart.items[index]),
                                  if (index != cart.items.length - 1)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Divider(
                                        height: 1,
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _CheckoutSection(
                      title: "Delivery Options",
                      child: Column(
                        children: DeliveryOption.values
                            .map(
                              (option) => Padding(
                                padding: EdgeInsets.only(
                                  bottom: option == DeliveryOption.values.last
                                      ? 0
                                      : 12,
                                ),
                                child: _SelectableOptionTile(
                                  title: _deliveryLabel(option),
                                  subtitle: _deliverySubtitle(option),
                                  trailingText:
                                      "Rs ${option == DeliveryOption.standard ? 120 : 250}",
                                  icon: _deliveryIcon(option),
                                  selected: _deliveryOption == option,
                                  onTap: () {
                                    setState(() => _deliveryOption = option);
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _CheckoutSection(
                      title: "Payment Method",
                      child: Column(
                        children: PaymentMethod.values
                            .map(
                              (method) => Padding(
                                padding: EdgeInsets.only(
                                  bottom: method == PaymentMethod.values.last
                                      ? 0
                                      : 12,
                                ),
                                child: _SelectableOptionTile(
                                  title: _paymentLabel(method),
                                  subtitle: _paymentSubtitle(method),
                                  icon: _paymentIcon(method),
                                  selected: _paymentMethod == method,
                                  onTap: () {
                                    setState(() => _paymentMethod = method);
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _CheckoutSection(
                      title: "Price Details",
                      child: Column(
                        children: [
                          _AmountRow(
                            label: "Subtotal",
                            value: "Rs $subtotal",
                          ),
                          const SizedBox(height: 10),
                          _AmountRow(
                            label: "Delivery Fee",
                            value: "Rs $_deliveryFee",
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Divider(height: 1),
                          ),
                          _AmountRow(
                            label: "Grand Total",
                            value: "Rs $total",
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${cart.itemCount} item${cart.itemCount == 1 ? '' : 's'}",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Total: Rs $total",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _isPlacingOrder ? null : () => _placeOrder(cart),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.green.shade200,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: _isPlacingOrder
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            "Place Order",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckoutSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _CheckoutSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _SummaryItemRow extends StatelessWidget {
  final CartItem item;

  const _SummaryItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CartItemImage(
          imagePath: item.image,
          width: 62,
          height: 62,
          borderRadius: 10,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.storeName,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Qty ${item.quantity}",
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          "Rs ${item.price * item.quantity}",
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _SelectableOptionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? trailingText;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _SelectableOptionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected ? Colors.green.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? Colors.green : Colors.grey.shade200,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: selected ? Colors.green : Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: selected ? Colors.white : Colors.green.shade700,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (trailingText != null)
                Text(
                  trailingText!,
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w700,
                  ),
                )
              else
                Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: selected ? Colors.green : Colors.grey.shade400,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AmountRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _AmountRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: isBold ? 16 : 14,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
      color: isBold ? Colors.black87 : Colors.grey.shade800,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textStyle),
        Text(value, style: textStyle),
      ],
    );
  }
}
