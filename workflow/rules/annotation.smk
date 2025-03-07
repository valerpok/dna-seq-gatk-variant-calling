rule annotate_variants:
    input:
        calls=results_path+"filtered/all.vcf.gz",
        cache=resources_path+"vep/cache",
        plugins=resources_path+"vep/plugins",
    output:
        calls=report(
            results_path+"annotated/all.vcf.gz",
            caption="../report/vcf.rst",
            category="Calls",
        ),
        stats=report(
            results_path+"stats/all.stats.html",
            caption="../report/stats.rst",
            category="Calls",
        ),
    params:
        # Pass a list of plugins to use, see https://www.ensembl.org/info/docs/tools/vep/script/vep_plugins.html
        # Plugin args can be added as well, e.g. via an entry "MyPlugin,1,FOO", see docs.
        plugins=config["params"]["vep"]["plugins"],
        extra=config["params"]["vep"]["extra"],
    log:
        "logs/vep/annotate.log",
    threads: 4
    wrapper:
        "0.75.0/bio/vep/annotate"
