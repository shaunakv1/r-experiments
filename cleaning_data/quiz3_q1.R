#Question 3
#ACR lot_size 3
#AGS Sales of Agriculture Products 6

df_hid = read.csv("./quiz3_data/getdata-data-ss06hid.csv")
agricultureLogical = df_hid$ACR == 3 & df_hid$AGS == 6
which(agricultureLogical)[1:3]