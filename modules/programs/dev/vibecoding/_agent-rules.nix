# The writing rules, defined once and rendered per agent. Claude Code takes
# them as separate documents under ~/.claude/rules/, which it loads as memory on
# its own. opencode has no equivalent directory, so opencode.nix concatenates
# them into AGENTS.md instead. The text is the same either way.
{ lib }:

let
  # One source of truth for the word list: the same JSON the linter reads is
  # rendered into the rule file, so the two can never drift apart.
  fillerWords = builtins.fromJSON (
    builtins.readFile ../../../../packages/prose-lint/filler-words.json
  );
  renderWords = words: lib.concatMapStringsSep "\n" (w: "- ${w}") words;
in
{
  prose-review-amendments = ''
    # Where the imported writing guides do not apply

    Two guides are installed as skills: `humanizer` for any language, and
    `writing-clearly-and-concisely-dutch` for Dutch. Read them through the
    amendments below. A guide adopted without stating its exceptions makes
    the text worse in the places where its advice is wrong for this
    material.

    ## A technical term keeps its accepted name

    The Dutch guide treats an English word as a red flag whenever a Dutch
    alternative exists, and rejects "it is a technical term" as an excuse.
    That does not apply here. When a term is the accepted name for the
    thing in its field, it stays: flake, input, lock, closure, derivation,
    store path, commit, merge, pull request.

    Translate a word that is merely borrowed, not one that names the
    thing. "Performance" becomes "prestaties" in ordinary prose; a
    `nix flake update` does not become "nix vlok bijwerken".

    ## The vocabulary list is English only

    humanizer's rule 12 lists overused English words, and says itself that
    it is the skill's only vocabulary list. Do not look for Dutch
    equivalents of it. Every other rule in humanizer applies to both
    languages, as its rule 1 states.

    ## A local rule wins

    Where a guide conflicts with the rules in `prose-typography.md` or
    `prose-filler-words.md`, the local rule wins. The Dutch guide is itself
    an example: it uses the em dash nineteen times, including in its own
    rule headings. Follow what it says about sentence construction, not
    what its punctuation does.

    ## Prose meant to be copied goes to a file

    When the user asks for prose to send to someone else, write it to a
    file and say where it is, rather than showing it only in a reply. A
    reply cannot be checked before it appears; a file can. Then run the
    gate on it.
  '';

  prose-typography = ''
    # Prose typography

    These marks are never wanted. Not in a blog post, not in a spec, not in
    a commit message, and in neither Dutch nor English. There is no context
    that calls for them, so there is no exception to weigh.

    - The em dash `—` (U+2014). Name the relation instead ("because",
      "but", "for example"), use a comma, a colon or parentheses, or write
      two sentences.
    - The en dash `–` (U+2013). In a range a plain hyphen does the job.
      Anywhere else, rewrite.
    - A spaced double hyphen used as a dash. Same rule as the em dash.
    - Curly quotation marks. Use straight quotes.

    Dashes and hyphens inside code blocks, inline code, commands, paths and
    URLs are not prose and are left alone.

    A hook checks this after every write to a prose file and fails the
    write when it finds a hit, so treat it as settled rather than as
    advice.
  '';

  prose-filler-words = ''
    # Filler words

    Use a word from this list only when it carries meaning. Drop it when it
    is a verbal tic. The same word can be either:

    - "dat is eigenlijk niet waar" corrects a claim, so it stays.
    - "dat is eigenlijk best goed" says nothing, so it goes.

    A hook reports these with the sentence they sit in. It does not fail
    the write, because only a reader can tell the two cases apart.

    ## Dutch

    ${renderWords fillerWords.nl}

    ## English

    ${renderWords fillerWords.en}
  '';
}
