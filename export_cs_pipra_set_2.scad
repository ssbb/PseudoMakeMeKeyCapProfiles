// Home row and extra variations for inner index

use <gen_sprued_keycaps.scad>

keycap_ids = [
    // Home row
    "cs_r3_1",
    "cs_r3_1",
    "cs_r3_1",
    "cs_r3_1",
    "cs_r3_1",
    "cs_r3_1",

    // R2 top inner indnex
    "cs_r2_lateral_l_rot",
    "cs_r2_lateral_r_rot",

    // R3 bottom inner index
    "cs_r3_lateral_l",
    "cs_r3_lateral_r"
];

gen_sprued_keycaps(keycap_ids, vertical=true);
