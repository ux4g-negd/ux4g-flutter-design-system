import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import '../foundation/colors.dart';
import '../foundation/typography.dart';

class UploadedFile {
  final String id;
  final String name;
  final int fileSize; // in bytes
  final UploadStatus status;
  final double progress; // 0.0 to 1.0
  final String? errorMessage;
  final XFile? xfile;

  UploadedFile({
    required this.id,
    required this.name,
    required this.fileSize,
    this.status = UploadStatus.idle,
    this.progress = 0.0,
    this.errorMessage,
    this.xfile,
  });

  UploadedFile copyWith({
    String? id,
    String? name,
    int? fileSize,
    UploadStatus? status,
    double? progress,
    String? errorMessage,
    XFile? xfile,
  }) {
    return UploadedFile(
      id: id ?? this.id,
      name: name ?? this.name,
      fileSize: fileSize ?? this.fileSize,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
      xfile: xfile ?? this.xfile,
    );
  }

  String get formattedSize {
    if (fileSize < 1024) return '$fileSize B';
    if (fileSize < 1024 * 1024) return '${(fileSize / 1024).toStringAsFixed(2)} KB';
    return '${(fileSize / (1024 * 1024)).toStringAsFixed(2)} MB';
  }
}

enum UploadStatus { idle, uploading, success, error }

enum Ux4gFileUploadBorderStyle { solid, dashed }

enum Ux4gFileUploadVariant { standard, dropzone }

class Ux4gFileUpload extends StatefulWidget {
  final int maxFiles;
  final int maxFileSize; // in bytes, default 5MB
  final Function(List<UploadedFile>)? onFilesChanged;
  final Future<bool> Function(UploadedFile)? onUpload;
  final List<String> allowedExtensions;
  final Ux4gFileUploadBorderStyle borderStyle;
  final Ux4gFileUploadVariant variant;
  final double buttonBorderRadius;
  final Color? buttonColor;
  final Color? buttonBorderColor;
  final ButtonStyle? buttonStyle;

  const Ux4gFileUpload({
    super.key,
    this.maxFiles = 5,
    this.maxFileSize = 5 * 1024 * 1024, // 5MB
    this.onFilesChanged,
    this.onUpload,
    this.allowedExtensions = const ['jpg', 'jpeg', 'png', 'gif', 'pdf', 'doc', 'docx'],
    this.borderStyle = Ux4gFileUploadBorderStyle.solid,
    this.variant = Ux4gFileUploadVariant.standard,
    this.buttonBorderRadius = 8,
    this.buttonColor,
    this.buttonBorderColor,
    this.buttonStyle,
  });

  @override
  State<Ux4gFileUpload> createState() => _Ux4gFileUploadState();
}

class _Ux4gFileUploadState extends State<Ux4gFileUpload> {
  final List<UploadedFile> _files = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFile({bool fromCamera = false}) async {
    try {
      XFile? file;

      if (fromCamera) {
        file = await _picker.pickImage(source: ImageSource.camera);
      } else {
        file = await _picker.pickImage(source: ImageSource.gallery);
      }

      if (file == null) return;

      // Check file size
      final fileSize = await file.length();
      if (fileSize > widget.maxFileSize) {
        _showErrorDialog(
          'File too large',
          'File size exceeds ${(widget.maxFileSize / (1024 * 1024)).toStringAsFixed(0)} MB limit',
        );
        return;
      }

      // Check max files
      if (_files.length >= widget.maxFiles) {
        _showErrorDialog(
          'Max files reached',
          'You can upload maximum ${widget.maxFiles} files',
        );
        return;
      }

      final uploadedFile = UploadedFile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: file.name,
        fileSize: fileSize,
        xfile: file,
      );

      setState(() => _files.add(uploadedFile));
      widget.onFilesChanged?.call(_files);

      // Simulate upload if callback provided
      if (widget.onUpload != null) {
        await _uploadFile(uploadedFile);
      }
    } catch (e) {
      _showErrorDialog('Error', 'Failed to pick file: $e');
    }
  }

  Future<void> _uploadFile(UploadedFile file) async {
    final fileIndex = _files.indexWhere((f) => f.id == file.id);
    if (fileIndex == -1) return;

    setState(() {
      _files[fileIndex] = _files[fileIndex].copyWith(status: UploadStatus.uploading);
    });

    try {
      // Simulate upload progress
      for (int i = 0; i <= 10; i++) {
        await Future.delayed(const Duration(milliseconds: 200));
        setState(() {
          _files[fileIndex] = _files[fileIndex].copyWith(progress: i / 10);
        });
      }

      // Call the upload callback
      final success = await widget.onUpload!(file);

      if (success) {
        setState(() {
          _files[fileIndex] = _files[fileIndex].copyWith(
            status: UploadStatus.success,
            progress: 1.0,
          );
        });
      } else {
        setState(() {
          _files[fileIndex] = _files[fileIndex].copyWith(
            status: UploadStatus.error,
            errorMessage: 'Upload failed. Please try again.',
          );
        });
      }
    } catch (e) {
      setState(() {
        _files[fileIndex] = _files[fileIndex].copyWith(
          status: UploadStatus.error,
          errorMessage: 'Error: ${e.toString()}',
        );
      });
    }

    widget.onFilesChanged?.call(_files);
  }

  Future<void> _retryUpload(UploadedFile file) async {
    final fileIndex = _files.indexWhere((f) => f.id == file.id);
    if (fileIndex == -1) return;

    setState(() {
      _files[fileIndex] = _files[fileIndex].copyWith(
        status: UploadStatus.idle,
        progress: 0.0,
        errorMessage: null,
      );
    });

    if (widget.onUpload != null) {
      await _uploadFile(_files[fileIndex]);
    }
  }

  void _removeFile(String id) {
    setState(() => _files.removeWhere((f) => f.id == id));
    widget.onFilesChanged?.call(_files);
  }

  void _showErrorDialog(String title, String message) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final error = ux4gColors?.error ?? materialTheme.colorScheme.error;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(message),
          ],
        ),
        backgroundColor: error,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final ux4gColors = materialTheme.extension<Ux4gColors>();
    final ux4gTypography = materialTheme.extension<Ux4gTypography>();

    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final onPrimary = ux4gColors?.onPrimary ?? materialTheme.colorScheme.onPrimary;
    final onBackground = ux4gColors?.onBackground ?? materialTheme.colorScheme.onSurface;
    final onSurface = ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;

    final lM_strong = ux4gTypography?.lM_strong ?? materialTheme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700) ?? const TextStyle(fontWeight: FontWeight.w700, fontSize: 12);
    final bS_default = ux4gTypography?.bS_default ?? materialTheme.textTheme.bodySmall ?? const TextStyle(fontSize: 14);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Upload area with icon and buttons
        widget.borderStyle == Ux4gFileUploadBorderStyle.dashed
            ? CustomPaint(
                painter: _DashedBorderPainter(
                  color: primary.withValues(alpha: 0.3),
                  strokeWidth: 2,
                  borderRadius: 12,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  child: _buildUploadContent(primary, onPrimary, onBackground, onSurface, lM_strong, bS_default),
                ),
              )
            : Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primary.withValues(alpha: 0.3),
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: _buildUploadContent(primary, onPrimary, onBackground, onSurface, lM_strong, bS_default),
                ),
              ),

        const SizedBox(height: 20),

        // Files list
        if (_files.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _files.map((file) => _buildFileItem(file, materialTheme, ux4gColors, ux4gTypography)).toList(),
          ),
      ],
    );
  }

  Widget _buildUploadContent(Color primary, Color onPrimary, Color onBackground, Color onSurface, TextStyle lM_strong, TextStyle bS_default) {
    if (widget.variant == Ux4gFileUploadVariant.dropzone) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Upload icon
          Icon(
            Icons.cloud_upload_outlined,
            size: 36,
            color: primary,
          ),
          const SizedBox(height: 12),

          // Header
          Text(
            'Drop file here',
            style: lM_strong.copyWith(
              color: onBackground,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),

          // Description
          Text(
            'File type: PDF JPG PNG Max size: ${(widget.maxFileSize / (1024 * 1024)).toStringAsFixed(0)} MB',
            style: bS_default.copyWith(
              color: onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Or divider
          Row(
            children: [
              Expanded(child: Divider(color: onSurface.withValues(alpha: 0.2))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Or',
                  style: bS_default.copyWith(color: onSurface.withValues(alpha: 0.5)),
                ),
              ),
              Expanded(child: Divider(color: onSurface.withValues(alpha: 0.2))),
            ],
          ),
          const SizedBox(height: 16),

          // Single Upload button
          OutlinedButton.icon(
            onPressed: () => _pickFile(fromCamera: false),
            icon: Icon(Icons.cloud_upload_outlined, color: widget.buttonColor ?? primary),
            label: Text('Upload', style: TextStyle(color: widget.buttonColor ?? primary)),
            style: widget.buttonStyle ?? OutlinedButton.styleFrom(
              side: BorderSide(color: widget.buttonBorderColor ?? primary, width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.buttonBorderRadius)),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Upload icon
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.cloud_upload_outlined,
            size: 32,
            color: primary,
          ),
        ),
        const SizedBox(height: 16),

        // Header
        Text(
          'Upload Documents',
          style: lM_strong.copyWith(
            color: onBackground,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),

        // Description
        Text(
          'File type: PDF JPG PNG Max size: ${(widget.maxFileSize / (1024 * 1024)).toStringAsFixed(0)} MB',
          style: bS_default.copyWith(
            color: onSurface.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        // Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _pickFile(fromCamera: false),
                icon: Icon(Icons.cloud_upload_outlined, color: widget.buttonColor ?? primary),
                label: Text('Upload', style: TextStyle(color: widget.buttonColor ?? primary)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: widget.buttonBorderColor ?? primary, width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.buttonBorderRadius)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _pickFile(fromCamera: true),
                icon: Icon(Icons.camera_alt, color: onPrimary),
                label: Text('Scan', style: TextStyle(color: onPrimary)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.buttonColor ?? primary,
                  foregroundColor: onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.buttonBorderRadius)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFileItem(UploadedFile file, ThemeData materialTheme, Ux4gColors? ux4gColors, Ux4gTypography? ux4gTypography) {
    final surface = ux4gColors?.surface ?? materialTheme.colorScheme.surface;
    final onSurface = ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final error = ux4gColors?.error ?? materialTheme.colorScheme.error;
    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final success = ux4gColors?.success ?? Colors.green;
    final onPrimary = ux4gColors?.onPrimary ?? materialTheme.colorScheme.onPrimary;

    final tS_strong = ux4gTypography?.tS_strong ?? materialTheme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700) ?? const TextStyle(fontWeight: FontWeight.w700, fontSize: 14);
    final bM_default = ux4gTypography?.bM_default ?? materialTheme.textTheme.bodyMedium ?? const TextStyle(fontSize: 16);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: surface,
          border: Border.all(
            color: file.status == UploadStatus.error
                ? error.withValues(alpha: 0.2)
                : onSurface.withValues(alpha: 0.08),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            // File icon
            _getFileIcon(file.name, ux4gColors, materialTheme),
            const SizedBox(width: 12),

            // File info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    file.name,
                    style: tS_strong.copyWith(
                      color: _getFileNameColor(file.status, ux4gColors, materialTheme),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (file.status == UploadStatus.error)
                    Text(
                      file.errorMessage ?? 'Error',
                      style: bM_default.copyWith(
                        color: error,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (file.status == UploadStatus.uploading)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: file.progress,
                        minHeight: 4,
                        backgroundColor: onSurface.withValues(alpha: 0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(primary),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Status indicator
            if (file.status == UploadStatus.uploading)
              Text(
                '${(file.progress * 100).toStringAsFixed(0)}%',
                style: tS_strong.copyWith(
                  color: onSurface.withValues(alpha: 0.5),
                ),
              )
            else if (file.status == UploadStatus.success)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: success,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: onPrimary, size: 14),
              )
            else if (file.status == UploadStatus.error)
              GestureDetector(
                onTap: () => _retryUpload(file),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: error.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.info_outline,
                        color: error,
                        size: 14,
                      ),
                    ),
                    Text(
                      'Retry',
                      style: bM_default.copyWith(
                        color: primary,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(width: 8),

            // Close button
            GestureDetector(
              onTap: () => _removeFile(file.id),
              child: Icon(
                Icons.close,
                size: 20,
                color: onSurface.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getFileNameColor(UploadStatus status, Ux4gColors? ux4gColors, ThemeData materialTheme) {
    final onSurface = ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;
    final success = ux4gColors?.success ?? Colors.green;
    final error = ux4gColors?.error ?? materialTheme.colorScheme.error;

    switch (status) {
      case UploadStatus.idle:
      case UploadStatus.uploading:
        return onSurface;
      case UploadStatus.success:
        return success;
      case UploadStatus.error:
        return error;
    }
  }

  Widget _getFileIcon(String fileName, Ux4gColors? ux4gColors, ThemeData materialTheme) {
    final primary = ux4gColors?.primary ?? materialTheme.colorScheme.primary;
    final error = ux4gColors?.error ?? materialTheme.colorScheme.error;
    final onSurface = ux4gColors?.onSurface ?? materialTheme.colorScheme.onSurface;

    final extension = fileName.split('.').last.toLowerCase();
    IconData icon;
    Color color;

    if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(extension)) {
      icon = Icons.image;
      color = primary;
    } else if (['pdf'].contains(extension)) {
      icon = Icons.picture_as_pdf;
      color = error;
    } else if (['doc', 'docx'].contains(extension)) {
      icon = Icons.description;
      color = primary;
    } else {
      icon = Icons.insert_drive_file;
      color = onSurface.withValues(alpha: 0.38);
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double borderRadius;
  final double dashWidth;
  final double dashSpace;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.borderRadius,
    this.dashWidth = 8.0,
    this.dashSpace = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final nextDash = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, nextDash.clamp(0, metric.length)),
          paint,
        );
        distance = nextDash + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace;
  }
}
