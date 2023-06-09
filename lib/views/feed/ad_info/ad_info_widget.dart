import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_shelter_new/consts/app_assets.dart';
import 'package:pet_shelter_new/consts/app_strings.dart';
import 'package:pet_shelter_new/models/announcement_with_address.dart';
import 'package:pet_shelter_new/ui_consts/feed_ui_consts.dart';
import 'package:pet_shelter_new/ui_consts/main_ui_consts.dart';
import 'package:pet_shelter_new/views/components/custom_app_bar.dart';
import 'package:pet_shelter_new/views/components/primary_button.dart';
import 'package:routemaster/routemaster.dart';

class AdInfoWidget extends StatelessWidget {
  final AnnouncementWithAddress ad;

  const AdInfoWidget({required this.ad, Key? key}) : super(key: key);

  static const locationMarkerSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(header: ad.title, onBack: () => Routemaster.of(context).history.back()),
        Expanded(child: SingleChildScrollView(
          child: Column(
            children: [
              _buildImage(),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: MainUIConstants.verticalPadding,
                      horizontal: FeedUIConstants.horizontalPadding
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: _buildAddress(),),
                          // const Spacer(),
                          PrimaryButton(
                              label: AppStrings.viewOnMapButton,
                              onPressed: () => Routemaster.of(context).push('map')
                          )
                        ],
                      ),
                      const SizedBox(height: MainUIConstants.verticalPadding),
                      Text(ad.description, style: MainUIConstants.textStyleSize16Weight400, maxLines: 20)
                    ],
                  )
              )
            ],
          ),
        ))
      ],
    );
  }

  Widget _buildImage() {
    return AspectRatio(
        aspectRatio: 1,
        child: Image.network(
            ad.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (_, child, loadingProgress) => loadingProgress == null
                ? child
                : SvgPicture.asset(AppAssets.placeholderImage),
            errorBuilder: (context, err, _) => SvgPicture.asset(AppAssets.placeholderImage),
        )
    );
  }

  Widget _buildAddress() {
    return Row(
      children: [
        SvgPicture.asset(
            AppAssets.locationMarker,
            width: locationMarkerSize,
            height: locationMarkerSize
        ),
        Expanded(
          child: Text(
            ad.address,
            style: MainUIConstants.textStyleSize16Weight400,
            maxLines: 2,
          )
        )
      ],
    );
  }
}
