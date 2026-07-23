import 'package:flutter/material.dart';

class VenueStyles {
  static const List<Color> _defaultGradient = [Color(0xFF2E5B4F), Color(0xFF3B2A50)];

  static final Map<String, List<Color>> _venueColorMap = {
    // Coach Venues
    'Pitch 1': [const Color(0xFF1E3A8A), const Color(0xFF312E81)], // Blue
    'Pitch 2': [const Color(0xFF065F46), const Color(0xFF064E3B)], // Teal/Green
    'Pitch 3': [const Color(0xFF3F6212), const Color(0xFF14532D)], // Moss Green
    'Main Pitch': [const Color(0xFF4C1D95), const Color(0xFF2E1065)], // Indigo/Purple
    
    // Organizer Venues
    'Business Bay Courts': [const Color(0xFF92400E), const Color(0xFF78350F)], // Dark Orange
    'Dubai Sports City': [const Color(0xFF14532D), const Color(0xFF064E3B)], // Forest Green
    'JBR Arena': [const Color(0xFF831843), const Color(0xFF701A75)], // Magenta/Plum
    'Kite Beach': [const Color(0xFF0891B2), const Color(0xFF164E63)], // Cyan/Sea Blue
    'Main Stadium': [const Color(0xFF1E3A8A), const Color(0xFF1E40AF)], // Navy Blue
    'JLT Pitch': [const Color(0xFF334155), const Color(0xFF1E293B)], // Slate/Dark Grey
    'Dubai Hills': [const Color(0xFF713F12), const Color(0xFF422006)], // Dark Brown/Bronze
  };

  static List<Color> getVenueGradient(String? venue) {
    if (venue == null) return _defaultGradient;
    
    // Try exact match
    if (_venueColorMap.containsKey(venue)) {
      return _venueColorMap[venue]!;
    }
    
    // Try case-insensitive partial match for common terms
    String venueLower = venue.toLowerCase();
    if (venueLower.contains('pitch 1')) return _venueColorMap['Pitch 1']!;
    if (venueLower.contains('pitch 2')) return _venueColorMap['Pitch 2']!;
    if (venueLower.contains('pitch 3')) return _venueColorMap['Pitch 3']!;
    if (venueLower.contains('main pitch')) return _venueColorMap['Main Pitch']!;
    
    return _defaultGradient;
  }
}
