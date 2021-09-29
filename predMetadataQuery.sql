use smdb; 
show tables; 
SELECT * FROM smdb.CITATIONS c, smdb.ISSNs i, smdb.predication p
 WHERE c.ISSN = i.eISSN
   AND c.pmid = p.pmid
   LIMIT 5; 

SELECT DISTINCT cp.*, i.* 
  FROM ISSNs i, (SELECT p.*, ISSN FROM predication p, CITATIONS c WHERE p.pmid = c.pmid) AS cp WHERE i.pISSN = cp.ISSN AND cp.object_cui IN ('C0022660', 'C0242528', 'C0035078') AND cp.predicate = 'CAUSES' LIMIT 5000; 

SELECT DISTINCT cp.*, i.* 
  FROM ISSNs i, (SELECT p.*, ISSN FROM predication p, CITATIONS c WHERE p.pmid = c.pmid) AS cp WHERE i.pISSN = cp.ISSN AND cp.predicate = 'TREATS' AND cp.subject_cui = 'C0022625' LIMIT 5000; 

##################

SELECT DISTINCT cp.*, i.* 
  FROM ISSNs i, (SELECT p.*, ISSN FROM predication p, CITATIONS c WHERE p.pmid = c.pmid) AS cp WHERE i.pISSN = cp.ISSN AND cp.object_cui IN ('C0022660', 'C0242528', 'C0035078') AND cp.predicate = 'CAUSES' LIMIT 5000; 

SELECT DISTINCT cp.*, i.* 
  FROM ISSNs i, (SELECT p.*, ISSN FROM predication p, CITATIONS c WHERE p.pmid = c.pmid) AS cp WHERE i.pISSN = cp.ISSN AND cp.predicate = 'TREATS' AND cp.subject_cui = 'C0022625' LIMIT 5000; 




##################

SELECT DISTINCT cp.*, i.* 
  FROM ISSNs i, (SELECT p.*, ISSN FROM causalpredications p, CITATIONS c WHERE p.pmid = c.pmid) AS cp WHERE i.pISSN = cp.ISSN AND cp.object_cui IN ('C0276496', 'C0494463', 'C0002395') AND cp.predicate IN ('TREATS', 'PREVENTS') LIMIT 5000; 


SELECT DISTINCT cp.subject_name, cp.predicate, i.journal_title, c.pyear, s.sentence 
  FROM ISSNs i, sentence s, citations c, (SELECT p.*, ISSN FROM causalpredications p, CITATIONS c WHERE p.pmid = c.pmid) AS cp WHERE i.pISSN = cp.ISSN AND cp.object_cui IN ('C0276496', 'C0494463', 'C0002395') AND cp.predicate IN ('PREVENTS') AND cp.sentence_id = s.sentence_id AND c.pmid = cp.pmid ORDER BY c.pyear DESC LIMIT 5000; 


SELECT DISTINCT cp.*, i.* 
  FROM ISSNs i, (SELECT p.*, ISSN FROM predication p, CITATIONS c WHERE p.pmid = c.pmid) AS cp WHERE i.pISSN = cp.ISSN AND cp.predicate = 'TREATS' AND cp.subject_cui = 'C0022625' LIMIT 5000; 

SELECT DISTINCT 
    sp1.confounder,
    sp1.sentence1,
    sp1.pmid1,
    sp1.jt1,
    sp2.sentence2,
    sp2.pmid2,
    sp2.jt2 #, '#####'
    
    



