module C = Configurator.V1
let () =
  C.main ~name:"qcaml-discover" (fun c ->
      let os_type = C.ocaml_config_var_exn c "system" |> String.lowercase_ascii in
      let architecture = C.ocaml_config_var_exn c "architecture" in
      let c_flags, c_library_flags =
        if String.contains os_type 'w' then
          (* Windows *)
          (["-I/mingw64/include"], ["-L/mingw64/lib"; "-lfreeglut"; "-lglu32"; "-lopengl32"])
        else if os_type = "macosx" then
          (* macOS ARM and Intel *)
          let include_path =
            if architecture = "arm64" then "/opt/homebrew/include"
            else "/usr/local/include"
          in
          (["-I" ^ include_path], ["-framework"; "OpenGL"; "-framework"; "GLUT"])
        else
          (* Linux, FreeBSD and others *)
          (["-I/usr/local/include"; "-I/usr/include"], 
           ["-L/usr/local/lib"; "-L/usr/lib"; "-lglut"; "-lGLU"; "-lGL"])
      in
      C.Flags.write_sexp "c_flags.sexp" c_flags;
      C.Flags.write_sexp "c_library_flags.sexp" c_library_flags)
