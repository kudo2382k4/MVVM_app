import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApiImagesPage extends StatefulWidget{
  const ApiImagesPage({super.key});

  @override
  State<ApiImagesPage> createState() => _ApiImagesPageState();
}

class _ApiImagesPageState extends State<ApiImagesPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<int> _codes = const[
    100, 101, 200, 201, 202, 204,
    301, 302, 304,
    400, 401, 403, 404, 405, 408, 409, 418, 429,
    500, 501, 502, 503, 504,
  ];

  int _selected = 404;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _codes.length, vsync: this);
  }

  String _imageUrl(){
    final idx = _tabController.index;
    if(idx == 0) return 'https://http.cat/$_selected';
    return 'https://http.dog/$_selected.jpg';
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFE9F4FF);
    const headerBlue = Color(0xFF1D4E9E);
    const primary = Color(0xFF1E88E5);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('xem ảnh qua API'),
        backgroundColor: headerBlue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelStyle: const TextStyle(fontWeight: FontWeight.w800),
          onTap: (_) => setState(() {}), //refresh url
          tabs: const [
            Tab(text: 'http.cat'),
            Tab(text: 'http.dog'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: primary.withOpacity(0.18)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 14,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _selected,
                isExpanded: true,
                items: _codes.map((c) => DropdownMenuItem(
                  value: c,
                  child: Text(
                    'HTTP $c',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )).toList(),
                onChanged: (v) => setState(() => _selected = v ?? 404),
              ),
              ),
            ),
            const SizedBox(height: 14),

            // Image viewer
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: primary.withOpacity(0.18)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    )
                  ],
              ),
                child: Column(
                  children: [
                    Text(
                      _imageUrl(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black.withOpacity(0.55)),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: InteractiveViewer(
                        minScale: 0.8,
                        maxScale: 3.0,
                        child: Image.network(
                          _imageUrl(),
                          fit: BoxFit.contain,
                          loadingBuilder: (c, w, p){
                            if(p == null) return w;
                            return const Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (c, e, s) {
                            return Center(
                              child: Text(
                                'Không tải được ảnh.\nHãy thử mã khác.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black.withOpacity(0.85)),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}