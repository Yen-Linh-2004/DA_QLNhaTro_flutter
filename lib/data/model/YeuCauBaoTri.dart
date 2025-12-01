import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/KhachThue.dart';

enum MaintenanceCategory { electrical, plumbing, other }
enum MaintenancePriority { low, medium, high }
enum MaintenanceStatus { pending, processing, completed }

class YeuCauBaoTri {
  final int id;
  final String tenantName;
  final String building;
  final String room;
  final String title;
  final String description;
  final MaintenanceCategory category;
  final MaintenancePriority priority;
  final MaintenanceStatus status;
  final DateTime? requestDate;
  final String? assignedTo;
  final DateTime? scheduledDate;
  final DateTime? completedDate;
  final String? notes;
  final double? actualCost;
  final List<String>? images;
  final KhachThue? tenant;

  YeuCauBaoTri({
    required this.id,
    required this.tenantName,
    required this.building,
    required this.room,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.status,
    this.requestDate,
    this.assignedTo,
    this.scheduledDate,
    this.completedDate,
    this.notes,
    this.actualCost,
    this.images,
    this.tenant,
  });

  factory YeuCauBaoTri.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? dateStr) {
      if (dateStr == null || dateStr.isEmpty) return null;
      try {
        return DateTime.parse(dateStr);
      } catch (_) {
        return null;
      }
    }

    double? parseDouble(dynamic value) {
      if (value == null) return null;
      if (value is int) return value.toDouble();
      if (value is double) return value;
      if (value is String) return double.tryParse(value.replaceAll(',', ''));
      return null;
    }

    return YeuCauBaoTri(
      id: json['id'] ?? 0,
      tenantName: json['tenantName'] ?? '',
      building: json['building'] ?? '',
      room: json['room'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: MaintenanceCategoryExtension.fromString(json['category'] as String?),
      priority: MaintenancePriorityExtension.fromString(json['priority'] as String?),
      status: MaintenanceStatusExtension.fromString(json['status'] as String?),
      requestDate: parseDate(json['requestDate'] as String?),
      assignedTo: json['assignedTo'] as String?,
      scheduledDate: parseDate(json['scheduledDate'] as String?),
      completedDate: parseDate(json['completedDate'] as String?),
      notes: json['notes'] as String?,
      actualCost: parseDouble(json['actualCost']),
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      tenant: json['tenant'] != null ? KhachThue.fromJson(json['hoTen'] as Map<String, dynamic>) : null,
    );
  }
}

extension MaintenanceCategoryExtension on MaintenanceCategory {
  static MaintenanceCategory fromString(String? value) {
    final val = value?.toLowerCase() ?? '';
    switch (val) {
      case 'electrical':
      case 'dien':
        return MaintenanceCategory.electrical;
      case 'plumbing':
      case 'nuoc':
        return MaintenanceCategory.plumbing;
      default:
        return MaintenanceCategory.other;
    }
  }

  String get displayName {
    switch (this) {
      case MaintenanceCategory.electrical:
        return 'Electrical';
      case MaintenanceCategory.plumbing:
        return 'Plumbing';
      case MaintenanceCategory.other:
        return 'Other';
    }
  }

  Color get color {
    switch (this) {
      case MaintenanceCategory.electrical:
        return Colors.blue;
      case MaintenanceCategory.plumbing:
        return Colors.green;
      case MaintenanceCategory.other:
        return Colors.grey;
    }
  }
}

extension MaintenancePriorityExtension on MaintenancePriority {
  static MaintenancePriority fromString(String? value) {
    final val = value?.toLowerCase() ?? '';
    switch (val) {
      case 'low':
      case 'thap':
        return MaintenancePriority.low;
      case 'medium':
      case 'trungbinh':
      case 'trung_binh':
        return MaintenancePriority.medium;
      case 'high':
      case 'cao':
        return MaintenancePriority.high;
      default:
        return MaintenancePriority.low;
    }
  }

  String get displayName {
    switch (this) {
      case MaintenancePriority.low:
        return 'Low';
      case MaintenancePriority.medium:
        return 'Medium';
      case MaintenancePriority.high:
        return 'High';
    }
  }

  Color get color {
    switch (this) {
      case MaintenancePriority.low:
        return Colors.green;
      case MaintenancePriority.medium:
        return Colors.orange;
      case MaintenancePriority.high:
        return Colors.redAccent;
    }
  }
}

extension MaintenanceStatusExtension on MaintenanceStatus {
  static MaintenanceStatus fromString(String? value) {
    final val = value?.toLowerCase() ?? '';
    switch (val) {
      case 'pending':
      case 'chophancong':
        return MaintenanceStatus.pending;
      case 'processing':
      case 'dangxuly':
        return MaintenanceStatus.processing;
      case 'completed':
      case 'dahoanthanh':
        return MaintenanceStatus.completed;
      default:
        return MaintenanceStatus.pending;
    }
  }

  String get displayName {
    switch (this) {
      case MaintenanceStatus.pending:
        return 'Pending';
      case MaintenanceStatus.processing:
        return 'Processing';
      case MaintenanceStatus.completed:
        return 'Completed';
    }
  }

  Color get color {
    switch (this) {
      case MaintenanceStatus.pending:
        return Colors.amber;
      case MaintenanceStatus.processing:
        return Colors.purple;
      case MaintenanceStatus.completed:
        return Colors.green;
    }
  }
}
