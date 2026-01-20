MERGE (Action:Genre { description:'Action' })
MERGE (SciFi:Genre { description:'Science Fiction' })

MERGE (TheMatrix:Movie { title:'The Matrix' })
 ON CREATE SET TheMatrix.released=1999, TheMatrix.tagline='Welcome to the Real World'

MERGE (TheMatrix)-[:IN_GENRE]->(Action)

MERGE (Keanu:Actor { name:'Keanu Reeves' })
 ON CREATE SET Keanu.born=1964
MERGE (Carrie:Actor { name:'Carrie-Anne Moss' })
 ON CREATE SET Carrie.born=1967
MERGE (Laurence:Actor { name:'Laurence Fishburne' })
 ON CREATE SET Laurence.born=1961
MERGE (Hugo:Actor { name:'Hugo Weaving' })
 ON CREATE SET Hugo.born=1960
MERGE (LillyW:Director { name:'Lilly Wachowski' })
 ON CREATE SET LillyW.born=1967
MERGE (LanaW:Director { name:'Lana Wachowski' })
 ON CREATE SET LanaW.born=1965
MERGE (JoelS:Director { name:'Joel Silver' })
 ON CREATE SET JoelS.born=1952

MERGE (Keanu)-[:ACTED_IN { roles:['Neo'] }]->(TheMatrix)
MERGE (Carrie)-[:ACTED_IN { roles:['Trinity'] }]->(TheMatrix)
MERGE (Laurence)-[:ACTED_IN { roles:['Morpheus'] }]->(TheMatrix)
MERGE (Hugo)-[:ACTED_IN { roles:['Agent Smith'] }]->(TheMatrix)
MERGE (LillyW)-[:DIRECTED]->(TheMatrix)
MERGE (LanaW)-[:DIRECTED]->(TheMatrix)
MERGE (JoelS)-[:PRODUCED]->(TheMatrix)

MERGE (StrangerThings:Serie { title:'Stranger Things' })
 ON CREATE SET StrangerThings.released=2025

MERGE (MariaD:User { name:'Maria do Carmo' })
 ON CREATE SET MariaD.language="pt-br"
MERGE (MariaD)-[:WATCHED { rating: "4" }]->(StrangerThings)

MERGE (MarioJ:User { name:'Mario Junior' })
 ON CREATE SET MarioJ.language="pt-br"
MERGE (MarioJ)-[:WATCHED { rating: "4" }]->(StrangerThings)
