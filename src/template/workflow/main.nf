workflow run_wf {
  take:
    input_ch

  main:

    output_ch =

      input_ch

        // Remove comments from each TSV input file
        | fastqc.run(
            fromState: [ input: "input" ],
            toState: { id, result, state -> state + result }
          )

        // Extract a single column from each TSV
        // The column to extract is specified in the sample sheet
        | kneaddata.run(
            fromState:
              [
                input: "input",
                hostDB: "hostDB"
              ],
            toState: { id, result, state -> result }
          )

  emit:
    output_ch
}
