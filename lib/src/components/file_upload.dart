import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import '../foundation/colors.dart';
import '../foundation/typography.dart';
import '../theme/theme.dart';

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

class Ux4gFileUpload extends StatefulWidget {
  final int maxFiles;
  final int maxFileSize; // in bytes, default 5MB
  final Function(List<UploadedFile>)? onFilesChanged;
  final Future<bool> Function(UploadedFile)? onUpload;
  final List<String> allowedExtensions;

  const Ux4gFileUpload({
    super.key,
    this.maxFiles = 5,
    this.maxFileSize = 5 * 1024 * 1024, // 5MB
    this.onFilesChanged,
    this.onUpload,
    this.allowedExtensions = const ['jpg', 'jpeg', 'png', 'gif', 'pdf', 'doc', 'docx'],
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
    final colors = Ux4gTheme.colors(context);
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
        backgroundColor: colors.error,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Ux4gTheme.colors(context);
    final typography = Ux4gTheme.typography(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Upload area with icon and buttons
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: colors.primary.withValues(alpha: 0.3),
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Upload icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.cloud_upload_outlined,
                    size: 32,
                    color: colors.primary,
                  ),
                ),
                const SizedBox(height: 16),

                // Header
                Text(
                  'Upload Documents',
                  style: typography.lM_strong.copyWith(
                    color: colors.onBackground,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  'File type: PDF JPG PNG Max size: 5 MB',
                  style: typography.bS_default.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.6),
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
                        icon: Icon(Icons.cloud_upload_outlined, color: colors.primary),
                        label: Text('Upload', style: TextStyle(color: colors.primary)),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: colors.primary, width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _pickFile(fromCamera: true),
                        icon: Icon(Icons.camera_alt, color: colors.onPrimary),
                        label: Text('Scan', style: TextStyle(color: colors.onPrimary)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary,
                          foregroundColor: colors.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Files list
        if (_files.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _files.map((file) => _buildFileItem(file, colors, typography)).toList(),
          ),
      ],
    );
  }

  Widget _buildFileItem(UploadedFile file, Ux4gColors colors, Ux4gTypography typography) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(
            color: file.status == UploadStatus.error
                ? colors.error.withValues(alpha: 0.2)
                : colors.onSurface.withValues(alpha: 0.08),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            // File icon
            _getFileIcon(file.name, colors),
            const SizedBox(width: 12),

            // File info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    file.name,
                    style: typography.tS_strong.copyWith(
                      color: _getFileNameColor(file.status, colors),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (file.status == UploadStatus.error)
                    Text(
                      file.errorMessage ?? 'Error',
                      style: typography.bM_default.copyWith(
                        color: colors.error,
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
                        backgroundColor: colors.onSurface.withValues(alpha: 0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
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
                style: typography.tS_strong.copyWith(
                  color: colors.onSurface.withValues(alpha: 0.5),
                ),
              )
            else if (file.status == UploadStatus.success)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: colors.success,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: colors.onPrimary, size: 14),
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
                        color: colors.error.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.info_outline,
                        color: colors.error,
                        size: 14,
                      ),
                    ),
                    Text(
                      'Retry',
                      style: typography.bM_default.copyWith(
                        color: colors.primary,
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
                color: colors.onSurface.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getFileNameColor(UploadStatus status, Ux4gColors colors) {
    switch (status) {
      case UploadStatus.idle:
      case UploadStatus.uploading:
        return colors.onSurface;
      case UploadStatus.success:
        return colors.success;
      case UploadStatus.error:
        return colors.error;
    }
  }

  Widget _getFileIcon(String fileName, Ux4gColors colors) {
    final extension = fileName.split('.').last.toLowerCase();
    IconData icon;
    Color color;

    if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(extension)) {
      icon = Icons.image;
      color = colors.primary;
    } else if (['pdf'].contains(extension)) {
      icon = Icons.picture_as_pdf;
      color = colors.error;
    } else if (['doc', 'docx'].contains(extension)) {
      icon = Icons.description;
      color = colors.primary;
    } else {
      icon = Icons.insert_drive_file;
      color = colors.onSurface.withValues(alpha: 0.38);
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
