// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'コンバーター';

  @override
  String get recorded => '記録しました';

  @override
  String get emptyRecords => '記録がありません';

  @override
  String get error => 'エラー';

  @override
  String get saveSuccess => '保存成功';

  @override
  String get ok => 'OK';

  @override
  String get history => '履歴';

  @override
  String get saveAsCsv => 'CSVファイルとして保存';

  @override
  String get addToHistory => '履歴に追加';

  @override
  String get deleteItem => '削除';

  @override
  String get confirmClear => 'クリアの確認';

  @override
  String get confirmClearMessage => 'すべての履歴をクリアしてもよろしいですか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => '確認';

  @override
  String get clear => 'クリア';

  @override
  String get historyCleared => '履歴をクリアしました';

  @override
  String get configuration => '設定';

  @override
  String get fpsLabel => 'フレームレート (FPS)';

  @override
  String get frames => 'フレーム';

  @override
  String get dropFrameMode => 'ドロップフレームモード';

  @override
  String get smpteTimecode => 'SMPTE タイムコード';

  @override
  String get seconds => '秒';

  @override
  String get minutes => '分';

  @override
  String get hours => '時間';

  @override
  String get settings => '設定';

  @override
  String get settingsContent => '設定コンテンツ';

  @override
  String get historyContent => '履歴コンテンツ';

  @override
  String get themeSettings => 'テーマ設定';

  @override
  String get framesSpecified => 'フレーム指定';

  @override
  String savedToPath(String path) {
    return '$path に保存しました';
  }

  @override
  String get today => '今日';

  @override
  String get yesterday => '昨日';

  @override
  String get newestFirst => '最新順';

  @override
  String get oldestFirst => '古い順';

  @override
  String get clearAllRecords => 'すべての記録をクリア';

  @override
  String get recordDeleted => '記録を削除しました';

  @override
  String get undo => '元に戻す';

  @override
  String get appearanceExperience => '外観と操作性';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get reverseLayout => 'レイアウト反転';

  @override
  String get reverseLayoutSubtitle => 'タイムコードとパラメータパネルの位置を切り替え';

  @override
  String get about => 'について';

  @override
  String get versionInfo => 'バージョン情報';

  @override
  String get githubRepo => 'GitHub リポジトリ';
}
