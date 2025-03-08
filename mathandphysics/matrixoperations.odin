package mathandphy

import "base:intrinsics"

outer_product_vanilla :: proc(x, y: []$T) -> [][]T
where intrinsics.type_is_numeric(T) {
    result := make([][]T, len(x))
    for i in 0..<len(x) {
        result[i] = make([]T, len(y))
        for j in 0..<len(y) {
            result[i][j] = x[i] * y[j]  // Direct element-wise product
        }
    }
    return result
}

outer_product_different_types :: proc(x: []$T, y: []$S) -> [][]T
where intrinsics.type_is_numeric(T) && intrinsics.type_is_numeric(S) {
    result := make([][]T, len(x))
    for i in 0..<len(x) {
        result[i] = make([]T, len(y))
        for j in 0..<len(y) {
            result[i][j] = T( x[i] ) * T( y[j] )  // Direct element-wise product
        }
    }
    return result
}

outer_product_different_types_to_target :: proc($TT: typeid, x: []$T, y: []$S) -> [][]T
where intrinsics.type_is_numeric(T) && intrinsics.type_is_numeric(S) {
    result := make([][]TT, len(x))
    for i in 0..<len(x) {
        result[i] = make([]TT, len(y))
        for j in 0..<len(y) {
            result[i][j] = TT( x[i] ) * TT( y[j] )  // Direct element-wise product
        }
    }
    return result
}

outter_product :: proc {
    outer_product_vanilla,
    outer_product_different_types,
    outer_product_different_types_to_target,
}
