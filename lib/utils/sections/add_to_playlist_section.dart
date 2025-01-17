import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify.dart';
import 'package:lottie/lottie.dart';
import 'package:sonicity/src/controllers/controllers.dart';
import 'package:sonicity/src/models/models.dart';
import 'package:sonicity/utils/contants/constants.dart';
import 'package:sonicity/utils/widgets/widgets.dart';

class AddToPlaylistDialog extends StatelessWidget {
  final Song song;
  AddToPlaylistDialog(this.song, {super.key});

  final settings = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Material(
            elevation: 5, borderRadius: BorderRadius.circular(12),
            shadowColor: (theme.brightness == Brightness.light) ? Colors.black : Colors.white,
            color: (theme.brightness == Brightness.light) ? Colors.white : Colors.black,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackgroundGradientDecorator(
                height: 80,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: song.image.medQuality,
                        height: 50, width: 50, fit: BoxFit.fill,
                        errorWidget: (_,__,___) {
                          return Image.asset(
                            "assets/images/songCover/songCover150x150.jpg",
                            fit: BoxFit.fill, width: 50, height: 50
                          );
                        },
                        placeholder: (_,__) {
                          return Image.asset(
                            "assets/images/songCover/songCover150x150.jpg",
                            fit: BoxFit.fill, width: 50, height: 50
                          );
                        },
                      ),
                    ),
                    title: Text(song.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodyLarge,),
                    subtitle: Text(song.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodySmall,),
                  ),
                )
              ),
            ),
          ),
        ),
        Gap(10),
        Container(
          width: double.maxFinite, padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (theme.brightness == Brightness.light) ? Colors.grey.shade100 : Colors.grey.shade900,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: (theme.brightness == Brightness.light) ? Colors.black : Colors.white, width: 0.5),
          ),
          child: GetBuilder(
            global: false,
            init: MyPlaylistController(song),
            builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(context, theme, controller: controller),
                  Gap(10),
                  _body(theme, controller),
                  Gap(10),
                  if(controller.playlists.isNotEmpty) _footer(context, controller, theme)
                ],
              );
            }
          ),
        ),
      ],
    );
  }

  Column _header(BuildContext context, ThemeData theme, {required MyPlaylistController controller,}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text("Add to Playlist", style: theme.appBarTheme.titleTextStyle!.copyWith(fontWeight: FontWeight.w300)),
            Spacer(),
            Tooltip(
              message: "New playlist",
              child: CircleAvatar(
                radius: 22, backgroundColor: Colors.transparent,
                child: InkWell(
                  onTap: () => showDialog(
                    context: context, barrierDismissible: true, useRootNavigator: true,
                    builder: (ctx) => NewPlaylistDialog(controller),
                  ),
                  borderRadius: BorderRadius.circular(50),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Iconify(Ic.twotone_playlist_add_circle, size: 30,),
                  ),
                ),
              ),
            ),
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () => controller.sort(SortType.name, Sort.asc),
                    child: PopUpButtonRow(icon: Mdi.sort_alphabetical_ascending, label: "Name Asc")
                  ),
                  PopupMenuItem(
                    onTap: () => controller.sort(SortType.name, Sort.dsc),
                    child: PopUpButtonRow(icon: Mdi.sort_alphabetical_descending, label: "Name Desc")
                  ),
                  PopupMenuItem(
                    onTap: () => controller.sort(SortType.songCount, Sort.asc),
                    child: PopUpButtonRow(icon: Mdi.sort_numeric_ascending, label: "Song Count Asc")
                  ),
                  PopupMenuItem(
                    onTap: () => controller.sort(SortType.songCount, Sort.dsc),
                    child: PopUpButtonRow(icon: Mdi.sort_numeric_descending, label: "Song Count Desc")
                  ),
                  PopupMenuItem(
                    onTap: () => controller.sort(SortType.date, Sort.asc),
                    child: PopUpButtonRow(icon: Mdi.sort_calendar_ascending, label: "Date Created Asc")
                  ),
                  PopupMenuItem(
                    onTap: () => controller.sort(SortType.date, Sort.dsc),
                    child: PopUpButtonRow(icon: Mdi.sort_calendar_descending, label: "Date Created Desc")
                  ),
                ];
              },
              icon: Iconify(MaterialSymbols.sort_rounded, color: theme.appBarTheme.actionsIconTheme!.color),
              position: PopupMenuPosition.under, color: Colors.grey.shade900,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 2),
          child: TextField(
            controller: controller.searchPlaylistController,
            focusNode: controller.searchPlaylistFocus,
            decoration: InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide(color: settings.getAccent, width: 3)),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 3)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: settings.getAccent, width: 1)),
              hintText: "\tSearch Playlist",
              hintStyle: theme.textTheme.titleSmall,
              prefixIcon: Iconify(
                Ri.search_line,
                color: (theme.brightness == Brightness.light) ? Colors.grey.shade600 : Colors.grey.shade400,
              ),
              prefixIconConstraints: BoxConstraints.loose(Size(40,30)),
              suffixIcon: CloseButton(onPressed: () {
                controller.searchPlaylistController.text = '';
                controller.filterSearchedPlaylists();
              },)
            ),
            onChanged: (query) => controller.filterSearchedPlaylists(),
            onTapOutside: (event) => controller.searchPlaylistFocus.unfocus(),
          ),
        )
      ],
    );
  }

  _body(ThemeData theme, MyPlaylistController controller) {
    return Obx(() {
      if(controller.playlistCount.value == -1) return Lottie.asset("assets/lottie/gramophone2.json", animate: true, height: 40);
      if(controller.playlistCount.value != 0 && controller.playlists.isEmpty && controller.isSongPresent.isEmpty)
        return Lottie.asset("assets/lottie/gramophone1.json", animate: true, height: 40);
      return ListView.builder(
        shrinkWrap: true,
        itemCount: (controller.searching.value) ? controller.searchResults.length : controller.playlists.length,
        itemBuilder: (context, index) {
          return MyPlaylistAddSongTile(index: index, controller: controller,);
        },
      );
    });
  }

  _footer(BuildContext context, MyPlaylistController controller, ThemeData theme) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: settings.getAccent,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Text("Done", style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal)),
      ),
    );
  }
}