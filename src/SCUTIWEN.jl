#!/usr/bin/env julia
module SCUTIWEN
import LightXML: parse_string, root,
    child_elements, find_element,
    content
import TextWrap: wrap

function main()
    uri = "https://api.forismatic.com/api/1.0/?" *
        "method=getQuote&format=xml&lang=en"
    response = read(`curl $uri -s`, String)
    let
        xml = (response
               |> parse_string
               |> root
               |> child_elements
               |> collect)[1]

        quote_text = (xml["quoteText"][1]
                      |> content
                      |> strip
                      |> xs ->
                          wrap(xs; width = 60,
                               subsequent_indent = 1))
        quote_author = content(xml["quoteAuthor"][1])

        println("\"\x1B[94m\x1B[1m$quote_text\x1B[0m\"")
        !isempty(quote_author) &&
            println("\x1B[93m$quote_author\x1B[0m")
    end # let
end # function

function __init__()
    main()
end # function
end # module
