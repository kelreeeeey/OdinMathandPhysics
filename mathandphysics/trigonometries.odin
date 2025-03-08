package mathandphy

import "core:math"
import "base:intrinsics"

sinc_default :: proc(x: $T) -> T
    where intrinsics.type_is_numeric(T) {
    phi_x := math.PI * f32(x)
    if phi_x == 0 { return T(1) }
    else { return  T(math.sin(phi_x)/phi_x) }
}


sinc_with_dtype :: proc(x: $T, $D:typeid) -> D
    where intrinsics.type_is_numeric(T),
          intrinsics.type_is_numeric(D) {
    phi_x := math.PI * f32(x)
    if phi_x == 0 { return D(1) }
    else { return  D(math.sin(phi_x)/phi_x) }
}

cosc_default :: proc(x: $T) -> T
    where intrinsics.type_is_numeric(T) {
    phi_x := math.PI * f32(x)
    if sinc(x-T(90)) != T(0) {return T(1)}
    else { return  T(math.cos(phi_x)/phi_x) }
}
cosc_with_dtype :: proc(x: $T, $D:typeid) -> D
    where intrinsics.type_is_numeric(T),
          intrinsics.type_is_numeric(D) {
    phi_x := math.PI * f32(x)
    if sinc_with_dtype(D(x-90), D) != D(0) {return D(1)}
    else { return  D(math.cos(phi_x)/phi_x) }
}

sinc :: proc { sinc_default, sinc_with_dtype }
cosc :: proc { cosc_default, cosc_with_dtype }
