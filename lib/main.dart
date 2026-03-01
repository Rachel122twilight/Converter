import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:converter/l10n/app_localizations.dart';

void main() {
  runApp(const ProFrameCalcApp());
}

enum SortType { timeAsc, timeDesc }

class FrameRecord {
  final String timeStamp;
  final String fps;
  final String frames;
  final String timecode;

  FrameRecord({
    required this.timeStamp,
    required this.fps,
    required this.frames,
    required this.timecode,
  });
}

class ProFrameCalcApp extends StatefulWidget {
  const ProFrameCalcApp({super.key});

  @override
  State<ProFrameCalcApp> createState() => _ProFrameCalcAppState();
}

class _ProFrameCalcAppState extends State<ProFrameCalcApp> {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isLayoutReversed = false;

  void _toggleTheme(bool isDark) {
    setState(() => _themeMode = isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void _toggleLayout(bool value) {
    setState(() => _isLayoutReversed = value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiPlatformConverter(
        onThemeChanged: _toggleTheme,
        onLayoutChanged: _toggleLayout,
        currentMode: _themeMode,
        isLayoutReversed: _isLayoutReversed,
      ),
    );
  }
}

class MultiPlatformConverter extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final Function(bool) onLayoutChanged;
  final ThemeMode currentMode;
  final bool isLayoutReversed;

  const MultiPlatformConverter({
    super.key,
    required this.onThemeChanged,
    required this.onLayoutChanged,
    required this.currentMode,
    required this.isLayoutReversed,
  });

  @override
  State<MultiPlatformConverter> createState() => _MultiPlatformConverterState();
}

class _MultiPlatformConverterState extends State<MultiPlatformConverter> {
  final TextEditingController _fpsController = TextEditingController(
    text: '29.97',
  );
  final TextEditingController _frameController = TextEditingController(
    text: '0',
  );
  bool _isDropFrame = false;
  final List<FrameRecord> _history = [];
  final List<double> _fpsPresets = [
    23.976,
    24,
    25,
    29.97,
    30,
    50,
    59.94,
    60,
    120,
  ];

  String _calculateTimecode() {
    double fps = double.tryParse(_fpsController.text) ?? 30;
    int frames = int.tryParse(_frameController.text) ?? 0;

    if (_isDropFrame && (fps == 29.97 || fps == 59.94)) {
      int dropFrames = (fps == 29.97) ? 2 : 4;
      int totalMinutes = (frames / (fps * 60)).floor();
      int dropped = totalMinutes - (totalMinutes ~/ 10);
      frames += dropped * dropFrames;
    }

    int f = (frames % fps).toInt();
    int s = (frames ~/ fps) % 60;
    int m = (frames ~/ (fps * 60)) % 60;
    int h = (frames ~/ (fps * 3600));

    String sep = _isDropFrame ? ";" : ":";
    return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}$sep${f.toString().padLeft(2, '0')}";
  }

  void _addRecord() {
    setState(() {
      _history.insert(
        0,
        FrameRecord(
          timeStamp: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          fps: _fpsController.text,
          frames: _frameController.text,
          timecode: _calculateTimecode(),
        ),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.recorded),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Converter")),
      drawer: _buildNavDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 650;
          List<Widget> children = [
            isWide
                ? Expanded(
                    flex: 2,
                    child: SingleChildScrollView(child: _buildInputSection()),
                  )
                : _buildInputSection(),
            isWide ? const VerticalDivider(width: 1) : const SizedBox.shrink(),
            isWide
                ? Expanded(flex: 3, child: Center(child: _buildResultSection()))
                : _buildResultSection(),
          ];

          if (widget.isLayoutReversed) children = children.reversed.toList();

          if (isWide)
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            );

          return SingleChildScrollView(
            child: Column(children: [...children, const SizedBox(height: 100)]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRecord,
        tooltip: AppLocalizations.of(context)!.addToHistory,
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _buildNavDrawer() {
    return NavigationDrawer(
      selectedIndex: -1,
      onDestinationSelected: (index) {
        Navigator.pop(context);
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HistoryPage(
                history: _history,
                onClear: () => setState(() => _history.clear()),
                onDelete: (record) => setState(() => _history.remove(record)),
                onUndo: (record, index) =>
                    setState(() => _history.insert(index, record)),
              ),
            ),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsPage(
                onThemeChanged: widget.onThemeChanged,
                onLayoutChanged: widget.onLayoutChanged,
                isDark: widget.currentMode == ThemeMode.dark,
                isLayoutReversed: widget.isLayoutReversed,
              ),
            ),
          );
        }
      },
      children: [
        const NavigationDrawerHeader(),
        NavigationDrawerDestination(
          icon: const Icon(Icons.history_rounded),
          label: Text(AppLocalizations.of(context)!.history),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.settings_outlined),
          label: Text(AppLocalizations.of(context)!.settings),
        ),
      ],
    );
  }

  Widget _buildInputSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "配置参数",
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _fpsController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: '帧率 (FPS)',
              border: OutlineInputBorder(),
            ),
            onChanged: (val) => setState(() {}),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _fpsPresets.map((f) {
              final isSelected = double.tryParse(_fpsController.text) == f;
              return FilterChip(
                label: Text(f.toString()),
                selected: isSelected,
                onSelected: (bool selected) =>
                    setState(() => _fpsController.text = f.toString()),
              );
            }).toList(),
          ),
          const Divider(height: 40),
          Text(
            "指定帧数",
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _frameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '帧数',
            ),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            onChanged: (_) => setState(() {}),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text("丢帧模式 (Drop Frame)"),
            value: _isDropFrame,
            onChanged: (val) => setState(() => _isDropFrame = val),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSection() {
    double fps = double.tryParse(_fpsController.text) ?? 1;
    int frames = int.tryParse(_frameController.text) ?? 0;
    double totalSec = frames / fps;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            elevation: 0,
            child: Container(
              padding: const EdgeInsets.all(40),
              width: double.infinity,
              child: Column(
                children: [
                  const Text(
                    "SMPTE TIMECODE",
                    style: TextStyle(letterSpacing: 2),
                  ),
                  const SizedBox(height: 16),
                  FittedBox(
                    child: Text(
                      _calculateTimecode(),
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 30,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _infoTile("秒数", "${totalSec.toStringAsFixed(3)} s"),
              _infoTile("分钟", "${(totalSec / 60).toStringAsFixed(2)} m"),
              _infoTile("小时", "${(totalSec / 3600).toStringAsFixed(4)} h"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class HistoryPage extends StatefulWidget {
  final List<FrameRecord> history;
  final VoidCallback onClear;
  final Function(FrameRecord) onDelete;
  final Function(FrameRecord, int) onUndo;

  const HistoryPage({
    super.key,
    required this.history,
    required this.onClear,
    required this.onDelete,
    required this.onUndo,
  });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  SortType _sortType = SortType.timeDesc;

  void _toggleSort() {
    setState(() {
      _sortType = (_sortType == SortType.timeDesc)
          ? SortType.timeAsc
          : SortType.timeDesc;
    });
  }

  Future<void> _exportCSV(BuildContext context) async {
    if (widget.history.isEmpty) return;
    try {
      String csvData = "Time,FPS,Frame,Time Code\n";
      for (var item in widget.history) {
        csvData +=
            "${item.timeStamp},${item.fps},${item.frames},${item.timecode}\n";
      }
      final directory = await getApplicationDocumentsDirectory();
      final String path =
          "${directory.path}/Converter_SMPTE_Export_${DateTime.now().millisecondsSinceEpoch}.csv";
      final File file = File(path);
      await file.writeAsString(csvData);
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (c) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.saveSuccess),
          content: SelectableText("已保存到 $path"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c),
              child: const Text("确定"),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Map<String, List<FrameRecord>> _groupHistory(List<FrameRecord> records) {
    Map<String, List<FrameRecord>> groups = {};
    final now = DateTime.now();
    final yesterday = DateTime.now().subtract(const Duration(days: 1));

    for (var record in records) {
      DateTime dt = DateTime.parse(record.timeStamp);
      String dayLabel;
      if (DateFormat('yyyy-MM-dd').format(dt) ==
          DateFormat('yyyy-MM-dd').format(now)) {
        dayLabel = "今天";
      } else if (DateFormat('yyyy-MM-dd').format(dt) ==
          DateFormat('yyyy-MM-dd').format(yesterday)) {
        dayLabel = "昨天";
      } else {
        dayLabel = DateFormat('yyyy年MM月dd日').format(dt);
      }
      groups.putIfAbsent(dayLabel, () => []).add(record);
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    List<FrameRecord> sortedList = List.from(widget.history);
    sortedList.sort(
      (a, b) => _sortType == SortType.timeDesc
          ? b.timeStamp.compareTo(a.timeStamp)
          : a.timeStamp.compareTo(b.timeStamp),
    );

    final groups = _groupHistory(sortedList);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.history),
        actions: widget.history.isNotEmpty
            ? [
                IconButton(
                  icon: Icon(
                    _sortType == SortType.timeDesc
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                  ),
                  tooltip: _sortType == SortType.timeDesc ? "最新在前" : "最早在前",
                  onPressed: _toggleSort,
                ),
                IconButton(
                  icon: const Icon(Icons.output_rounded),
                  tooltip: "导出为 CSV 文件",
                  onPressed: () => _exportCSV(context),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_sweep_outlined),
                  tooltip: "清空所有记录",
                  onPressed: () => _showClearDialog(context),
                ),
              ]
            : null,
      ),
      body: widget.history.isEmpty
          ? const Center(child: Opacity(opacity: 0.5, child: Text("暂无记录")))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                String date = groups.keys.elementAt(index);
                List<FrameRecord> items = groups[date]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 4,
                      ),
                      child: Text(
                        date,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...items.map((item) => _buildHistoryCard(item)),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
    );
  }

  Widget _buildHistoryCard(FrameRecord item) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          item.timecode,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
        subtitle: Text(
          "${item.fps} FPS • ${item.frames} F • ${item.timeStamp.split(' ')}",
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            final index = widget.history.indexOf(item);
            widget.onDelete(item);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("已删除此条记录"),
                action: SnackBarAction(
                  label: "撤回",
                  onPressed: () {
                    widget.onUndo(item, index);
                    setState(() {});
                  },
                ),
              ),
            );
            setState(() {});
          },
        ),
      ),
    );
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("清空历史记录"),
        content: const Text("确定要永久删除所有记录吗？"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("取消"),
          ),
          FilledButton.tonal(
            onPressed: () {
              widget.onClear();
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text("确认"),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final Function(bool) onLayoutChanged;
  final bool isDark;
  final bool isLayoutReversed;

  const SettingsPage({
    super.key,
    required this.onThemeChanged,
    required this.onLayoutChanged,
    required this.isDark,
    required this.isLayoutReversed,
  });

  Future<void> _launchGitHub() async {
    final Uri url = Uri.parse('https://github.com/tasuda/converter');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingsGroup(context, "外观与体验", [
            SwitchListTile(
              secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
              title: const Text("深色模式"),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 16,
              ),
              value: isDark,
              onChanged: onThemeChanged,
            ),
            SwitchListTile(
              secondary: const Icon(Icons.swap_vert_rounded),
              title: const Text("反转布局"),
              subtitle: const Text("切换时间码与参数面板的位置"),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 16,
              ),
              value: isLayoutReversed,
              onChanged: onLayoutChanged,
            ),
          ]),
          const SizedBox(height: 16),
          _buildSettingsGroup(context, "关于", [
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("版本信息"),
              subtitle: const Text("1.0.0"),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Converter",
                  applicationVersion: "1.0.0",
                  applicationLegalese: "© 2026 Tasuda",
                  applicationIcon: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'android/app/src/main/res/mipmap/ic_launcher.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text("GitHub 仓库"),
              subtitle: const Text("github.com/tasuda/converter"),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              trailing: const Icon(Icons.open_in_new, size: 18),
              onTap: _launchGitHub,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8),
          child: Text(title, style: Theme.of(context).textTheme.labelLarge),
        ),
        Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          child: Column(children: children),
        ),
      ],
    );
  }
}

class NavigationDrawerHeader extends StatelessWidget {
  const NavigationDrawerHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 24, 16, 20),
      child: Text(
        "Converter",
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
