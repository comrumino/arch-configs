# Example usage of reversed_by and sort_by/2
# jq -n 'include "custom_functions"; [{s:"B",n:1},{s:"A",n:2},{s:"A",n:1},{s:"B",n:2}] | reversed_by([.s,.n])'
# jq -n 'include "custom_functions"; [{s:"B",n:1},{s:"A",n:2},{s:"A",n:1},{s:"B",n:2}] | sort_by([.s,.n]; [false,true])'


def sort_by(jv_keys; $reverse_ordering):
    # Overloads sort_by/1 with reverse_ordering parameter to support multiple object keys and reverse ordering
    # Invariants:
    #   1. The argument `$reverse_ordering` is an array such that all elements are booleans.
    #   2. The argument `jv_keys` is a filter such that it returns an array with length same as $reverse_ordering
    #   2. Ordering by `jv_keys[i]` has a higher precedence than jv_keys[j] where i < j and i,j ∈ {0, 1, ..., N - 1}.
    #      In other words, `sort_by(jv_keys[i])` is always ran after `sort_by(jv_keys[j])`
    # Reference: https://devdocs.io/jq/index#DefiningFunctions
    if (. | type) != "array" or $reverse_ordering == [] then
        .
    elif $reverse_ordering[0] == true then
        [group_by(jv_keys[0]) | reverse | map(sort_by(jv_keys[1:]; $reverse_ordering[1:]))[][]]
    else 
        [group_by(jv_keys[0]) | map(sort_by(jv_keys[1:]; $reverse_ordering[1:]))[][]]
    end;


def _get_ordering(filters; $cfg):
    # Validate cfg satifies invariants if it is an array. Otherwise, normalize $cfg to be an array of booleans that satifies invariants to sort_by
    try
        (.[0] | filters | length) as $n |
        if (. | type) != "array" then
            error("Expected '.', the identity filter, to be an array... \($__loc__)\n")
        elif ($cfg | type) == "array" and ($cfg | map(type == "boolean") | all) and $n == ($cfg | length) then
            $cfg
        elif ($cfg | type) == "boolean" then
            [range(.[0] | filters | length)] | map($cfg)
        else
            error("Expected cfg to be of a boolean or an array to satisfy sort_by invariants... \($__loc__)\n")
        end
    catch
        halt_error(1);


def reversed_by(filters):
    sort_by(filters; _get_ordering(filters; true));
