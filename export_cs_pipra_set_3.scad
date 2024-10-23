// Lateral preset for the Pipra with rotated inner index

use <gen_sprued_keycaps.scad>

keycap_ids = [
    // Left Side
    "cs_r2_lateral_l" ,    // Top Alpha
    "cs_r3_lateral_l_rot", // Top Alpha Rotated
    "cs_r2_lateral_l",     // Home Row
    "cs_r4_lateral_l",     // Bottom Alpha

    // Right Side
    "cs_r2_lateral_r" ,    // Top Alpha
    "cs_r3_lateral_r_rot", // Top Alpha Rotated
    "cs_r2_lateral_r",     // Home Row
    "cs_r4_lateral_r",     // Bottom Alpha

    // Homing
    "cs_r3_lateral_l_dot",    // Left Homing
    "cs_r3_lateral_r_dot",    // Right Homing
];

gen_sprued_keycaps(keycap_ids, vertical=true);
