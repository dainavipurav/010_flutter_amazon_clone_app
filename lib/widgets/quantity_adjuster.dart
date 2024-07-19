import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';

import '../core/enums.dart';

class QuantityAdjuster extends StatelessWidget {
  final String quantity;
  final void Function(QuantityAction action) onUpdateQuantity;
  final double? qtyFontSize;
  final double? buttonSize;
  const QuantityAdjuster({
    super.key,
    required this.quantity,
    required this.onUpdateQuantity,
    this.qtyFontSize = 18,
    this.buttonSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              buildQuantityAdjusterButton(
                context,
                action: QuantityAction.decrease,
              ),
              const SizedBox(width: 10),
              TextOneLine(
                quantity,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: qtyFontSize,
                ),
              ),
              const SizedBox(width: 10),
              buildQuantityAdjusterButton(
                context,
                action: QuantityAction.increase,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildQuantityAdjusterButton(BuildContext context,
      {required QuantityAction action}) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => onUpdateQuantity(action),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(buttonSize! + 8),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
        height: buttonSize! * 3.5,
        width: buttonSize! * 5.5,
        child: Icon(
          action == QuantityAction.decrease ? Icons.remove : Icons.add,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
      ),
    );
  }
}
