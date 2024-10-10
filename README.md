# HeLe

## 项目简介

这是一个基于Flutter的跨平台App，主要使用bangumi开源API作为数据源。
实现跨平台的影视进度管理，未来实现本地进度管理进度数据上传云平台和影视资源更新与上线通知推送。

## 项目依赖
~~~yaml
   # 国际化
   flutter_localizations: # 国际化
     sdk: flutter
   intl: ^0.19.0 # 国际化

   # 界面UI
   custom_sliding_segmented_control: ^1.8.3 # 分段器
   scroll_datetime_picker: ^0.1.2 # 滑动时间选择
   loading_animation_widget: ^1.2.1 # 加载动画
   animated_rating_stars: ^1.0.1 # 评分星标
   flutter_smart_dialog: ^4.9.8 # 弹窗
   font_awesome_flutter: ^10.7.0 # icon
   auto_size_text: ^3.0.0 # 文本自适应
   expand_widget: ^3.1.1 # 文本折叠
   cupertino_icons: ^1.0.8 # icon
   fl_chart: ^0.69.0 # 图表
   gap: ^3.0.1 # 间隔

   # 网络请求
   connectivity_plus: ^6.0.5
   dio: ^5.6.0 # 网络请求

   # 开发工具
   cached_network_image: ^3.4.1 # 图片缓存
   flutter_screenutil: ^5.9.3 # 屏幕适配
   url_launcher: ^6.3.0 # url跳转
   easy_debounce: ^2.0.3 # 防抖
   share_plus: ^10.0.2 # 分享
   nil: ^1.1.1 # 占位符

   # 状态管理
   get: ^4.6.6 # 路由 & 状态管理
   provider: ^6.1.2 # 状态管理

   # 本地存储
   shared_preferences: ^2.3.2 # 本地状态存储
   floor: ^1.5.0 # 本地数据库
~~~

## 项目环境
~~~
 Flutter (Channel stable, 3.24.3, on Microsoft Windows [版本 10.0.19045.3930], locale zh-CN)
 • Flutter version 3.24.3 on channel stable at H:\SDKs\Flutter
 • Upstream repository https://github.com/flutter/flutter.git
 • Framework revision 2663184aa7 (4 weeks ago), 2024-09-11 16:27:48 -0500
 • Engine revision 36335019a8
 • Dart version 3.5.3
 • DevTools version 2.37.3
 • Pub download mirror https://pub.flutter-io.cn
 • Flutter download mirror https://storage.flutter-io.cn
~~~

## 项目结构
~~~
/lib
├─providers---------------------------------------# 状态管理
│ └─application
│   └─application.dart
├─db---------------------------------------------# 持久化
│ ├─preference-----------------------------------# 持久化存储
│ │ └─preferences_db.dart
│ └─database------------------------------------# 数据库
│   ├─dao---------------------------------------# dao
│   │ ├─subjects_history_dao.dart
│   │ ├─subjects_star_dao.dart
│   │ └─subjects_user_tags_dao.dart
│   ├─entity------------------------------------# 实体
│   │ ├─subjects_history.dart-------------------# 历史记录
│   │ ├─subjects_star.dart----------------------# 标注记录
│   │ ├─subjects_user_tags.dart-----------------# 用户标签
│   │ └─subjects.dart---------------------------# 番剧信息
│   ├─app_database.dart-------------------------# 数据库
│   └─app_database.g.dart
├─l10n-------------------------------------------# 国际化
│ ├─gen
│ │ ├─app_g_en.dart
│ │ ├─app_g_untranslated.json
│ │ ├─app_g_zh.dart
│ │ └─app_g.dart
│ ├─app_en.arb----------------------------------# 英文
│ └─app_zh.arb----------------------------------# 中文
├─pages------------------------------------------# 页面
│ ├─about----------------------------------------# 关于
│ │ ├─model
│ │ └─views
│ │   └─about_section.dart
│ ├─apply_data----------------------------------# 应用数据
│ │ ├─bindings
│ │ ├─controllers
│ │ ├─model
│ │ │ └─info.dart
│ │ ├─views
│ │ │ └─apply_data.dart
│ │ └─widget
│ │   ├─common_card.dart-----------------------# 卡片展示
│ │   └─info_header.dart-----------------------# 标题
│ ├─browsing_history----------------------------# 浏览记录
│ │ ├─bindings
│ │ ├─controllers
│ │ │ └─browsing_history_controllers.dart
│ │ ├─model
│ │ ├─views
│ │ │ └─browsing_history.dart
│ │ └─widget
│ ├─data_and_statistics-------------------------# 数据与统计
│ │ ├─bindings
│ │ │ └─data_and_statistics_bingings.dart
│ │ ├─controllers
│ │ │ └─data_and_statistics_controllers.dart
│ │ ├─model
│ │ ├─views
│ │ │ └─data_and_statistics.dart
│ │ └─widget
│ ├─extra_info----------------------------------# 更多信息
│ │ ├─bindings
│ │ ├─controllers
│ │ │ └─extra_info_controllers.dart
│ │ ├─views
│ │ │ └─extra_info.dart
│ │ └─widget
│ ├─home----------------------------------------# 首页
│ │ ├─bindings
│ │ │ └─home_binding.dart
│ │ ├─controllers
│ │ │ └─home_controller.dart
│ │ ├─model
│ │ │ └─tab_type.dart
│ │ ├─views
│ │ │ └─home.dart
│ │ └─widget
│ │   ├─custom_tabs.dart-----------------------# TabBar
│ │   ├─search_appbar.dart---------------------# AppBar
│ │   └─theme_card.dart------------------------# 主题卡片
│ ├─main----------------------------------------# 底部导航栏
│ │ ├─bindings
│ │ │ └─main_binding.dart
│ │ ├─controllers
│ │ │ └─main_controllers.dart
│ │ └─views
│ │   └─main.dart
│ ├─manage_entries------------------------------# 管理条目
│ │ ├─bindings
│ │ │ └─manage_entries_bindings.dart
│ │ ├─controllers
│ │ │ └─manage_entries_controllers.dart
│ │ ├─model
│ │ │ └─tracking_type_list.dart
│ │ ├─views
│ │ │ └─manage_entries.dart
│ │ └─widget
│ │   ├─series_info_panel.dart
│ │   └─tracking_type.dart
│ ├─my------------------------------------------# 我的
│ │ ├─model
│ │ │ └─list_tile.dart
│ │ └─views
│ │   └─my.dart
│ ├─my_favorites-------------------------------# 我的收藏
│ │ ├─bindings
│ │ │ └─my_favorites_bindings.dart
│ │ ├─controllers
│ │ │ └─my_favorites_controllers.dart
│ │ ├─model
│ │ ├─views
│ │ │ └─my_favorites.dart
│ │ └─widget
│ ├─rank_list-----------------------------------# 排行榜
│ │ ├─bindings
│ │ ├─controllers
│ │ │ └─rank_controller.dart
│ │ ├─model
│ │ ├─views
│ │ │ └─rank_list.dart
│ │ └─widget
│ │   ├─ranked_cards_list.dart-----------------# 排行榜卡片
│ │   └─scroll_year_picker.dart-----------------# 滚动年份选择器
│ ├─search--------------------------------------# 搜索
│ │ ├─bindings
│ │ │ └─search_binding.dart
│ │ ├─controllers
│ │ │ └─search_controller.dart
│ │ ├─views
│ │ │ └─search.dart
│ │ └─widget
│ │   └─search_text.dart-----------------------# 搜索历史标签
│ ├─search_result-------------------------------# 搜索结果
│ │ ├─bindings
│ │ │ └─search_result_bindings.dart
│ │ ├─controllers
│ │ │ └─search_result_controllers.dart
│ │ ├─views
│ │ │ └─search_result.dart
│ │ └─widget
│ ├─settings------------------------------------# 设置
│ │ ├─bindings
│ │ ├─controllers
│ │ ├─model
│ │ ├─views
│ │ │ └─settings.dart
│ │ └─widget
│ │   ├─select_dialog.dart---------------------# 选择对话框
│ │   └─switch_item.dart-----------------------# 设置条目
│ ├─tabs----------------------------------------# 首页Tags
│ │ ├─anime------------------------------------# 动漫
│ │ │ ├─controllers
│ │ │ │ └─anime_controller.dart
│ │ │ ├─views
│ │ │ │ └─anime.dart
│ │ │ └─widget
│ │ │   ├─bangumu_card.dart-------------------# 卡片
│ │ │   └─recommendations_card.dart------------# 推荐卡片
│ │ ├─lightNovel------------------------------# 轻小说
│ │ │ ├─controllers
│ │ │ │ └─lightNovel_controller.dart
│ │ │ ├─views
│ │ │ │ └─light_novel.dart
│ │ │ └─widget
│ │ └─manga-----------------------------------# 漫画
│ │   ├─controllers
│ │   │ └─manga_controller.dart
│ │   ├─model
│ │   ├─views
│ │   │ └─manga.dart
│ │   └─widget
│ ├─user_tags-----------------------------------# 用户标签
│ │ ├─controllers
│ │ │ └─user_tags_controllers.dart
│ │ ├─views
│ │ │ └─user_tags.dart
│ │ └─widget
│ │   └─edit_popup.dart------------------------# 修改弹框
│ └─wiki----------------------------------------# 百科
│   ├─bindings
│   │ └─wiki_bindings.dart
│   ├─controllers
│   │ └─wiki_controller.dart
│   ├─views
│   │ └─wiki.dart
│   └─widget
│     ├─action_item.dart------------------------# 图标按钮
│     ├─extended_list.dart----------------------# 更多列表
│     ├─horizontal_rating.dart------------------# 水平评分描述
│     ├─info_subitem.dart-----------------------# 横向小卡片
│     ├─introduction.dart-----------------------# 封面介绍
│     ├─more_information.dart--------------------# 更多
│     ├─popup_header.dart-----------------------# 弹框头部
│     ├─ratingGraph.dart------------------------# 评分图表
│     ├─SeriesInfoPanel.dart
│     ├─subheading.dart-------------------------# 副标题
│     ├─tab_selector_horizontal.dart-------------# 水平状态选择
│     └─tag_selection.dart----------------------# 标签页选择
├─themes-----------------------------------------# 主题
│ ├─app_style
│ │ └─colors
│ │   └─app_theme_color_scheme.dart
│ ├─multiple_themes_mode
│ │ ├─material_scheme.dart----------------------# 主题工具类
│ │ ├─multiple_themes.dart----------------------# 主题表配置
│ │ ├─theme_cyan.dart---------------------------# 蓝色
│ │ ├─theme_green.dart--------------------------# 浅绿色
│ │ ├─theme_orange.dart-------------------------# 粉色
│ │ ├─theme_purple.dart-------------------------# 紫色
│ │ ├─theme_red.dart----------------------------# 红色
│ │ ├─theme_yellow.dart-------------------------# 黄色
│ │ └─theme_default.dart------------------------# 默认
│ └─app_theme.dart
├─init.dart--------------------------------------# 初始化
├─Application.dart-------------------------------# 应用配置
├─routes-----------------------------------------# 路由
│ ├─app_pages.dart
│ ├─app_routes.dart
│ └─initial_binding.dart
├─common-----------------------------------------# 通用工具类
│ ├─network-------------------------------------# 请求封装
│ │ ├─constants.dart
│ │ ├─init.dart
│ │ └─interceptor.dart
│ ├─flavors-------------------------------------# 环境配置
│ ├─Widget-------------------------------------# 通用组件
│ │ ├─badge.dart-------------------------------# 标签
│ │ ├─doubleCheckConfirmation.dart--------------# 二次返回确认
│ │ ├─empty.dart-------------------------------# 空状态
│ │ ├─entry_title.dart-------------------------# 条目标题
│ │ ├─flexible_space_bar.dart-------------------# 可变大小的顶部栏
│ │ ├─gradient_background.dart------------------# 渐变背景
│ │ ├─network_img.dart-------------------------# 图片封装
│ │ └─show_modal_bottom_detail.dart-------------# 底部弹出层
│ └─utils--------------------------------------# 通用工具类
│   ├─badge.dart-------------------------------# 标签
│   ├─date_utils.dart--------------------------# 时间计算
│   ├─empty.dart-------------------------------# 空状态
│   ├─evaluation_utils.dart---------------------# 字符串计算
│   ├─math_utils.dart---------------------------# 数学计算
│   └─network_img.dart-------------------------# 图片封装
├─http-------------------------------------------# 网络
│ ├─net
│ │ ├─constants.dart
│ │ ├─init.dart
│ │ └─interceptor.dart
│ ├─bangumi_api.dart
│ └─bangumi_net.dart
├─model------------------------------------------# 模型
│ ├─calendar------------------------------------# 追番表
│ │ └─calendar.dart
│ ├─character_list------------------------------# 角色列表
│ │ ├─character_involvement.dart----------------# 角色参与作品
│ │ └─character_list.dart
│ ├─collection.dart-----------------------------# 收藏人数
│ ├─derivation----------------------------------# 衍生
│ │ └─related_works_query.dart------------------# 相关作品
│ ├─images.dart---------------------------------# 图片集合
│ ├─infobox.dart-------------------------------# 详细信息
│ ├─pagination.dart----------------------------# 分页
│ ├─person_career------------------------------# 演员列表
│ │ └─person_career.dart
│ ├─rating.dart---------------------------------# 评分
│ ├─search-------------------------------------# 搜索
│ │ ├─query_parameters.dart--------------------# 搜索Query
│ │ ├─request_body.dart------------------------# 搜索Body
│ │ └─search.dart-----------------------------# 搜索
│ ├─stat.dart----------------------------------# 评论数量
│ ├─subjects-----------------------------------# 条目
│ │ └─subjects.dart
│ ├─tag.dart-----------------------------------# 标签
│ └─wiki_detail.dart---------------------------# 更多信息
├─assets-----------------------------------------# 本地资源
├─l10n.yaml-------------------------------------# 国际化配置文件
└─pubspec.yaml----------------------------------# 依赖管理
~~~

## 项目预览

| ![hele_app](https://t.tutu.to/img/8dq8i) | ![hele_app](https://t.tutu.to/img/8d9nJ) | ![hele_app](https://t.tutu.to/img/8dUeo) | ![hele_app](https://t.tutu.to/img/8dk1I) |
| :--------------------------------------: | :--------------------------------------: | :--------------------------------------: | :--------------------------------------: |
|                  动漫页                  |                  漫画页                  |                  资料页                  |                  资料页                  |



## 项目打包

```sh
flutter build apk --split-per-abi --obfuscate --split-debug-info=H:\Logs
```

#### 国际化重新生成
```sh
flutter gen-l10n
```

#### 数据库重新生成
```sh
dart run build_runner build
```
## 致谢
