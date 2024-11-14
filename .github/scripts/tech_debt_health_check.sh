#!/bin/bash
#
# Outputs health metrics of various tech debt migration efforts
#
# Usage:
# download_seed "https://url/to/download" "output_filename"
#
exit_code=0

if [[ -z ${FILENAME} ]]; then
    echo "Missing FILENAME variable"
    exit 1
fi

function check_usages() {
    local readonly DESCRIPTION=$1
    local readonly SEARCH_STRING=$2
    local readonly STARTING_POINT=$3
    COUNT="$(grep -ri "${SEARCH_STRING}" * | wc -l | tr -d ' ')"
    DIFFERENCE=$(($STARTING_POINT - $COUNT))
    PERCENTAGE_REMAINING=$(echo "result = $DIFFERENCE / $STARTING_POINT * 100; scale=0; result / 1" | bc -l)
    echo "Usages of ${DESCRIPTION}: ${COUNT} (${PERCENTAGE_REMAINING}%)"
    echo "|$DESCRIPTION|$STARTING_POINT|$COUNT|![$PERCENTAGE_REMAINING%](https://progress-bar.xyz/$PERCENTAGE_REMAINING?title=Completed)|" >> "$FILENAME"
    return 0
}

rm -f "$FILENAME"

echo "| Migration | Starting Usage | Current Usages | Status |" >> "$FILENAME"
echo "| --- | --- | --- | --- |" >> "$FILENAME"

echo "Checking Health..."
echo -e "=============================\n"

echo "Checking code usages of deprecated libraries..."
check_usages "RxJava 1" "^import rx" 571
check_usages "RxJava 2" "^import io.reactivex" 85
check_usages "Joda Time" "^import org.joda" 204
check_usages "Otto" "^import com.squareup.otto" 764
check_usages "Gson" "^import com.google.gson" 165
check_usages "Volley" "^import com.android.volley" 116
check_usages "CoreLogger" "^import au.com.core.log.CoreLogger" 577
check_usages "Color" "^import androidx.compose.ui.graphics.Color" 63

echo "Checking kotest..."
check_usages "Kotest test cases" "^import io.kotest.core.test.TestCase" 155

echo -e "\nDone."
exit $exit_code
