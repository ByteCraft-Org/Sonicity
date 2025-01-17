import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify.dart';
import 'package:sonicity/src/models/models.dart';
import 'package:sonicity/src/views/todo/todo_view.dart';
import 'package:sonicity/utils/widgets/widgets.dart';

class DownloadQuality {
  static String get q12kbps => "12kbps";
  static String get q48kbps => "48kbps";
  static String get q96kbps => "96kbps";
  static String get q160kbps => "160kbps";
  static String get q320kbps => "320kbps";
}

class DownloadUrlSection extends StatelessWidget {
  final DownloadUrl downloadUrl;
  DownloadUrlSection({super.key, required this.downloadUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Column(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(() => ToDoView(text: "Donwload this song on high quality"));
                },
                icon: CircleAvatar(
                  backgroundColor: (theme.brightness == Brightness.light) ? Colors.grey.shade200 : Colors.grey.shade800,
                  radius: 40,
                  child: Iconify(Ic.twotone_cloud_download, size: 50,)
                ),
              ),
              Text(DownloadQuality.q320kbps, style: theme.textTheme.labelMedium),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(() => ToDoView(text: "Donwload this song on medium quality"));
                },
                icon: CircleAvatar(
                  backgroundColor: (theme.brightness == Brightness.light) ? Colors.grey.shade200 : Colors.grey.shade800,
                  radius: 40,
                  child: Iconify(Ic.round_download, size: 50,)
                ),
              ),
              Text(DownloadQuality.q160kbps, style: theme.textTheme.labelMedium),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(() => ToDoView(text: "Donwload this song on low quality"));
                },
                icon: CircleAvatar(
                  backgroundColor: (theme.brightness == Brightness.light) ? Colors.grey.shade200 : Colors.grey.shade800,
                  radius: 40,
                  child: Iconify(MaterialSymbols.download_rounded, size: 50,)
                ),
              ),
              Text(DownloadQuality.q96kbps, style: theme.textTheme.labelMedium),
            ],
          ),
        ],
      ),
    );
  }
}