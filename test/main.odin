#+feature dynamic-literals
package main_mathandphysics

import "core:fmt"
import "core:math"
import mp "../mathandphysics"


test_trig :: proc() {

    fmt.println("\nTest: Trigonometries and frens")
    x:f32 =-90
    sinc_x := mp.sinc(x, f64)
    cosc_x := mp.cosc(x)

    //fmt.printfln("================\nsinc(%v)=%v", x, sinc_x)
    fmt.printfln("================\nsinc(%v)=%v, cosc(%v)=%v",
        x, sinc_x,
        x, cosc_x)
}

test_matrixops :: proc() {

    fmt.println("\nTest: Matrix Operations")

    xInt:= []int{3, 5, 9, 10, 2}
    yInt:= []int{1, 2,10, 20, 8}

    xyInt := mp.outer_product(xInt, yInt)

    x64:= []f64{3, 5, 9, 10, 2}
    y64:= []f64{1, 2,10, 20, 8}

    xy64 := mp.outer_product(x64, y64)
    xInty64 := mp.outer_product(xInt, y64) // output would be type of []int, (the first argument's type)
    x64yInt_tof32 := mp.cast_outer_product(f32, x64, yInt) // output would be type of [][]f32

    fmt.printfln("================\nxInt(%v)= %v | yInt(%v)= %v",
        typeid_of(type_of(xInt)), xInt, typeid_of(type_of(yInt)), yInt)
    fmt.printfln("OutProd xInt-yInt(%v)= %v",
        typeid_of(type_of(xyInt)), xyInt)
    fmt.printfln("================\nx64(%v)= %v | y64(%v)= %v",
        typeid_of(type_of(x64)), x64, typeid_of(type_of(y64)), y64)
    fmt.printfln("OutProd x64-y64(%v)= %v", typeid_of(type_of(xy64)), xy64)
    fmt.printfln("================\nxInt(%v)= %v | y64(%v)= %v",
        typeid_of(type_of(xInt)), xInt, typeid_of(type_of(y64)), y64)
    fmt.printfln("OutProd xInt-y64(%v)= %v",
        typeid_of(type_of(xInty64)), xInty64)
    fmt.printfln("================\nx64(%v)= %v | yInt(%v)= %v",
        typeid_of(type_of(x64)), x64, typeid_of(type_of(yInt)), yInt)
    fmt.printfln("OutProd x64-yInt(%v)= %v",
        typeid_of(type_of(x64)), yInt)
    fmt.printfln("OutProd x64-yInt-casted to f32(%v)= %v",
        typeid_of(type_of(x64yInt_tof32)), x64yInt_tof32)

}

test_tensors :: proc() {

    fmt.println("\nTest: Tensor")

    f_n:= mp.Tensor(f32, 1)
    fnT :typeid= type_of(f_n)
    f_nn:= mp.Tensor(f32, 2)
    fnnT : type_of(f_nn)
    f_n.data = [dynamic]f32{1,2,3,4,5}
    f_nn.data = [dynamic]type_of(f_n){ f_n, f_n }
    fmt.println(f_n)
    fmt.println(f_nn)
    fmt.println(f_nn.data[0], f_nn.data[1].data[:])

}

main :: proc() {
    fmt.println("Math and Physics OdinLib")
    test_trig()
    test_matrixops()
    test_tensors()
}
