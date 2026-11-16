for n in 1 2 3 4; do
    rm -rf Testcase${n}Diff
    for f in Testcase$n/*.1.txt; do
        name=$(basename $f .1.txt)
        if ! diff -q $f Testcase$n/$name.2.txt > /dev/null; then
            mkdir -p Testcase${n}Diff
            diff -u $f Testcase$n/$name.2.txt > Testcase${n}Diff/${name}Diff.txt
        fi
    done
done
