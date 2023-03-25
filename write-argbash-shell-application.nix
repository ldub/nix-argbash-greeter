{ argbash, runCommandLocal, writeShellApplication }:

let
  writeArgbashShellApplication =
    { name
    , text
    , runtimeInputs ? [ ]
    , checkPhase ? null
    }:
    let
      templateFile = builtins.toFile "templateSource.m4" text;
      argbashedText = runCommandLocal "${name}-argbashed"
        {
          buildInputs = [ argbash ];
        } ''
        # Run argbash on the input
        argbash -o "argbashed-script.sh" "${templateFile}"

        # Copy the output script to the $out directory
        mkdir -p $out
        cp "argbashed-script.sh" "$out/argbashed-script.sh"
      '';
    in
    writeShellApplication {
      inherit name;
      inherit runtimeInputs;
      inherit checkPhase;
      text = builtins.readFile "${argbashedText}/argbashed-script.sh";
    };
in
writeArgbashShellApplication