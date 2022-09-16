import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql =
        "CREATE TABLE users (id INTEGER PRIMARY KEY,request_key TEXT,eave_flashing_inches TEXT,eave_flashing_feet Text,fascia_board_feet TEXT,fascia_board_inches TEXT,soffit_height_feet TEXT,soffit_height_inches TEXT,soffit_width_feet TEXT,soffit_width_inches TEXT,soffit_type TEXT,shingles_height_feet TEXT,shingles_height_inches TEXT,shingles_width_feet TEXT,shingles_width_inches TEXT,shingle_style TEXT,plywood_height_feet TEXT,plywood_height_inches TEXT,plywood_width_feet TEXT,plywood_width_inches TEXT,ice_and_water_shield_height_feet TEXT,ice_and_water_shield_height_inches TEXT,ice_and_water_shield_width_feet TEXT,ice_and_water_shield_width_inches TEXT,tough_guard_height_feet TEXT,tough_guard_height_inches TEXT,tough_guard_width_feet TEXT,tough_guard_width_inches TEXT,torch_on_height_feet TEXT,torch_on_height_inches TEXT,torch_on_width_feet TEXT,torch_on_width_inches TEXT,type TEXT,window_style TEXT,quantity TEXT,size_height_feet TEXT,size_height_inches TEXT,size_width_feet TEXT,size_width_inches TEXT,type_one TEXT,window_style_one TEXT,quantity_one TEXT,size_height_feet_one TEXT,size_height_inches_one TEXT,size_width_feet_one TEXT,size_width_inches_one TEXT,type_two TEXT,window_style_two TEXT,quantity_two TEXT,size_height_feet_two TEXT,size_height_inches_two TEXT,size_width_feet_two TEXT,size_width_inches_two TEXT,location TEXT,door_type TEXT,orientation TEXT,door_quantity TEXT,door_size_height_feet TEXT,door_size_height_inches TEXT,door_size_width_feet TEXT,door_size_width_inches TEXT,location_one TEXT,door_type_one TEXT,orientation_one TEXT,door_quantity_one TEXT,door_size_height_feet_one TEXT,door_size_height_inches_one TEXT,door_size_width_feet_one TEXT,door_size_width_inches_one TEXT,location_two TEXT,door_type_two TEXT,orientation_two TEXT,door_quantity_two TEXT,door_size_height_feet_two TEXT,door_size_height_inches_two TEXT,door_size_width_feet_two TEXT,door_size_width_inches_two TEXT,service_entrance TEXT,service_pole TEXT,meter_can_size TEXT,meter_switch_size TEXT,interior_flooding TEXT,flooding_height_feet TEXT,flooding_height_inches TEXT,ground_rod TEXT,ground_clamp TEXT,ground_wire TEXT,water_supply TEXT,water_closet TEXT,onebytwo_service_pipe TEXT,length_of_damage_feet TEXT,length_of_damage_inches TEXT,threebyfour_service_pipe TEXT,length_of_damage_feet_one TEXT,length_of_damage_inches_one TEXT,one_service_pipe TEXT,length_of_damage_feet_two TEXT,length_of_damage_inches_two TEXT,additional_comment TEXT,damage_snaps TEXT,material TEXT,material_one TEXT,material_two TEXT,name TEXT,email_address TEXT,eave_flashing_size TEXT,fascia_board_size_inches_one TEXT,fascia_board_size_inches_two TEXT,colonial_style TEXT,colonial_style_one TEXT,colonial_style_two TEXT);";
    await database.execute(sql);
  }
}
//,door_quantity_two TEXT,door_size_height_feet_two TEXT,door_size_height_inches_two TEXT,door_size_width_feet_two TEXT,door_size_width_inches_two TEXT,service_entrance TEXT,service_pole TEXT,meter_can_size TEXT,meter_switch_size TEXT,interior_flooding TEXT,flooding_height_feet TEXT,flooding_height_inches TEXT,ground_rod TEXT,