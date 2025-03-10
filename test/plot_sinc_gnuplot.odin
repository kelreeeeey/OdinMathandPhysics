package main_mathandphysics

import "core:sys/posix"
import "core:strconv"
import "core:fmt"
import "core:os"
import mp "../mathandphysics"

example_plot_sinc_gnuplot :: proc()
{

    // generate normalized sin wave and it's corresponding x points
    args := os.args
    if len(args) <= 3 {
        fmt.println("hi!.")
        fmt.println("Lil Bro, you need [3](THREE) args for this chad to run!")
        fmt.println("\t args[1] number of samples! (only positive numbers), ex: 10, 200, 100")
        fmt.println("\t args[2] minimum range of the wave x' points, ex: -10.111, 0.5, 10.2")
        fmt.println("\t args[3] max range of the wave x' points, ex: -5.01, 100, 3.14")
        fmt.println("\n\t here full example\n\t plot_sinc_gnuplot.exe 100 -10 1.5\n")
        panic("Hollup!!!, check your args, bro! you sus!")
    }

    n_sample : int = strconv.atoi(args[1])
    start : f64 = strconv.atof(args[2])
    end : f64 = strconv.atof(args[3])

    if start >= end {
        fmt.println("you kidding right?! the second arg should more or equal to the third arg!")
        fmt.printfln("i got (( %v ))v for right bound, and (( %v ))", start, end)
        panic("So Hollup!!!, go fix yo args!")
    } else if n_sample <= 0 {
        fmt.printfln("You can not make a set of points with %v sample", n_sample)
        panic("So Hollup!!!, go fix yo args!")
    }

    //start, end : f64 = -20.0, 20.0

    x_points, x_step, uxp_behave := mp.linear_spacing(start, end, n_sample)
    if uxp_behave != nil {
        fmt.printfln(
            "Not cool bro!, you gave %v to %v with %v samples, what you expect!?",
            start, end, n_sample)
        panic("Not cool bro!, can not make array with those arguments you gave")
    } else {
        fmt.printfln(
            "Created %v data X points from %v to %v",
            n_sample, start, end)
    }
    y_points := mp.sinc(x_points)


    // file handler to dump the data points
    f : os.Handle
    err : os.Error
    file_name : string = "./data_file.dat"

    CREATE := os.O_CREATE | os.O_TRUNC
    WRITE := os.O_WRONLY

    f, err = os.open(file_name, CREATE)
    if err != nil { // os.General_Error.Not_Exist {
        //fd, _ = os.open(file_name, CREATE)
        fmt.println(err)
        panic("Not cool bro!, can not open the file_name")
    } else {
        //fd, _ = os.open(file_name, WRITE)
    }
    defer os.close(f)

    // dumping the points to `file_name`
    for i in 0..=(n_sample) {
        fmt.fprintfln(
            f,
            "%v %v", x_points[i], y_points[i])
    }

    gnu_plot := posix.popen("gnuplot -p", "w")
    gnu_plot_cmd : cstring = "plot './data_file.dat' w l linewidth 5\n"
    if gnu_plot == nil {
        fmt.printfln("Not cool bro, can not use the `gnuplot -p w`")
        panic("GETOUT!")
    } else {
        posix.fprintf(gnu_plot, gnu_plot_cmd)
    }

    status := posix.pclose(gnu_plot)
    if status == -1 {
        /* Error reported by pclose() */
    }
}

main :: proc() {
    example_plot_sinc_gnuplot()
}
