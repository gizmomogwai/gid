//!repo Vte-3.91

//!subdtype Align AlignVte

//# Set basic parameters to out
//!set record[EventContext].method[get_coordinates].parameters.parameter[x][direction] out
//!set record[EventContext].method[get_coordinates].parameters.parameter[y][direction] out

//# Disable some problematic deprecated methods
//!set class[Terminal].method[get_text][ignore] 1
//!set class[Terminal].method[get_text_include_trailing_spaces][ignore] 1
//!set class[Terminal].method[get_text_range][ignore] 1
