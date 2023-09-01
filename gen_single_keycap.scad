use <gen_sprued_keycaps.scad>

keycap_id = undef;
echo(keycap_id=keycap_id)
assert(keycap_id != undef, str("Please specify the keycap_id using -Dkeycap_id=cs_r2_1."))

gen_sprued_keycaps([keycap_id]);
