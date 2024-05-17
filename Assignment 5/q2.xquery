let $max-Co-Authors := max(
    for $paper in doc("John_L_Hennessy.xml")//(inproceedings|article|book|proceedings)
    let $authorsCount := count($paper/author)
    return $authorsCount
)

let $paper-With-Title :=
    for $paper in doc("John_L_Hennessy.xml")//(inproceedings|article|book|proceedings)
    where count($paper/author) = $max-Co-Authors
    return $paper/title


return <Papers>{$paper-With-Title[position() lt 2]}</Papers>
(: to get all papers with maximum title remove [position() lt 2] :)