open Soup 
open Extractor_t
open Printf

(** [empty] is the empty game with no levels in it. *)
let empty = {
  levels = []
}

(** [getwords messy_list] is a list of words in a level. *)
let rec getwords messy_list = to_word_list messy_list "" []

and to_word_list messy_list word wordlist=
  match messy_list with 
  | h::t -> let h = String.uppercase_ascii h in
    if (String.length h > 1 || h = "\n" || h = "\t") then 
      if word = "" then to_word_list t "" wordlist
      else to_word_list t "" (word::wordlist)
    else to_word_list t (word^h) wordlist
  | [] -> wordlist

(** [getchar list] is a string of characters in a [level] represented by 
    [list]. *)
let rec getchar list = getletters list "" 0

and getletters string_list string len =
  match string_list with
  | h::t -> let hlen = String.length h in 
    if (String.length h > len ) then 
      (getletters t (String.uppercase_ascii h) hlen) 
    else getletters t string len
  | [] -> string

(** [get_list_from_html htmlstring] is an extracted list of strings under the
    html class words. *)
let get_list_from_html htmlstring = 
  (read_file htmlstring |> parse) $ ".words" |> texts

(** [formatnumber n] is the 5-digit representation of n with extra 0's added. 
    Requires: n is not bigger than 5-digit*)
let rec formatnumber n = 
  if (String.length n < 5) then formatnumber ("0"^n)
  else n

(** [addLevels levels k n r] is [levels] added with levels from gamefile[k] to 
    gamefile[n] and [r] as the current directory *)
let rec addLevels levels k n r=
  if k > n then levels
  else
    let formatted_k = formatnumber (string_of_int k) in
    let uncleaned_list =
      get_list_from_html (r^"/Levels/level"^formatted_k^".html") in
    let new_words = getwords uncleaned_list in
    let new_bonus_word = List.nth new_words (Random.int (List.length new_words)) in
    let updated_new_words = 
      List.filter (fun x -> x!=new_bonus_word) new_words in
    let new_letters = getchar new_words in
    let newlevel = {
      words = updated_new_words;
      letters = new_letters;
      bonus_word = new_bonus_word
    } in 
    let alllevels = {
      levels = newlevel::(levels.levels)
    } in
    (addLevels (alllevels) (k+1) n r)

let print_instructions () = 
  print_endline ("\nEnter the current path of this folder.");()

let _ = print_instructions ()
let r = read_line()

(** [create_game n1 n2] creates a game from level [n1] to level [n2]
    inclusive. *)
let create_game n1 n2 = 
  let x = addLevels empty n1 n2 r in
  {
    levels = List.rev x.levels
  }

(** [to_json_string game] converts [game] to its representation as a json 
    string. *)
let to_json_string x =
  Extractor_j.string_of_all_levels x

(** [filename k] is the output filename ["outputk.json"] where k is an int. *)
let filename k = r^"/Outputs/game"^string_of_int k^".json"

(** [write_file x filename] creates a file with filename [filename] in json 
    format. 
    Requires: [x] is a valid json string. *)
let write_file x filename =
  let output_channel = open_out filename in   
  fprintf output_channel "%s" x;  
  close_out output_channel;
  print_endline("\nsucessfully wrotefile\n");()

(** [write_multiple_games k count] writes [count-k+1] number of games, each with
    20 levels and labels them from k to count.
    eg. game1.json .. game9.json for [k] = 0 and [count] = 9*)
let rec write_multiple_games k count = 
  (let game = create_game (k*20+1) ((k+1)*20) |> to_json_string in
   write_file game (filename (k));
   let next = k+1 in
   if next > count then ()
   else write_multiple_games (k+1) count)

(** [write_ten_games ()] outputs 10 game files with 20 levels each. *)
let write_ten_games () = write_multiple_games 0 9
let write_thirty_games () = write_multiple_games 0 30

let y = write_thirty_games()


