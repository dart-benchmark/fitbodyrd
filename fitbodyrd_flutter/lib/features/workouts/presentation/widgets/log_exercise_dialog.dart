import 'package:fitbodyrd_client/fitbodyrd_client.dart';
import 'package:fitbodyrd_flutter/features/workouts/domain/repositories/workout_repository.dart';
import 'package:fitbodyrd_flutter/src/core/common/components/c_button.dart';
import 'package:fitbodyrd_flutter/src/core/common/components/c_text_field.dart';
import 'package:fitbodyrd_flutter/src/core/injections/injection_container.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_colors.dart';
import 'package:fitbodyrd_flutter/src/core/style/k_text.dart';
import 'package:fitbodyrd_flutter/src/core/utils/core_utils.dart';
import 'package:flutter/material.dart';
import 'package:record_result/record_result.dart';

class LogExerciseDialog extends StatefulWidget {
  const LogExerciseDialog({
    required this.workoutExercise,
    required this.selectedDate,
    this.existingLog,
    super.key,
  });

  final WorkoutExercise workoutExercise;
  final DateTime selectedDate;
  final ExerciseLog? existingLog;

  @override
  State<LogExerciseDialog> createState() => _LogExerciseDialogState();
}

class _LogExerciseDialogState extends State<LogExerciseDialog> {
  bool _isQuickLog = true;
  bool _isLoading = false;

  // Controllers for custom log
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingLog != null) {
      _setsController.text = widget.existingLog!.setsCompleted.toString();
      _repsController.text = widget.existingLog!.repsCompleted.toString();
      _weightController.text = widget.existingLog!.weightUsed?.toString() ?? '';
    } else {
      _setsController.text = widget.workoutExercise.sets.toString();
      _repsController.text = widget.workoutExercise.reps.toString();
    }
  }

  @override
  void dispose() {
    _setsController.dispose();
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final repository = sl<WorkoutRepository>();

    final log = ExerciseLog(
      userId: 0, // Backend handles this
      exerciseId: widget.workoutExercise.exerciseId,
      workoutExerciseId: widget.workoutExercise.id,
      date: widget.selectedDate,
      setsCompleted: _isQuickLog
          ? widget.workoutExercise.sets
          : int.tryParse(_setsController.text) ?? 0,
      repsCompleted: _isQuickLog
          ? widget.workoutExercise.reps
          : int.tryParse(_repsController.text) ?? 0,
      weightUsed: _isQuickLog ? null : double.tryParse(_weightController.text),
    );

    final result = await repository.logWorkoutExercise(log);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      result.fold(
        (savedLog) => Navigator.of(context).pop(savedLog),
        (failure) => CoreUtils.showSnackBar(context, failure.message),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: KColors.greyScale.g900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KText.headlineSmall(
              widget.workoutExercise.exercise?.name ?? 'Ejercicio',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),

            // Toggle between Quick and Custom
            Row(
              children: [
                Expanded(
                  child: _OptionButton(
                    label: 'Registro Rápido',
                    isSelected: _isQuickLog,
                    onTap: () => setState(() => _isQuickLog = true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _OptionButton(
                    label: 'Personalizado',
                    isSelected: !_isQuickLog,
                    onTap: () => setState(() => _isQuickLog = false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Content based on selection
            if (_isQuickLog) ...[
              _QuickLogContent(
                sets: widget.workoutExercise.sets,
                reps: widget.workoutExercise.reps,
              ),
            ] else ...[
              _CustomLogContent(
                setsController: _setsController,
                repsController: _repsController,
                weightController: _weightController,
              ),
            ],

            const SizedBox(height: 24),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed:
                      _isLoading ? null : () => Navigator.of(context).pop(),
                  child: const KText.bodyMedium('Cancelar'),
                ),
                const SizedBox(width: 12),
                CButton.primary(
                  text: _isLoading ? 'Guardando...' : 'Guardar',
                  width: null,
                  onPressed: _isLoading ? null : _handleSave,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  const _OptionButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? KColors.primary.p500 : Colors.transparent,
          border: Border.all(
            color: isSelected ? KColors.primary.p500 : KColors.greyScale.g200,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: KText.bodyMedium(
            label,
            color: isSelected ? KColors.greyScale.g900 : KColors.greyScale.g200,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _QuickLogContent extends StatelessWidget {
  const _QuickLogContent({
    required this.sets,
    required this.reps,
  });

  final int sets;
  final int reps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: KColors.greyScale.g900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KText.bodyMedium(
            'Se registrará:',
            color: KColors.greyScale.g200,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 8),
          KText.bodyLarge(
            '$sets series de $reps repeticiones',
            color: KColors.primary.p500,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}

class _CustomLogContent extends StatelessWidget {
  const _CustomLogContent({
    required this.setsController,
    required this.repsController,
    required this.weightController,
  });

  final TextEditingController setsController;
  final TextEditingController repsController;
  final TextEditingController weightController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CTextField(
          controller: setsController,
          labelText: 'Series Completadas',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        CTextField(
          controller: repsController,
          labelText: 'Repeticiones Completadas',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        CTextField(
          controller: weightController,
          labelText: 'Peso Usado (kg) - Opcional',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
      ],
    );
  }
}
