package mathandphy

import "base:intrinsics"
import "core:fmt"

gauss_elimintaion :: proc(a: $T/[][]$E, b: $TT/[]E, n: int)
where intrinsics.type_is_numeric(E)
{
    i,j,k : int
    lambda : E

    if n != len(a) || n != len(b) || len(b) != len(a) {
        fmt.panicf("Bro, lenght of a and b should match the n")
    }

    // elimnitaion phase
    for k = 0; k < n-1; k+=1 {
        for i = k+1; i < n; i+=1 {
            if a[i][k] != 0 {
                lambda = a[i][k] / a[k][k]

                for j = k+1; j < n; j+=1 {
                    a[i][j] = a[i][j] - (lambda * a[k][j])
                }

                b[i] = b[i] - (lambda * b[k])
            }
        }
    }

    fmt.printfln("a:%v\nb:%v\n", a, b)

    for k = n-1; k>-1; k-=1 {
        temp_sum := dot(a[k][k+1:n], b[k+1:n])
        fmt.printfln("temp_sum = %v", temp_sum)
        sum : E = 0.0
        if len(temp_sum) == 0 {
            sum += 0
        } else {
            for i in 0..<len(temp_sum) {
                sum += temp_sum[i]
            }
        }
        sum = (b[k] - sum)

        //sum := prod(temp_sum)
        b[k] = sum / a[k][k]
        fmt.printfln("k=%v, a = %v, b = %v\nb[k]=%v, sum=%v, a[%v][%v]=%v\n",
            k, a[k][k+1:n], b[k+1:n],
            b[k], sum, k, k, a[k][k])

        //defer delete(temp_sum)
    }

    fmt.printfln("a:%v\nb:%v", a, b)

}
