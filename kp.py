

from indra.tools.gene_network import GeneNetwork
from indra import literature
from indra.sources import reach
from indra.tools import assemble_corpus as ac

from libsbml import *

gn = GeneNetwork(['APOE'])
biopax_stmts = gn.get_biopax_stmts()
bel_stmts = gn.get_bel_stmts()


pmids = literature.pubmed_client.get_ids_for_gene('APOE')

paper_contents = {}
for pmid in pmids:
    content, content_type = literature.get_full_text(pmid, 'pmid')
    if content_type == 'abstract':
        paper_contents[pmid] = content
    if len(paper_contents) == 10:
        break

literature_stmts = []
for pmid, content in paper_contents.items():
    rp = reach.process_text(content, url=reach.local_text_url)
    literature_stmts += rp.statements

print('Got %d statements' % len(literature_stmts))

stmts = bel_stmts + biopax_stmts + literature_stmts

stmts = ac.map_grounding(stmts)
stmts = ac.map_sequence(stmts)
stmts = ac.run_preassembly(stmts)

# Assemble the statements into a network model

from indra.assemblers.pysb import PysbAssembler
pa = PysbAssembler()
pa.add_statements(stmts)
model = pa.make_model()

# Compile model

import os
os.environ['BNGPATH'] = '/home/smalec/Projects/BioNetGen-2.6.0'

for monomer in pa.model.monomers:
   print(monomer)

for rule in pa.model.rules:
   print(rule)


for annotation in pa.model.annotations:
   print(annotation)

pa.export_model('sbml', file_name='model.sbml')
 
