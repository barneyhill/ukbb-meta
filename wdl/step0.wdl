task count_bam {
    input {
        File bam
    }

    command <<<
        samtools view -c ~{bam}
    >>>
    runtime {
        docker: "dx://project-GBvkP10Jg8Jpy18FPjPByv29:/ukbb-meta/docker/saige-1.1.6.1.tar.gz"
    }
    output {
        Int count = read_int(stdout())
    }
}
