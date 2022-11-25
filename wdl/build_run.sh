echo "BUILDING $1"
workflow=$(dxCompiler compile $1 --folder /ukbb-meta/workflows/ -instanceTypeSelection dynamic -defaultInstanceType "mem3_ssd1_v2_x2" -inputs $2 -f)
echo "RUNNING $1 w/ $2"
dx run $workflow --destination /ukbb-meta/data/workflow/AA/ -f ${2%.*}.dx.json --priority low -y
rm ${2%.*}.dx.json
