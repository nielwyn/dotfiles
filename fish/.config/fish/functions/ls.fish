function ls --wraps=ls --description 'ls with highlighted file permissions'
    if isatty stdout
        command ls --color=always $argv | __highlight_permissions
    else
        command ls $argv
    end
end

function __highlight_permissions
    set -l N (set_color normal)
    while read -l line
        if string match -qr '^[dlbcps\-][rwxsStT\-]{9}' -- $line
            set -l t (string sub -l 1 -- $line)
            set -l bits (string sub -s 2 -l 9 -- $line)
            set -l rest (string sub -s 11 -- $line)

            switch $t
                case d;   set t (set_color --bold blue)$t$N
                case l;   set t (set_color --bold cyan)$t$N
                case '-'; set t (set_color brblack)$t$N
                case '*'; set t (set_color --bold magenta)$t$N
            end

            set bits (string replace -ar 'r' (set_color green)r$N $bits)
            set bits (string replace -ar 'w' (set_color red)w$N $bits)
            set bits (string replace -ar '([xsStT])' (set_color --bold yellow)'$1'$N $bits)
            set bits (string replace -ar -- '-' (set_color brblack)-$N $bits)

            printf '%s\n' $t$bits$rest
        else
            printf '%s\n' $line
        end
    end
end
