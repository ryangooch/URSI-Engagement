MATCH (ys:Year)-[:Year_Started]-(n:Award)-[]-(p:Person) WHERE n.AwardAbstract =~ '.*soil moisture.*' RETURN n, p
WITH p
MATCH q = p-[]-(inst:Institution) RETURN q LIMIT 30;

// List of people per institution submitting 
MATCH (ys:Year)-[:Year_Started]-(n:Award)-[]-(p:Person) WHERE n.AbstractNarration =~ '.*soil moisture.*' AND n.AbstractNarration =~ '.*radar.*'
WITH p, n, ys
MATCH q = (p)-[]-(inst:Institution) RETURN DISTINCT Year.Year, inst.Name as Institution, count(p) AS people ORDER by people;

// Linking shared award names
// 
MATCH (n1:Award)-[:Year_Started]-(ys:Year)
WITH n1, ys
MATCH (n:Award)-[:Year_Started]-(ys1:Year) 
  WHERE n.AbstractNarration = n1.AbstractNarration AND n1.AwardID = n.AwardID
RETURN n.AwardID;