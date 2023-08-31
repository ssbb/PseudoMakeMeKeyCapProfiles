use <Choc_Chicago_Steno.scad>
spru_n = 2;
spacing = 18.0 ;
spru_radius = 0.8;

keycap_ids = ["cs_r3_1", "cs_r3_125", "cs_r3_1_bar", "cs_r3_225"];

    translate([0, -spacing * 1, 0])  cs_spru(keycap_ids=keycap_ids, spacing=spacing);


available_keycaps = [
    // keycap_id, keyID, width, mirror, homing dots, homing bar

    // Top and bottom rows (R2)
    ["cs_r2_1",          0, 1.00, false, false, false],
    ["cs_r2_125",        5, 1.25, false, false, false],
    ["cs_r2_15",         7, 1.50, false, false, false],
    ["cs_r2_175",        9, 1.75, false, false, false],
    ["cs_r2_2",          7, 2.00, false, false, false],
    ["cs_r2_225",        7, 2.25, false, false, false],

    // Middle Rows (R3)
    ["cs_r3_1",          1, 1.00, false, false, false],
    ["cs_r3_1_dot",      1, 1.00, false, true,  false],
    ["cs_r3_1_bar",      1, 1.00, false, false, true],
    ["cs_r3_125",        6, 1.25, false, false, false],
    ["cs_r3_125_dot",    6, 1.25, false, true,  false],
    ["cs_r3_125_bar",    6, 1.25, false, false, true],
    ["cs_r3_15",         8, 1.50, false, false, false],
    ["cs_r3_175",       10, 1.75, false, false, false],
    ["cs_r3_2",         12, 2.00, false, false, false],
    ["cs_r3_225",       14, 2.25, false, false, false],
];

function get_keycap(keycap_id) = [
  for (keycap = available_keycaps)
  if (keycap[0] == keycap_id)
  keycap
];

module cs_spru(keycap_ids, spacing=18, radius=spru_radius) {
    echo ("Keycap ids: ", keycap_ids, " radius: ", radius);

    if (len(keycap_ids) > 1) {
        union() {
            for (i = [0 : len(keycap_ids) - 1]){

                keycap_id = keycap_ids[i];

                translate([i * spacing, 0, 0])
                mirror([0,0,0])
                cs_keycap(keycap_id);
            }

            for (i = [0 : len(keycap_ids) - 2]){
                translate([(i) * spacing + spacing / 2 - 1.5, 0, 0])
                translate([0, 0, -0.9 * radius])
                rotate([0, 90, 0])
                cylinder(h = 3, r = spru_radius, $fn=12);
            }
        }
    }
    else {
        translate([spacing, 0, 0])
        mirror([0,0,0])
        cs_keycap(keycap_ids[0]);
    }
}

module cs_keycap(keycap_id) {

    keycap = get_keycap(keycap_id)[0];
    if (keycap == undef) {
        echo ("Keycap id not found");
        echo(keycap_id=keycap_id);
        assert(keycap_id == undef);
    }
    keycap_key_id = keycap[1];
    keycap_width = keycap[2];
    keycap_mirrored = keycap[3];
    keycap_dot = keycap[4];
    keycap_bar = keycap[5];
    echo ("building: ", keycap, " width: ", keycap_width, " keycap_key_id: ", keycap_key_id);

    if(keycap_width > 1 && keycap_mirrored == true) {

        mirror(0, 1, 0)
        rotate([0, 0, 90])
        translate([0, 0.5, 0])
            cs_default(keycap_key_id, dot=keycap_dot, bar=keycap_bar);
    } else if(keycap_width > 1 && keycap_mirrored == false) {

        rotate([0, 0, 90])
        translate([0, 0.5, 0])
            cs_default(keycap_key_id, dot=keycap_dot, bar=keycap_bar);
    } else if(keycap_width <= 1 && keycap_mirrored == true) {

        mirror(0, 1, 0)
            cs_default(keycap_key_id, dot=keycap_dot, bar=keycap_bar);
    } else {

        cs_default(keycap_key_id, dot=keycap_dot, bar=keycap_bar);
    }
}

module cs_default(keyID, dot=false, bar=false) {
    echo("keyID", keyID)
    keycap_cs(
        keyID  = keyID, //change profile refer to KeyParameters Struct
        Stem   = true, //turns on shell and stems
        Dish = true,
        visualizeDish=false,
        crossSection=false,
        homeDot = dot,
        homeBar = bar
    );
}


