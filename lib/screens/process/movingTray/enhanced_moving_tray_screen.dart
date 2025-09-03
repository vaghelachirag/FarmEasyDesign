import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../base/utils/app_colors.dart';
import '../../../base/utils/app_decorations.dart';
import '../../../generator/assets.gen.dart';

class EnhancedMovingTrayScreen extends StatefulWidget {
  const EnhancedMovingTrayScreen({super.key});

  @override
  State<EnhancedMovingTrayScreen> createState() => _EnhancedMovingTrayScreenState();
}

class _EnhancedMovingTrayScreenState extends State<EnhancedMovingTrayScreen> {
  int currentStep = 0;
  bool isScanning = false;
  bool isScanSuccessful = false;
  bool showConfirmDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildProgressSteps(),
          Expanded(
            child: _buildMainContent(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.darkGray,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Moving Trays',
        style: TextStyle(
          color: AppColors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildProgressSteps() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStepItem(
            stepNumber: 'Step 1',
            stepTitle: 'Scan Level QR',
            icon: Icons.qr_code_scanner,
            isActive: currentStep == 0,
            isCompleted: currentStep > 0,
          ),
          _buildStepConnector(currentStep > 0),
          _buildStepItem(
            stepNumber: 'Step 2',
            stepTitle: 'Add Details',
            icon: Icons.edit,
            isActive: currentStep == 1,
            isCompleted: currentStep > 1,
          ),
          _buildStepConnector(currentStep > 1),
          _buildStepItem(
            stepNumber: 'Step 3',
            stepTitle: 'Scan Level QR',
            icon: Icons.qr_code,
            isActive: currentStep == 2,
            isCompleted: currentStep > 2,
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem({
    required String stepNumber,
    required String stepTitle,
    required IconData icon,
    required bool isActive,
    required bool isCompleted,
  }) {
    return Column(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted 
                ? AppColors.buttonBackgroundColor 
                : isActive 
                    ? AppColors.buttonBackgroundColor 
                    : AppColors.scanQrMainBg,
            border: Border.all(
              color: AppColors.buttonBackgroundColor,
              width: 2,
            ),
          ),
          child: Icon(
            isCompleted ? Icons.check : icon,
            color: isCompleted || isActive ? AppColors.white : AppColors.buttonBackgroundColor,
            size: 20.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          stepNumber,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.hintTextColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          stepTitle,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textColor,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStepConnector(bool isCompleted) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        height: 2.h,
        decoration: BoxDecoration(
          color: isCompleted ? AppColors.buttonBackgroundColor : AppColors.scanQrMainBg,
          borderRadius: BorderRadius.circular(1.r),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.scanQrMainBg,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _buildTopBar(),
            SizedBox(height: 20.h),
            _buildInstructionBanner(),
            SizedBox(height: 30.h),
            Expanded(
              child: _buildQRScannerArea(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Icon - QR Scanner
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.qr_code_scanner,
            color: AppColors.white,
            size: 18.sp,
          ),
        ),
        
        // Right Icons
        Row(
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.buttonBackgroundColor,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.flash_on,
                color: AppColors.buttonBackgroundColor,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.buttonBackgroundColor,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.more_vert,
                color: AppColors.buttonBackgroundColor,
                size: 18.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInstructionBanner() {
    String instructionText = currentStep == 0 
        ? 'Scan the level QR **from** where you want to move the trays'
        : 'Scan the level QR where you want to move the trays';
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Color(0xFFFFF8CB), // Light yellow background
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Color(0xFFFFD54F),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lightbulb_outline,
            color: Color(0xFFFF8F00),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500,
                ),
                children: currentStep == 0 ? [
                  TextSpan(text: 'Scan the level QR '),
                  TextSpan(
                    text: 'from',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: ' where you want to move the trays'),
                ] : [
                  TextSpan(text: 'Scan the level QR where you want to move the trays'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRScannerArea() {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (!isScanning && !isScanSuccessful) {
            setState(() {
              isScanning = true;
            });
          }
        },
        child: Container(
          width: 280.w,
          height: 280.w,
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Stack(
            children: [
              // Corner Decorations
              Positioned(
                top: 0,
                left: 0,
                child: SvgPicture.asset(
                  Assets.images.leftSideCornerScan.path,
                  width: 40.w,
                  height: 40.w,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: SvgPicture.asset(
                  Assets.images.iconRightTopCorner.path,
                  width: 40.w,
                  height: 40.w,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: SvgPicture.asset(
                  Assets.images.iconLeftBottomCorner.path,
                  width: 40.w,
                  height: 40.w,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: SvgPicture.asset(
                  Assets.images.iconRightBottomCorner.path,
                  width: 40.w,
                  height: 40.w,
                ),
              ),
              
              // Main Content
              Center(
                child: _buildScannerContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScannerContent() {
    if (showConfirmDetails) {
      return _buildConfirmDetailsContent();
    } else if (isScanSuccessful) {
      return _buildScanSuccessContent();
    } else if (isScanning) {
      return _buildMobileScanner();
    } else {
      return _buildTapToScanContent();
    }
  }

  Widget _buildTapToScanContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Background QR Pattern
        Opacity(
          opacity: 0.1,
          child: Icon(
            Icons.qr_code,
            size: 120.sp,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: 20.h),
        
        // Tap to Scan Text
        Text(
          'Tap to Scan',
          style: TextStyle(
            fontSize: 18.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        
        // Hand Icon
        Icon(
          Icons.touch_app,
          size: 32.sp,
          color: AppColors.white,
        ),
      ],
    );
  }

  Widget _buildMobileScanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.normal,
          facing: CameraFacing.back,
        ),
        onDetect: (BarcodeCapture barcode) {
          setState(() {
            isScanning = false;
            isScanSuccessful = true;
          });
          
          // Simulate scan success and move to next step
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              if (currentStep < 2) {
                currentStep++;
                isScanSuccessful = false;
              }
              if (currentStep == 2) {
                showConfirmDetails = true;
              }
            });
          });
        },
      ),
    );
  }

  Widget _buildScanSuccessContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
            size: 40.sp,
            color: AppColors.buttonBackgroundColor,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Scan Successful',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmDetailsContent() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          Container(
            width: 120.w,
            height: 120.w,
            child: Stack(
              children: [
                // Person holding phone
                Positioned(
                  left: 20.w,
                  child: Icon(
                    Icons.person,
                    size: 60.sp,
                    color: AppColors.white,
                  ),
                ),
                // Success popup
                Positioned(
                  right: 0,
                  child: Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          size: 24.sp,
                          color: AppColors.buttonBackgroundColor,
                        ),
                        SizedBox(height: 4.h),
                        Icon(
                          Icons.close,
                          size: 16.sp,
                          color: AppColors.hintTextColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          
          // Tray Details
          Text(
            'Moving 8 Trays:',
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          
          _buildTrayDetailRow('Tray Details:', '8 Arugula Tray | 9 Gms'),
          SizedBox(height: 12.h),
          _buildTrayDetailRow('Tray Position:', 'Zone 5 | Section 4 | Level 3', 
              buttonText: 'Old Position', buttonColor: Color(0xFFE1BEE7)),
          SizedBox(height: 12.h),
          _buildTrayDetailRow('Tray Position:', 'Zone 5 | Section 4 | Level 4', 
              buttonText: 'New Position', buttonColor: AppColors.buttonBackgroundColor),
          SizedBox(height: 12.h),
          _buildTrayDetailRow('Current Status:', 'Germination', 
              buttonText: 'Since 25/05/2025', buttonColor: Color(0xFFFFF59D)),
        ],
      ),
    );
  }

  Widget _buildTrayDetailRow(String label, String value, {String? buttonText, Color? buttonColor}) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (buttonText != null && buttonColor != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBottomButton() {
    if (currentStep == 0 && !isScanSuccessful) {
      return SizedBox.shrink();
    }

    String buttonText = '';
    IconData buttonIcon = Icons.arrow_forward;
    
    if (showConfirmDetails) {
      buttonText = 'Confirm & Save';
      buttonIcon = Icons.check;
    } else if (isScanSuccessful) {
      buttonText = 'Next';
      buttonIcon = Icons.arrow_forward;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      child: ElevatedButton(
        onPressed: () {
          if (showConfirmDetails) {
            // Handle final confirmation
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tray movement confirmed and saved!')),
            );
          } else if (isScanSuccessful) {
            setState(() {
              if (currentStep < 2) {
                currentStep++;
                isScanSuccessful = false;
              }
              if (currentStep == 2) {
                showConfirmDetails = true;
              }
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonBackgroundColor,
          foregroundColor: AppColors.white,
          minimumSize: Size(double.infinity, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(buttonIcon),
            SizedBox(width: 8.w),
            Text(
              buttonText,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

