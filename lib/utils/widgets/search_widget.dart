
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify.dart';
import 'package:sonicity/src/controllers/controllers.dart';
import 'package:sonicity/src/views/navigation/navigation.dart';
import 'package:sonicity/utils/widgets/widgets.dart';

class SearchContainer extends StatelessWidget {
  final Size media;
  SearchContainer({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    return GestureDetector(
      onTap: () => Get.to(() => SearchView()),
      child: Container(
        width: media.width/1.4, height: 54,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: (theme.brightness == Brightness.light) ? Color(0xFFEAEAEA)  : Color(0xFF151515),
          border: Border.all(
            width: 2,
            color: (theme.brightness == Brightness.light) ? Colors.cyan.withOpacity(0.75) : Colors.cyanAccent.withOpacity(0.75),
          ),
          borderRadius: BorderRadius.circular(kToolbarHeight/2)
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <WidgetSpan>[
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: GlowText(
                  "S", blurRadius: 25,
                  style: GoogleFonts.audiowide(
                    fontSize: 32,letterSpacing: 10,
                    fontWeight: FontWeight.bold,
                    color: (theme.brightness == Brightness.light) ? Colors.cyan : Colors.cyanAccent,
                  )
                )
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: GlowContainer(
                  blurRadius: 25,
                  child: Iconify(
                    IconParkTwotone.search, size: 32,
                    color: (theme.brightness == Brightness.light) ? Colors.cyan : Colors.cyanAccent,
                  )
                )
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: GlowText(
                  "nicity", blurRadius: 25,
                  style: GoogleFonts.audiowide(
                    fontSize: 32, letterSpacing: 10,
                    fontWeight: FontWeight.bold,
                    color: (theme.brightness == Brightness.light) ? Colors.cyan : Colors.cyanAccent,
                  )
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final TextEditingController searchController;
  final FocusNode focusNode;
  final Function(String) onSubmitted, onChanged;
  SearchBox({super.key, required this.onSubmitted, required this.onChanged, required this.searchController, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: kToolbarHeight, alignment: Alignment.center,
      child: TextField(
        controller: searchController,
        focusNode: focusNode,
        maxLines: 1,
        maxLength: 20,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        cursorColor: Get.find<SettingsController>().getAccent,
        style: TextStyle(color: (theme.brightness == Brightness.light) ? Colors.black : Colors.white, fontWeight: FontWeight.normal),
        onTapOutside: (_) => focusNode.unfocus(),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Songs, albums or artists",
          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
          counterText: "",
          prefixIcon: BackButton(),
          suffixIcon: CloseButton(onPressed: () => searchController.clear()),
        ),
        onSubmitted: onSubmitted,
        onChanged: onChanged,
      ),
    );
  }
}