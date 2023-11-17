import 'package:ambeego_test/core/utils/app_module.dart';
import 'package:ambeego_test/core/utils/helpers.dart';
import 'package:ambeego_test/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:ambeego_test/utilities/colors.dart';
import 'package:ambeego_test/utilities/spacing_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

class FocusHistoryScreen extends HookWidget {
  const FocusHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timerBloc = BlocProvider.of<TimerBloc>(context);
    useEffect(() {
      timerBloc.add(GetFocusHistoryEntriesEvent(data: {"email": module.email}));
      return null;
    }, []);

    final focusEntriesList = useState<List<dynamic>>([]);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Work History",
          style: GoogleFonts.familjenGrotesk(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<TimerBloc, TimerState>(
        bloc: timerBloc,
        listener: (context, state) {
          if (state is GetFocusHistoryEntriesSuccess) {
            focusEntriesList.value = state.data.data;
          }
        },
        builder: (context, state) {
          if (state is GetFocusHistoryEntriesError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error),
                  const YMargin(30),
                  MaterialButton(
                    onPressed: () {
                      timerBloc.add(GetFocusHistoryEntriesEvent(data: {"email": module.email}));
                    },
                    padding: EdgeInsets.zero,
                    child: Container(
                      height: 50,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: AppColors.brandBlue500,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Retry",
                          style: GoogleFonts.familjenGrotesk(
                            color: AppColors.brandWhite,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is GetFocusHistoryEntriesLoading) {
            return Center(
              child: Helper.getProgressLoader(color: AppColors.brandBlue500),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: focusEntriesList.value.isEmpty
                ? const Center(
                    child: Text('No focus entries yet'),
                  )
                : ListView.builder(
                    itemCount: focusEntriesList.value.length,
                    itemBuilder: (_, index) {
                      return _focusHistoryTile(focusEntriesList.value[index]);
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget _focusHistoryTile(Map<String, dynamic> data) {
    final startTime = Helper.parseToReadableTime(DateTime.parse(data['start_time']));

    final endTime = Helper.parseToReadableTime(DateTime.parse(data['end_time']));
    return Column(
      children: [
        SizedBox(
          height: 40,
          width: double.maxFinite,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.brandBlue500.withOpacity(0.10),
                child: const Icon(Icons.history, color: AppColors.brandBlue500),
              ),
              const XMargin(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Focus",
                    style: GoogleFonts.familjenGrotesk(
                      fontSize: 14,
                      color: AppColors.neutralBlack,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        Helper.parseToReadableDate(DateTime.parse(data['start_time'])),
                        style: GoogleFonts.familjenGrotesk(
                          fontSize: 12,
                          color: AppColors.neutralBlack.withOpacity(0.70),
                        ),
                      ),
                      const XMargin(5),
                      Container(
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.textLight.withOpacity(0.50),
                        ),
                      ),
                      const XMargin(5),
                      Text(
                        "$startTime - $endTime",
                        style: GoogleFonts.familjenGrotesk(
                          fontSize: 12,
                          color: AppColors.neutralBlack.withOpacity(0.70),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        const YMargin(20),
      ],
    );
  }
}
