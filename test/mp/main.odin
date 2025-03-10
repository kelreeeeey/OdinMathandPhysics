#+feature dynamic-literals
package main_mathandphysics

import "core:fmt"
import "core:math"
import "core:c"
import mp "../../mathandphysics"


test_trig :: proc() {

    fmt.println("\nTest: Trigonometries and frens")
    x:f32 =46
    xs := []c.double{10, 20, 30, 50, 70}
    sinc_x := mp.sinc(x, c.double)
    sinc_xs := mp.sinc(xs, c.double)
    cosc_x := mp.cosc(x)

    for i in 0..<len(xs) {
        fmt.printfln("sinc(xs[%v]=[%v])=[%v]",
            i, xs[i], sinc_xs[i]) }
    fmt.printfln("================\nsinc(%v)=%v, cosc(%v)=%v",
        x, sinc_x,
        x, cosc_x)
}

test_utils :: proc() {
    fmt.println("\nTest: Utils - Linear Spacing")

    {
        start, end : f64= 2.0, 3.0
        n_smpl :int=5
        lnsp, step, unexpected_behaviour := mp.linear_spacing(start, end, n_smpl)
        if unexpected_behaviour == nil {
            fmt.printfln("Linear spacing from [%v, %v] with %v samples:\n\t%v, with %v step ",
            start, end, n_smpl, lnsp, step)  }
    }

    { // unexpected behaviour catched!, n_sample ideally should always be positive number!
        start, end : f64= 2.0, 10.0
        n_smpl :int=0
        lnsp, step, unexpected_behaviour := mp.linear_spacing(start, end, n_smpl)
        if unexpected_behaviour != nil {
            fmt.printfln(
                "Unexpected Consequence [%v] || Linear spacing from [%v, %v] with %v samples:\n\t%v, with %v step ",
            unexpected_behaviour, start, end, n_smpl, lnsp, step)  }
    }

    {

        start, end : f64= 2.0, 5
        n_smpl :int=10
        lnsp, step, unexpected_behaviour := mp.linear_spacing(start, end, n_smpl)
        if unexpected_behaviour == nil
        {
            fmt.printfln("Linear spacing from [%v, %v] with %v samples:\n\t%v, with %v step ",
                start, end, n_smpl, lnsp, step)
        }
    }

    fmt.println("\nTest: Utils - Geometric Spacing")
    { // geometrics 
        start, end : f64= 1.0, 1000.0
        n_smpl :int=4
        lnsp, step, unexpected_behaviour := mp.geometric_spacing(start, end, n_smpl)
        if unexpected_behaviour == nil {
            fmt.printfln(
                "Unexpected Consequence [%v] || Linear spacing from [%v, %v] with %v samples:\n\t%v, with %v step ",
            unexpected_behaviour, start, end, n_smpl, lnsp, step)  }
    }

    {
        a := matrix[2, 3]f32{
            2, 3, 1,
            4, 5, 0,
        }

        b := matrix[3, 2]f32{
            1, 2,
            3, 4,
            5, 6,
        }

        fmt.println("\n\n\na", a)
        fmt.println("b", b)

        c := a * b + 10
        #assert(type_of(c) == matrix[2, 2]f32)
        fmt.println("\n\n\nc = a * b", c)
    }


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
    test_utils()
    fmt.println("Math and Physics OdinLib")
    //example_plot_sinc_gnuplot()
    //test_matrixops()
    //test_tensors()
}
