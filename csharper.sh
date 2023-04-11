#!/bin/bash

# Coded by twitter: @volshebrer

# Banner

Banner() {

echo -e "\n"

echo " ::::::::   ::::::::  :::    :::     :::     :::::::::  :::::::::  :::::::::: :::::::::  
:+:    :+: :+:    :+: :+:    :+:   :+: :+:   :+:    :+: :+:    :+: :+:        :+:    :+: 
+:+        +:+        +:+    +:+  +:+   +:+  +:+    +:+ +:+    +:+ +:+        +:+    +:+ 
+#+        +#++:++#++ +#++:++#++ +#++:++#++: +#++:++#:  +#++:++#+  +#++:++#   +#++:++#:  
+#+               +#+ +#+    +#+ +#+     +#+ +#+    +#+ +#+        +#+        +#+    +#+ 
#+#    #+# #+#    #+# #+#    #+# #+#     #+# #+#    #+# #+#        #+#        #+#    #+# 
 ########   ########  ###    ### ###     ### ###    ### ###        ########## ###    ### "


echo -e "\n"
echo "This Script First Compiles .CS file, Executes the Generated Binary and Automatically Deletes the Binary After Executing It."
echo -e "\n"
echo "Disclaimer : Use this Script as a Learning Tool Only, DO NOT use this with/for your real-projects."
}

# Check If Mono-Complete Exists on the System


Check_Mono() {
    if [[ ! -x /usr/bin/mono && /usr/bin/mcs ]]; then
       echo "Looks like Mono-Complete Package is not Installed on this System or isn't available on the '/usr/bin/' path"
       echo "This Script Requires Mono-Complete Package, Please install it first and then run the script"
       exit 1; 
    fi
}

# Getting the Name of the .CS File

Getting_File_Name() {
   echo -e "\n" 
   read -p "[+] Enter the Name of Your Temp .CS File> " tmp_file_name
}

# Deleting Previously Created Binary

Del_Prv_Bin() {
    read -p "[+] Do you want to Delete it [Type y/n]> " del
    if [[ $del == 'y' || $del == 'yes' ]]
       then
           rm $tmp_file_name.exe
           echo -e "\n"
           echo "[-] Deleted Binary: $tmp_file_name"
           echo -e "\n"
           echo "[-] Exiting the Script..."
       else
           echo -e "\n"
           echo "[-] You chose No"
           echo -e "\n"
           read -p "[+] Execute the Existing Binary Then?? [Type y/n]> " dec
           if [[ $dec == 'y' || $dec == 'yes' ]]
               then
                    echo -e "\n"
                    mono $tmp_file_name.exe
                    if [ $? -ne 0 ]     # To Check If the Binary Contains Error 
                    then
                        echo -e "\n"
                        echo "[-] The '$tmp_file_name.exe' Binary Contains Errors, Execution Failed."
                        echo -e "\n"
                        echo "[-] Exiting the Script.."
                        exit 1;
                    fi
           else
               echo -e "\n"
               echo "[-] Exiting the Script Then..."
               exit 1;
           fi
    fi
    echo -e "\n"
}


BinEx() {
    echo -e "\n"
    echo "[+] An Exe Binary named $tmp_file_name.exe Already Exists."
    echo -e "\n"
    Del_Prv_Bin
    exit 1; 
}

# Check if A Binary with the Same Name Already Exists

Check_Bin_Exs_PWD() {

    if [[ -f $(pwd)/$tmp_file_name.exe ]]
        then
            BinEx
    fi

}

# Taking the .CS file, Compiling it to create a Binary, Executing it and Deleting it.

CSExts() {
    echo -e "\n"
    echo "[+] Attempting to Create a Binary Named: $tmp_file_name.exe"
    echo -e "\n"
    mcs -out:$tmp_file_name.exe $tmp_file_name.cs
    if [ $? -ne 0 ]     # To Check If the .CS File Contains Error 
    then
        echo -e "\n"
        echo "[-] The '$tmp_file_name.cs' File Contains Errors, Compilation Failed."
        echo -e "\n"
        echo "[-] Exiting the Script.."
        exit 1;
    else
        echo "[+] Build Successful.."
        echo -e "\n"
        echo "[+] Running the Program Now..."
        echo -e "\n"
        mono $tmp_file_name.exe
        echo -e "\n"
        echo "[-] Deleted the Binary.."
        rm $tmp_file_name.exe
    fi
}

# Check if the File (FileName) Provided By User Exist in the Current Directory

Check_CS_Exs_PWD() {

    if [[ ! -f $(pwd)/$tmp_file_name.cs ]]
        then
        echo -e "\n"
        echo "The File Named '$tmp_file_name.cs' Doesn't Exist in '$(pwd)' Directory, Create One or Execute the Script in the Directory Where it is Present.."
    else
        CSExts
    fi

}

# All Necessary Functions

Banner

Check_Mono

Getting_File_Name

Check_Bin_Exs_PWD

Check_CS_Exs_PWD
