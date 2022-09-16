class sumitted_form_model {
  String? message;
  AssessmentDetailsList? assessmentDetailsList;

  sumitted_form_model({this.message, this.assessmentDetailsList});

  sumitted_form_model.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    assessmentDetailsList = json['assessmentDetailsList'] != null
        ? new AssessmentDetailsList.fromJson(json['assessmentDetailsList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.assessmentDetailsList != null) {
      data['assessmentDetailsList'] = this.assessmentDetailsList!.toJson();
    }
    return data;
  }
}

class AssessmentDetailsList {
  String? eaveFlashingFeet;
  String? eaveFlashingInches;
  String? fasciaBoardFeet;
  String? fasciaBoardInches;
  String? soffitHeightFeet;
  String? soffitHeightInches;
  String? soffitWidthFeet;
  String? soffitWidthInches;
  String? soffitType;
  String? shinglesHeightFeet;
  String? shinglesHeightInches;
  String? shinglesWidthFeet;
  String? shinglesWidthInches;
  String? shingleStyle;
  String? plywoodHeightFeet;
  String? plywoodHeightInches;
  String? plywoodWidthFeet;
  String? plywoodWidthInches;
  String? iceAndWaterShieldHeightFeet;
  String? iceAndWaterShieldHeightInches;
  String? iceAndWaterShieldWidthFeet;
  String? iceAndWaterShieldWidthInches;
  String? toughGuardHeightFeet;
  String? toughGuardHeightInches;
  String? toughGuardWidthFeet;
  String? toughGuardWidthInches;
  String? torchOnHeightFeet;
  String? torchOnHeightInches;
  String? torchOnWidthFeet;
  String? torchOnWidthInches;
  String? type;
  String? windowStyle;
  String? quantity;
  String? sizeHeightFeet;
  String? sizeHeightInches;
  String? sizeWidthFeet;
  String? sizeWidthInches;
  String? typeOne;
  String? windowStyleOne;
  String? quantityOne;
  String? sizeHeightFeetOne;
  String? sizeHeightInchesOne;
  String? sizeWidthFeetOne;
  String? sizeWidthInchesOne;
  String? typeTwo;
  String? windowStyleTwo;
  String? quantityTwo;
  String? sizeHeightFeetTwo;
  String? sizeHeightInchesTwo;
  String? sizeWidthFeetTwo;
  String? sizeWidthInchesTwo;
  String? location;
  String? doorType;
  String? orientation;
  String? doorQuantity;
  String? doorSizeHeightFeet;
  String? doorSizeHeightInches;
  String? doorSizeWidthFeet;
  String? doorSizeWidthInches;
  String? locationOne;
  String? doorTypeOne;
  String? orientationOne;
  String? doorQuantityOne;
  String? doorSizeHeightFeetOne;
  String? doorSizeHeightInchesOne;
  String? doorSizeWidthFeetOne;
  String? doorSizeWidthInchesOne;
  String? locationTwo;
  String? doorTypeTwo;
  String? orientationTwo;
  String? doorQuantityTwo;
  String? doorSizeHeightFeetTwo;
  String? doorSizeHeightInchesTwo;
  String? doorSizeWidthFeetTwo;
  String? doorSizeWidthInchesTwo;
  String? serviceEntrance;
  String? servicePole;
  String? meterCanSize;
  String? meterSwitchSize;
  String? interiorFlooding;
  String? floodingHeightFeet;
  String? floodingHeightInches;
  String? groundRod;
  String? groundClamp;
  String? groundWire;
  String? waterSupply;
  String? waterCloset;
  String? s12ServicePipe;
  String? lengthOfDamageFeet;
  String? lengthOfDamageInches;
  String? s34ServicePipe;
  String? lengthOfDamageFeetOne;
  String? lengthOfDamageInchesOne;
  String? s1ServicePipe;
  String? lengthOfDamageFeetTwo;
  String? lengthOfDamageInchesTwo;
  String? additionalComment;
  String? projectOfficer;
  String? date;
  String? name;
  String? emailAddress;
  String? callNumber;
  String? streetAddress;
  String? island;
  String? homeNumber;
  String? settlement;
  List<String>? damageSnaps;
  String? eaveFlashingSize;
  String? fasciaBoardSizeInchesOne;
  String? meterialTwo;
  String? meterialOne;
  String? meterial;
  String? colonialStyleTwo;
  String? fasciaBoardSizeInchesTwo;
  String? colonialStyleOne;
  String? colonialStyle;

  AssessmentDetailsList(
      {this.eaveFlashingFeet,
        this.eaveFlashingInches,
        this.fasciaBoardFeet,
        this.fasciaBoardInches,
        this.soffitHeightFeet,
        this.soffitHeightInches,
        this.soffitWidthFeet,
        this.soffitWidthInches,
        this.soffitType,
        this.shinglesHeightFeet,
        this.shinglesHeightInches,
        this.shinglesWidthFeet,
        this.shinglesWidthInches,
        this.shingleStyle,
        this.plywoodHeightFeet,
        this.plywoodHeightInches,
        this.plywoodWidthFeet,
        this.plywoodWidthInches,
        this.iceAndWaterShieldHeightFeet,
        this.iceAndWaterShieldHeightInches,
        this.iceAndWaterShieldWidthFeet,
        this.iceAndWaterShieldWidthInches,
        this.toughGuardHeightFeet,
        this.toughGuardHeightInches,
        this.toughGuardWidthFeet,
        this.toughGuardWidthInches,
        this.torchOnHeightFeet,
        this.torchOnHeightInches,
        this.torchOnWidthFeet,
        this.torchOnWidthInches,
        this.type,
        this.windowStyle,
        this.quantity,
        this.sizeHeightFeet,
        this.sizeHeightInches,
        this.sizeWidthFeet,
        this.sizeWidthInches,
        this.typeOne,
        this.windowStyleOne,
        this.quantityOne,
        this.sizeHeightFeetOne,
        this.sizeHeightInchesOne,
        this.sizeWidthFeetOne,
        this.sizeWidthInchesOne,
        this.typeTwo,
        this.windowStyleTwo,
        this.quantityTwo,
        this.sizeHeightFeetTwo,
        this.sizeHeightInchesTwo,
        this.sizeWidthFeetTwo,
        this.sizeWidthInchesTwo,
        this.location,
        this.doorType,
        this.orientation,
        this.doorQuantity,
        this.doorSizeHeightFeet,
        this.doorSizeHeightInches,
        this.doorSizeWidthFeet,
        this.doorSizeWidthInches,
        this.locationOne,
        this.doorTypeOne,
        this.orientationOne,
        this.doorQuantityOne,
        this.doorSizeHeightFeetOne,
        this.doorSizeHeightInchesOne,
        this.doorSizeWidthFeetOne,
        this.doorSizeWidthInchesOne,
        this.locationTwo,
        this.doorTypeTwo,
        this.orientationTwo,
        this.doorQuantityTwo,
        this.doorSizeHeightFeetTwo,
        this.doorSizeHeightInchesTwo,
        this.doorSizeWidthFeetTwo,
        this.doorSizeWidthInchesTwo,
        this.serviceEntrance,
        this.servicePole,
        this.meterCanSize,
        this.meterSwitchSize,
        this.interiorFlooding,
        this.floodingHeightFeet,
        this.floodingHeightInches,
        this.groundRod,
        this.groundClamp,
        this.groundWire,
        this.waterSupply,
        this.waterCloset,
        this.s12ServicePipe,
        this.lengthOfDamageFeet,
        this.lengthOfDamageInches,
        this.s34ServicePipe,
        this.lengthOfDamageFeetOne,
        this.lengthOfDamageInchesOne,
        this.s1ServicePipe,
        this.lengthOfDamageFeetTwo,
        this.lengthOfDamageInchesTwo,
        this.additionalComment,
        this.projectOfficer,
        this.date,
        this.name,
        this.emailAddress,
        this.callNumber,
        this.streetAddress,
        this.island,
        this.homeNumber,
        this.damageSnaps,
        this.settlement,
        this.eaveFlashingSize,
        this.fasciaBoardSizeInchesOne,
        this.meterialTwo,
        this.meterialOne,
        this.meterial,
        this.colonialStyleTwo,
        this.fasciaBoardSizeInchesTwo,
        this.colonialStyleOne,
        this.colonialStyle});

  AssessmentDetailsList.fromJson(Map<String, dynamic> json) {
    eaveFlashingFeet = json['eave-flashing-feet'];
    eaveFlashingInches = json['eave-flashing-inches'];
    fasciaBoardFeet = json['fascia-board-feet'];
    fasciaBoardInches = json['fascia-board-inches'];
    soffitHeightFeet = json['soffit-height-feet'];
    soffitHeightInches = json['soffit-height-inches'];
    soffitWidthFeet = json['soffit-width-feet'];
    soffitWidthInches = json['soffit-width-inches'];
    soffitType = json['soffit-type'];
    shinglesHeightFeet = json['shingles-height-feet'];
    shinglesHeightInches = json['shingles-height-inches'];
    shinglesWidthFeet = json['shingles-width-feet'];
    shinglesWidthInches = json['shingles-width-inches'];
    shingleStyle = json['shingle-style'];
    plywoodHeightFeet = json['plywood-height-feet'];
    plywoodHeightInches = json['plywood-height-inches'];
    plywoodWidthFeet = json['plywood-width-feet'];
    plywoodWidthInches = json['plywood-width-inches'];
    iceAndWaterShieldHeightFeet = json['ice-and-water-shield-height-feet'];
    iceAndWaterShieldHeightInches = json['ice-and-water-shield-height-inches'];
    iceAndWaterShieldWidthFeet = json['ice-and-water-shield-width-feet'];
    iceAndWaterShieldWidthInches = json['ice-and-water-shield-width-inches'];
    toughGuardHeightFeet = json['tough-guard-height-feet'];
    toughGuardHeightInches = json['tough-guard-height-inches'];
    toughGuardWidthFeet = json['tough-guard-width-feet'];
    toughGuardWidthInches = json['tough-guard-width-inches'];
    torchOnHeightFeet = json['torch-on-height-feet'];
    torchOnHeightInches = json['torch-on-height-inches'];
    torchOnWidthFeet = json['torch-on-width-feet'];
    torchOnWidthInches = json['torch-on-width-inches'];
    type = json['type'];
    windowStyle = json['window-style'];
    quantity = json['quantity'];
    sizeHeightFeet = json['size-height-feet'];
    sizeHeightInches = json['size-height-inches'];
    sizeWidthFeet = json['size-width-feet'];
    sizeWidthInches = json['size-width-inches'];
    typeOne = json['type-one'];
    windowStyleOne = json['window-style-one'];
    quantityOne = json['quantity-one'];
    sizeHeightFeetOne = json['size-height-feet-one'];
    sizeHeightInchesOne = json['size-height-inches-one'];
    sizeWidthFeetOne = json['size-width-feet-one'];
    sizeWidthInchesOne = json['size-width-inches-one'];
    typeTwo = json['type-two'];
    windowStyleTwo = json['window-style-two'];
    quantityTwo = json['quantity-two'];
    sizeHeightFeetTwo = json['size-height-feet-two'];
    sizeHeightInchesTwo = json['size-height-inches-two'];
    sizeWidthFeetTwo = json['size-width-feet-two'];
    sizeWidthInchesTwo = json['size-width-inches-two'];
    location = json['location'];
    doorType = json['door-type'];
    orientation = json['orientation'];
    doorQuantity = json['door-quantity'];
    doorSizeHeightFeet = json['door-size-height-feet'];
    doorSizeHeightInches = json['door-size-height-inches'];
    doorSizeWidthFeet = json['door-size-width-feet'];
    doorSizeWidthInches = json['door-size-width-inches'];
    locationOne = json['location-one'];
    doorTypeOne = json['door-type-one'];
    orientationOne = json['orientation-one'];
    doorQuantityOne = json['door-quantity-one'];
    doorSizeHeightFeetOne = json['door-size-height-feet-one'];
    doorSizeHeightInchesOne = json['door-size-height-inches-one'];
    doorSizeWidthFeetOne = json['door-size-width-feet-one'];
    doorSizeWidthInchesOne = json['door-size-width-inches-one'];
    locationTwo = json['location-two'];
    doorTypeTwo = json['door-type-two'];
    orientationTwo = json['orientation-two'];
    doorQuantityTwo = json['door-quantity-two'];
    doorSizeHeightFeetTwo = json['door-size-height-feet-two'];
    doorSizeHeightInchesTwo = json['door-size-height-inches-two'];
    doorSizeWidthFeetTwo = json['door-size-width-feet-two'];
    doorSizeWidthInchesTwo = json['door-size-width-inches-two'];
    serviceEntrance = json['service-entrance'];
    servicePole = json['service-pole'];
    meterCanSize = json['meter-can-size'];
    meterSwitchSize = json['meter-switch-size'];
    interiorFlooding = json['interior-flooding'];
    floodingHeightFeet = json['flooding-height-feet'];
    floodingHeightInches = json['flooding-height-inches'];
    groundRod = json['ground-rod'];
    groundClamp = json['ground-clamp'];
    groundWire = json['ground-wire'];
    waterSupply = json['water-supply'];
    waterCloset = json['water-closet'];
    s12ServicePipe = json['1/2-service-pipe'];
    lengthOfDamageFeet = json['length-of-damage-feet'];
    lengthOfDamageInches = json['length-of-damage-inches'];
    s34ServicePipe = json['3/4-service-pipe'];
    lengthOfDamageFeetOne = json['length-of-damage-feet-one'];
    lengthOfDamageInchesOne = json['length-of-damage-inches-one'];
    s1ServicePipe = json['1-service-pipe'];
    lengthOfDamageFeetTwo = json['length-of-damage-feet-two'];
    lengthOfDamageInchesTwo = json['length-of-damage-inches-two'];
    additionalComment = json['additional-comment'];
    projectOfficer = json['project-officer'];
    date = json['date'];
    name = json['name'];
    emailAddress = json['email-address'];
    callNumber = json['call-number'];
    streetAddress = json['street-address'];
    island = json['island'];
    homeNumber = json['home-number'];
    settlement = json['settlement'];
    eaveFlashingSize = json['eave-flashing-size'];
    fasciaBoardSizeInchesOne = json['fascia-board-size-inches-one'];
    meterialTwo = json['meterial-two'];
    meterialOne = json['meterial-one'];
    meterial = json['meterial'];
    colonialStyleTwo = json['colonial-style-two'];
    fasciaBoardSizeInchesTwo = json['fascia-board-size-inches-two'];
    colonialStyleOne = json['colonial-style-one'];
    colonialStyle = json['colonial-style'];
    //damageSnaps = json['damage-snaps'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eave-flashing-feet'] = this.eaveFlashingFeet;
    data['eave-flashing-inches'] = this.eaveFlashingInches;
    data['fascia-board-feet'] = this.fasciaBoardFeet;
    data['fascia-board-inches'] = this.fasciaBoardInches;
    data['soffit-height-feet'] = this.soffitHeightFeet;
    data['soffit-height-inches'] = this.soffitHeightInches;
    data['soffit-width-feet'] = this.soffitWidthFeet;
    data['soffit-width-inches'] = this.soffitWidthInches;
    data['soffit-type'] = this.soffitType;
    data['shingles-height-feet'] = this.shinglesHeightFeet;
    data['shingles-height-inches'] = this.shinglesHeightInches;
    data['shingles-width-feet'] = this.shinglesWidthFeet;
    data['shingles-width-inches'] = this.shinglesWidthInches;
    data['shingle-style'] = this.shingleStyle;
    data['plywood-height-feet'] = this.plywoodHeightFeet;
    data['plywood-height-inches'] = this.plywoodHeightInches;
    data['plywood-width-feet'] = this.plywoodWidthFeet;
    data['plywood-width-inches'] = this.plywoodWidthInches;
    data['ice-and-water-shield-height-feet'] = this.iceAndWaterShieldHeightFeet;
    data['ice-and-water-shield-height-inches'] =
        this.iceAndWaterShieldHeightInches;
    data['ice-and-water-shield-width-feet'] = this.iceAndWaterShieldWidthFeet;
    data['ice-and-water-shield-width-inches'] =
        this.iceAndWaterShieldWidthInches;
    data['tough-guard-height-feet'] = this.toughGuardHeightFeet;
    data['tough-guard-height-inches'] = this.toughGuardHeightInches;
    data['tough-guard-width-feet'] = this.toughGuardWidthFeet;
    data['tough-guard-width-inches'] = this.toughGuardWidthInches;
    data['torch-on-height-feet'] = this.torchOnHeightFeet;
    data['torch-on-height-inches'] = this.torchOnHeightInches;
    data['torch-on-width-feet'] = this.torchOnWidthFeet;
    data['torch-on-width-inches'] = this.torchOnWidthInches;
    data['type'] = this.type;
    data['window-style'] = this.windowStyle;
    data['quantity'] = this.quantity;
    data['size-height-feet'] = this.sizeHeightFeet;
    data['size-height-inches'] = this.sizeHeightInches;
    data['size-width-feet'] = this.sizeWidthFeet;
    data['size-width-inches'] = this.sizeWidthInches;
    data['type-one'] = this.typeOne;
    data['window-style-one'] = this.windowStyleOne;
    data['quantity-one'] = this.quantityOne;
    data['size-height-feet-one'] = this.sizeHeightFeetOne;
    data['size-height-inches-one'] = this.sizeHeightInchesOne;
    data['size-width-feet-one'] = this.sizeWidthFeetOne;
    data['size-width-inches-one'] = this.sizeWidthInchesOne;
    data['type-two'] = this.typeTwo;
    data['window-style-two'] = this.windowStyleTwo;
    data['quantity-two'] = this.quantityTwo;
    data['size-height-feet-two'] = this.sizeHeightFeetTwo;
    data['size-height-inches-two'] = this.sizeHeightInchesTwo;
    data['size-width-feet-two'] = this.sizeWidthFeetTwo;
    data['size-width-inches-two'] = this.sizeWidthInchesTwo;
    data['location'] = this.location;
    data['door-type'] = this.doorType;
    data['orientation'] = this.orientation;
    data['door-quantity'] = this.doorQuantity;
    data['door-size-height-feet'] = this.doorSizeHeightFeet;
    data['door-size-height-inches'] = this.doorSizeHeightInches;
    data['door-size-width-feet'] = this.doorSizeWidthFeet;
    data['door-size-width-inches'] = this.doorSizeWidthInches;
    data['location-one'] = this.locationOne;
    data['door-type-one'] = this.doorTypeOne;
    data['orientation-one'] = this.orientationOne;
    data['door-quantity-one'] = this.doorQuantityOne;
    data['door-size-height-feet-one'] = this.doorSizeHeightFeetOne;
    data['door-size-height-inches-one'] = this.doorSizeHeightInchesOne;
    data['door-size-width-feet-one'] = this.doorSizeWidthFeetOne;
    data['door-size-width-inches-one'] = this.doorSizeWidthInchesOne;
    data['location-two'] = this.locationTwo;
    data['door-type-two'] = this.doorTypeTwo;
    data['orientation-two'] = this.orientationTwo;
    data['door-quantity-two'] = this.doorQuantityTwo;
    data['door-size-height-feet-two'] = this.doorSizeHeightFeetTwo;
    data['door-size-height-inches-two'] = this.doorSizeHeightInchesTwo;
    data['door-size-width-feet-two'] = this.doorSizeWidthFeetTwo;
    data['door-size-width-inches-two'] = this.doorSizeWidthInchesTwo;
    data['service-entrance'] = this.serviceEntrance;
    data['service-pole'] = this.servicePole;
    data['meter-can-size'] = this.meterCanSize;
    data['meter-switch-size'] = this.meterSwitchSize;
    data['interior-flooding'] = this.interiorFlooding;
    data['flooding-height-feet'] = this.floodingHeightFeet;
    data['flooding-height-inches'] = this.floodingHeightInches;
    data['ground-rod'] = this.groundRod;
    data['ground-clamp'] = this.groundClamp;
    data['ground-wire'] = this.groundWire;
    data['water-supply'] = this.waterSupply;
    data['water-closet'] = this.waterCloset;
    data['1/2-service-pipe'] = this.s12ServicePipe;
    data['length-of-damage-feet'] = this.lengthOfDamageFeet;
    data['length-of-damage-inches'] = this.lengthOfDamageInches;
    data['3/4-service-pipe'] = this.s34ServicePipe;
    data['length-of-damage-feet-one'] = this.lengthOfDamageFeetOne;
    data['length-of-damage-inches-one'] = this.lengthOfDamageInchesOne;
    data['1-service-pipe'] = this.s1ServicePipe;
    data['length-of-damage-feet-two'] = this.lengthOfDamageFeetTwo;
    data['length-of-damage-inches-two'] = this.lengthOfDamageInchesTwo;
    data['additional-comment'] = this.additionalComment;
    data['project-officer'] = this.projectOfficer;
    data['date'] = this.date;
    data['name'] = this.name;
    data['email-address'] = this.emailAddress;
    data['call-number'] = this.callNumber;
    data['street-address'] = this.streetAddress;
    data['island'] = this.island;
    data['home-number'] = this.homeNumber;
    data['settlement'] = this.settlement;
    data['damage-snaps'] = this.damageSnaps;
    data['eave-flashing-size'] = this.eaveFlashingSize;
    data['fascia-board-size-inches-one'] = this.fasciaBoardSizeInchesOne;
    data['meterial-two'] = this.meterialTwo;
    data['meterial-one'] = this.meterialOne;
    data['meterial'] = this.meterial;
    data['colonial-style-two'] = this.colonialStyleTwo;
    data['fascia-board-size-inches-two'] = this.fasciaBoardSizeInchesTwo;
    data['colonial-style-one'] = this.colonialStyleOne;
    data['colonial-style'] = this.colonialStyle;
    return data;
  }
}