import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final String name;
  final bool isPassword;
  final TextEditingController? controller;
  final String? initialValue;
  final VoidCallback? onTapOutside;
  final String? Function(String?)? validator;
  final OutlineInputBorder? outlineInputBorder;
  final bool enabled;
  final Icon? prefixIcon;
  const CustomTextFormField({
    super.key,
    required this.name,
    this.isPassword = false,
    this.controller,
    this.initialValue,
    this.onTapOutside,
    this.validator,
    this.outlineInputBorder,
    this.enabled = true,
    this.prefixIcon,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        TextFormField(
          validator: widget.validator ??
              (value) {
                if (value?.isEmpty ?? true) {
                  return "${widget.name} required";
                } else {
                  return null;
                }
              },
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
            widget.onTapOutside == null ? null : widget.onTapOutside!();
          },
          initialValue: widget.initialValue,
          controller: widget.controller,
          enabled: widget.enabled,
          obscureText: widget.isPassword ? isPasswordHidden : false,
          cursorColor: Colors.deepOrange,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: widget.outlineInputBorder ?? customInputBorder(),
            enabledBorder: customInputBorder(),
            focusedBorder: customInputBorder(),
            focusedErrorBorder: customErrorInputBorder(),
            errorBorder: customErrorInputBorder(),
            hintText: widget.name,
            hintStyle: TextStyle(
              color: Colors.grey[400],
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon:
                widget.isPassword ? visibiltyIcon(isPasswordHidden) : null,
          ),
        ),
      ],
    );
  }

  // const Color(0xFFE3E2E9)

  OutlineInputBorder customErrorInputBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(12)));
  }

  OutlineInputBorder customInputBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide.none);
  }

  IconButton visibiltyIcon(bool visibilty) {
    return IconButton(
      onPressed: () {
        setState(() {
          isPasswordHidden = !isPasswordHidden;
        });
      },
      icon: visibilty
          ? const Icon(Icons.visibility_outlined)
          : const Icon(Icons.visibility_off_outlined),
      color: const Color(0xFFA5A5A5),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  final void Function(String, BuildContext)? onChanged;
  const CustomSearchBar({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.w,
      child: TextField(
        onChanged: (value) {
          if (onChanged != null && value.isNotEmpty) {
            onChanged!(value, context);
          }
        },
        cursorColor: Colors.black,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: const Color(0xFFF2F3F2),
          border: customOutlineInputDecoration(),
          enabledBorder: customOutlineInputDecoration(),
          focusedBorder: customOutlineInputDecoration(),
          hintText: 'Search...',
          hintStyle: const TextStyle(
            color: Color(0xFF7C7C7C),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder customOutlineInputDecoration() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide.none,
    );
  }
}
