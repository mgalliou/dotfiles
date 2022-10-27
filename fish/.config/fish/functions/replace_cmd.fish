function replace_cmd
    if type -q $argv[2]
        abbr $argv[1] $argv[2]
    end
end
