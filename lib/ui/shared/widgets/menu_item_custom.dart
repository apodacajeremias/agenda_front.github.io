import 'package:agenda_front/constants.dart';
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
          ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1)
          : widget.isActive
              ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2)
              : Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // onTap: widget.isActive ? null : () => widget.onPressed(),
          onTap: () => widget.onPressed(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 2, vertical: defaultPadding / 2),
            child: MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(widget.icon,
                      color: isHovered
                          ? Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.7)
                          : widget.isActive
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.5)),
                  const SizedBox(width: defaultPadding),
                  Text(
                    widget.text,
                    style: Theme.of(context).textTheme.labelMedium?.apply(
                        color: isHovered
                            ? Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.7)
                            : widget.isActive
                                ? Theme.of(context).scaffoldBackgroundColor
                                : Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.5)),
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
