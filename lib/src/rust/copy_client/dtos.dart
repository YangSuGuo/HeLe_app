// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.1.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

class Author {
  final String name;
  final String? alias;
  final String pathWord;

  const Author({
    required this.name,
    this.alias,
    required this.pathWord,
  });

  @override
  int get hashCode => name.hashCode ^ alias.hashCode ^ pathWord.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Author &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          alias == other.alias &&
          pathWord == other.pathWord;
}

class Browse {
  final String chapterId;
  final String chapterName;
  final String chapterUuid;
  final String comicId;
  final String comicUuid;
  final String pathWord;

  const Browse({
    required this.chapterId,
    required this.chapterName,
    required this.chapterUuid,
    required this.comicId,
    required this.comicUuid,
    required this.pathWord,
  });

  @override
  int get hashCode =>
      chapterId.hashCode ^
      chapterName.hashCode ^
      chapterUuid.hashCode ^
      comicId.hashCode ^
      comicUuid.hashCode ^
      pathWord.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Browse &&
          runtimeType == other.runtimeType &&
          chapterId == other.chapterId &&
          chapterName == other.chapterName &&
          chapterUuid == other.chapterUuid &&
          comicId == other.comicId &&
          comicUuid == other.comicUuid &&
          pathWord == other.pathWord;
}

class ChapterComicInfo {
  final String name;
  final String pathWord;
  final ClassifyItem restrict;
  final String uuid;

  const ChapterComicInfo({
    required this.name,
    required this.pathWord,
    required this.restrict,
    required this.uuid,
  });

  @override
  int get hashCode =>
      name.hashCode ^ pathWord.hashCode ^ restrict.hashCode ^ uuid.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterComicInfo &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          pathWord == other.pathWord &&
          restrict == other.restrict &&
          uuid == other.uuid;
}

class ChapterImage {
  final String url;

  const ChapterImage({
    required this.url,
  });

  @override
  int get hashCode => url.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterImage &&
          runtimeType == other.runtimeType &&
          url == other.url;
}

class ClassifyItem {
  final String display;
  final PlatformInt64 value;

  const ClassifyItem({
    required this.display,
    required this.value,
  });

  @override
  int get hashCode => display.hashCode ^ value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassifyItem &&
          runtimeType == other.runtimeType &&
          display == other.display &&
          value == other.value;
}

class CollectedComic {
  final PlatformInt64 uuid;
  final String? name;
  final bool bFolder;
  final String? folderId;
  final LastBrowse? lastBrowse;
  final CollectedComicInfo comic;

  const CollectedComic({
    required this.uuid,
    this.name,
    required this.bFolder,
    this.folderId,
    this.lastBrowse,
    required this.comic,
  });

  @override
  int get hashCode =>
      uuid.hashCode ^
      name.hashCode ^
      bFolder.hashCode ^
      folderId.hashCode ^
      lastBrowse.hashCode ^
      comic.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectedComic &&
          runtimeType == other.runtimeType &&
          uuid == other.uuid &&
          name == other.name &&
          bFolder == other.bFolder &&
          folderId == other.folderId &&
          lastBrowse == other.lastBrowse &&
          comic == other.comic;
}

class CollectedComicInfo {
  final String uuid;
  final bool bDisplay;
  final String name;
  final String pathWord;
  final List<SexualOrientation> females;
  final List<SexualOrientation> males;
  final List<Author> author;
  final List<Tag> theme;
  final String cover;
  final PlatformInt64 status;
  final PlatformInt64 popular;
  final String datetimeUpdated;
  final String lastChapterId;
  final String lastChapterName;

  const CollectedComicInfo({
    required this.uuid,
    required this.bDisplay,
    required this.name,
    required this.pathWord,
    required this.females,
    required this.males,
    required this.author,
    required this.theme,
    required this.cover,
    required this.status,
    required this.popular,
    required this.datetimeUpdated,
    required this.lastChapterId,
    required this.lastChapterName,
  });

  @override
  int get hashCode =>
      uuid.hashCode ^
      bDisplay.hashCode ^
      name.hashCode ^
      pathWord.hashCode ^
      females.hashCode ^
      males.hashCode ^
      author.hashCode ^
      theme.hashCode ^
      cover.hashCode ^
      status.hashCode ^
      popular.hashCode ^
      datetimeUpdated.hashCode ^
      lastChapterId.hashCode ^
      lastChapterName.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectedComicInfo &&
          runtimeType == other.runtimeType &&
          uuid == other.uuid &&
          bDisplay == other.bDisplay &&
          name == other.name &&
          pathWord == other.pathWord &&
          females == other.females &&
          males == other.males &&
          author == other.author &&
          theme == other.theme &&
          cover == other.cover &&
          status == other.status &&
          popular == other.popular &&
          datetimeUpdated == other.datetimeUpdated &&
          lastChapterId == other.lastChapterId &&
          lastChapterName == other.lastChapterName;
}

class Group {
  final PlatformInt64 count;
  final String name;
  final String pathWord;

  const Group({
    required this.count,
    required this.name,
    required this.pathWord,
  });

  @override
  int get hashCode => count.hashCode ^ name.hashCode ^ pathWord.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Group &&
          runtimeType == other.runtimeType &&
          count == other.count &&
          name == other.name &&
          pathWord == other.pathWord;
}

class LastBrowse {
  final String lastBrowseId;
  final String lastBrowseName;

  const LastBrowse({
    required this.lastBrowseId,
    required this.lastBrowseName,
  });

  @override
  int get hashCode => lastBrowseId.hashCode ^ lastBrowseName.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LastBrowse &&
          runtimeType == other.runtimeType &&
          lastBrowseId == other.lastBrowseId &&
          lastBrowseName == other.lastBrowseName;
}

class LastChapter {
  final String name;
  final String uuid;

  const LastChapter({
    required this.name,
    required this.uuid,
  });

  @override
  int get hashCode => name.hashCode ^ uuid.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LastChapter &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          uuid == other.uuid;
}

class MemberInfo {
  final String userId;
  final String username;
  final String nickname;
  final String avatar;
  final bool isAuthenticated;
  final String datetimeCreated;
  final bool bVerifyEmail;
  final String email;
  final String? mobile;
  final String? mobileRegion;
  final PlatformInt64 point;
  final PlatformInt64 comicVip;
  final String? comicVipEnd;
  final String? comicVipStart;
  final PlatformInt64 cartoonVip;
  final String? cartoonVipEnd;
  final String? cartoonVipStart;
  final String? adsVipEnd;
  final bool closeReport;
  final PlatformInt64 downloads;
  final PlatformInt64 vipDownloads;
  final PlatformInt64 rewardDownloads;
  final String? inviteCode;
  final String? invited;
  final bool bSstv;
  final bool scyAnswer;
  final String dayDownloadsRefresh;
  final PlatformInt64 dayDownloads;

  const MemberInfo({
    required this.userId,
    required this.username,
    required this.nickname,
    required this.avatar,
    required this.isAuthenticated,
    required this.datetimeCreated,
    required this.bVerifyEmail,
    required this.email,
    this.mobile,
    this.mobileRegion,
    required this.point,
    required this.comicVip,
    this.comicVipEnd,
    this.comicVipStart,
    required this.cartoonVip,
    this.cartoonVipEnd,
    this.cartoonVipStart,
    this.adsVipEnd,
    required this.closeReport,
    required this.downloads,
    required this.vipDownloads,
    required this.rewardDownloads,
    this.inviteCode,
    this.invited,
    required this.bSstv,
    required this.scyAnswer,
    required this.dayDownloadsRefresh,
    required this.dayDownloads,
  });

  @override
  int get hashCode =>
      userId.hashCode ^
      username.hashCode ^
      nickname.hashCode ^
      avatar.hashCode ^
      isAuthenticated.hashCode ^
      datetimeCreated.hashCode ^
      bVerifyEmail.hashCode ^
      email.hashCode ^
      mobile.hashCode ^
      mobileRegion.hashCode ^
      point.hashCode ^
      comicVip.hashCode ^
      comicVipEnd.hashCode ^
      comicVipStart.hashCode ^
      cartoonVip.hashCode ^
      cartoonVipEnd.hashCode ^
      cartoonVipStart.hashCode ^
      adsVipEnd.hashCode ^
      closeReport.hashCode ^
      downloads.hashCode ^
      vipDownloads.hashCode ^
      rewardDownloads.hashCode ^
      inviteCode.hashCode ^
      invited.hashCode ^
      bSstv.hashCode ^
      scyAnswer.hashCode ^
      dayDownloadsRefresh.hashCode ^
      dayDownloads.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberInfo &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          username == other.username &&
          nickname == other.nickname &&
          avatar == other.avatar &&
          isAuthenticated == other.isAuthenticated &&
          datetimeCreated == other.datetimeCreated &&
          bVerifyEmail == other.bVerifyEmail &&
          email == other.email &&
          mobile == other.mobile &&
          mobileRegion == other.mobileRegion &&
          point == other.point &&
          comicVip == other.comicVip &&
          comicVipEnd == other.comicVipEnd &&
          comicVipStart == other.comicVipStart &&
          cartoonVip == other.cartoonVip &&
          cartoonVipEnd == other.cartoonVipEnd &&
          cartoonVipStart == other.cartoonVipStart &&
          adsVipEnd == other.adsVipEnd &&
          closeReport == other.closeReport &&
          downloads == other.downloads &&
          vipDownloads == other.vipDownloads &&
          rewardDownloads == other.rewardDownloads &&
          inviteCode == other.inviteCode &&
          invited == other.invited &&
          bSstv == other.bSstv &&
          scyAnswer == other.scyAnswer &&
          dayDownloadsRefresh == other.dayDownloadsRefresh &&
          dayDownloads == other.dayDownloads;
}

class RegisterResult {
  final String userId;
  final String uuid;
  final String datetimeCreated;
  final String? token;
  final String nickname;
  final String avatar;
  final String? inviteCode;

  const RegisterResult({
    required this.userId,
    required this.uuid,
    required this.datetimeCreated,
    this.token,
    required this.nickname,
    required this.avatar,
    this.inviteCode,
  });

  @override
  int get hashCode =>
      userId.hashCode ^
      uuid.hashCode ^
      datetimeCreated.hashCode ^
      token.hashCode ^
      nickname.hashCode ^
      avatar.hashCode ^
      inviteCode.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterResult &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          uuid == other.uuid &&
          datetimeCreated == other.datetimeCreated &&
          token == other.token &&
          nickname == other.nickname &&
          avatar == other.avatar &&
          inviteCode == other.inviteCode;
}

class SexualOrientation {
  final String name;
  final String pathWord;
  final PlatformInt64 gender;

  const SexualOrientation({
    required this.name,
    required this.pathWord,
    required this.gender,
  });

  @override
  int get hashCode => name.hashCode ^ pathWord.hashCode ^ gender.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SexualOrientation &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          pathWord == other.pathWord &&
          gender == other.gender;
}

class Tag {
  final String name;
  final String pathWord;

  const Tag({
    required this.name,
    required this.pathWord,
  });

  @override
  int get hashCode => name.hashCode ^ pathWord.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tag &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          pathWord == other.pathWord;
}
