echo "REVERSE PROSPECT $1"

declare -a pagesAffected=("contactList")
#declare -a componentsAffected=("")

if [ $1 == "enabled" ]; then

    for j in "${pagesAffected[@]}"
    do
        #jsx
        sed -i -e "s/{\/.*jsx-begin reverse_prospect/{\/*jsx-enabled-begin reverse_prospect*\/}/g" ../../src/pages/${j}/index.js
        sed -i -e "s/jsx-end reverse_prospect.*\/}/{\/*jsx-end-enabled reverse_prospect*\/}/g" ../../src/pages/${j}/index.js


        #js
        sed -i -e "s/\/.*js-begin reverse_prospect/\/*js-enabled-begin reverse_prospect*\//g" ../../src/pages/${j}/index.js
        sed -i -e "s/js-end reverse_prospect.*\//\/*js-end-enabled reverse_prospect*\//g" ../../src/pages/${j}/index.js
    done
    
fi

if [ $1 == "disabled" ]; then

    for i in "${pagesAffected[@]}"
    do
        #jsx
        sed -i -e "s/{\/.*jsx-enabled-begin reverse_prospect.*\/}/{\/*jsx-begin reverse_prospect/g" ../../src/pages/${i}/index.js
        sed -i -e "s/{\/.*jsx-end-enabled reverse_prospect.*\/}/jsx-end reverse_prospect*\/}/g" ../../src/pages/${i}/index.js

        #js
        sed -i -e "s/\/.*js-enabled-begin reverse_prospect.*\//\/*js-begin reverse_prospect/g" ../../src/pages/${i}/index.js
        sed -i -e "s/\/.*js-end-enabled reverse_prospect.*\//js-end reverse_prospect*\//g" ../../src/pages/${i}/index.js
    done
    
fi