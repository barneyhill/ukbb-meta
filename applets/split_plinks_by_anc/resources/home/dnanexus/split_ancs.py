import csv
import random
from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument("--qced_sampled_id_file", dest="qced_sampled_id_file")
parser.add_argument("--superpopulation_file", dest="superpopulation_file")
parser.add_argument("--anc", dest="anc")

args = parser.parse_args()

with open(args.qced_sampled_id_file, "r") as f:
    qc_exome_sampled_ids = f.read().splitlines()

anc_sample_list = []
with open(args.superpopulation_file) as file: # Read sample IDs into respective anc lists
        tsv_file = csv.reader(file, delimiter="\t")
        for line in tsv_file:
                if line[1] == args.anc:
                        anc_sample_list.append(line[0])

anc_sample_list = list(set(anc_sample_list) & set(qc_exome_sampled_ids)) # Only include IDs found in QCd exome data
with open(args.anc +".txt", 'w') as fp:
    fp.write('\n'.join(anc_sample_list))
with open("pheno.txt", 'w') as fp:
    fp.write("y_binary IID\n")
    for sample in anc_sample_list:
        fp.write(str(random.randint(0, 1)) + " " + str(sample) + "\n")
