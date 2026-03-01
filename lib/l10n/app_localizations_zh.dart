// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '转换器';

  @override
  String get recorded => '已记录';

  @override
  String get emptyRecords => '记录为空';

  @override
  String get error => '错误';

  @override
  String get saveSuccess => '保存成功';

  @override
  String get ok => '确定';

  @override
  String get history => '历史记录';

  @override
  String get saveAsCsv => '保存为 CSV 文件';

  @override
  String get addToHistory => '添加到历史记录';

  @override
  String get deleteItem => '删除此条';

  @override
  String get confirmClear => '确认清空';

  @override
  String get confirmClearMessage => '确定要清空所有历史记录吗？';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get clear => '清空';

  @override
  String get historyCleared => '历史记录已清空';

  @override
  String get configuration => '配置参数';

  @override
  String get fpsLabel => '帧率 (FPS)';

  @override
  String get frames => '帧';

  @override
  String get dropFrameMode => '丢帧模式 (Drop Frame)';

  @override
  String get smpteTimecode => 'SMPTE TIMECODE';

  @override
  String get seconds => '秒数';

  @override
  String get minutes => '分钟';

  @override
  String get hours => '小时';

  @override
  String get settings => '设置';

  @override
  String get settingsContent => '设置内容';

  @override
  String get historyContent => '历史记录内容';

  @override
  String get themeSettings => '主题设置';

  @override
  String get framesSpecified => '指定帧数';

  @override
  String savedToPath(String path) {
    return '已保存到 $path';
  }

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String get newestFirst => '最新在前';

  @override
  String get oldestFirst => '最早在前';

  @override
  String get clearAllRecords => '清空所有记录';

  @override
  String get recordDeleted => '已删除此条记录';

  @override
  String get undo => '撤回';

  @override
  String get appearanceExperience => '外观与体验';

  @override
  String get darkMode => '深色模式';

  @override
  String get reverseLayout => '反转布局';

  @override
  String get reverseLayoutSubtitle => '切换时间码与参数面板的位置';

  @override
  String get about => '关于';

  @override
  String get versionInfo => '版本信息';

  @override
  String get githubRepo => 'GitHub 仓库';
}
