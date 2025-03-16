package mathandphy

import "base:intrinsics"

outer_product :: proc(x: $T/[]$E, y: $TT/[]$S) -> [][]E
    where intrinsics.type_is_numeric(E), intrinsics.type_is_numeric(S) {
    result := make([][]E, len(x))
    for i in 0..<len(x) {
        result[i] = make([]E, len(y))
        for j in 0..<len(y) {
            result[i][j] = x[j] * E( y[i] )  // Direct element-wise product
        }
    }
    return result
}

prod_1D :: proc(x: $T/[]$E) -> E
    where intrinsics.type_is_numeric(E)
{
    prod : E = 0.0
    for i in 0..<len(x) {
        prod += x[i]
    }
    return prod
}

prod_2D :: proc(x: $T/[][]$E) -> E
    where intrinsics.type_is_numeric(E)
{
    prod : E = 1.0
    len_x := len(x)
    len_x0 := len(x[0])
    for i in 0..<len_x {
        for j in 0..<len_x0 {
            prod *= x[i][j]
        }
    }
    return prod
}

//prod_2D_axis :: proc(x: $T/[][]$E, axis: int) -> []E
//    where intrinsics.type_is_numeric(E)
//{
//    prod : []E
//    len_x := len(x)
//    len_x0 := len(x[0])
//    if axis == 0 { prod = make([]E, len_x)}
//    if axis == 1 { prod = make([]E, len_x0)}
//    for i in 0..<len_x {
//        for j in 0..<len_x0 {
//            if axis == 0 {
//                prod[i] =
//            }
//            prod = x[i][j]
//        }
//    }
//    return prod
//}


prod :: proc { prod_1D, prod_2D }

dotprod_1Dx1D :: proc(x: $T/[]$E, y: $TT/[]$S) -> []E
    where intrinsics.type_is_numeric(E),
          intrinsics.type_is_numeric(S)
{
    len_x := len(x)
    prod : = make([]E, len_x)
    for i in 0..<len_x {
        sum : E = 0.0
        for j in 0..<len_x {
            sum += (x[i] * y[j])
        }
        prod[i] = sum
    }
    return prod
}

dotprod_2Dx1D :: proc(x: $T/[][]$E, y: $TT/[]$S) -> []E
    where intrinsics.type_is_numeric(E),
          intrinsics.type_is_numeric(S)
{
    len_x := len(x)
    len_x0 := len(x[0])
    prod := make([]E, len_x)
    for i in 0..<len_x {
        for j in 0..<len_x0 {
            prod[i] += (x[i][j] * cast(E)y[i])
        }
    }
    return prod
}

dot :: proc { dotprod_1Dx1D, dotprod_2Dx1D }

cast_outer_product :: proc($T: typeid, x: $TT/[]$E, y: $TTT/[]$S) -> [][]T
where intrinsics.type_is_numeric(T), intrinsics.type_is_numeric(E), intrinsics.type_is_numeric(S) {
    result := make([][]T, len(x))
    for i in 0..<len(x) {
        result[i] = make([]T, len(y))
        for j in 0..<len(y) {
            result[i][j] = T( x[i] ) * T( y[j] )  // Direct element-wise product
        }
    }
    return result
}
