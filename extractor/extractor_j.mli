(* Auto-generated from "extractor.atd" *)
[@@@ocaml.warning "-27-32-35-39"]

type levels = Extractor_t.levels = {
  words: string list;
  letters: string;
  bonus_word: string
}

type all_levels = Extractor_t.all_levels = { levels: levels list }

val write_levels :
  Bi_outbuf.t -> levels -> unit
  (** Output a JSON value of type {!levels}. *)

val string_of_levels :
  ?len:int -> levels -> string
  (** Serialize a value of type {!levels}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_levels :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> levels
  (** Input JSON data of type {!levels}. *)

val levels_of_string :
  string -> levels
  (** Deserialize JSON data of type {!levels}. *)

val write_all_levels :
  Bi_outbuf.t -> all_levels -> unit
  (** Output a JSON value of type {!all_levels}. *)

val string_of_all_levels :
  ?len:int -> all_levels -> string
  (** Serialize a value of type {!all_levels}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_all_levels :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> all_levels
  (** Input JSON data of type {!all_levels}. *)

val all_levels_of_string :
  string -> all_levels
  (** Deserialize JSON data of type {!all_levels}. *)

