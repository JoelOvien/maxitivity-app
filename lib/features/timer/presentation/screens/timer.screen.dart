import 'package:ambeego_test/core/utils/app_module.dart';
import 'package:ambeego_test/core/utils/helpers.dart';
import 'package:ambeego_test/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:ambeego_test/utilities/colors.dart';
import 'package:ambeego_test/utilities/snack_bar_util.dart';
import 'package:ambeego_test/utilities/spacing_util.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerScreen extends StatefulHookWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final countDownController = CountDownController();

  @override
  Widget build(BuildContext context) {
    final startDateTime = useState<DateTime?>(null);
    final endDateTime = useState<DateTime?>(null);
    final isTimerPaused = useState<bool>(true);
    final timerBloc = BlocProvider.of<TimerBloc>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: const [
          CircleAvatar(
            child: Icon(Icons.person_outline),
          ),
          XMargin(20),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Welcome,",
              style: GoogleFonts.familjenGrotesk(
                fontSize: 12,
                color: AppColors.neutralBodyText,
              ),
            ),
            Text(
              module.fullname ?? 'User',
              style: GoogleFonts.familjenGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: BlocConsumer<TimerBloc, TimerState>(
        bloc: timerBloc,
        listener: (context, state) {
          if (state is CreateFocusHistoryEntryError) {
            SnackbarUtil.showErrorSnack(context, state.error);
          }

          if (state is CreateFocusHistoryEntrySuccess) {
            SnackbarUtil.showSnack(context, 'Focus Time Entry created successfully');
          }
        },
        builder: (context, state) {
          if (state is CreateFocusHistoryEntryLoading) {
            return Center(
              child: Helper.getProgressLoader(color: AppColors.brandBlue500),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const YMargin(20),
                Center(
                  child: Text(
                    "Focus",
                    style: GoogleFonts.familjenGrotesk(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const YMargin(40),

                Center(
                  child: Text(
                    "Start Timer",
                    style: GoogleFonts.familjenGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                const YMargin(24),

                ///Timer
                CircularCountDownTimer(
                  duration: 60,
                  initialDuration: 0,
                  controller: countDownController,
                  width: 180,
                  height: 180,
                  ringColor: AppColors.brandBlue500.withOpacity(0.10),
                  ringGradient: null,
                  fillColor: AppColors.brandBlue500,
                  fillGradient: null,
                  backgroundColor: AppColors.brandWhite,
                  backgroundGradient: null,
                  strokeWidth: 15.0,
                  strokeCap: StrokeCap.round,
                  textStyle: GoogleFonts.familjenGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textFormat: CountdownTextFormat.HH_MM_SS,
                  isReverse: true,
                  isReverseAnimation: false,
                  isTimerTextShown: true,
                  autoStart: false,
                  onStart: () {
                    startDateTime.value = DateTime.now();
                  },
                  onComplete: () {
                    endDateTime.value = DateTime.now();
                    final data = {
                      "start_time": startDateTime.value.toString(),
                      "end_time": endDateTime.value.toString(),
                      "email": module.email,
                    };
                    timerBloc.add(CreateFocusHistoryEntryEvent(data: data));
                  },
                  timeFormatterFunction: (defaultFormatterFunction, duration) {
                    if (duration.inSeconds == 0) {
                      return "Start";
                    } else {
                      return Function.apply(defaultFormatterFunction, [duration]);
                    }
                  },
                ),
                const YMargin(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isTimerPaused.value)
                      ActionButtonWidget(
                        action: () {
                          HapticFeedback.lightImpact();
                          if (countDownController.isPaused) {
                            countDownController.resume();
                          } else {
                            countDownController.start();
                          }
                          isTimerPaused.value = false;
                        },
                        icon: Icons.play_arrow,
                      )
                    else
                      ActionButtonWidget(
                        action: () {
                          HapticFeedback.lightImpact();
                          countDownController.pause();
                          isTimerPaused.value = true;
                        },
                        icon: Icons.pause,
                      ),
                    const XMargin(10),
                    ActionButtonWidget(
                      action: () {
                        HapticFeedback.lightImpact();
                        countDownController.reset();
                        isTimerPaused.value = true;
                      },
                      icon: Icons.restore,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ActionButtonWidget extends StatelessWidget {
  final VoidCallback action;
  final IconData icon;
  const ActionButtonWidget({super.key, required this.action, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: SizedBox(
        height: 70,
        width: 70,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Container(
                height: 66,
                width: 66,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.brandBlue500.withOpacity(0.10),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 56,
                width: 56,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.brandBlue500,
                ),
                child: Icon(
                  icon,
                  color: AppColors.brandWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
