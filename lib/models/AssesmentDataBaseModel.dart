class AssesmentDataBaseModel {
  int? id;

  String? requestKey;
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
  String? damageSnaps;
  String? material;
  String? materialOne;
  String? materialTwo;
  String? name;
  String? emailAddress;
  String? eaveFlashingSize;
  String? fasciaBoardSizeInchesOne;
  String? colonialStyleTwo;
  String? fasciaBoardSizeInchesTwo;
  String? colonialStyleOne;
  String? colonialStyle;

  // String? island;
  // String? homeNumber;
  // String? settlement;

  AssesmentDataBaseModel(
      {this.requestKey,
      this.eaveFlashingFeet,
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
      this.damageSnaps,
      this.material,
      this.materialOne,
      this.materialTwo,
      this.name,
      this.emailAddress,
      this.eaveFlashingSize,
      this.fasciaBoardSizeInchesOne,
      this.colonialStyleTwo,
      this.fasciaBoardSizeInchesTwo,
      this.colonialStyleOne,
      this.colonialStyle});

  // AssesmentDataBaseModel(
  //     {this.requestKey,
  //     this.eaveFlashingFeet,
  //     this.eaveFlashingInches,
  //     this.fasciaBoardFeet});

  userMap() {
    var mapping = Map<String, dynamic>();

    mapping['id'] = id ?? null;
    mapping['request_key'] = requestKey!;
    mapping['eave_flashing_inches'] = eaveFlashingInches!;
    mapping['eave_flashing_feet'] = eaveFlashingFeet!;
    mapping['fascia_board_feet'] = fasciaBoardFeet!;

    mapping['fascia_board_inches'] = fasciaBoardInches;
    mapping['soffit_height_feet'] = soffitHeightFeet;
    mapping['soffit_height_inches'] = soffitHeightInches;
    mapping['soffit_width_feet'] = soffitWidthFeet;
    mapping['soffit_width_inches'] = soffitWidthInches;
    mapping['soffit_type'] = soffitType;
    mapping['shingles_height_feet'] = shinglesHeightFeet;
    mapping['shingles_height_inches'] = shinglesHeightInches;
    mapping['shingles_width_feet'] = shinglesWidthFeet;
    mapping['shingles_width_inches'] = shinglesWidthInches;
    mapping['shingle_style'] = shingleStyle;
    mapping['plywood_height_feet'] = plywoodHeightFeet;
    mapping['plywood_height_inches'] = plywoodHeightInches;
    mapping['plywood_width_feet'] = plywoodWidthFeet;
    mapping['plywood_width_inches'] = plywoodWidthInches;
    mapping['ice_and_water_shield_height_feet'] =
        this.iceAndWaterShieldHeightFeet;
    mapping['ice_and_water_shield_height_inches'] =
        this.iceAndWaterShieldHeightInches;
    mapping['ice_and_water_shield_width_feet'] =
        this.iceAndWaterShieldWidthFeet;
    mapping['ice_and_water_shield_width_inches'] =
        this.iceAndWaterShieldWidthInches;

    mapping['tough_guard_height_feet'] = this.toughGuardHeightFeet;
    mapping['tough_guard_height_inches'] = this.toughGuardHeightInches;
    mapping['tough_guard_width_feet'] = this.toughGuardWidthFeet;
    mapping['tough_guard_width_inches'] = this.toughGuardWidthInches;
    mapping['torch_on_height_feet'] = this.torchOnHeightFeet;
    mapping['torch_on_height_inches'] = this.torchOnHeightInches;
    mapping['torch_on_width_feet'] = this.torchOnWidthFeet;
    mapping['torch_on_width_inches'] = this.torchOnWidthInches;
    mapping['type'] = this.type;
    mapping['window_style'] = this.windowStyle;
    mapping['quantity'] = this.quantity;
    mapping['size_height_feet'] = this.sizeHeightFeet;
    mapping['size_height_inches'] = this.sizeHeightInches;
    mapping['size_width_feet'] = this.sizeWidthFeet;
    mapping['size_width_inches'] = this.sizeWidthInches;
    mapping['type_one'] = this.typeOne;
    mapping['window_style_one'] = this.windowStyleOne;
    mapping['quantity_one'] = this.quantityOne;
    mapping['size_height_feet_one'] = this.sizeHeightFeetOne;
    mapping['size_height_inches_one'] = this.sizeHeightInchesOne;
    mapping['size_width_feet_one'] = this.sizeWidthFeetOne;
    mapping['size_width_inches_one'] = this.sizeWidthInchesOne;
    mapping['type_two'] = this.typeTwo;
    mapping['window_style_two'] = this.windowStyleTwo;
    mapping['quantity_two'] = this.quantityTwo;
    mapping['size_height_feet_two'] = this.sizeHeightFeetTwo;
    mapping['size_height_inches_two'] = this.sizeHeightInchesTwo;
    mapping['size_width_feet_two'] = this.sizeWidthFeetTwo;
    mapping['size_width_inches_two'] = this.sizeWidthInchesTwo;
    mapping['location'] = this.location;
    mapping['door_type'] = this.doorType;
    mapping['orientation'] = this.orientation;
    mapping['door_quantity'] = this.doorQuantity;
    mapping['door_size_height_feet'] = this.doorSizeHeightFeet;
    mapping['door_size_height_inches'] = this.doorSizeHeightInches;
    mapping['door_size_width_feet'] = this.doorSizeWidthFeet;
    mapping['door_size_width_inches'] = this.doorSizeWidthInches;
    mapping['location_one'] = this.locationOne;
    mapping['door_type_one'] = this.doorTypeOne;
    mapping['orientation_one'] = this.orientationOne;
    mapping['door_quantity_one'] = this.doorQuantityOne;
    mapping['door_size_height_feet_one'] = this.doorSizeHeightFeetOne;
    mapping['door_size_height_inches_one'] = this.doorSizeHeightInchesOne;
    mapping['door_size_width_feet_one'] = this.doorSizeWidthFeetOne;
    mapping['door_size_width_inches_one'] = this.doorSizeWidthInchesOne;
    mapping['location_two'] = this.locationTwo;
    mapping['door_type_two'] = this.doorTypeTwo;
    mapping['orientation_two'] = this.orientationTwo;
    mapping['door_quantity_two'] = this.doorQuantityTwo;
    mapping['door_size_height_feet_two'] = this.doorSizeHeightFeetTwo;
    mapping['door_size_height_inches_two'] = this.doorSizeHeightInchesTwo;
    mapping['door_size_width_feet_two'] = this.doorSizeWidthFeetTwo;
    mapping['door_size_width_inches_two'] = this.doorSizeWidthInchesTwo;
    mapping['service_entrance'] = this.serviceEntrance;
    mapping['service_pole'] = this.servicePole;
    mapping['meter_can_size'] = this.meterCanSize;
    mapping['meter_switch_size'] = this.meterSwitchSize;
    mapping['interior_flooding'] = this.interiorFlooding;
    mapping['flooding_height_feet'] = this.floodingHeightFeet;
    mapping['flooding_height_inches'] = this.floodingHeightInches;
    mapping['ground_rod'] = this.groundRod;
    mapping['ground_clamp'] = this.groundClamp;
    mapping['ground_wire'] = this.groundWire;
    mapping['water_supply'] = this.waterSupply;
    mapping['water_closet'] = this.waterCloset;
    mapping['onebytwo_service_pipe'] = this.s12ServicePipe;
    mapping['length_of_damage_feet'] = this.lengthOfDamageFeet;
    mapping['length_of_damage_inches'] = this.lengthOfDamageInches;
    mapping['threebyfour_service_pipe'] = this.s34ServicePipe;
    mapping['length_of_damage_feet_one'] = this.lengthOfDamageFeetOne;
    mapping['length_of_damage_inches_one'] = this.lengthOfDamageInchesOne;
    mapping['one_service_pipe'] = this.s1ServicePipe;
    mapping['length_of_damage_feet_two'] = this.lengthOfDamageFeetTwo;
    mapping['length_of_damage_inches_two'] = this.lengthOfDamageInchesTwo;
    mapping['additional_comment'] = this.additionalComment;
    mapping['damage_snaps'] = this.damageSnaps;
    mapping['material'] = this.material;
    mapping['material_one'] = this.materialOne;
    mapping['material_two'] = this.materialTwo;
    mapping['name'] = this.name;
    mapping['email_address'] = this.emailAddress;
    mapping['eave_flashing_size'] = this.eaveFlashingSize;
    mapping['fascia_board_size_inches_one'] = this.fasciaBoardSizeInchesOne;
    mapping['colonial_style_two'] = this.colonialStyleTwo;
    mapping['fascia_board_size_inches_two'] = this.fasciaBoardSizeInchesTwo;
    mapping['colonial_style_one'] = this.colonialStyleOne;
    mapping['colonial_style'] = this.colonialStyle;

    /*mapping['project_officer'] = this.projectOfficer;
    mapping['date'] = this.date;
    mapping['name'] = this.name;
    mapping['email_address'] = this.emailAddress;
    mapping['call_number'] = this.callNumber;
    mapping['street_address'] = this.streetAddress;
    mapping['island'] = this.island;
    mapping['home_number'] = this.homeNumber;
    mapping['settlement'] = this.settlement;*/
    //damageSnaps = json['damage-snaps'].cast<String>();

    return mapping;
  }

  AssesmentDataBaseModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];

    requestKey = map['request_key'];
    eaveFlashingInches = map['eave_flashing_inches'];
    eaveFlashingFeet = map['eave_flashing_feet'];
    fasciaBoardFeet = map['fascia_board_feet'];

    fasciaBoardInches = map['fascia_board_inches'];
    soffitHeightFeet = map['soffit_height_feet'];
    soffitHeightInches = map['soffit_height_inches'];
    soffitWidthFeet = map['soffit_width_feet'];
    soffitWidthInches = map['soffit_width_inches'];
    soffitType = map['soffit_type'];
    shinglesHeightFeet = map['shingles_height_feet'];
    shinglesHeightInches = map['shingles_height_inches'];
    shinglesWidthFeet = map['shingles_width_feet'];
    shinglesWidthInches = map['shingles_width_inches'];
    shingleStyle = map['shingle_style'];
    plywoodHeightFeet = map['plywood_height_feet'];
    plywoodHeightInches = map['plywood_height_inches'];
    plywoodWidthFeet = map['plywood_width_feet'];
    plywoodWidthInches = map['plywood_width_inches'];
    iceAndWaterShieldHeightFeet = map['ice_and_water_shield_height_feet'];
    iceAndWaterShieldHeightInches = map['ice_and_water_shield_height_inches'];
    iceAndWaterShieldWidthFeet = map['ice_and_water_shield_width_feet'];
    iceAndWaterShieldWidthInches = map['ice_and_water_shield_width_inches'];
    toughGuardHeightFeet = map['tough_guard_height_feet'];
    toughGuardHeightInches = map['tough_guard_height_inches'];
    toughGuardWidthFeet = map['tough_guard_width_feet'];
    toughGuardWidthInches = map['tough_guard_width_inches'];
    torchOnHeightFeet = map['torch_on_height_feet'];
    torchOnHeightInches = map['torch_on_height_inches'];
    torchOnWidthFeet = map['torch_on_width_feet'];
    torchOnWidthInches = map['torch_on_width_inches'];
    type = map['type'];
    windowStyle = map['window_style'];
    quantity = map['quantity'];
    sizeHeightFeet = map['size_height_feet'];
    sizeHeightInches = map['size_height_inches'];
    sizeWidthFeet = map['size_width_feet'];
    sizeWidthInches = map['size_width_inches'];
    typeOne = map['type_one'];
    windowStyleOne = map['window_style_one'];
    quantityOne = map['quantity_one'];
    sizeHeightFeetOne = map['size_height_feet_one'];
    sizeHeightInchesOne = map['size_height_inches_one'];
    sizeWidthFeetOne = map['size_width_feet_one'];
    sizeWidthInchesOne = map['size_width_inches_one'];
    typeTwo = map['type_two'];
    windowStyleTwo = map['window_style_two'];
    quantityTwo = map['quantity_two'];
    sizeHeightFeetTwo = map['size_height_feet_two'];
    sizeHeightInchesTwo = map['size_height_inches_two'];
    sizeWidthFeetTwo = map['size_width_feet_two'];
    sizeWidthInchesTwo = map['size_width_inches_two'];
    location = map['location'];
    doorType = map['door_type'];
    orientation = map['orientation'];
    doorQuantity = map['door_quantity'];
    doorSizeHeightFeet = map['door_size_height_feet'];
    doorSizeHeightInches = map['door_size_height_inches'];
    doorSizeWidthFeet = map['door_size_width_feet'];
    doorSizeWidthInches = map['door_size_width_inches'];
    locationOne = map['location_one'];
    doorTypeOne = map['door_type_one'];
    orientationOne = map['orientation_one'];
    doorQuantityOne = map['door_quantity_one'];
    doorSizeHeightFeetOne = map['door_size_height_feet_one'];
    doorSizeHeightInchesOne = map['door_size_height_inches_one'];
    doorSizeWidthFeetOne = map['door_size_width_feet_one'];
    doorSizeWidthInchesOne = map['door_size_width_inches_one'];
    locationTwo = map['location_two'];
    doorTypeTwo = map['door_type_two'];
    orientationTwo = map['orientation_two'];
    doorQuantityTwo = map['door_quantity_two'];
    doorSizeHeightFeetTwo = map['door_size_height_feet_two'];
    doorSizeHeightInchesTwo = map['door_size_height_inches_two'];
    doorSizeWidthFeetTwo = map['door_size_width_feet_two'];
    doorSizeWidthInchesTwo = map['door_size_width_inches_two'];
    serviceEntrance = map['service_entrance'];
    servicePole = map['service_pole'];
    meterCanSize = map['meter_can_size'];
    meterSwitchSize = map['meter_switch_size'];
    interiorFlooding = map['interior_flooding'];
    floodingHeightFeet = map['flooding_height_feet'];
    floodingHeightInches = map['flooding_height_inches'];
    groundRod = map['ground_rod'];
    groundClamp = map['ground_clamp'];
    groundWire = map['ground_wire'];
    waterSupply = map['water_supply'];
    waterCloset = map['water_closet'];
    s12ServicePipe = map['onebytwo_service_pipe'];
    lengthOfDamageFeet = map['length_of_damage_feet'];
    lengthOfDamageInches = map['length_of_damage_inches'];
    s34ServicePipe = map['threebyfour_service_pipe'];
    lengthOfDamageFeetOne = map['length_of_damage_feet_one'];
    lengthOfDamageInchesOne = map['length_of_damage_inches_one'];
    s1ServicePipe = map['one_service_pipe'];
    lengthOfDamageFeetTwo = map['length_of_damage_feet_two'];
    lengthOfDamageInchesTwo = map['length_of_damage_inches_two'];
    additionalComment = map['additional_comment'];
    damageSnaps = map['damage_snaps'];
    material = map['material'];
    materialOne = map['material_one'];
    materialTwo = map['material_two'];
    name = map['name'];
    emailAddress = map['email_address'];
    eaveFlashingSize = map['eave_flashing_size'];
    fasciaBoardSizeInchesOne = map['fascia_board_size_inches_one'];
    colonialStyleTwo = map['colonial_style_two'];
    fasciaBoardSizeInchesTwo = map['fascia_board_size_inches_two'];
    colonialStyleOne = map['colonial_style_one'];
    colonialStyle = map['colonial_style'];
  }
}
