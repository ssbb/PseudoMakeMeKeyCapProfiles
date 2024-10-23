// Top alpha, bottom alpha and thumbs

use <gen_sprued_keycaps.scad>

keycap_ids = [
    // Top alpha
    "cs_r2_1",
    "cs_r2_1",
    "cs_r2_1",
    "cs_r2_1",

    // Bottom alpha
    "cs_r4_1",
    "cs_r4_1",
    "cs_r4_1",
    "cs_r4_1",

    // Thumbs
    "cs_t_1_l",
    "cs_t_1_r"
];

gen_sprued_keycaps(keycap_ids, vertical=true);
