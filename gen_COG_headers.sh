#!/bin/bash
for filename in /mnt/c/Temp/ppf/*.ppf; do
  filepath="pwd $filename";
  filenm="$(basename $filename)";
  IFS='_' read -a fn_parts <<< "${filenm%.*}";
  sht_ppr=${fn_parts[1]}${fn_parts[2]};
  sht_pdf=${fn_parts[1]}_${fn_parts[2]};
  case "${fn_parts[0]}" in
    'STD') paper_dim="PAPER_SIZE = ( 1030.000000, 690.000000 )";
            flip="";
       ;;
    'STD-2') paper_dim="PAPER_SIZE = ( 1060.000000, 700.000000 )";
            flip="_R";
       ;;
    'STD-3') paper_dim="PAPER_SIZE = ( 1270.000000, 700.000000 )";
            flip="_R";
       ;;
    'Half') paper_dim="PAPER_SIZE = ( 566.000000, 720.000000 )";
            flip="_R";
       ;;
    'Metrotto') paper_dim="PAPER_SIZE = ( 1200.000000, 700.000000 )";
            flip="_R";
       ;;
    'XXL') paper_dim="PAPER_SIZE = ( 1220.000000, 805.000000 )";
            flip="_R";
       ;;
    'Square') paper_dim="PAPER_SIZE = ( 990.000000, 885.000000 )";
            flip="";
       ;;
    *) echo "PAPER SIZE NOT SET, UNRECOGNISED IDENTIFIER";
       ;;
  esac
  echo "FILE = O:\COG\master\print\COG_master_z50.dgn" > "${sht_pdf}_2018.ppf";
  echo "MODEL = Default" >> "${sht_pdf}_2018.ppf";
  echo "OUTPUT = O:\COG\master\output\public\\"${sht_pdf}"_pub"${flip}".pdf" >> "${sht_pdf}_2018.ppf";
  echo "LV =      Default, \\" >> "${sht_pdf}_2018.ppf";
  echo "SCALE = 50.000000" >> "${sht_pdf}_2018.ppf";
  echo "OFFSET_HEIGHT = 0.032665" >> "${sht_pdf}_2018.ppf";
  echo "##########################################################################################";
  echo ${paper_dim} >> "${sht_pdf}_2018.ppf";
  cat "$filename" | grep FENCE >> "${sht_pdf}_2018.ppf";
  echo "##########################################################################################";
  echo "%include O:\COG\master\headers\includes\public_header_1.ppr" >> "${sht_pdf}_2018.ppf";
  echo "%include O:\COG\master\headers\includes\public_header_2.ppr" >> "${sht_pdf}_2018.ppf";
  echo "%include O:\COG\master\headers\includes\public_header_3.ppr" >> "${sht_pdf}_2018.ppf";
  echo "%include O:\COG\master\headers\includes\pub_sheets\\"${sht_ppr}"_sht.ppr" >> "${sht_pdf}_2018.ppf";
  echo "%include O:\COG\master\headers\includes\pdf_sheet_tokens.ppr" >> "${sht_pdf}_2018.ppf";
  cat "${sht_pdf}_2018.ppf";
done
