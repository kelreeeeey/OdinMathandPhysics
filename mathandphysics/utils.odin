package mathandphy

import "core:math/linalg"
import "core:slice"
import "base:intrinsics"

convert_slice_vanilla :: proc($T: typeid, s: []$S) -> []T {
    result := make([]T, len(s))
    for v, i in s {
        result[i] = T(v)
    }
    return result
}

convert_slice_with_addition :: proc($T: typeid, s: []$S, scalar: T) -> []T {
    result := make([]T, len(s))
    for v, i in s {
        result[i] = T(v) + scalar
    }
    return result
}

convert_slice :: proc { convert_slice_vanilla, convert_slice_with_addition }

//where_comp_1d_array_vanilla :: proc(s: $T/[]$S, $NUM: typeid) -> []bool
//where intrinsics.type_is_numeric(S),
//      intrinsics.type_is_numeric(NUM) {
//          len_input := len(s)
//          out_mask := make([]bool, len_input)
//          for i in 0..<len_input {
//              if s[i]
//          }
//
//      }

NumberSets :: enum {
   ExpectZeroOnly,
   ExpectNegativeIntegerOnly,
   ExpectNegativeFloatOnly,
   ExpectNegativeOnly,
   ExpectPositiveIntegerOnly,
   ExpectPositiveFloatOnly,
   ExpectPositiveOnly,
   ExpectIntegerOnly,
   ExpectFloatOnly
}

linear_spacing :: proc(
    start: $T,
    end: $D,
    samples:int
) -> ([]f32, f32, NumberSets)
    where intrinsics.type_is_numeric(T),
          intrinsics.type_is_numeric(D) {

    err : NumberSets
    range: f32 = f32(end-start)

    if samples <= 0 {
        array:= make([]f32, 2)
        array[0] = f32( start )
        array[1] = f32( end )
        err := NumberSets.ExpectPositiveOnly
        return array, range, err
    }

    steps := range / f32( samples)
    array := make([]f32, samples+1)
    array[0] = f32(start)
    for i in 1..<len(array) {
        array[i] = array[i-1]+steps
    }
    return array, steps, nil
}

geometric_spacing :: proc(
    start: $T,
    end: $D,
    samples:int
) -> ([]f32, f32, NumberSets)
    where intrinsics.type_is_numeric(T),
          intrinsics.type_is_numeric(D) {

    err : NumberSets
    range: f32 = f32(end-start)

    if samples <= 0 {
        array:= make([]f32, 2)
        array[0] = f32( start )
        array[1] = f32( end )
        err := NumberSets.ExpectPositiveOnly
        return array, range, err
    }

    // a^n = a_0 \times r^{n-1}
    // factor = r = \( \frac{a^n}{a_0} \)^{1/n-1}
    factor := linalg.pow(f32(end)/ f32(start), 1.0/f32(samples-1))
    array := make([]f32, samples+1)
    array[0] = f32(start)
    for i in 1..<len(array) {
        array[i] = array[i-1]*factor
    }
    return array, factor, nil
}


diagonal_NN_array :: proc(a: $T/[][]$E) -> []E
where intrinsics.type_is_numeric(E) {


    len_a := len(a)
    len_a0 := len(a[0])

    // TODO: ASSURE A IS NxN array
    if len_a != len_a0 {
        panic("a is not an n*n array")
    }

    out := make([]E, len_a0)

    for i in 0..<len_a {
        for j in 0..<len_a0 {
            if i == j {
                out[i] = a[i][j]
            }
        }
    }

    return out

}

diagonal :: proc { diagonal_NN_array }

//NumberErrors :: enum {
//    ZeroError,
//    NegativeError,
//    PositiveError,
//}

