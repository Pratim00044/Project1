import 'package:flutter/material.dart';
import 'player_profile.dart';

class TeammateProfile extends StatelessWidget {
  final String playerName;
  final String? playerNumber;

  const TeammateProfile({
    super.key,
    required this.playerName,
    this.playerNumber,
  });

  @override
  Widget build(BuildContext context) {
    return DetailedPlayerProfile(
      name: playerName,
      pos: 'Midfielder',
      club: 'Core FC',
      isMe: false,
      showBackButton: true,
    );
  }
}
