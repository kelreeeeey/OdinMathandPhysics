package example_mpplot

import "core:strconv"
import "core:fmt"
import "core:os"
import "core:mem"
import "core:strings"
import mp "../../mathandphysics"
import mpplt "../../mpplot"


CREATE := os.O_CREATE | os.O_TRUNC

example_plot_sinc_gnuplot :: proc()
{

    // generate normalized sin wave and it's corresponding x points
    args := os.args
    if len(args) < 3 {
        fmt.println("hi!.")
        fmt.println("Lil Bro, you need [3](THREE) args for this chad to run!")
        fmt.println("\t args[1] number of samples! (only positive numbers), ex: 10, 200, 100")
        fmt.println("\t args[2] minimum range of the wave x' points, ex: -10.111, 0.5, 10.2")
        fmt.println("\t args[3] max range of the wave x' points, ex: -5.01, 100, 3.14")
        fmt.println("\n\t here full example\n\t plot_sinc_gnuplot.exe 100 -10 1.5\n")
        panic("\nHollup!!!, check your args, bro! you sus!")
    }

    n_sample : int = strconv.atoi(args[1])
    start : f64 = strconv.atof(args[2])
    end : f64 = strconv.atof(args[3])

    if start >= end {
        fmt.println("you kidding right?! the second arg should more or equal to the third arg!")
        fmt.printfln("i got (( %v )) for right bound, and (( %v ))", start, end)
        panic("\nSo Hollup!!!, go fix yo args!")
    } else if n_sample <= 0 {
        fmt.printfln("You can not make a set of points with %v sample", n_sample)
        panic("\nSo Hollup!!!, go fix yo args!")
    }

    x_points, x_step, uxp_behave := mp.linear_spacing(start, end, n_sample)
    defer delete(x_points)
    if uxp_behave != nil {
        fmt.printfln(
            "Not cool bro!, you gave %v to %v with %v samples, what you expect!?",
            start, end, n_sample)
        panic("\nNot cool bro!, can not make array with those arguments you gave")
    } else {
        fmt.printfln(
            "Created %v data X points from %v to %v",
            n_sample, start, end)
    }

    y_points := mp.sinc(x_points)
    defer delete(y_points)

    array2d := mp.outer_product(x_points, x_points)
    defer delete(array2d)

    // Filename and gnuplot argument generator
    file_name : string
    file_name_2 : string
    //err_upper : mem.Allocator_Error
    if len(args) > 4 {
        file_name = args[4]
        //file_name_2, err_upper = strings.to_upper(file_name[:])
    } else {
        file_name = "./data_plot2d.dat"
        file_name_2 = "./another_data.dat"
    }

    defer delete(file_name)
    defer delete(file_name_2)

    mpplt.dump_gnuplot_file(x_points, y_points, file_name)
    gnup_args := mpplt.make_gnuplot_args(file_name, "' w l linewidth 1\n")
    mpplt.plot(gnup_args)

    mpplt.dump_gnuplot_file(array2d, file_name_2)
    gnup_args_2 := mpplt.make_gnuplot_args(file_name_2, "' matrix with image pixels\n")
    mpplt.imshow(gnup_args_2)

}

main :: proc() {
    example_plot_sinc_gnuplot()
}
