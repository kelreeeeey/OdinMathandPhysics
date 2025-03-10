package mpplot

import "core:sys/posix"
import "core:strings"
import "core:os"
import "core:fmt"

CREATE := os.O_CREATE | os.O_TRUNC

make_gnuplot_args :: proc(file_name: string) -> cstring {

    raw_args := make([]string, 3)
    defer delete( raw_args )
    raw_args[0] = "plot '"
    raw_args[1] = file_name
    raw_args[2] = "' w l linewidth 5\n"

    gnup_args := convert_gnuplot_args(raw_args)

    return gnup_args
}

// TODO: Handle the mem.Allocator_Error!
convert_gnuplot_args :: proc(args:  []string) -> cstring {
    gnu_plot_cmd, clone_err := strings.clone_to_cstring(
        strings.join(args[:], "") )

    return gnu_plot_cmd
}

dump_gnuplot_file :: proc(x,y : $T/[]$E, file_name:string) {
    f : os.Handle
    err : os.Error

    f, err = os.open(file_name, CREATE)
    if err != nil { // os.General_Error.Not_Exist {
        fmt.printfln("Got error: %v to open `%v`", err, file_name)
        panic("Not cool bro!, can not open the file_name")
    }
    defer os.close(f)

    // dumping the points to `file_name`
    n_sample := len(x)
    for i in 0..<(n_sample) {
        fmt.fprintfln(
            f,
            "%v\t%v", x[i], y[i])
    }
}

gnu_plot :: proc(gnu_args: cstring) {

    GNU_PLOT := posix.popen("gnuplot -p", "w")
    if GNU_PLOT == nil {
        fmt.printfln("Not cool bro, can not use the `gnuplot -p w`")
        panic("GETOUT!")
    } else {
        posix.fprintf(GNU_PLOT, gnu_args)
    }

    // TODO: HANDLE THE posix.pclose's status!
    status := posix.pclose(GNU_PLOT)
    if status == -1 {}

}

plot :: proc { gnu_plot }
