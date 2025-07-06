import 'package:flutter/material.dart';
import 'package:smart_transportation/app/di.dart';
import 'package:smart_transportation/domain/model/models.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered_impl.dart';
import 'package:smart_transportation/presentation/dashboard/pages/dashboard_details/viewmodel/dashboard_viewmodel.dart';
import 'package:smart_transportation/presentation/dashboard/pages/organization_detail_view.dart';

import 'package:smart_transportation/presentation/dashboard/widgets/left_cut_clipper.dart';
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
  FlowState? _lastState; // Track the last state to avoid duplicate handling

  @override
  void initState() {
    super.initState();
    _viewModel.start();
    _viewModel.outputNavigateToOrganizationDetails.listen((organizationId) {
      if (organizationId != null) {
        // Use addPostFrameCallback to ensure navigation happens after build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
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
      }
    });
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
            final state = snapshot.data!;

            // Handle state navigation only if state changed
            if (_lastState != state) {
              _lastState = state;
              _handleStateNavigation(state);
            }

            // Return the screen widget WITHOUT calling dismissDialog or other state changes
            return _getScreenWidgetSafely(state);
          } else {
            return LoadingState(
              stateRendererType: StateRendererType.fullScreenLoadingState,
            ).getScreenWidget(context, Container(), () {});
          }
        },
      ),
    );
  }

  // Safe method to get screen widget without triggering state changes during build
  Widget _getScreenWidgetSafely(FlowState state) {
    // Instead of calling state.getScreenWidget() which might trigger navigation,
    // handle the state rendering manually to avoid build conflicts
    switch (state.getStateRendererType()) {
      case StateRendererType.contentState:
        return _buildDashboardContent();
      case StateRendererType.popUpLoadingState:
        return Stack(
          children: [
            _buildDashboardContent(),
            const Center(child: CircularProgressIndicator()),
          ],
        );
      case StateRendererType.fullScreenLoadingState:
        return const Center(child: CircularProgressIndicator());
      case StateRendererType.fullScreenEmptyState:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.getMessage() ?? 'No data available'),
              ElevatedButton(
                onPressed: () => _viewModel.getAllOrganizations(),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      case StateRendererType.fullScreenErrorState:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.getMessage() ?? 'An error occurred'),
              ElevatedButton(
                onPressed: () => _viewModel.getAllOrganizations(),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      default:
        return _buildDashboardContent();
    }
  }

  // Handle navigation outside of build method
  void _handleStateNavigation(FlowState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      // Handle any state-specific navigation or dialogs here
      // For example, if you need to show error dialogs:
      if (state.getStateRendererType() == StateRendererType.popUpErrorState) {
        _showErrorDialog(state.getMessage() ?? 'An error occurred');
      }
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        children: [
          _buildActiveOrganizationHeader(),
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
                  radius: 25,
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
      {'icon': Icons.group, 'label': 'Members', 'route': Routes.memberRoute},
      {
        'icon': Icons.school_outlined,
        'label': 'Students',
        'route': Routes.studentRoute
      },
      {'icon': Icons.directions_bus, 'label': 'Buses', 'route': '/buses'},
      {'icon': Icons.track_changes, 'label': 'Track Buses', 'route': '/track'},
      {'icon': Icons.more_horiz, 'label': 'Other', 'route': Routes.otherRoute},
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
          childAspectRatio: 0.5, // Increased from 0.7 to 0.8 for better proportions
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Use addPostFrameCallback for navigation to avoid build conflicts
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  Navigator.of(context)
                      .pushNamed(features[index]['route'] as String);
                }
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min, // Added to prevent overflow
              mainAxisAlignment: MainAxisAlignment.center, // Center the content
              children: [
                Flexible( // Wrap the container with Flexible
                  flex: 3, // Give more space to the icon container
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSize.s8),
                      child: Icon(
                        features[index]['icon'] as IconData,
                        color: Theme.of(context).primaryColor,
                        size: 28, // Reduced from 30 to 28 for better fit
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s4),
                Flexible( // Wrap the text with Flexible
                  flex: 1, // Give less space to the text
                  child: Text(
                    features[index]['label'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: FontSize.s8),
                    maxLines: 1, // Limit to 1 line
                    overflow: TextOverflow.ellipsis, // Handle overflow
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsCards() {
    final stats = [
      {
        'count': 500,
        'label': 'Total Members',
        'color': Colors.blue.shade200,
        'icon': Icons.group
      },
      {
        'count': 100,
        'label': 'Total Buses',
        'color': Colors.amber.shade200,
        'icon': Icons.directions_bus
      },
      {
        'count': 250,
        'label': 'Total Trips',
        'color': Colors.indigo.shade400,
        'icon': Icons.route
      },
    ];

    return Column(
      children: stats.map((stat) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          height: 90, // Increased height from 80 to 90
          child: Stack(
            children: [
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
                              height: 90, // Increased height from 80 to 90
                              width: double.infinity,
                              color: stat['color'] as Color,
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              alignment: Alignment.centerRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min, // Added this
                                children: [
                                  Text(
                                    '${stat['count']}',
                                    style: const TextStyle(
                                      fontSize: 22, // Reduced from 24 to 22
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 2), // Added small spacing
                                  Flexible( // Wrap the label text with Flexible
                                    child: Text(
                                      stat['label'] as String,
                                      style: const TextStyle(
                                        fontSize: 14, // Reduced from 16 to 14
                                        color: Colors.white,
                                      ),
                                      maxLines: 1, // Limit to 1 line
                                      overflow: TextOverflow.ellipsis, // Handle overflow
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
    // Use addPostFrameCallback to avoid conflicts with current build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

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
                      style: Theme
                          .of(context)
                          .textTheme
                          .displayMedium,
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
                    Divider(
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                    const SizedBox(height: 10),

                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.createNewOrganization);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Theme
                            .of(context)
                            .primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

                      ),

                      label: const Text("Add new Organization",style: TextStyle(fontSize: 16),),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            },
          );
        },
      );
    });
  }}