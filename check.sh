status=0
for n in 1 2 3 4; do
    ok=1
    found=0
    for f in Testcase$n/*.1.txt; do
        name=$(basename $f .1.txt)
        out=Testcase${n}Diff/${name}Diff.txt
        if diff -q $f Testcase$n/$name.2.txt > /dev/null; then
            if [ -f $out ]; then ok=0; fi
        else
            found=1
            if [ ! -f $out ]; then
                ok=0
            elif ! cmp -s <(tail -n +3 $out) <(diff -u $f Testcase$n/$name.2.txt | tail -n +3); then
                ok=0
            fi
        fi
    done
    if [ $found -eq 1 ] && [ ! -d Testcase${n}Diff ]; then ok=0; fi
    if [ $found -eq 0 ] && [ -d Testcase${n}Diff ]; then ok=0; fi
    if [ $ok -eq 1 ]; then
        echo "Testcase$n: PASS"
    else
        echo "Testcase$n: FAIL"
        status=1
    fi
done
exit $status
