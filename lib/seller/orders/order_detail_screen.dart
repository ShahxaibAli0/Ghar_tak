import 'package:flutter/material.dart';
import '../widgets/seller_colors.dart';

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderDetailScreen({super.key, required this.order});

  Color _statusColor(String status) {
    switch (status) {
      case 'Pending':     return Colors.orange;
      case 'Processing':  return Colors.blue;
      case 'Shipped':     return Colors.purple;
      case 'Delivered':   return Colors.green;
      case 'Cancelled':   return Colors.red;
      default:            return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(order['status']);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          _buildHeader(context, color),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildStatusTracker(),
                  const SizedBox(height: 14),
                  _buildCustomerCard(),
                  const SizedBox(height: 14),
                  _buildAddressCard(),
                  const SizedBox(height: 14),
                  _buildProductsCard(),
                  const SizedBox(height: 14),
                  _buildPaymentCard(),
                  const SizedBox(height: 14),
                  if (order['status'] == 'Pending') _buildActionButtons(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══ Header ═══
  Widget _buildHeader(BuildContext context, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 55, 20, 22),
      decoration: const BoxDecoration(
        color: SellerColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order['id'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                Text('${order['date']}  •  ${order['time']}',
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.4)),
            ),
            child: Text(
              order['status'],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══ Status Tracker ═══
  Widget _buildStatusTracker() {
    final steps = ['Pending', 'Processing', 'Shipped', 'Delivered'];
    final currentStep = steps.indexOf(order['status']);

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardTitle('Order Progress', Icons.timeline),
          const SizedBox(height: 16),
          Row(
            children: steps.asMap().entries.map((entry) {
              final i = entry.key;
              final step = entry.value;
              final isDone = currentStep >= i;
              final isLast = i == steps.length - 1;
              final color = isDone ? SellerColors.primary : Colors.grey[300]!;

              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: isDone
                                  ? SellerColors.primary
                                  : Colors.grey[200],
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: color, width: 2),
                            ),
                            child: Icon(
                              isDone
                                  ? Icons.check
                                  : Icons.circle_outlined,
                              size: 16,
                              color: isDone
                                  ? Colors.white
                                  : Colors.grey[400],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(step,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: isDone
                                    ? SellerColors.primary
                                    : SellerColors.subText,
                                fontWeight: isDone
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              )),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          height: 2,
                          margin: const EdgeInsets.only(bottom: 22),
                          color: currentStep > i
                              ? SellerColors.primary
                              : Colors.grey[300],
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ═══ Customer Card ═══
  Widget _buildCustomerCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardTitle('Customer Info', Icons.person_outline),
          const SizedBox(height: 14),
          _infoRow(Icons.person, 'Name', order['name']),
          const SizedBox(height: 10),
          _infoRow(Icons.phone, 'Phone', order['phone']),
        ],
      ),
    );
  }

  // ═══ Address Card ═══
  Widget _buildAddressCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardTitle('Delivery Address', Icons.location_on_outlined),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.home_outlined,
                  color: SellerColors.primary, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(order['address'],
                    style: const TextStyle(
                      color: SellerColors.darkText,
                      fontSize: 13,
                      height: 1.5,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ═══ Products Card ═══
  Widget _buildProductsCard() {
    final List products = order['products'] as List;

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardTitle('Ordered Items', Icons.shopping_bag_outlined),
          const SizedBox(height: 14),
          ...products.map(
            (product) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: SellerColors.lightGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.inventory_2_outlined,
                        color: SellerColors.primary, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(product,
                        style: const TextStyle(
                          color: SellerColors.darkText,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  const Icon(Icons.check_circle,
                      color: SellerColors.primary, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══ Payment Card ═══
  Widget _buildPaymentCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardTitle('Payment Summary', Icons.receipt_outlined),
          const SizedBox(height: 14),
          _payRow('Subtotal', order['amount']),
          _payRow('Delivery Fee', 'Rs. 100'),
          _payRow('Discount', '- Rs. 0'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: Color(0xFFEEEEEE)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Amount',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: SellerColors.darkText,
                  )),
              Text(order['amount'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: SellerColors.primary,
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.payments_outlined,
                    color: Colors.green, size: 16),
                SizedBox(width: 6),
                Text('Cash on Delivery',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══ Action Buttons ═══
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.red, size: 18),
            label: const Text('Reject Order',
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red, width: 1.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.check, color: Colors.white, size: 18),
            label: const Text('Accept Order',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: SellerColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 3,
            ),
          ),
        ),
      ],
    );
  }

  // ═══ Helpers ═══
  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _cardTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: SellerColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Icon(icon, color: SellerColors.primary, size: 18),
        const SizedBox(width: 6),
        Text(title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: SellerColors.darkText,
            )),
      ],
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: SellerColors.primary, size: 18),
        const SizedBox(width: 10),
        Text('$label: ',
            style: const TextStyle(
              color: SellerColors.subText,
              fontSize: 13,
            )),
        Text(value,
            style: const TextStyle(
              color: SellerColors.darkText,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            )),
      ],
    );
  }

  Widget _payRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                color: SellerColors.subText,
                fontSize: 13,
              )),
          Text(value,
              style: const TextStyle(
                color: SellerColors.darkText,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}