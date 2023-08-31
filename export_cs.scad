use <Choc_Chicago_Steno.scad>
spru_n = 2;
spacing = 18.0 ;
spru_radius = 0.8;

keycap_ids = ["cs_r3_1"];

union() {
//    translate([0, -spacing * 0, 0])  cs_spru(row=3, width= 1.25);
    translate([0, -spacing * 1, 0])  cs_spru(keycap_ids=keycap_ids, w=1.25);
//    translate([0, -spacing * 2, 0])  cs_spru(row=3, w=1.25, bar=true);
//    translate([0, -spacing * 1, 0])  cs_spru(row=3, width=1.25);
//    translate([0, -spacing * 2, 0])  cs_spru(row=3, width=1.50);
//    translate([0, -spacing * 3, 0])  cs_spru(row=3, width=1.75);
//    translate([0, -spacing * 4, 0])  cs_spru(row=3, width=2.00);
//    translate([0, -spacing * 5, 0])  cs_spru(row=3, width=2.25);
//
//    translate([0, -spacing * 7, 0])  cs_spru(row=2);
//    translate([0, -spacing * 1, 0])  cs_spru(row=2, width=1.25);
//    translate([0, -spacing * 9, 0])  cs_spru(row=2, width=1.50);
//    translate([0, -spacing * 10, 0])  cs_spru(row=2, width=1.75);
//    translate([0, -spacing * 11, 0])  cs_spru(row=2, width=2.00);
//    translate([0, -spacing * 12, 0])  cs_spru(row=2, width=2.25);
}



function selector(item) = [
  for (spec = available_specs)
  if (spec[0] == item)
  spec
];

module cs_spru(keycap_ids, width=1, radius=spru_radius) {
    echo ("Keycap ids: ", keycap_ids, " width: ", width, " radius: ", radius);

    if (n > 1) {
        union() {
            for (i = [0 : n - 1]){
                translate([i * spacing * width, 0, 0])
                mirror([0,0,0])
                cs_keycap("cs_r2_1");
            }

            for (i = [0 : n - 1 - 1]){
                translate([(i) * spacing * width, 0, 0])
                translate([spacing / 2 + 1, 0, -0.9 * spru_radius])
                rotate([0, 90, 0])
                cylinder(h = 3, r = spru_radius, $fn=12);
            }
        }
    }
    else {
        translate([i * spacing, 0, 0])
        mirror([0,0,0])
        cs_keycap(keycap_ids[0]);
    }
}

module cs_keycap(keycap_id) {

    w=0;

    // Top and bottom rows (R2)
    if      (keycap_id == "cs_r2_1"      ) {cs_default( 0); w=1;}
    else if (keycap_id == "cs_r2_125"    ) {cs_default( 5); w=1.25;}
    else if (keycap_id == "cs_r2_15"     ) {cs_default( 7); w=1.5;}
    else if (keycap_id == "cs_r2_175"    ) {cs_default( 9); w=1.75;}
    else if (keycap_id == "cs_r2_2"      ) {cs_default(11); w=2;}
    else if (keycap_id == "cs_r2_225"    ) {cs_default(13); w=2.25;}

    // Middle Rows (R3)
    else if (keycap_id == "cs_r3_1"      ) {cs_default( 1); w=1;}
    else if (keycap_id == "cs_r3_1_dot"  ) {cs_default( 1, dot=true); w=1;}
    else if (keycap_id == "cs_r3_1_bar"  ) {cs_default( 1, bar=true); w=1;}
    else if (keycap_id == "cs_r3_125"    ) {cs_default( 6); width = 1.25;}
    else if (keycap_id == "cs_r3_125_dot") {cs_default( 6, dot=true); w=1.25;}
    else if (keycap_id == "cs_r3_125_bar") {cs_default( 6, bar=true); w=1.25;}
    else if (keycap_id == "cs_r3_15"     ) {cs_default( 8); w=1.5;}
    else if (keycap_id == "cs_r3_175"    ) {cs_default(10); w=1.75;}
    else if (keycap_id == "cs_r3_2"      ) {cs_default(12); w=2;}
    else if (keycap_id == "cs_r3_225"    ) {cs_default(14); w=2.25;}
    else {
        assert(false, concat("The keycap_id ", keycap_id, " is unknown."));
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


