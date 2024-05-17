SELECT XMLQUERY ('
      		
                let $max-Co-Authors := max( $doc//(inproceedings|book|article|proceedings)/count(author))
                for $paper in $doc//(inproceedings|book|article|proceedings)
                where count($paper/author) = $max-Co-Authors
                return 
        <most-co-authored-paper>{$doc/dblpperson/@name}{$paper/title}</most-co-authored-paper>' 
                PASSING XML_Content as "doc") AS most_co_authored_paper
FROM XML_Documents;~
