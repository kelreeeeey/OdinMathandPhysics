package mathandphy

import "core:math"
import "base:intrinsics"

sinc :: proc(x: $T) -> T where intrinsics.type_is_numeric(T) {
    phi_x := math.PI * x
    if phi_x == 0 { return T(1) }
    else { return  T(math.sin(phi_x)/phi_x) }
}

cosc :: proc(x: $T) -> T where intrinsics.type_is_numeric(T) {
    phi_x := math.PI * x
    if phi_x == 90 { return T(1) }
    else { return  T(math.cos(phi_x)/phi_x) }
}
