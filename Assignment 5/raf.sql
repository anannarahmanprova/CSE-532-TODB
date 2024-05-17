--CREATE TABLE XML_Documents1 (
    
--    XML_Content XML
   
--);~


--import from test.del OF DEL INSERT INTO XML_DOCUMENTS(XML_Content)@ 


--FROM XML_Documents
--WHERE XMLQUERY('for $a in /dblp/inproceedings[author="John L. Hennessy"]/author,
--               $b in /dblp/inproceedings[author="David A. Patterson 0001"]/author
 --              return if ($a = $b) then $a else ()' PASSING XML_Content) IS NOT NULL
--GROUP BY Author_Name;




--SELECT Author_Name,
  --     XMLQUERY('declare default element namespace "http://posample.org";
   --    		for $paper in $doc/inproceedings
    --             let $maxCoAuthors := max(count($paper/author))
    --             where count($paper/author) = $maxCoAuthors
        --         return $paper/title' 
        --         PASSING XML_Content as "doc") AS Paper_With_Most_CoAuthors
--FROM XML_Documents;~



--XQUERY 
--let $hennessy_papers := db2-fn:xmlcolumn("XML_DOCUMENTS.XML_CONTENT")//(inproceedings[author = "John L. Hennessy"]|book[author = "John L. Hennessy"]|article[author = "John L. --Hennessy"]|proceedings[author = "John L. Hennessy"])
--let $peterson_papers := db2-fn:xmlcolumn("XML_DOCUMENTS.XML_CONTENT")//(inproceedings[author = "David A. Patterson 0001"]|book[author = "David A. Patterson 0001"]|------article[author = "David A. Patterson 0001"]|proceedings[author = "David A. Patterson 0001"])

--let $common_authors :=
 --   for $hennessy_paper in $hennessy_papers
 --for $peterson_paper in $peterson_papers
  --  where  $hennessy_paper/author = $peterson_paper/author and not($hennessy_paper/author="David A. Patterson 0001") and  not($peterson_paper/author="John L. Hennessy")
 
  --  return $hennessy_paper/author
    

--return <emp>{$common_authors}</emp>~




SELECT XMLQUERY ('
      		
                let $maxCoAuthors := max( $doc//(inproceedings|book|article|proceedings)/count(author))
                for $paper in $doc//(inproceedings|book|article|proceedings)
                where count($paper/author) = $maxCoAuthors
                return 
        <most-co-authored-paper>{$doc/dblpperson/@name}{$paper/title}</most-co-authored-paper>' 
                PASSING XML_Content as "doc") AS most_co_authored_paper
FROM XML_Documents;~




        
        

        
        
        
        
        







