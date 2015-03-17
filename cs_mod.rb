require 'kconv'

def main

  fstr = File.open(ARGV[0]).read.toutf8

  fstr = fstr.gsub(/\/\*.*?\*\//, "")

  fstr = input_filter(fstr)

end


def input_filter(fstr)

  result = ""

  bracketLv = -1
  comments = []

  fstr.each_line do |line|

#    line = line.strip

    if (line =~ /\sclass\s/) then

      bracketLv = 0
      comments = []
    end

    case line
      when /\/\/\/.*/
        line = $&
        if (bracketLv > 1) then

          comments.push( line.gsub(/\/\/\//, "").strip )
          line = $`
        end

      when /\/\/.*/
        line = $`

      when /[\\]\".*?[^\\]\"/
        line = $` + '"something string"' + $'

      else
        ;
    end

    bracketLv += 1 if ((line =~/\{/) and (bracketLv >= 0))

    if (line =~/\}/) then

      bracketLv -= 1

      if (bracketLv == 1) then

#        result += parse(comments.join("\n"))
        result += (comments.join("\n") + "\n")
      end
    end

    result += (line + "\n")
  end

  return result
end

def parse(body)

  result = ""

  body.each_line do |line|

    result += '/// ' + line
  end

  return result
end

print main

