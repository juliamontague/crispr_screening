CONFIG = "test_config.env"

rule all:
    input:
        "cutadapt_output/cutadapt.done",
        "cutadapt_output/fastqc_output/fastqc.done",
        "mageck_output/mageck_count.done",
        "mageck_output/mageck_test.done"

rule cutadapt:
    output:
        "cutadapt_output/cutadapt.done"
    shell:
        """
        bash scripts/run_cutadapt.sh {CONFIG}
        touch {output}
        """

rule fastqc:
    input:
        "cutadapt_output/cutadapt.done"
    output:
        "cutadapt_output/fastqc_output/fastqc.done"
    shell:
        """
        bash scripts/run_fastqc.sh {CONFIG}
        touch {output}
        """

rule mageck_count:
    input:
        "cutadapt_output/fastqc_output/fastqc.done"
    output:
        "mageck_output/mageck_count.done"
    shell:
        """
        bash scripts/do_mageck_count.sh {CONFIG}
        touch {output}
        """

rule mageck_test:
    input:
        "mageck_output/mageck_count.done"
    output:
        "mageck_output/mageck_test.done"
    shell:
        """
        bash scripts/do_mageck_test.sh {CONFIG}
        touch {output}
        """
