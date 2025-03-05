# !/bin/bash

if [ "$#" -ne 5 ]; then
    echo "Usage: $0 arg1 arg2 arg3"
    echo "arg1 is the source folder (zip or not)"
    echo "arg2 is the page name"
    echo "arg3 src folder"
    echo "arg4 boolean flag to wait the source folder"
    echo "arg5 boolean flag to create backups or not"
    exit 1
fi

echo -e "Script executed with arguments"
echo -e "\tSource folder: $1"
echo -e "\tPage name: $2"
echo -e "\tWebsite src folder: $3"
echo -e "\tWait for the source folder: $4"
echo -e "\tCreate backups: $5"

while true; do
    if [ -f "$1" ]; then
        
        date
        if unzip -t "$1" >/dev/null 2>&1; then
            echo "$1 is a ZIP file."
            unzip -o $1 -d $2
        else
            echo "$1 is not a ZIP file or does not exist."
        fi

        if [ $5 -eq 1 ]; then
            mv $3/$2/$2.component.html $3/$2/$2.component.html.backup
            mv $3/$2/$2.component.css $3/$2/$2.component.css.backup
        fi

        mv $2/index.html $3/$2/$2.component.html
        mv $2/style.css $3/$2/$2.component.css

        sed -i 's/__ngmodel__/[(ngModel)]/g' $3/$2/$2.component.html
        sed -i 's/_value_/[value]/g' $3/$2/$2.component.html
        sed -i 's/_ngfor/*ngFor/g' $3/$2/$2.component.html
        sed -i 's/_ngif/*ngIf/g' $3/$2/$2.component.html
        sed -i 's/_keydown_/(keydown)/g' $3/$2/$2.component.html
        sed -i '/<meta name=\"generator\"[^>]*>/d' $3/$2/$2.component.html
        sed -i '/<link rel=\"stylesheet\"[^>]*>/d' $3/$2/$2.component.html

        rm -rf $1
        rm -rf $2
    else
        if [ $4 -ne 1 ]; then
            break
        else
            sleep 1
        fi
    fi
done