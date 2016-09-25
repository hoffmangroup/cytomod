#!/usr/bin/env bash
set -o nounset -o pipefail -o errexit

source $(dirname $0)/commonTestUtils.sh

# NB: all test cases use non-default ASCII-code order
PROGRAM_PATH="$BASE_PROG_PATH/convertToOrModifyExtreMEME.py --ASCIICodeOrder "

echo -e "------------------------\nconvertToOrModifyExtreMEME.py\n------------------------" >&2


# -------------------------------- Test 1 --------------------------------

# 1A) check single sequence (from file) input

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsTest "$PROGRAM_PATH" '1A' "-s $DATA_DIR/NFATC1.seq" "$correct_result"

# 1B) check PFM input

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.100000	0.225000	0.175000	0.500000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.200000	0.100000	0.250000	0.450000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.050000	0.150000	0.600000	0.200000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.925000	0.075000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsTest "$PROGRAM_PATH" '1B' "-c $DATA_DIR/TFAP2A.pfm" "$correct_result"

# 1C) check TRANSFAC count matrix input

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.127660	0.319149	0.404255	0.148936	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.297872	0.255319	0.276596	0.170213	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.404255	0.063830	0.340426	0.191489	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.085106	0.042553	0.106383	0.765957	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.085106	0.042553	0.702128	0.170213	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.765957	0.085106	0.042553	0.106383	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.063830	0.276596	0.617021	0.042553	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.042553	0.936170	0.000000	0.021277	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.042553	0.170213	0.510638	0.276596	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.212766	0.510638	0.106383	0.170213	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.319149	0.255319	0.234043	0.191489	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsTest "$PROGRAM_PATH" '1C' "-t $DATA_DIR/c-Jun.transfac" "$correct_result"

# 1D) check TRANSFAC frequency matrix input (here a count matrix is parsed, but should still work to verify this)
# currently not tested, since program checks for PWM summing to one

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	6.000000	15.000000	19.000000	7.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	14.000000	12.000000	13.000000	8.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	19.000000	3.000000	16.000000	9.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	4.000000	2.000000	5.000000	36.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	4.000000	2.000000	33.000000	8.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	36.000000	4.000000	2.000000	5.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	3.000000	13.000000	29.000000	2.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	47.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	2.000000	44.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	47.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	2.000000	8.000000	24.000000	13.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	10.000000	24.000000	5.000000	8.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	15.000000	12.000000	11.000000	9.000000	0.000000	0.000000	0.000000	0.000000
EOF
)

#runContainsTest "$PROGRAM_PATH" '1D' "-f $DATA_DIR/c-Jun.transfac" "$correct_result"

# 1E) check JASPAR input

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.388258	0.133155	0.233403	0.245183	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.339374	0.140118	0.237743	0.282764	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.309805	0.090757	0.461751	0.137686	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.788153	0.034767	0.177079	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.994325	0.005675	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.999952	0.000000	0.000000	0.000048	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.163964	0.215185	0.620851	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.028997	0.971003	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.044735	0.168399	0.000000	0.786866	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.329264	0.670736	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.009681	0.176650	0.048455	0.765214	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsTest "$PROGRAM_PATH" '1E' "-j $DATA_DIR/JUN.jaspar" "$correct_result"

# 1F) check the use of a non-directly supported format using another format with '-a'

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.251714	0.102260	0.130213	0.515812	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.231021	0.315993	0.266960	0.186027	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.371176	0.148489	0.154093	0.326242	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.343516	0.182792	0.241158	0.232533	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.189182	0.406736	0.150469	0.253613	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.373250	0.213861	0.093013	0.319877	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.159426	0.324485	0.354969	0.161120	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.387399	0.041865	0.554464	0.016273	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.160370	0.045745	0.095696	0.698188	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.005796	0.990551	0.002425	0.001229	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.984310	0.010504	0.001069	0.004117	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000521	0.975244	0.009222	0.015013	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.051217	0.006412	0.941806	0.000565	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.005548	0.004339	0.009408	0.980706	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.001089	0.001609	0.973243	0.024060	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.436684	0.262473	0.085756	0.215086	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.106430	0.184028	0.060086	0.649457	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.087265	0.549339	0.129208	0.234188	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.277936	0.127202	0.253172	0.341690	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.222894	0.198103	0.437904	0.141099	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.366797	0.306136	0.194022	0.133046	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.226022	0.321957	0.116642	0.335379	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsTest "$PROGRAM_PATH" '1F' "-a -c $DATA_DIR/Cbf1.uniprobe" "$correct_result"

# 1G) check MEME single input

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.358219	0.129452	0.172146	0.340183	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.256849	0.175342	0.390183	0.177626	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.355023	0.166438	0.278539	0.200000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.239954	0.119863	0.097489	0.542694	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.007306	0.241324	0.174658	0.576712	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.002055	0.688356	0.208676	0.100913	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.043836	0.000000	0.956164	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.011644	0.000000	0.000000	0.988356	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.279680	0.000000	0.000000	0.720320	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.023744	0.402968	0.449087	0.124201	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.286758	0.270548	0.051142	0.391553	0.000000	0.000000	0.000000
EOF
)

runContainsTest "$PROGRAM_PATH" '1G' "-m $DATA_DIR/MA0036.2_GATA2_JASPAR.meme" "$correct_result"

# 1H) check MEME multiple input

correct_result=$(cat <<'EOF'
MOTIF AAAACAAA DREME

letter-probability matrix: alength= 10 w= 8 nsites= 52 E= 1.1e-002
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000

MOTIF AMACAS DREME

letter-probability matrix: alength= 10 w= 6 nsites= 2023 E= 2.7e-019
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.467128	0.532872	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.391498	0.608502	0.000000	0.000000	0.000000	0.000000

MOTIF MA0036.2 GATA2

letter-probability matrix: alength= 10 w= 14 nsites= 4380 E= 0.0e+000
0.000000	0.000000	0.000000	0.358219	0.129452	0.172146	0.340183	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.256849	0.175342	0.390183	0.177626	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.355023	0.166438	0.278539	0.200000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.239954	0.119863	0.097489	0.542694	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.007306	0.241324	0.174658	0.576712	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.002055	0.688356	0.208676	0.100913	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.043836	0.000000	0.956164	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.011644	0.000000	0.000000	0.988356	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.279680	0.000000	0.000000	0.720320	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.023744	0.402968	0.449087	0.124201	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.286758	0.270548	0.051142	0.391553	0.000000	0.000000	0.000000

MOTIF MA0037.2 GATA3

letter-probability matrix: alength= 10 w= 8 nsites= 4628 E= 0.0e+000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.278738	0.000000	0.721262	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.604149	0.153846	0.242005	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsTest "$PROGRAM_PATH" '1H' "-m $DATA_DIR/ENCFF001YFL_GATA1_MEME-ChIP_result_sample.meme" "$correct_result"

# 1I) check MEME multiple input with an additional sequence input
#     also checks that the background line is as expected

correct_result=$(cat <<'EOF'
1 0.001 2 0.0 3 0.0 A 0.257 C 0.242 G 0.242 T 0.257 f 0.0 h 0.0 m 0.001

MOTIF CACRTG

letter-probability matrix: alength= 10 w= 6
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.500000	0.000000	0.500000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000

MOTIF [C1][AG1]RDCMCC1GVC MEME

letter-probability matrix: alength= 10 w= 12 nsites= 10 E= 4.8e-009
0.300000	0.000000	0.000000	0.000000	0.600000	0.100000	0.000000	0.000000	0.000000	0.000000
0.200000	0.000000	0.000000	0.400000	0.100000	0.300000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.500000	0.200000	0.300000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.300000	0.000000	0.400000	0.300000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.100000	0.700000	0.200000	0.000000	0.000000	0.000000	0.000000
0.200000	0.000000	0.000000	0.300000	0.500000	0.000000	0.000000	0.000000	0.000000	0.000000
0.100000	0.000000	0.000000	0.000000	0.700000	0.200000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.800000	0.000000	0.000000	0.000000	0.000000	0.200000
1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.800000	0.200000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.300000	0.200000	0.400000	0.100000	0.000000	0.000000	0.000000
0.100000	0.000000	0.000000	0.000000	0.900000	0.000000	0.000000	0.000000	0.000000	0.000000

MOTIF AAAACAAA DREME

letter-probability matrix: alength= 10 w= 8 nsites= 52 E= 1.1e-002
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000

MOTIF AMACAS DREME

letter-probability matrix: alength= 10 w= 6 nsites= 2023 E= 2.7e-019
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.467128	0.532872	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.391498	0.608502	0.000000	0.000000	0.000000	0.000000

MOTIF MA0036.2 GATA2

letter-probability matrix: alength= 10 w= 14 nsites= 4380 E= 0.0e+000
0.000000	0.000000	0.000000	0.358219	0.129452	0.172146	0.340183	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.256849	0.175342	0.390183	0.177626	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.355023	0.166438	0.278539	0.200000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.239954	0.119863	0.097489	0.542694	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.007306	0.241324	0.174658	0.576712	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.002055	0.688356	0.208676	0.100913	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.043836	0.000000	0.956164	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.011644	0.000000	0.000000	0.988356	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.279680	0.000000	0.000000	0.720320	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.023744	0.402968	0.449087	0.124201	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.286758	0.270548	0.051142	0.391553	0.000000	0.000000	0.000000

MOTIF MA0037.2 GATA3

letter-probability matrix: alength= 10 w= 8 nsites= 4628 E= 0.0e+000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.278738	0.000000	0.721262	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.604149	0.153846	0.242005	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsTest "$PROGRAM_PATH" '1I' "-s CACRTG -m $DATA_DIR/ENCFF001YFL_GATA1_MEME-ChIP_result_sample.meme" "$correct_result"

# 2) check skipping a portion of a motif

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.371176	0.148489	0.154093	0.326242	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.343516	0.182792	0.241158	0.232533	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.189182	0.406736	0.150469	0.253613	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.373250	0.213861	0.093013	0.319877	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsTest "$PROGRAM_PATH" '2' "-S 0:2,6: -a -c $DATA_DIR/Cbf1.uniprobe" "$correct_result"

# 3A) check reverse complementing a motif constructed from a sequence file

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsTest "$PROGRAM_PATH" '3A' "-s $DATA_DIR/NFATC1.seq --revcomp" "$correct_result"

# 3B) check reverse complementing a motif constructed from a matrix file

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.075000	0.925000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.200000	0.600000	0.150000	0.050000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.450000	0.250000	0.100000	0.200000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.500000	0.175000	0.225000	0.100000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsTest "$PROGRAM_PATH" '3B' "-c $DATA_DIR/TFAP2A.pfm --revcomp" "$correct_result"

# 4A) check nucleobase omission, single base, specified by symbol

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.100000	0.225000	0.175000	0.500000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.200000	0.100000	0.250000	0.450000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.050000	0.150000	0.600000	0.200000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.925000	0.075000	0.000000	0.000000	0.000000
EOF
)

runContainsTest "$PROGRAM_PATH" '4A' "-c $DATA_DIR/TFAP2A.pfm -N c" "$correct_result"

# 4B) check nucleobase omission, two bases: one specified by symbol, the other by short name

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.100000	0.225000	0.175000	0.500000	0.000000	0.000000
0.000000	0.000000	0.200000	0.100000	0.250000	0.450000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.050000	0.150000	0.600000	0.200000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.925000	0.075000	0.000000	0.000000
EOF
)

runContainsTest "$PROGRAM_PATH" '4B' "-c $DATA_DIR/TFAP2A.pfm -N c,5hmC" "$correct_result"

# 5A) check a basic positional modification

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsFileTest "$PROGRAM_PATH" '5A' "--noWarnings -s $DATA_DIR/NFATC1.seq -P 2 -M f" "$correct_result"

# 5B) check that 5A is identical in fractional mode as well (since all matrix values are 0 or 1)

runContainsFileTest "$PROGRAM_PATH" '5B' "--noWarnings -s $DATA_DIR/NFATC1.seq -P 2 -M f -F" "$correct_result"

# 6) check that ambiguity codes are parsed correctly

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.500000	0.500000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.500000	0.000000	0.500000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.200000	0.000000	0.000000	0.200000	0.200000	0.200000	0.200000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.500000	0.500000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.333333	0.000000	0.000000	0.333333	0.333333	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000
0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.250000	0.250000	0.250000	0.250000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsTest "$PROGRAM_PATH" '6' "--noWarnings -s KRzxTCym3N" "$correct_result"

# 7A) check a fractional CpG context modification

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000
1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsFileTest "$PROGRAM_PATH" '7A' "--noWarnings -s TCCGT -M m -P G" "$correct_result"

# 7B) check that the fractional version of 7A is identical

runContainsFileTest "$PROGRAM_PATH" '7B' "--noWarnings -s TCCGT -M m -P G -F" "$correct_result"

# 8) check a CpT context modification

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsFileTest "$PROGRAM_PATH" '8' "--noWarnings -s TCCGG -M m -P T" "$correct_result"

# 9) check a fractional CpG context modification for an edge case

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000
0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsFileTest "$PROGRAM_PATH" '9' "--noWarnings -s TCACG -M h -P G" "$correct_result"

# 10) check basic hemi-modification

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000
1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsFileTest "$PROGRAM_PATH" '10A' "--noWarnings -s CCGT -M m -P G" "$correct_result"

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsFileTest "$PROGRAM_PATH" '10B' "--noWarnings -s CCGT -M m -P G -H +" "$correct_result"

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsFileTest "$PROGRAM_PATH" '10C' "--noWarnings -s CCGT -M m -P G -H -" "$correct_result"

# 11) check central modification

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000
1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsFileTest "$PROGRAM_PATH" '11A' "--noWarnings -s AACATCGAACGC -M m -P c" "$correct_result"

runContainsFileTest "$PROGRAM_PATH" '11B' "--noWarnings -s AACATCGAACGC -M m -P c -F" "$correct_result"

# 12) check that combinatorial modifications can at least run
# NB: this test does not verify the validity of the actual modifications themselves

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsTest "$PROGRAM_PATH" '12A' "--noWarnings -s CCGT -C 3" "$correct_result"

runContainsTest "$PROGRAM_PATH" '12B' "--noWarnings -s CCGT -C -A" "$correct_result"

rm -f *.meme  # remove output from this test

# 13) check that hemi-modification in non-Cp[CG] contexts functions as expected

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsFileTest "$PROGRAM_PATH" '13A' "--noWarnings -s TTCT -P T -M m" "$correct_result"

runContainsFileTest "$PROGRAM_PATH" '13B' "--noWarnings -s TTCT -P T -M m -F" "$correct_result"

runContainsFileTest "$PROGRAM_PATH" '13C' "--noWarnings -s TTCT -P T -M m -H +" "$correct_result"

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
EOF
)

runContainsFileTest "$PROGRAM_PATH" '13D' "--noWarnings -s TTCT -P T -M m -H -" "$correct_result"

# 14) check modification of all positions to a specific modification with a motif containing ambigous nucleobases or also containing already modified nucleobases

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000
EOF
)

runContainsFileTest "$PROGRAM_PATH" '14A' "--noWarnings -s CAKCTGY -A m" "$correct_result"

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.500000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.500000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000
1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.500000	0.000000	0.000000	0.000000	0.500000
EOF
)

runContainsFileTest "$PROGRAM_PATH" '14B' "--noWarnings -s CAKCm1Y -A m -F" "$correct_result"

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.500000	0.000000	0.000000	0.000000	0.000000	0.500000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000
1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.500000	0.000000	0.500000	0.000000	0.000000
EOF
)

runContainsFileTest "$PROGRAM_PATH" '14C' "--noWarnings -s CAKCm1Y -A f -F" "$correct_result"

# 15) check a specific CpG context modification

correct_result=$(cat <<'EOF'
0.000000	0.000000	0.000000	0.404939	0.000000	0.446787	0.000000	0.000000	0.000000	0.148274
0.385049	0.000000	0.000000	0.597851	0.017101	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.003461	0.840101	0.156437	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.000000	0.000000	1.000000	0.000000	0.000000	0.000000	0.000000
0.000000	0.000000	0.000000	0.146311	0.000000	0.303833	0.109475	0.000000	0.000000	0.440380
0.266997	0.000000	0.000000	0.276038	0.000000	0.000000	0.262503	0.000000	0.000000	0.194462
0.388458	0.000000	0.000000	0.210219	0.246435	0.000000	0.154887	0.000000	0.000000	0.000000
EOF
)

runContainsFileTest "$PROGRAM_PATH" '15' "--noWarnings -m $DATA_DIR/MA0500.1_Myog_JASPAR.meme -F -P G -M m" "$correct_result"
