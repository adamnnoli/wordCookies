This extractor requires installation of lambdasoup and atdgen

Levels were webscrapped using wget

Run extractor executable to output json game files into the Output folder

extractor.ml can be modified to output the number of levels in a game file and the number of output

Each game in /Outputs currently has 20 levels to reduce memory usage when running the game


Run these commands to build the executable:

$ ocamlfind ocamlc -c extractor_t.mli -package atdgen
$ ocamlfind ocamlc -c extractor_j.mli -package atdgen
$ ocamlfind ocamlopt -c extractor_t.ml -package atdgen
$ ocamlfind ocamlopt -c extractor_j.ml -package atdgen
$ ocamlfind ocamlopt -c extractor.ml -package atdgen -package lambdasoup
$ ocamlfind ocamlopt -o extractor extractor_t.cmx extractor_j.cmx extractor.cmx -package atdgen -package lambdasoup -linkpkg