workflow run_wf {
  take:
    input_ch

  main:

    output_ch =

      input_ch

        // Fastq quality check
        | fastqc.run(
            fromState: [ input: "input" ],
            toState: { id, result, state -> state + result }
          )

        // Kneaddata host reads removal
        | kneaddata.run(
            fromState:
              [
                input: "input",
                hostDB: "hostDB"
              ],
            toState: { id, result, state -> state + result }
          )
          
        // Metaphlan taxonomic profiling
        | metaphlan.run(
            fromState:
              [
                input: "output",
                bowtieDB: "bowtieDB"
              ],
            toState: { id, result, state -> result }
          )

  emit:
    output_ch
}
