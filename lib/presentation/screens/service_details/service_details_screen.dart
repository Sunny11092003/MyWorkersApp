import 'package:flutter/material.dart';
import '../../../config/routes/route_names.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import 'service_details_controller.dart';
import 'widgets/estimate_total_widget.dart';
import 'widgets/kinetic_promise_widget.dart';
import 'widgets/service_card.dart';
import 'widgets/service_experience_section.dart';
import 'widgets/service_info_row.dart';
import 'widgets/what_included_section.dart';

/// Full-page screen showing details for a single service.
///
/// Uses [ServiceDetailsController] for date/time picker state and
/// delegates each visual section to its own widget.
class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  late final ServiceDetailsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ServiceDetailsController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.detailedServiceTitle,
          style: AppTextStyles.appBarTitle,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ServiceCard(imageAssetPath: AppAssets.deepCleaning),
              const SizedBox(height: AppConstants.paddingXXL),
              const ServiceInfoRow(),
              const SizedBox(height: AppConstants.paddingHuge),
              const ServiceExperienceSection(),
              const SizedBox(height: AppConstants.paddingHuge),
              const WhatIncludedSection(),
              const SizedBox(height: AppConstants.paddingHuge),
              const KineticPromiseWidget(),
              const SizedBox(height: AppConstants.paddingHuge),
              _buildSelectDateButton(),
              const SizedBox(height: AppConstants.paddingL),
              const EstimateTotalWidget(),
              const SizedBox(height: AppConstants.paddingHuge),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectDateButton() {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _controller.isLoading
                ? null
                : () => _controller.selectDateAndTime(context, () {
                      Navigator.pushNamed(context, RouteNames.booking);
                    }),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(
                vertical: AppConstants.paddingL,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusXL),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.detailedSelectDate,
                  style: AppTextStyles.button,
                ),
                const SizedBox(width: AppConstants.paddingS),
                const Icon(
                  Icons.arrow_forward,
                  color: AppColors.white,
                  size: AppConstants.iconM,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
