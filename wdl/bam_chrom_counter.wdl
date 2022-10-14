version 1.0

workflow bam_chrom_counter {
    input {
        Int num_chrom
    }

    call slice_bam {
        input: num_chrom=num_chrom
    }
}

task slice_bam {
    input {
        Int num_chrom = 22
    }
    command <<<
    echo Test_${num_chrom}
    >>>
    output {
    }
}

