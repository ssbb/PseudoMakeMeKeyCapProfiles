use <gen_sprued_keycaps.scad>

keycap_ids = [
    // Left Keyboard Side
    "cs_t_1" ,          // 1u outer
    "cs_r2x_1_bottom",  // Convex middle key
    "cs_t_1_mirrored",  // 1u inner
    "cs_t_15_mirrored", // 1.5u inner (corne style)

    // Right Keyboard Side
    "cs_t_15",          // 1.5u inner (corne style)
    "cs_t_1",           // 1u inner
    "cs_r2x_1_bottom",  // Convex middle key
    "cs_t_1_mirrored",  // 1u outer

    // Convex middle keys with increased height
    "cs_r3x_1",
    "cs_r3x_1",
];

gen_sprued_keycaps(keycap_ids);
