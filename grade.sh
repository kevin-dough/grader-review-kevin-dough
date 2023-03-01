set -e
CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[ -f ListExamples.java ]]
then
    echo 'ListExamples.java found.'
else
    echo 'ListExamples.java not found.'
    exit
fi

cp ../TestListExamples.java .
cd ..
cp -R lib/ student-submission/

set +e

cd student-submission

javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" ListExamples.java TestListExamples.java >compileOut.txt 2>&1


if [[ $? -eq 0 ]]
then
    echo 'Compiled!'
else
    echo 'Not compiled!'
    exit
fi

java -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" org.junit.runner.JUnitCore TestListExamples >runOut.txt

if [[ $? -eq 0 ]]
then
    echo 'No failures! What a dub!'
else   
    echo 'Fail!'
fi

echo `grep "Tests run:" runOut.txt`

