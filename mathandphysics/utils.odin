package mathandphy

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

