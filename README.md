LIMIT WINDOW SIZE
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

Text files that do not have "hard" word wrapping via embedded line breaks can
be cumbersome to edit in a wide editor window, as it is strenuous on the eyes
to jump back and forth between begin and end of the soft-wrapped lines.
The simplest solution is to resize the editor window (:set columns=80), but
one may still want to have the large editor size for other edited buffers that
benefit from the large screen real estate.

This plugin places an empty padding window next to the current window, thereby
reducing its size while maintaining the overall editor size.

USAGE
------------------------------------------------------------------------------

    :LimitWindowWidth [{width}]
                            Limit the window width of the current window by placing
                            an empty padding window to the right. If there already
                            is a padding window, its size is adapted according to
                            'textwidth' / {width}, or removed if the width is so
                            large that no padding is needed.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-LimitWindowSize
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim LimitWindowSize*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- Requires the ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.004 or
  higher.

TODO
------------------------------------------------------------------------------

- Auto-remove padding window if the window is removed.

### CONTRIBUTING

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-LimitWindowSize/issues or email (address
below).

HISTORY
------------------------------------------------------------------------------

##### 1.02    RELEASEME
- ENH: Keep previous (last accessed) window.

##### 1.01    29-Nov-2013
- Add workaround for when a :LimitWindowWidth command is issued from a still
  minimized GVIM in the process of restoring its window. The check for the
  window width then needs to be delayed until after the VimResized event.
- Add dependency to ingo-library ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)).

__You need to separately
  install ingo-library ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)) version 1.004 (or higher)!__

##### 1.00    11-Sep-2010
- First published version.

##### 0.01    10-May-2008
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2010-2022 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;
