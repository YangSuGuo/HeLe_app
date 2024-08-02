import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hele_app/pages/my/model/list_tile.dart';

class My extends StatefulWidget {
  const My({super.key});

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(toolbarHeight: 30),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ListTile(
            leading: null,
            title: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                '媒体库',
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.secondary),
              ),
            ),
          ),
          for (var i in listTile) ...[
            ListTile(
              onTap: () => i['onTap'](),
              dense: true,
              leading: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                      width: 45.sp,
                      child: Center(
                        child: FaIcon(
                          i['icon'],
                          size: 40.sp,
                          color: colorScheme.primary,
                        ),
                      ))),
              contentPadding: const EdgeInsets.only(left: 15, top: 2, bottom: 2),
              minLeadingWidth: 0,
              title: Text(
                i['title'],
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Divider(
                color: colorScheme.primary,
              )),
          for (var i in listTile2) ...[
            ListTile(
              onTap: () => i['onTap'](),
              dense: true,
              leading: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                      width: 45.sp,
                      child: Center(
                        child: FaIcon(
                          i['icon'],
                          size: 40.sp,
                          color: colorScheme.primary,
                        ),
                      ))),
              contentPadding: const EdgeInsets.only(left: 15, top: 2, bottom: 2),
              minLeadingWidth: 0,
              title: Text(
                i['title'],
                style: TextStyle(fontSize: 15, color: colorScheme.secondary),
              ),
            ),
          ],
        ],
      )),
    );
  }
}
