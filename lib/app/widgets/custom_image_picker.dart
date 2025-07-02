import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewMyImagePicker extends StatefulWidget {
  const NewMyImagePicker({super.key, this.color, this.max, this.initialValues, this.onChanged, this.hintText});
  final Color? color;
  final int? max;
  final List<XFile>? initialValues;
  final ValueChanged<List<XFile>>? onChanged;
  final String? hintText;

  @override
  State<NewMyImagePicker> createState() => _NewMyImagePickerState();
}

class _NewMyImagePickerState extends State<NewMyImagePicker> {
  late Color _color;
  late int _max;
  late List<XFile> _result;

  @override
  void initState() {
    _color = widget.color ?? Colors.blue;
    _max = widget.max ?? 3;
    _result = widget.initialValues ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Lampiran', style: Get.textTheme.titleMedium?.copyWith(color: Colors.grey.shade600)),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              ..._result
                  .take(_max)
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              e.path.startsWith('http') ? e.path : '',
                              // fallback ke file jika bukan url
                              errorBuilder:
                                  (context, error, stackTrace) => Image.file(
                                    // ignore: deprecated_member_use
                                    // ignore: use_build_context_synchronously
                                    File(e.path),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => onRemove(e),
                              child: Container(
                                decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), shape: BoxShape.circle),
                                padding: const EdgeInsets.all(4),
                                child: const Icon(Icons.close, size: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              if (_result.length < _max)
                GestureDetector(
                  onTap: onPickSource,
                  child: DottedBorder(
                    // color: Colors.grey,
                    // borderType: BorderType.RRect,
                    // radius: const Radius.circular(16),
                    // dashPattern: const [6, 3],
                    // strokeWidth: 1.5,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.document_upload_copy, size: 28, color: Colors.grey),
                          const SizedBox(height: 8),
                          Text(
                            widget.hintText ?? 'Upload the files',
                            style: const TextStyle(fontSize: 13, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void onPickSource() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera_rounded),
                title: const Text('Kamera'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.image_rounded),
                title: const Text('Galeri'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
    );
    if (source == null) return;
    if (source == ImageSource.gallery) {
      if (_max == 1) {
        onPickSingleImage(ImageSource.gallery);
      } else {
        onPickMultiImage();
      }
    } else {
      onPickSingleImage(ImageSource.camera);
    }
  }

  void onPickSingleImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final result = await picker.pickImage(source: source);
    if (result != null) {
      setState(() {
        _result = [result];
      });
      onValueChanged();
    }
  }

  void onPickMultiImage() async {
    final ImagePicker picker = ImagePicker();
    final results = await picker.pickMultiImage();
    if (results != null && results.isNotEmpty) {
      final remain = _max - _result.length;
      if (results.length > remain) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Maksimal hanya bisa memilih $remain gambar lagi.'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      setState(() {
        _result.addAll(results.take(remain));
      });
      onValueChanged();
    }
  }

  void onRemove(XFile value) {
    setState(() {
      _result.remove(value);
    });
    onValueChanged();
  }

  void onValueChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(_result);
    }
  }
}
