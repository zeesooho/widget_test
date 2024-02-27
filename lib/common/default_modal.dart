import 'package:flutter/cupertino.dart';

class DefaultModal extends StatelessWidget {
  final String? title;

  final Widget child;

  const DefaultModal({super.key, this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Visibility(
              visible: title != null,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  title ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
