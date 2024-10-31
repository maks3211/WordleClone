import 'package:flutter/material.dart';

class StatsTile extends StatelessWidget {
  const StatsTile({
    required this.valueName,
    required this.value,
    super.key,
  });

  final String valueName;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: const Alignment(0, 1),
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Text(
                  value.toString(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              alignment: const Alignment(0, -1),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Text(
                  valueName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}