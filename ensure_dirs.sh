DIRS=(./src ./inc ./bin ./obj)

for d in "${DIRS[@]}"
do
    if [ ! -d "$d" ]; then
        mkdir "$d"
    fi
done
