package mathandphy

import "core:fmt"
import "base:intrinsics"

TensorR1 :: struct($T: typeid)
    where intrinsics.type_is_numeric(T) {
    data: [dynamic]T
}

TensorR2 :: struct($T: typeid)
    where intrinsics.type_is_numeric(T) {
    data: [dynamic]TensorR1(T)
}

TensorR3 :: struct($T: typeid)
    where intrinsics.type_is_numeric(T) {
    data: [dynamic]TensorR2(T)
}

create_T1 :: proc($T: typeid, $ND: int) -> TensorR1(T)
    where intrinsics.type_is_numeric(T),
          ND == 1{
    vec : TensorR1(T)
    return vec
}

create_T2 :: proc($T: typeid, $ND: int) -> TensorR2(T)
    where intrinsics.type_is_numeric(T),
          ND == 2 {
    vec : TensorR2(T)
    return vec
}

create_T3 :: proc($T: typeid, $ND: int) -> TensorR3(T)
    where intrinsics.type_is_numeric(T),
          ND == 3 {
    vec : TensorR3(T)
    return vec
}

Tensor :: proc { create_T1, create_T2, create_T3  }
