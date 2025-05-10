import 'package:flutter/material.dart';
import 'package:smart_transportation/app/di.dart';
import 'package:smart_transportation/domain/model/models.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered_impl.dart';
import 'package:smart_transportation/presentation/dashboard/pages/dashboard_details/viewmodel/dashboard_viewmodel.dart';
import 'package:smart_transportation/presentation/dashboard/pages/organization_detail_view.dart';

import 'package:smart_transportation/presentation/dashboard/widgets/left_cut_clipper.dart';
import 'package:smart_transportation/presentation/on_boarding_organizer/pages/organization_details_view.dart';
import 'package:smart_transportation/presentation/resources/asset_manager.dart';
import 'package:smart_transportation/presentation/resources/route_manager.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart';
import 'package:smart_transportation/presentation/resources/color_manager.dart';
import 'package:smart_transportation/presentation/resources/values_manager.dart';

import '../../../../resources/font_manager.dart';



class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final DashboardViewModel _viewModel = instance<DashboardViewModel>();

  @override
  void initState() {
    _viewModel.start();
    _viewModel.outputNavigateToOrganizationDetails.listen((organizationId) {
      if (organizationId != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OrganizationDetailView(organizationId: organizationId),
          ),
        ).then((_) {
          _viewModel.navigationController.sink.add(null);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.getScreenWidget(
              context,
              _buildDashboardContent(),
              () => _viewModel.getAllOrganizations(),
            );
          } else {
            return LoadingState(
              stateRendererType: StateRendererType.fullScreenLoadingState,
            ).getScreenWidget(context, Container(), () {});
          }
        },
      ),
    );
  }

  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        children: [
          Center(
            child: SizedBox(
              height: AppHeight.h150,
              width: AppHeight.h150,
              child: Image.asset(
                ImageAssets.logoIco,
              ),
            ),
          ),
          _buildActiveOrganizationHeader(),
          const SizedBox(height: AppMargin.m20),
          _buildFeatureButtons(),
          Divider(
            color: ColorManager.grey,
            thickness: AppSize.s0_3,
          ),
          const SizedBox(height: AppMargin.m20),

          _buildStatsCards(),
        ],
      ),
    );
  }

  Widget _buildActiveOrganizationHeader() {
    return StreamBuilder<OrganizationItem?>(
      stream: _viewModel.outputFirstOrganization,
      builder: (context, snapshot) {
        final organization = snapshot.data;
        return InkWell(
          onTap: () => _showSwitchOrganizationSheet(),
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p12),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s20)),
              color: ColorManager.white,
              boxShadow: const [
                BoxShadow(
                  color: ColorManager.black12,
                  blurRadius: 6,
                  offset: Offset(0, 10),
                )
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: (organization?.image != null &&
                          organization!.image.isNotEmpty)
                      ? NetworkImage(organization.fullImageUrl)
                      : const AssetImage(ImageAssets.onboardingLogo1)
                          as ImageProvider,
                  radius: 25, // Increased radius
                ),
                const SizedBox(width: AppSize.s10),
                Expanded(
                  child: Text(
                    organization?.name ?? AppStrings.noOrganizationsAvailable,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: ColorManager.primary,
                  size: AppSize.s32,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureButtons() {
    final features = [
      {'icon': Icons.group, 'label': 'Members', 'route': '/members'},
      {
        'icon': Icons.notifications_active,
        'label': 'Send  Notifications',
        'route': '/notifications'
      },
      {'icon': Icons.directions_bus, 'label': 'Buses', 'route': '/buses'},
      {'icon': Icons.track_changes, 'label': 'Track Buses', 'route': '/track'},
      {'icon': Icons.more_horiz, 'label': 'Other', 'route': '/createDriverRoute'},
    ];
    return Container(
      padding: const EdgeInsets.all(AppSize.s10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: features.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: AppSize.s10,
          crossAxisSpacing: AppSize.s10,
          childAspectRatio: 0.7, // Adjust as needed
        ),
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(features[index]['route'] as String);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // White background
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      // Add a border
                      color: Theme.of(context)
                          .primaryColor, // Primary color border
                      width: 1, // Border width
                    ),
                  ),
                  child: Padding(
                    // Added padding inside the container
                    padding: const EdgeInsets.all(AppSize.s8),
                    child: Icon(
                      features[index]['icon'] as IconData,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s4),
              Text(
                features[index]['label'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: FontSize.s12),
              ),
            ],
          );
        },
      ),
    );
  }


  Widget _buildStatsCards() {
    final stats = [
      {'count': 500, 'label': 'Total Members', 'color': Colors.blue.shade200, 'icon': Icons.group},
      {'count': 100, 'label': 'Total Buses', 'color': Colors.amber.shade200, 'icon': Icons.directions_bus},
      {'count': 250, 'label': 'Total Trips', 'color': Colors.indigo.shade400, 'icon': Icons.route},
    ];

    return Column(
      children: stats.map((stat) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          height: 80,
          child: Stack(
            children: [
              // Background with the clipped shape on the right
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: stat['color'] as Color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      stat['icon'] as IconData,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: ClipPath(
                            clipper: LeftCutClipper(),
                            child: Container(
                              height: 80,
                              width: double.infinity,
                              color: stat['color'] as Color,
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              alignment: Alignment.centerRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${stat['count']}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    stat['label'] as String,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }




void _showSwitchOrganizationSheet() {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) {
      return StreamBuilder<List<OrganizationItem>>(
        stream: _viewModel.outputAllOrganizations,
        builder: (context, snapshot) {
          final organizations = snapshot.data ?? [];

          return Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Switch Organization",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: AppSize.s16),
                ...organizations.map((org) {
                  return ListTile(
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(org.fullImageUrl)),
                    title: Text(org.name),
                    onTap: () {
                      Navigator.pop(context);
                      _viewModel.activateOrganization(org.id);
                    },
                  );
                }).toList(),
                const Divider(),
                TextButton.icon(
                  onPressed: () {
                   Navigator.pushNamed(context, Routes.createNewOrganization);

                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add new Organization"),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
}