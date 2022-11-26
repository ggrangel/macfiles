function! s:debugMessage(str)
    " This may be overkill.
    if exists("g:vim_code_browser_debug_mode") && g:vim_code_browser_debug_mode
        " Print to the window
        echo "[debug] " . a:str
    else
        " Print to the message buffer accessible with :messages
        echom "[debug] " . a:str
    endif
endfunction

function! s:url_encode(str)
  return substitute(a:str,'[^A-Za-z0-9_.~-]','\="%".printf("%02X",char2nr(submatch(0)))','g')
endfunction

function! s:getWorkspaceInfo()
    let info = {}
    let info.workspaceRoot = expand("%:p:h") " See :help expand()

    while !filereadable(info.workspaceRoot . "/Config")
        let info.workspaceRoot = info.workspaceRoot . "/.."
    endwhile

    let info.workspaceRoot = simplify(info.workspaceRoot) " Remove all the ../ parts
    let info.packageName = matchstr(info.workspaceRoot, '\v[^\/]+$') " Basically, get last directory name in the path
    let info.filename = expand("%:t") " See :help expand()
    let info.absolutePathToFile = expand("%:p")
    let info.absolutePathToDir = expand("%:p:h")
    let info.relativePathToFile = substitute(substitute(info.absolutePathToFile, info.workspaceRoot, "", ""), '\v^\/', "", "")
    let info.relativePathToDir = substitute(substitute(info.absolutePathToDir, info.workspaceRoot, "", ""), '\v^\/', "", "")

    call s:debugMessage("Workspace root: " . info.workspaceRoot)
    call s:debugMessage("Package name: " . info.packageName)
    call s:debugMessage("Filename: " . info.filename)
    call s:debugMessage("Absolute path to file: " . info.absolutePathToFile)
    call s:debugMessage("Relative path to file: " . info.relativePathToFile)
    call s:debugMessage("Absolute path to dir: " . info.absolutePathToDir)
    call s:debugMessage("Relative path to dir: " . info.relativePathToDir)

    return info
endfunction

function! s:createCodeBrowserUrl(type, startLine, endLine, howToGetReference, ...)
    " a:type String: "blobs" | "trees"
    " a:startLine Number: line to start highlighting
    " a:endLine Number: line to end highlighting
    " a:howToGetReference: String really dumb way of flagging whether to fetch the current commit or use one provided

    " The trailing ... means this function needs two args and accepts a
    " variable number of extra args. Here's how you can access these extra
    " args and make decisions about what to do with them.
    " a:0 => number of extra args
    " a:1 => first extra arg
    " a:2 => second extra arg
    " a:000 => all the extra args in a List
    let format = ""
    if a:0 >= 1
        let format = a:1
        call s:debugMessage("Format is " . format)
    endif

    let info = s:getWorkspaceInfo()

    let ref = 'mainline'
    if a:howToGetReference == 'USE_CURRENT_COMMIT'
        " Switch to workspace dir just in case we aren't already in it.
        let cwd = getcwd()
        execute "cd " . info.workspaceRoot
        call s:debugMessage("Temporarily switching to workspace dir " . info.workspaceRoot)
        let gitCommand = "git log -1 --pretty=format:%H"
        let ref = system(gitCommand)
        call s:debugMessage("Running system command: " . gitCommand)
        if ref =~ "fatal"
            " Not sure why this would happen but whatever
            call s:debugMessage("Running git log failed! Using \"mainline\" as the git ref instead")
            let ref = 'mainline'
        endif
        call s:debugMessage("Switching back to previous dir " . cwd)
        execute "cd " . cwd
    elseif a:howToGetReference == 'USE_MAINLINE_COMMIT'
        let ref = 'mainline'
    else
        let ref = 'mainline' " Redundant but explicit
    endif

    if a:type == 'trees'
        let resource = info.relativePathToDir
    elseif a:type == 'blobs'
        let resource = info.relativePathToFile
    else
        " Error
    endif

    call s:debugMessage("Raw resource string: " . resource)
    let resourceParts = split(resource, "/")
    let resource = join(map(resourceParts, 's:url_encode(v:val)'), "/")
    call s:debugMessage("URL-encoded resource: " . resource)

    " TODO: URL-encode directory/file names?
    let url = 'https://code.amazon.com/packages/' . info.packageName . '/' . a:type . '/' . ref . '/--/' . resource
    let hash = ""

    if a:startLine != 1 || a:endLine != line('$')
        " Assert: want to highlight specific lines. This will not catch the
        " one edge case where *all* the lines were in fact visually
        " highlighted, but that seems rare.
        let topLine = max([a:startLine - 3, 1]) " The line the page auto-scrolls to
        call s:debugMessage("Highlight start: " . a:startLine)
        call s:debugMessage("Highlight end: " . a:endLine)
        call s:debugMessage("Top line: " . topLine)
        let hash = "#L" . a:startLine . "-L" . a:endLine
        let url = url . hash
    endif

    if format == "markdown"
        let resourceTail = get(resourceParts, len(resourceParts) - 1)
        call s:debugMessage("Resource tail: " . resourceTail)
        let linkText = info.packageName . ': ' . resourceTail
        if a:0 >= 2 " a:0 is the number of extra args
            " If user provided a string for the link name, use it
            let linkText = a:2 " a:2 is the second extra arg
        elseif  hash != ''
            " If user highlighted lines, include them in the link text
            let linkText = info.packageName . ' ' . resourceTail . hash
        endif
        call s:debugMessage("Link text: " . linkText)
        " let formattedUrl = '[' . info.packageName . ': ' . resource . '](https://code.amazon.com/packages/' . info.packageName . '/' . a:type . '/' . ref . '/--/' . resource . ')'
        let formattedUrl = '[' . linkText . '](' . url . ')'
        echo formattedUrl
    else
        let formattedUrl = url
    endif

    echo "Code Browser " . substitute(a:type, 's$', "", "") . " URL for git ref [" . ref . "]:"
    echohl Directory
    echo formattedUrl
    echohl None

    " test
    let cmd = "echo " . shellescape(formattedUrl, 1) . " | " . "pbcopy"
    call s:debugMessage("Running system command the following system command:")
    call s:debugMessage(cmd)
    execute "silent !" . cmd
    " test 

    " if exists("g:vim_code_browser_url_handler_command")
    "     " A handy one is "xargs open" which will open the URL in your
    "     " default browser. If you're working remotely you could try
    "     " something like "ssh mac-laptop "xargs open"
    "     let destination = g:vim_code_browser_url_handler_command
    "     echo "Destination " . destination
    "     let cmd = "echo " . shellescape(formattedUrl, 1) . " | " . destination
    "     call s:debugMessage("Running system command the following system command:")
    "     call s:debugMessage(cmd)
    "     execute "silent !" . cmd
    "     redraw!
    " endif

endfunction

" For reference. The types of code browser URLs.
" ----------------------------------------------
" -- View most recent commit on mainline. Probably don't want to use this one
" -- that much.
" -- https://code.amazon.com/packages/ShortVideoContentPageletGroup/blobs/heads/mainline/--/Config
"
" -- Canonical way to view most recent commit on the mainline branch
" The nice thing about this one is you can give it any git ref and it'll also
" work. A branch name will just point to the latest commit on that branch.
" https://code.amazon.com/packages/ShortVideoContentPageletGroup/blobs/mainline/--/Config
"
" Snapshot of file at commit
" https://code.amazon.com/packages/ShortVideoContentPageletGroup/blobs/6ee34/--/Config
"
" Go directly to a commit (needs full hash)
" https://code.amazon.com/commit/e0718eebfa73c823346943d65cb7a66522bdf4da

command! -nargs=* -range=% CodeBrowserBlobUrl call s:createCodeBrowserUrl('blobs', <line1>, <line2>, 'USE_MAINLINE_COMMIT', <f-args>)
command! -nargs=* -range=% CodeBrowserTreeUrl call s:createCodeBrowserUrl('trees', <line1>, <line2>, 'USE_MAINLINE_COMMIT', <f-args>)
command! -nargs=* -range=% CodeBrowserBlobUrlFromLatestCommit call s:createCodeBrowserUrl('blobs', <line1>, <line2>, 'USE_CURRENT_COMMIT', <f-args>)
command! -nargs=* -range=% CodeBrowserTreeUrlFromLatestCommit call s:createCodeBrowserUrl('trees', <line1>, <line2>, 'USE_CURRENT_COMMIT', <f-args>)
