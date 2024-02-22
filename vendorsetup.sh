if [ "$SKIP_DT_SETUP" = "True" ]; then
    echo "Skipped proprietary files setup!"
else
if [ -n "${CLEAN_DT_REPOS}" ]; then
    if [ "$CLEAN_DT_REPOS" = "True" ]; then
        echo "Cleaning old repos before cloning"
        rm -rf device/motorola/sm8475-common
        rm -rf device/motorola/eqs-kernel
        rm -rf vendor/motorola
        rm -rf hardware/motorola
        unset CLEAN_DT_REPOS
    fi
fi
echo Cloning device specific HALs
rm -rf hardware/qcom-caf/sm8450/display
git clone https://github.com/Project-Elixir/hardware_qcom-caf_sm8450_display hardware/qcom-caf/sm8450/display
echo Done.
echo Pulling changes from git for device/motorola/eqs
cd device/motorola/eqs && git reset --hard HEAD~1 && git pull;cd ../../..
echo Done pulling changes, now proceeding to clone or pull changes of other repos
echo eqs: start cloning device specific repos
COMMON_DT=device/motorola/sm8475-common/sm8475.mk
if ! [ -a $COMMON_DT ]; then git clone https://github.com/nishant6342/device_motorola_sm8475-common -b UNO device/motorola/sm8475-common
else
cd device/motorola/sm8475-common && git reset --hard HEAD~1 && git pull;cd ../../..
fi
COMMON_VT=vendor/motorola/sm8475-common/sm8475-common-vendor.mk
if ! [ -a $COMMON_VT ]; then git clone https://github.com/nishant6342/vendor_motorola_sm8475-common -b UNO vendor/motorola/sm8475-common
else
cd vendor/motorola/sm8475-common && git reset --hard HEAD~1 && git pull;cd ../../..
fi
VT=vendor/motorola/eqs/eqs-vendor.mk
if ! [ -a $VT ]; then git clone https://gitea.com/nishant6342/vendor_motorola_eqs -b UNO vendor/motorola/eqs
else
cd vendor/motorola/eqs && git reset --hard HEAD~1 && git pull;cd ../../..
fi
KT=device/motorola/eqs-kernel
if [ ! -d "$KT" ]; then git clone --depth=1 https://github.com/nishant6342/device_motorola_eqs-kernel device/motorola/eqs-kernel
else
cd device/motorola/eqs-kernel && git reset --hard HEAD && git pull;cd ../../..
fi
HARDWARE_MOTO=hardware/motorola/lineage.dependencies
if ! [ -a $HARDWARE_MOTO ]; then git clone --depth=1 https://github.com/nishant6342/hardware_motorola -b UNO hardware/motorola
else
cd hardware/motorola && git reset --hard HEAD && git pull;cd ../..
fi
KERNEL_SOURCE=kernel/motorola/sm8475/Makefile
if ! [ -a $KERNEL_SOURCE ]; then git clone --depth=1 https://github.com/nishant6342/android_kernel_motorola_sm8475 -b workbranch kernel/motorola/sm8475
fi
echo eqs: end cloning device specific repos
fi