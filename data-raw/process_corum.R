library(tidyverse)

corum_180627 <- read_tsv("inst/ext-data/allComplexes.txt") %>%
  set_tidy_names(syntactic = T)

corum_alt_ids_180627 <- corum_180627 %>%
  select(ComplexID, Organism,
         subunits.Entrez.IDs., subunits.Protein.name., subunits.UniProt.IDs.)

corum_go_terms_180627 <- corum_180627 %>%
  select(ComplexID, Organism,
         GO.ID, GO.description)

####
corum_180627 %>% select(ComplexID,ComplexName,Organism, subunits.Gene.name.) %>%
  mutate(subunits.Gene.name. = map(subunits.Gene.name.,
                                   .f=function(x) str_split(x,";") %>%
                                     data.frame() %>% as_tibble())) %>%
  unnest() -> intermediate

intermediate %>%
  gather(complex, gene, 4:3326) %>%
  drop_na() %>%
  select(-complex) %>%
  distinct() -> corum_tidy_180627

devtools::use_data(corum_180627,
                   corum_alt_ids_180627,
                   corum_go_terms_180627,
                   corum_tidy_180627)


