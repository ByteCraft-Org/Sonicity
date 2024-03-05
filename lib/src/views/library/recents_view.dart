// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/icons/ic.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:sonicity/src/controllers/recents_controller.dart';
import 'package:sonicity/src/controllers/settings_controller.dart';
import 'package:sonicity/src/models/album.dart';
import 'package:sonicity/src/models/artist.dart';
import 'package:sonicity/src/models/playlist.dart';
import 'package:sonicity/src/models/song.dart';
import 'package:sonicity/utils/contants/enums.dart';
import 'package:sonicity/utils/widgets/album_widget.dart';
import 'package:sonicity/utils/widgets/artist_widget.dart';
import 'package:sonicity/utils/widgets/iconify.dart';
import 'package:sonicity/utils/widgets/playlist_widget.dart';
import 'package:sonicity/utils/widgets/pop_up_buttons.dart';
import 'package:sonicity/utils/widgets/report_widget.dart';
import 'package:sonicity/utils/widgets/song_widget.dart';
import 'package:sonicity/utils/widgets/style_widget.dart';

class RecentsView extends StatelessWidget {
  RecentsView({super.key});

  final controller = Get.find<RecentsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradientDecorator(
        child: CustomScrollView(
          slivers: [
            _appbar(context),
            SliverPersistentHeader(pinned: true, delegate: _SongsPlayControls(controller)),
            _body()
          ],
        )
      ),
      floatingActionButton: CircleAvatar(radius: 25, backgroundColor: Colors.red, child: SpiderReport()),
    );
  }

  SliverAppBar _appbar(BuildContext context) {
    return SliverAppBar(
      pinned: true, shadowColor: Colors.transparent,
      title: Text("Recents"),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) {
            if(controller.selectedTab.value == 0) {
              return [
                PopupMenuItem(
                  onTap: () => controller.sortSongs(SortType.name, Sort.asc),
                  child: PopUpButtonRow(icon: Mdi.sort_alphabetical_ascending, label: "Name Asc")
                ),
                PopupMenuItem(
                  onTap: () => controller.sortSongs(SortType.name, Sort.dsc),
                  child: PopUpButtonRow(icon: Mdi.sort_alphabetical_descending, label: "Name Desc")
                ),
                PopupMenuItem(
                  onTap: () => controller.sortSongs(SortType.duration, Sort.asc),
                  child: PopUpButtonRow(icon: Mdi.sort_numeric_ascending, label: "Duration Asc")
                ),
                PopupMenuItem(
                  onTap: () => controller.sortSongs(SortType.duration, Sort.dsc),
                  child: PopUpButtonRow(icon: Mdi.sort_numeric_descending, label: "Duration Desc")
                ),
                PopupMenuItem(
                  onTap: () => controller.sortSongs(SortType.year, Sort.asc),
                  child: PopUpButtonRow(icon: Mdi.sort_calendar_ascending, label: "Year Asc")
                ),
                PopupMenuItem(
                  onTap: () => controller.sortSongs(SortType.year, Sort.dsc),
                  child: PopUpButtonRow(icon: Mdi.sort_calendar_descending, label: "Year Desc")
                ),
              ];
            } else if(controller.selectedTab.value == 1) {
              return [
                PopupMenuItem(
                  onTap: () => controller.sortAlbums(SortType.name, Sort.asc),
                  child: PopUpButtonRow(icon: Mdi.sort_alphabetical_ascending, label: "Name Asc")
                ),
                PopupMenuItem(
                  onTap: () => controller.sortAlbums(SortType.name, Sort.dsc),
                  child: PopUpButtonRow(icon: Mdi.sort_alphabetical_descending, label: "Name Desc")
                ),
                PopupMenuItem(
                  onTap: () => controller.sortAlbums(SortType.duration, Sort.asc),
                  child: PopUpButtonRow(icon: Mdi.sort_numeric_ascending, label: "Song Count Asc")
                ),
                PopupMenuItem(
                  onTap: () => controller.sortAlbums(SortType.duration, Sort.dsc),
                  child: PopUpButtonRow(icon: Mdi.sort_numeric_descending, label: "Song Count Desc")
                ),
              ];
            } else if(controller.selectedTab.value == 2) {
              return <PopupMenuItem>[
                PopupMenuItem(
                  onTap: () => controller.sortArtists(SortType.name, Sort.asc),
                  child: PopUpButtonRow(icon: Mdi.sort_alphabetical_ascending, label: "Name Asc")
                ),
                PopupMenuItem(
                  onTap: () => controller.sortArtists(SortType.name, Sort.dsc),
                  child: PopUpButtonRow(icon: Mdi.sort_alphabetical_descending, label: "Name Desc")
                ),
                PopupMenuItem(
                  onTap: () => controller.sortArtists(SortType.duration, Sort.asc),
                  child: PopUpButtonRow(icon: Mdi.sort_numeric_ascending, label: "Type Asc")
                ),
                PopupMenuItem(
                  onTap: () => controller.sortArtists(SortType.duration, Sort.dsc),
                  child: PopUpButtonRow(icon: Mdi.sort_numeric_descending, label: "Type Desc")
                ),
              ];
            } else {
              return [
                PopupMenuItem(
                  onTap: () => controller.sortPlaylists(SortType.name, Sort.asc),
                  child: PopUpButtonRow(icon: Mdi.sort_alphabetical_ascending, label: "Name Asc")
                ),
                PopupMenuItem(
                  onTap: () => controller.sortPlaylists(SortType.name, Sort.dsc),
                  child: PopUpButtonRow(icon: Mdi.sort_alphabetical_descending, label: "Name Desc")
                ),
                PopupMenuItem(
                  onTap: () => controller.sortPlaylists(SortType.duration, Sort.asc),
                  child: PopUpButtonRow(icon: Mdi.sort_numeric_ascending, label: "Song Count Asc")
                ),
                PopupMenuItem(
                  onTap: () => controller.sortPlaylists(SortType.duration, Sort.dsc),
                  child: PopUpButtonRow(icon: Mdi.sort_numeric_descending, label: "Song Count Desc")
                ),
              ];
            }
          },
          icon: Iconify(MaterialSymbols.sort_rounded,),
          position: PopupMenuPosition.under,
          color: (Theme.of(context).brightness == Brightness.light) ? Colors.grey.shade100 : Colors.grey.shade900,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ],
      bottom: TabBar(
        controller: controller.tabController,
        labelColor: (Theme.of(context).brightness == Brightness.light) ? Colors.black : Colors.white,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Get.find<SettingsController>().getAccent, dividerColor: Get.find<SettingsController>().getAccentDark,
        tabs: [Tab(text: "Songs"), Tab(text: "Albums"), Tab(text: "Artists") , Tab(text: "Playlists")],
      ),
    );
  }

  SliverFillRemaining _body() {
    return SliverFillRemaining(
      child: TabBarView(
        controller: controller.tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Obx(() => ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            itemCount: controller.recentSongs.length,
            itemBuilder: (context, index) {
              Song song = controller.recentSongs[controller.recentSongs.length - index - 1];
              return SongsTile(song);
            },
          )),
          Obx(() => ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            itemCount: controller.recentAlbums.length,
            itemBuilder: (context, index) {
              Album album = controller.recentAlbums[controller.recentAlbums.length - index - 1];
              return AlbumTile(album, subtitle: "${album.songCount} Songs");
            },
          )),
          Obx(() => ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            itemCount: controller.recentArtists.length,
            itemBuilder: (context, index) {
              Artist artist = controller.recentArtists[controller.recentArtists.length - index - 1];
              return ArtistTile(artist: artist, subtitle: "${artist.dominantType}");
            },
          )),
          Obx(() => ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            itemCount: controller.recentPlaylists.length,
            itemBuilder: (context, index) {
              Playlist playlist = controller.recentPlaylists[controller.recentPlaylists.length - index - 1];
              return PlaylistTile(playlist, subtitle: "${playlist.songCount} Songs");
            },
          )),
        ],
      ),
    );
  }
}

class _SongsPlayControls extends SliverPersistentHeaderDelegate {
  final RecentsController controller;
  _SongsPlayControls(this.controller);

  @override
  double get minExtent => kToolbarHeight;

  @override
  double get maxExtent => kToolbarHeight;

  final lengths = "".obs;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Obx(() {
      if(controller.selectedTab.value == 0) {
        lengths.value = "${controller.recentSongs.length} Songs";
      } else if(controller.selectedTab.value == 1) {
        lengths.value = "${controller.recentAlbums.length} Albums";
      }else if(controller.selectedTab.value == 2) {
        lengths.value = "${controller.recentArtists.length} Artists";
      } else {
        lengths.value = "${controller.recentPlaylists.length} Playlists";
      }
      return Container(
        height: kToolbarHeight,
        decoration: BoxDecoration(
          color: (Theme.of(context).brightness == Brightness.light) ? Colors.grey.shade200 : Colors.grey.shade800,
          boxShadow: [BoxShadow(
            color: (Theme.of(context).brightness == Brightness.light) ? Colors.black : Colors.white,
            spreadRadius: 1, blurRadius: 5
          )]
        ),
        child: Row(
          children: [
            Gap(20),
            Text(lengths.value, style: Theme.of(context).textTheme.bodyLarge),
            Spacer(),
            if(controller.selectedTab.value == 0)
              Container(
                height: kBottomNavigationBarHeight, alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Shuffle",
                          style: TextStyle(color: Colors.grey.shade300, fontSize: 21),
                        ),
                        Iconify(
                          Ic.twotone_shuffle, size: 25,
                          color: (Theme.of(context).brightness == Brightness.light) ? Colors.grey.shade700 : Colors.grey.shade300,),
                      ],
                    ),
                    Gap(5),
                    Container(height: 30, width: 1, color: Colors.white38),
                    Gap(5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Iconify(
                        Ic.twotone_play_arrow, size: 27,
                        color: (Theme.of(context).brightness == Brightness.light) ? Colors.grey.shade700 : Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),
              ),
            Gap(8)
          ],
        ),
      );
    });
  }

  @override
  bool shouldRebuild(_SongsPlayControls oldDelegate) {
    return false;
  }
}