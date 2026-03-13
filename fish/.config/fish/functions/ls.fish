function ls --wraps=ls --description 'ls with highlighted file permissions'
    if isatty stdout
        command ls --color=always $argv | __highlight_permissions
    else
        command ls $argv
    end
end

function __highlight_permissions
    while read -l line
        if string match -qr '^[dlbcps\-][rwxsStT\-]{9}' -- $line
            set -l perm (string sub -l 10 -- $line)
            set -l rest (string sub -s 11 -- $line)
            set -l out ""
            for i in (seq 1 10)
                set -l c (string sub -s $i -l 1 -- $perm)
                if test $i -eq 1
                    switch $c
                        case d;   set out $out(set_color --bold blue)$c(set_color normal)
                        case l;   set out $out(set_color --bold cyan)$c(set_color normal)
                        case '-'; set out $out(set_color brblack)$c(set_color normal)
                        case '*'; set out $out(set_color --bold magenta)$c(set_color normal)
                    end
                else
                    switch $c
                        case r;         set out $out(set_color green)$c(set_color normal)
                        case w;         set out $out(set_color red)$c(set_color normal)
                        case x s S t T; set out $out(set_color --bold yellow)$c(set_color normal)
                        case '-';       set out $out(set_color brblack)$c(set_color normal)
                        case '*';       set out $out$c
                    end
                end
            end
            printf '%s\n' $out$rest
        else
            printf '%s\n' $line
        end
    end
end
