use <Choc_Chicago_Steno.scad>
use <Choc_Chicago_Steno_Convex.scad>
use <Choc_Chicago_Steno_Thumb.scad>

module gen_sprued_keycaps(keycap_ids, spacing=18, spru_radius=0.8) {
    translate([0, -spacing * 1, 0])
        cs_spru(keycap_ids=keycap_ids, spacing=spacing);
}

available_keycaps = [
    // keycap_id, variation, keyID, width, stemRot, mirror, homing dots, homing bar

    // Top and bottom rows (R2)
    ["cs_r2_1",          1, 0, 1.00, 0, false, false, false],
    ["cs_r2_125",        1, 5, 1.25, 0, false, false, false],
    ["cs_r2_15",         1, 7, 1.50, 0, false, false, false],
    ["cs_r2_175",        1, 9, 1.75, 0, false, false, false],
    ["cs_r2_2",          1, 7, 2.00, 0, false, false, false],
    ["cs_r2_225",        1, 7, 2.25, 0, false, false, false],

    // Middle Rows (R3)
    ["cs_r3_1",         1,  1, 1.00,  0, false, false, false],
    ["cs_r3_1_dot",     1,  1, 1.00,  0, false, true,  false],
    ["cs_r3_1_bar",     1,  1, 1.00,  0, false, false, true],
    ["cs_r3_125",       1,  6, 1.25,  0, false, false, false],
    ["cs_r3_125_dot",   1,  6, 1.25,  0, false, true,  false],
    ["cs_r3_125_bar",   1,  6, 1.25,  0, false, false, true],
    ["cs_r3_15",        1,  8, 1.50,  0, false, false, false],
    ["cs_r3_175",       1, 10, 1.75,  0, false, false, false],
    ["cs_r3_2",         1, 12, 2.00,  0, false, false, false],
    ["cs_r3_225",       1, 14, 2.25,  0, false, false, false],

    // Convex
    ["cs_r2x_1",        2,  0, 1.00,  0, false, false, false],
    ["cs_r3x_1",        2,  1, 1.00,  0, false, false, false],

    // Thumbs
    ["cs_t_1",          3,  2, 1.00,  0, false, false, false],
    ["cs_t_1_mirrored", 3,  2, 1.00,  0, true, false, false],
    ["cs_t_15",         3,  3, 1.00, 90, false, false, false],
    ["cs_t_15_mirrored",3,  3, 1.00, 90, true, false, false],
    ["cs_t_2",          3,  4, 1.00, 90, false, false, false],
    ["cs_t_2_mirrored", 3,  4, 1.00, 90, true, false, false],
];

function get_keycap(keycap_id) = [
  for (keycap = available_keycaps)
  if (keycap[0] == keycap_id)
  keycap
];

module cs_spru(keycap_ids, spacing=18, radius=0.8) {
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
                cylinder(h = 3, r = radius, $fn=12);
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
    variation = keycap[1];
    keycap_key_id = keycap[2];
    keycap_width = keycap[3];
    keycap_stem_rot = keycap[4];
    keycap_mirrored = keycap[5];
    keycap_dot = keycap[6];
    keycap_bar = keycap[7];
    echo ("building: ", keycap, " width: ", keycap_width, " keycap_key_id: ", keycap_key_id);

    if(keycap_width > 1 && keycap_mirrored == true) {

        mirror([0, 1, 0])
        rotate([0, 0, 90])
        translate([0, 0.5, 0])
            cs_default(
                keycap_key_id, variation, keycap_stem_rot,
                dot=keycap_dot, bar=keycap_bar
            );
    } else if(keycap_width > 1 && keycap_mirrored == false) {

        rotate([0, 0, 90])
        translate([0, 0.5, 0])
            cs_default(
                keycap_key_id, variation, keycap_stem_rot,
                dot=keycap_dot, bar=keycap_bar
            );
    } else if(keycap_width <= 1 && keycap_mirrored == true) {

        mirror([1, 0, ])
            cs_default(
                keycap_key_id, variation, keycap_stem_rot,
                dot=keycap_dot, bar=keycap_bar
            );
    } else {

        cs_default(
            keycap_key_id, variation, keycap_stem_rot,
            dot=keycap_dot, bar=keycap_bar
        );
    }
}

module cs_default(keyID, variation=1, stem_rot=0, dot=false, bar=false) {
    echo("keyID", keyID)

    if(variation == 1) {
        keycap_cs(
            keyID  = keyID, //change profile refer to KeyParameters Struct
            Stem   = true, //turns on shell and stems
            StemRot = stem_rot,//change stem orientation by deg
            Dish = true,
            visualizeDish=false,
            crossSection=false,
            homeDot = dot,
            homeBar = bar
        );
    } else if(variation == 2) {
        keycap_cs_convex(
            keyID  = keyID, //change profile refer to KeyParameters Struct
            Stem   = true, //turns on shell and stems
            StemRot = stem_rot,//change stem orientation by deg
            Dish = true,
            visualizeDish=false,
            crossSection=false,
            homeDot = dot
        );
    } else if(variation == 3) {
        keycap_cs_thumb(
            keyID  = keyID, //change profile refer to KeyParameters Struct
            Stem   = true, //turns on shell and stems
            StemRot = stem_rot,//change stem orientation by deg
            Dish = true,
            visualizeDish=false,
            crossSection=false,
            homeDot = dot
        );
    }
}


