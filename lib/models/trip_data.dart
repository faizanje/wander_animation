typedef TripAdditionalInfo = ({String number, String title});

class TripData {
  final String title;
  final String imagePath;
  final List<TripAdditionalInfo> tripAdditionalInfos;

  const TripData({
    required this.title,
    required this.imagePath,
    required this.tripAdditionalInfos,
  });
}
