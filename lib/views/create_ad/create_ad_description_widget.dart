import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pet_shelter_new/consts/app_colors.dart';
import 'package:pet_shelter_new/consts/app_strings.dart';
import 'package:pet_shelter_new/models/pet_type.dart';
import 'package:pet_shelter_new/states/app_state/app_state.dart';
import 'package:pet_shelter_new/states/create_ad/create_ad_state.dart';
import 'package:pet_shelter_new/ui_consts/create_ad_ui_consts.dart';
import 'package:pet_shelter_new/ui_consts/main_ui_consts.dart';
import 'package:pet_shelter_new/views/components/custom_app_bar.dart';
import 'package:pet_shelter_new/views/components/custom_form_field.dart';
import 'package:pet_shelter_new/views/components/primary_button.dart';
import 'package:pet_shelter_new/views/components/top_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

import '../components/loading_widget.dart';

class CreateAdDescriptionWidget extends StatelessWidget {

  final CreateAdState state;

  const CreateAdDescriptionWidget({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
        children: [
          CustomAppBar(
              header: AppStrings.petDescriptionHeader,
              onBack: () => state.selectScreen(CreateAdScreen.specifyAddress)
          ),
          Expanded(child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: screenSize.height * 0.75),
              child: Observer(
                builder: (_) => state.inProgress ? const LoadingWidget() : _buildContent(context),
              ),
            ),
          ))
        ]
    );
  }

  Widget _buildContent(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MainUIConstants.verticalPadding,
        horizontal: screenSize.width * MainUIConstants.horizontalPaddingCof
      ),
      child: Column(
        children: [
          _buildPetTypeSelectors(screenSize),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: MainUIConstants.formFieldVerticalSpacing),
              child: _buildTitleTextField()
          ),
          Expanded(child: _buildDescriptionTextField()),
          const Spacer(),
          _buildCreateButton(context)
        ],
      ),
    );
  }

  Widget _buildTitleTextField() {
    return CustomFormField(
      value: state.title,
      labelText: AppStrings.adTitleHint,
      onChanged: (value) => state.onTitleChanged(value),
      errorText: state.titleError,
    );
  }

  Widget _buildDescriptionTextField() {
    return CustomFormField(
      value: state.description,
      labelText: AppStrings.petDescriptionHint,
      onChanged: (value) => state.onDescriptionChanged(value),
      errorText: state.descriptionError,
      maxLines: 10,
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    final AppState appState = Provider.of<AppState>(context);
    // final FeedState feedState = Provider.of<FeedState>(context, listen: false);
    return PrimaryButton(
        label: AppStrings.createAdButton,
        onPressed: () => state.createAd(
            (announcement) async {
              showOverlay((context, t) {
                return const TopSnackBar(text: AppStrings.createAdSuccessAlert);
              });
              Routemaster.of(context).replace('/feed');
              // await feedState.onSelectedAnnouncementWithoutAddress(announcement, () {});
            },
            () {
              showOverlay((context, t) {
                return const TopSnackBar(text: AppStrings.createAdErrorAlert, isError: true);
              });
            },
            appState.logout
        )
    );
  }

  Widget _buildPetTypeSelectors(Size screenSize) {
    final selectorsCount = PetType.values.length;
    final selectors = List.generate(selectorsCount, (index) =>
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 0 : CreateAdUIConstants.petTypeSelectorsSpacing / 2,
            right: index == selectorsCount - 1 ? 0 : CreateAdUIConstants.petTypeSelectorsSpacing / 2,
          ),
          child: GestureDetector(
            onTap: () => state.selectPetType(PetType.values[index]),
            child: Observer(
              builder: (_) => _buildPetTypeItem(
                  PetType.values[index],
                  state.petType == PetType.values[index],
                  screenSize
              ),
            ),
          )
        )
      )
    );
    return Row(children: selectors);
  }

  Widget _buildPetTypeItem(PetType petType, bool selected, Size screenSize) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
            color: selected ? AppColors.accent : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, spreadRadius: 2)]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
                petType.getIconName(),
                color: selected ? Colors.white : AppColors.primary,
                width: screenSize.width * 0.16
            ),
            Text(
              petType.getDisplayName(),
              style: MainUIConstants.textStyleSize14Weight600
                  .copyWith(color: selected ? Colors.white : AppColors.primary)
            )
          ],
        ),
      ),
    );
  }
}
