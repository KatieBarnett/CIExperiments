#!/bin/bash
#
# Outputs health metrics of various tech debt migration efforts
#
# Usage:
# download_seed "https://url/to/download" "output_filename"
#
exit_code=0
function check_usages() {
    local readonly DESCRIPTION=$1
    local readonly SEARCH_STRING=$2
    local readonly STARTING_POINT=$3
    COUNT="$(grep -ri "${SEARCH_STRING}" * | wc -l | tr -d ' ')"
    echo "Usages of ${DESCRIPTION}: ${COUNT}"
    DIFFERENCE=$(($STARTING_POINT - $COUNT))
    PERCENTAGE_REMAINING=$(($DIFFERENCE/ $STARTING_POINT * 100))
    echo "|$DESCRIPTION|$STARTING_POINT|$COUNT|![$PERCENTAGE_REMAINING%](https://progress-bar.xyz/$PERCENTAGE_REMAINING?title=Completed)|" >> health_check.md
    return 0
}

rm -f health_check.md

echo "| Migration | Starting Usage | Current Usages | Status |" >> health_check.md
echo "| --- | --- | --- | --- |" >> health_check.md

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
