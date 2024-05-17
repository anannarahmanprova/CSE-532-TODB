
for $year in distinct-values(doc("David_A_Patterson.xml")//year)
let $papers := doc("David_A_Patterson.xml")//year[text() = $year]/(ancestor::inproceedings[author = "David A. Patterson 0001"]|ancestor::article[author = "David A. Patterson 0001"]|ancestor::book[author = "David A. Patterson 0001"]|ancestor::proceedings[author = "David A. Patterson 0001"])
let $totalPapers := count($papers)
let $totalCoAuthors := sum($papers/author[. != "David A. Patterson 0001"]/count(.))
order by $year ascending
return
    <Summary>
        <Year>{$year}</Year>
        <Count>{$totalPapers}</Count>
        <AverageCoAuthors>{if ($totalPapers ne 0) then $totalCoAuthors div $totalPapers else 0}</AverageCoAuthors>
    </Summary>
