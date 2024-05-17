XQUERY 

let $coauthor-j:= 
	for $co-j in db2-fn:xmlcolumn("XML_DOCUMENTS.XML_CONTENT")/dblpperson
         where $co-j/person/author/@pid="h/JohnLHennessy"
	return $co-j/coauthors/co/na

	let $coauthor-d :=for $co-d in db2-fn:xmlcolumn("XML_DOCUMENTS.XML_CONTENT")/dblpperson
	where $co-d/person/author/@pid="p/DAPatterson"
	return $co-d/coauthors/co/na
	

   let $resultset:= for $c-j in $coauthor-j
   	      for $c-d in $coauthor-d
              where  $c-j=$c-d
  	      return <name>{$c-j/text()}</name>
	
	
return <co-author>{$resultset}</co-author>~
        
