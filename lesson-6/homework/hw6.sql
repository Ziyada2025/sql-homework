Question 1: Explain at least two ways to find distinct values based on two columns. 
1 way) SELECT 
    LEAST(col1, col2) AS col1,
    GREATEST(col1, col2) AS col2
FROM 
    InputTbl
GROUP BY 
    LEAST(col1, col2), GREATEST(col1, col2); 
2 way) SELECT 
    CASE WHEN col1 <= col2 THEN col1 ELSE col2 END AS col1,
    CASE WHEN col1 <= col2 THEN col2 ELSE col1 END AS col2
FROM 
    InputTbl
GROUP BY 
    CASE WHEN col1 <= col2 THEN col1 ELSE col2 END,
    CASE WHEN col1 <= col2 THEN col2 ELSE col1 END; 
Question 2: Question: If all the columns have zero values, then don’t show that row. In this case, we have to remove the 5th row while selecting data.
Answer: SELECT * FROM TestMultipleZero 
	WHERE a<>0 OR b<>0 OR c<>0 OR d<> 0 ;
Question 3: Find those with odd ids 
SELECT * FROM section1 
WHERE id%2=0 ;
Question 4: Person with the smallest id 
SELECT * FROM section1
WHERE ID=(SELECT MIN(ID) FROM section1) ;
QUESTION5: Person with the highest id (use the table in puzzle 3) 
SELECT * FROM section1
WHERE ID=(SELECT MAX(ID) FROM section1);
QUESTION 6:People whose name starts with b 
SELECT * FROM section1
WHERE NAME='B%';
question 7: Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard). 
SELECT * FROM ProductCodes 
WHERE Code LIKE '%\_%' ESCAPE '\';
