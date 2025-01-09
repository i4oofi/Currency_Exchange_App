import 'package:flutter/material.dart';

class SwitchCurrencyButton extends StatefulWidget {
  final VoidCallback onSwitch;

  const SwitchCurrencyButton({
    super.key,
    required this.onSwitch,
  });

  @override
  State<SwitchCurrencyButton> createState() => _SwitchCurrencyButtonState();
}

class _SwitchCurrencyButtonState extends State<SwitchCurrencyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward(from: 0);
    widget.onSwitch();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Divider(
          indent: 24,
          endIndent: 24,
          height: 1,
          thickness: 1,
          color: Color(0xffE7E7EE),
        ),
        GestureDetector(
          onTap: _handleTap,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xff26278D),
              shape: BoxShape.circle,
            ),
            child: RotationTransition(
              turns: _rotationAnimation,
              child: const Icon(
                Icons.swap_vert,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
