import 'package:flutter/material.dart';
import 'player_home.dart';
import 'dashboard_sections/news_section.dart';
import 'dashboard_sections/session_section.dart';
import 'dashboard_sections/ranking_section.dart';
import 'package:file_picker/file_picker.dart' as fp;

const Color goldColor = Color(0xFFD4AF37);
const Color darkBg = Color(0xFF080808);
const Color surfaceColor = Color(0xFF121212);

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('HIGHLIGHT VIDEOS', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
        foregroundColor: goldColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('YOUR UPLOADS', 
                  style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                ElevatedButton.icon(
                  onPressed: () async {
                    fp.FilePickerResult? result = await fp.FilePicker.platform.pickFiles(
                      type: fp.FileType.video,
                    );
                    if (result != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Uploading ${result.files.single.name}...'))
                      );
                    }
                  },
                  icon: const Icon(Icons.cloud_upload_outlined, size: 16, color: Colors.black),
                  label: const Text('UPLOAD NEW', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: goldColor,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.2,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final List<String> tileImages = [
                  'assets/images/img1.jpeg',
                  'assets/images/img2.jpeg',
                  'assets/images/img3.jpeg',
                  'assets/images/img4.jpeg',
                ];
                String currentImage = tileImages[index % tileImages.length];

                return Container(
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: goldColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.play_arrow, color: goldColor, size: 30),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Text(
                          index == 0 ? 'Top Goals 2024' : 'Skill Highlight ${index + 1}',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('LATEST NEWS', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
        foregroundColor: goldColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(child: NewsSection()),
    );
  }
}

class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('ACADEMY SESSIONS', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
        foregroundColor: goldColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SessionSection(),
    );
  }
}

class RankingsPage extends StatelessWidget {
  const RankingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: const Text('GLOBAL RANKINGS', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
        foregroundColor: goldColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(child: RankingSection()),
    );
  }
}
