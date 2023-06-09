import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:pet_shelter_new/consts/app_assets.dart';
import 'package:pet_shelter_new/consts/app_colors.dart';
import 'package:pet_shelter_new/consts/app_strings.dart';
import 'package:pet_shelter_new/repositories/local_storage/local_storage.dart';
import 'package:pet_shelter_new/services/network_service.dart';
import 'package:pet_shelter_new/states/auth/sing_in_state.dart';
import 'package:pet_shelter_new/states/auth/sing_up_state.dart';
import 'package:pet_shelter_new/ui_consts/auth_ui_consts.dart';
import 'package:pet_shelter_new/ui_consts/main_ui_consts.dart';
import 'package:pet_shelter_new/views/auth/sign_in/sing_in_container_widget.dart';
import 'package:pet_shelter_new/views/auth/sign_up/sing_up_container_widget.dart';
import 'package:pet_shelter_new/views/components/secondary_button.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: screenWidth * AuthUIConstants.verticalPaddingCof,
          horizontal: screenWidth * MainUIConstants.horizontalPaddingCof
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogoView(screenWidth * AuthUIConstants.logoWithCof),
            SizedBox(height: screenWidth * AuthUIConstants.tabBarTopPaddingCof),
            _buildTabBar(screenWidth),
            SizedBox(height: screenWidth * AuthUIConstants.tabBarBottomPaddingCof),
            _buildTabView(screenWidth),
            _buildLoginLaterButton()
          ]
        )
      )
    );
  }

  Widget _buildLogoView(double width) {
    return SvgPicture.asset(AppAssets.appLogo, width: width);
  }

  Widget _buildTabBar(double screenWidth) {
    return Container(
      height: screenWidth * AuthUIConstants.tabBarHeightCof,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: AppColors.primary,
                  width: AuthUIConstants.inactiveIndicatorHeight
              )
          )
      ),
      child: TabBar(
        controller: _tabController,
        indicator: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: AppColors.primary,
                  width: AuthUIConstants.activeIndicatorHeight
              )
          ),
        ),
        labelColor: AppColors.black,
        unselectedLabelColor: AppColors.black,
        labelStyle: MainUIConstants.textStyleSize16Weight700,
        tabs: const [
          Tab(text: AppStrings.signInTab),
          Tab(text: AppStrings.signUpTab),
        ],
      ),
    );
  }

  Widget _buildTabView(double screenWidth) {
    final networkService = GetIt.instance.get<NetworkService>();
    final localStorage = GetIt.instance.get<LocalStorage>();
    return Expanded(
        child: MultiProvider(
          providers: [
            Provider<SignInState>(create: (_) => SignInState(networkService: networkService, localStorage: localStorage)),
            Provider<SignUpState>(create: (_) => SignUpState(networkService: networkService, localStorage: localStorage)),
          ],
          child: TabBarView(
            clipBehavior: Clip.none,
            controller: _tabController,
            children: [
              _buildSignInView(),
              _buildSignUpView()
            ],
          ),
        )
    );
  }

  Widget _buildSignInView() {
    return const SingleChildScrollView(
        child: SignInContainerWidget()
    );
  }

  Widget _buildSignUpView() {
    return const SingleChildScrollView(
        child: SignUpContainerWidget()
    );
  }

  Widget _buildLoginLaterButton() {
    return SecondaryButton(
        label: AppStrings.logInLaterButton,
        icon: AppAssets.arrowForwardIcon,
        iconLeading: false,
        onPressed: () => Routemaster.of(context).replace('/guest')
    );
  }

  // Widget _buildForgotPasswordButton() {
  //   return SecondaryButton(label: AppStrings.forgotPassword, onPressed: () {});
  // }
}
