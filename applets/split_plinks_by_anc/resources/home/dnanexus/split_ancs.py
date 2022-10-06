import csv
from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument("--qced_sampled_id_file", dest="qced_sampled_id_file")
parser.add_argument("--superpopulation_file", dest="superpopulation_file")

args = parser.parse_args()


with open(args.qced_sampled_id_file, "r") as f:
    qc_exome_sampled_ids = f.read().splitlines()

ancs={'EUR':[], 'AFR':[], 'SAS':[], 'EAS':[], 'AMR':[]}
with open(args.superpopulation_file) as file: # Read sample IDs into respective anc lists
        tsv_file = csv.reader(file, delimiter="\t")
        for line in tsv_file:
                if line[1] in list(ancs.keys()):
                        ancs[line[1]].append(line[0])

for anc in list(ancs.keys()):
        ancs[anc] = list(set(ancs[anc]) & set(qc_exome_sampled_ids)) # Only include IDs found in QCd exome data
        with open(anc +".txt", 'w') as fp:
                fp.write('\n'.join(ancs[anc]))

