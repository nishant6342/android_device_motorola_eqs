if [ -n "${CLEAN_DT_REPOS}" ]; then
    if [ "$CLEAN_DT_REPOS" = "True" ]; then
        echo "Cleaning old repos before cloning"
        rm -rf device/motorola/sm8475-common
        rm -rf device/motorola/eqs-kernel
        rm -rf vendor/motorola
        rm -rf packages/apps/PocketMode
        rm -rf hardware/motorola
        unset CLEAN_DT_REPOS
    fi
fi
echo eqs: Deleting and cloning qcom sepolicy for this device
rm -rf device/qcom/sepolicy_vndr
git clone https://github.com/Project-Elixir/device_qcom_sepolicy_vndr -b UNO device/qcom/sepolicy_vndr
echo eqs: Done
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
if ! [ -a $VT ]; then git clone https://gitlab.com/nishant6342/vendor_motorola_eqs -b UNO vendor/motorola/eqs
else
cd vendor/motorola/eqs && git reset --hard HEAD~1 && git pull;cd ../../..
fi
KT=device/motorola/eqs-kernel/kernel
if ! [ -a $KT ]; then git clone --depth=1 https://github.com/nishant6342/device_motorola_eqs-kernel device/motorola/eqs-kernel
else
cd device/motorola/eqs-kernel && git reset --hard HEAD && git pull;cd ../../..
fi
HARDWARE_MOTO=hardware/motorola/lineage.dependencies
if ! [ -a $HARDWARE_MOTO ]; then git clone --depth=1 https://github.com/nishant6342/hardware_motorola -b UNO hardware/motorola
else
cd hardware/motorola && git reset --hard HEAD && git pull;cd ../..
fi
POCKET=packages/apps/PocketMode/pocket_mode.mk
if ! [ -a $POCKET ]; then git clone --depth=1 https://github.com/nishant6342/packages_apps_PocketMode -b UNO packages/apps/PocketMode
fi
KERNEL_SOURCE=kernel/motorola/sm8475/Makefile
if ! [ -a $KERNEL_SOURCE ]; then git clone --depth=1 https://github.com/nishant6342/android_kernel_motorola_sm8475 -b lineage-20 kernel/motorola/sm8475
fi
echo eqs: end cloning device specific repos
