import 'package:flutter/material.dart';

class IncidentCategory {
  const IncidentCategory({
    required this.id,
    required this.label,
    required this.description,
    required this.icon,
  });

  final String id;
  final String label;
  final String description;
  final IconData icon;
}

const incidentCategories = <IncidentCategory>[
  IncidentCategory(
    id: 'flood',
    label: 'Flood / waterlogging',
    description: 'Standing water, blocked drains, or flood risk.',
    icon: Icons.flood_rounded,
  ),
  IncidentCategory(
    id: 'electric',
    label: 'Electric hazard',
    description: 'Exposed wires, sparks, poles, or unsafe power lines.',
    icon: Icons.electrical_services_rounded,
  ),
  IncidentCategory(
    id: 'pothole',
    label: 'Pothole / road damage',
    description: 'Potholes, broken roads, or dangerous traffic surfaces.',
    icon: Icons.car_crash_rounded,
  ),
  IncidentCategory(
    id: 'unsafe_area',
    label: 'Unsafe area',
    description: 'A place that feels unsafe and needs careful review.',
    icon: Icons.warning_amber_rounded,
  ),
];
