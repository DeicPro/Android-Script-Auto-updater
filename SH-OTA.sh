SH-OTA(){ # v2.1_alpha By Deic, DiamondBond & hoholee12

    # Configuration
    version="version"
    cloud="https://your_site.com/update.txt"

    # Optional
    notes_cloud="https://your_site.com/notes.txt"

    # 0/1 = Disabled/Enabled
    show_version="1"
    show_notes="0"

    # Don't touch from here
    data_dir="/data/SH-OTA/"
    tools_version="$data_dir/tools_v1.0"
    tools_cloud="https://github.com/DeicPro/Download/releases/download/SH-OTA_Tools/SH-OTA_Tools.zip"
    tools_zip="$EXTERNAL_STORAGE/download/SH-OTA_Tools.zip"
    done="$data_dir/zzz"
    script_name=`basename $0`

    cd $data_dir/tools/ 2>/dev/null
    mount -o remount,rw rootfs
    mount -o remount,rw /system
    mount -o remount,rw /data
    mkdir -p $data_dir
    chmod 755 $data_dir

    if [ ! -f $tools_version ]; then
        clear
        echo "Downloading Tools..."
        am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity $tools_cloud >/dev/null 2>&1

        while true; do
            if [ -f $tools_zip ]; then
                kill -9 $(pgrep com.android.browser)
                sleep 5
                break
            fi
        done

        clear
        echo "Installing Tools..."
        rm -f $data_dir/tools_v*
        unzip -o -q $download_dir/SH-OTA_Tools.zip -d $data_dir

        while true; do
            if [ -f $done ]; then
                chmod -R 755 $data_dir
                busybox --install -s $data_dir/tools/
                chmod -R 755 $data_dir
                rm -f $done
                rm -f $tools_zip
                clear
                echo "Installed."
                sleep 1.5
                break
            fi
        done
    fi

    clear
    echo "Checking updates..."
    curl -k -L -o $data_dir/update.txt $cloud 2>/dev/null

    if [ "$show_notes" == 1 ]; then
        curl -k -L -o $data_dir/notes.txt $notes_cloud 2>/dev/null
    fi

    while true; do
        if [ -f $data_dir/update.txt ]; then
            if [ "`grep $version $data_dir/update.txt 2>/dev/null`" ]; then
                clear
                echo "You have the latest version."
                sleep 1.5
                install="0"
                break
            else
                if [ "$show_version" == 1 ]; then
                    version_opt=": $version"
                else
                    version_opt="..."
                fi

                clear
                echo "A new version of the script was found$version_opt"
                echo

                if [ "$show_notes" == 1 ] && [ -f $data_dir/notes.txt ]; then
                    cat $data_dir/notes.txt
                    echo
                fi

                echo "Want install it? (Y/N)"
                echo
                echo -n "> "
                read i
                case $i in
                    y|Y )
                        install="1"
                        break
                    ;;
                    n|N )
                        install="0"
                        break
                    ;;
                    * )
                        echo "Write [Y] or [N] and press enter..."
                        sleep 1.5
                    ;;
                esac
            fi
        fi
    done

    if [ "$install"  == 1 ]; then
        clear
        echo "Downloading..."
        curl -k -L -o $data_dir/$script_name $(cat $data_dir/update.txt | tr '\n' ',' | cut -d ',' -f2) 2>/dev/null
    fi

    while true; do
        if [ "$install" == 0 ]; then
            clear
            break
        fi

        if [ -f $data_dir/$script_name ]; then
            clear
            echo "Installing..."
            cp -f $data_dir/$script_name $0
            sleep 2
            chmod 755 $0
            rm -f $data_dir/$script_name
            clear
            echo "Installed."
            sleep 1.5
            $SHELL -c $0
            clear
            exit
        fi
    done

    cd /
}
SH-OTA
