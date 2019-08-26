library(dplyr)
options(scipen = 999)
setwd("C:/Users/320024909/Desktop")
lsp_ct <- read.csv("LSP_CT.csv", stringsAsFactors = FALSE, na.strings="") %>% 
  filter(!is.na(Golden.Oppy.ID)) %>% select(Golden.Oppy.ID, Value)
lsp_ct$Value <- as.integer(lsp_ct$Value)
sfdc_ct <- read.csv("Master_LSP.csv", stringsAsFactors = FALSE, na.strings = "") %>% filter(!is.na(Golden.Opportunity.ID)) %>% select(Golden.Opportunity.ID, Philips.Target.Value..converted.)

colnames(lsp_ct) <- c("Golden.Oppy.ID",  "Value")
colnames(sfdc_ct)<- c("Golden.Oppy.ID", "Value")

test <- inner_join(sfdc_ct, lsp_ct, by = "Golden.Oppy.ID")

test1 <- test %>% filter(Value.x != Value.y)

original_ct <-  read.csv("LSP_CT.csv", stringsAsFactors = FALSE, na.strings="")
test2 <- left_join(test1, original_ct, by = "Golden.Oppy.ID") %>% select(Opportunity.Name, Stage, Capture.Manager, Golden.Oppy.ID, Value.x, Value.y)

write.csv(test2, "test2.csv")
