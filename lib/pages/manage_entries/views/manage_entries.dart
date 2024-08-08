import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';

class ManageEntries extends StatefulWidget {
  const ManageEntries({super.key});

  @override
  State<ManageEntries> createState() => _ManageEntriesState();
}

class _ManageEntriesState extends State<ManageEntries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [

        Gap(100.h),
        Slidable(
          key: const ValueKey(0),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            children: [
               SlidableAction(
                  onPressed: (BuildContext context){
                    print("删除");
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
            ],
          ),

          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
                SlidableAction(
                  flex: 2,
                  onPressed: (BuildContext context){
                    print("删除");
                  },
                  backgroundColor: Color(0xFF7BC043),
                  foregroundColor: Colors.white,
                  icon: Icons.archive,
                  label: 'Archive',
                ),
                SlidableAction(
                  onPressed: (BuildContext context){},
                  backgroundColor: Color(0xFF0392CF),
                  foregroundColor: Colors.white,
                  icon: Icons.save,
                  label: 'Save',
                ),
            ],
          ),
          child: const ListTile(
              title: Text('侧滑组件')),
        ),
      ]),
    );
  }
}
