import 'package:flutter/material.dart';

const Color goldColor = Color(0xFFD4AF37);
const Color surfaceColor = Color(0xFF121212);

class NewsSection extends StatefulWidget {
  const NewsSection({super.key});

  @override
  State<NewsSection> createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  Map<String, dynamic>? _selectedNews;

  @override
  Widget build(BuildContext context) {
    if (_selectedNews != null) {
      return _buildNewsDetail(_selectedNews!);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth > 800;
        if (isWide) {
          return GridView.count(
            padding: const EdgeInsets.all(20),
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1.6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: _buildNewsList(),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) => _buildNewsList()[index],
        );
      },
    );
  }

  List<Widget> _buildNewsList() {
    return [
      _buildNewsCard('MATCH PREVIEW: CORE FC VS DUBAI CITY', 'Jan 30, 2024 • 5 min read', const Color(0xFF2E5B4F)),
      _buildNewsCard('MESSI HITS 90 GOAL MARK', 'Jan 28, 2024 • 3 min read', const Color(0xFF831843)),
      _buildNewsCard('NEW TRAINING FACILITY OPENED', 'Jan 25, 2024 • 4 min read', const Color(0xFF1E3A8A)),
    ];
  }

  Widget _buildNewsCard(String title, String meta, Color accentColor) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedNews = {
            'title': title,
            'meta': meta,
            'color': accentColor,
            'content': [
              {
                'type': 'text',
                'data':
                    'The club has officially announced the opening of its latest training facility. This world-class center features state-of-the-art equipment, multiple indoor pitches, and specialized recovery zones for players.'
              },
              {
                'type': 'text',
                'data':
                    'Head coach emphasized the importance of this facility in nurturing young talent and maintaining the physical peak of professional athletes.'
              },
            ]
          };
        });
      },
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Container(
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: accentColor.withValues(alpha: 0.2), width: 1.5),
            gradient: LinearGradient(
              colors: [accentColor.withValues(alpha: 0.15), Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('LATEST',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1)),
                ),
                const SizedBox(height: 12),
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        height: 1.2)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.white38, size: 14),
                    const SizedBox(width: 6),
                    Text(meta,
                        style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 11,
                            fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Icon(Icons.arrow_forward, color: accentColor, size: 18),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewsDetail(Map<String, dynamic> news) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => setState(() => _selectedNews = null),
            icon: const Icon(Icons.arrow_back, color: goldColor),
          ),
          const SizedBox(height: 10),
          Text(news['title'],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  height: 1.1)),
          const SizedBox(height: 12),
          Text(news['meta'],
              style: const TextStyle(
                  color: Colors.white38, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          ...((news['content'] as List).map((item) {
            if (item['type'] == 'text') {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  item['data'],
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 15,
                      height: 1.6),
                ),
              );
            } else if (item['type'] == 'image') {
              return Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(item['data'], fit: BoxFit.cover),
                ),
              );
            }
            return const SizedBox.shrink();
          })),
        ],
      ),
    );
  }
}
