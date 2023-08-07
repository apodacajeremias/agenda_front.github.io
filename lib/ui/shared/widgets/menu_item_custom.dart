import 'package:flutter/material.dart';

class MenuItemCustom extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool isActive;
  final Function onPressed;

  const MenuItemCustom({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isActive = false,
  }) : super(key: key);

  @override
  State<MenuItemCustom> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItemCustom> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      color: isHovered
          ? Colors.white.withOpacity(0.1)
          : widget.isActive
              ? Colors.white.withOpacity(0.2)
              : Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isActive ? null : () => widget.onPressed(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(widget.icon,
                      color: isHovered
                          ? Colors.white.withOpacity(0.7)
                          : widget.isActive
                              ? Colors.white
                              : Colors.white.withOpacity(0.5)),
                  const SizedBox(width: 10),
                  Text(
                    widget.text,
                    style: Theme.of(context).textTheme.labelMedium?.apply(
                        color: isHovered
                            ? Colors.white.withOpacity(0.7)
                            : widget.isActive
                                ? Colors.white
                                : Colors.white.withOpacity(0.5)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
