source("https://bioconductor.org/biocLite.R")
biocLite("Biostrings")
library(Biostrings)
library(genbankr)
library(annotate)


gff <- "C:\\Users\\tanner\\Downloads\\AG-S4_annotations.gff" #later this needs to be made into a filestream input
fasta <- "C:\\Users\\tanner\\Downloads\\AG-S4.fasta"
sequence <- readDNAStringSet(fasta, format="fasta")
annotations <- read.gff(gff)
dnachar <- as.character(sequence)

# This script will loop through each 'cds' annotation and then transcribe it.


for(i in 1:nrow(annotations)){
    if(annotations[i,"type"] == "CDS"){
        start <- annotations[i, "start"]
        stop <- annotations[i, "stop"]
        CDS <- getCodingSequence(annotations[i,], dnachar, stop, start)
        
        }
    }
}
getCodingSequence <- function(annotations, dnachar, stop, start){
    if(annotations[,"strand"] == "-"){
            locus <- substr(dnachar, stop, start)
            locus <- DNAString(locus)
            codingSequence <- as.character(reverseComplement(locus))
    }
    if(annotations[,"strand"] == "+"){
        codingSequence <- substr(dnachar, start, stop)
    }
    return(codingSequence)    
}
# First: check start codon. If CDS has invalid bacterial start check if start is ACG, 
#ACC, CCG, GCG, or CAG (I *think* these are all of the bacterial start codons). If this 
#is the case, they are likely result of RNA editing, so add transl_except for those residues.
#This should cover almost every case of invalid starts. Any other case probably needs to be
#done manually for now (give relevant error message) 
checkStartCodon <- function(CDS){
    if(substr)
    }
# Second: check final codon. If it isn't a valid stop codon compare to the length of the subject CDS to the length of adi-cap-ven. In many cases there are missing stops because the cds is simply too long. For these instances the next step is to look for stop codons on the subject sequence within 15bp +/- the length of adi-cap-ven cds. If there are any, the one that is closest to the length of adi-cap-ven is the new final codon. 
# If after this step there is still no valid stop codon, then we extend the length of the cds 15bp, and check again if there is a stop codon. If there is not, then missing stop codon likely due to RNA editing. 
# Check final codon. If it is CAA, CAG, CGA, then transl_except final codon to term.
# If still no valid stop, probably needs to be done manually (give relevant error message).

# Third: look for internal stops. Add transl_except for each of those. 

