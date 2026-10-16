{ inputs, ... } : {
  flake.modules.homeManager.vibecoding-opencode = { pkgs, lib, ... }:
    let
      agentRules = import ./_agent-rules.nix { inherit lib; };

      # opencode 2, pinned to a tag of anomalyco/opencode in flake.nix. See the
      # comment on the input for why it does not follow this repository's
      # nixpkgs.
      #
      # The `src` override is load-bearing, not cosmetic. Upstream's
      # nix/node_modules.nix builds its source with a fileset that omits the
      # repository-root `script/` directory, while packages/cli/script/build.ts
      # imports `../../../script/native-arch` from it, so the upstream flake
      # cannot build its own CLI:
      #
      #   error: Cannot find module '../../../script/native-arch'
      #          from '/build/source/packages/cli/script/build.ts'
      #
      # Replacing `src` on the final derivation hands the build the unpruned
      # flake source. The fixed-output node_modules derivation keeps its own
      # pruned source, which is right: `bun install` reads bun.lock and
      # package.json and has no use for `script/`. Re-test on every tag bump;
      # if upstream repairs the fileset this becomes redundant and can go.
      opencode =
        inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.opencode
          .overrideAttrs (_: { src = inputs.opencode; });
    in
    {
    programs.opencode = {
      enable = true;
      package = opencode;
      agents   = {};

      # The same attribute set Claude Code gets. No translation: opencode
      # derives a command's name by stripping the `commands/` prefix and the
      # `.md` suffix from its path, and matches the text up to the first
      # whitespace after the slash, so `mip:ship.md` answers to /mip:ship here
      # too. Frontmatter it has no key for, such as `argument-hint`, is ignored
      # rather than rejected.
      commands = import ./_agent-commands.nix;

      # opencode 2 reads AGENTS.md and nothing else: the ~/.claude/CLAUDE.md
      # fallback that opencode 1 had is gone from the source. It is also the
      # only channel that inlines text unconditionally, because `instructions`
      # is in the config schema with no consumer and `references` renders a
      # catalogue of paths the agent may read. So the rules are concatenated in
      # here rather than pointed at. Each keeps its own heading, which is as
      # much of claude.nix's one-file-per-concern arrangement as survives.
      context = lib.concatStringsSep "\n" (
        [ (import ./_agent-context.nix) ] ++ lib.attrValues agentRules
      );

      # Deliberately unset: opencode scans ~/.claude/skills/<name>/SKILL.md
      # itself, so declaring the skills again would write a second copy of each
      # for no gain. See claude.nix, which declares them.

      # No `tui` block. opencode 2 retired tui.json: it reads the file once as
      # legacy input, writes ~/.config/opencode/cli.json, and owns that file
      # from then on. Declaring cli.json from Nix would make the theme and the
      # other in-application settings read-only and break changing them in the
      # TUI, so the theme is deliberately not declarative here.

      settings = {
        share = "disabled";

        # Not "auto". A store-installed binary cannot replace itself, and
        # upstream's wrapper, unlike the nixpkgs one, does not set
        # OPENCODE_DISABLE_AUTOUPDATE. Updating is a tag change in flake.nix.
        update = "disable";

        plugins = [
          "@tarquinen/opencode-dcp@latest"
          "@mohak34/opencode-notifier@latest"
        ];
        providers = {
          anthropic = {
            options = {
              baseURL = "https://api.anthropic.com/v1";
            };
          };
          amazon-bedrock = {
            options = {
              region = "eu-central-1";
              profile = "technative_pg-playground_pim";
            };
          };
        };
      };
      themes = {};
    };
  };

}
