import 'festival.dart';
import 'festival_tariff.dart';

class FestivalOrderArgs {
  final Festival festival;
  final FestivalTariff tariff;

  FestivalOrderArgs({required this.festival, required this.tariff});
}