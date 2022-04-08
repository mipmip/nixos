{ config, pkgs, ... }:

{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      ultisnips
      vim-javascript
      vim-jsx-pretty
    ];
    settings = {
      ignorecase = true;
    };

    extraConfig = ''

        if has('python2')
        endif
        if has('python3')
        endif

        for f in split(glob('~/.vim/base*.vim'), '\n')
          exe 'source' f
        endfor

        if has('gui_running')
          for f in split(glob('~/.vim/gui*.vim'), '\n')
            exe 'source' f
          endfor
        else
          for f in split(glob('~/.vim/cli*.vim'), '\n')
            exe 'source' f
          endfor
        endif

        for f in split(glob('~/.vim/last*.vim'), '\n')
          exe 'source' f
        endfor

    '';
  };
}
