class ScannerResult {
  ScannerResult({
    this.value, this.symbology, this.subtype, this.aimID, this.decoderType
  });
  ScannerResult.fromMap(Map? map)
    :value = map?['value']?.toString(),
    symbology = map?['symbology'],
    subtype = map?['subtype'],
    aimID = map?['aimID'],
    decoderType = map?['decoderType'];


  final String? value;
  final int? symbology;
  final int? subtype;
  final String? aimID;
  final int? decoderType;
}