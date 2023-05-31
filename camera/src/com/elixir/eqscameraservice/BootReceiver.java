/*
 * Copyright (C) 2023 ArrowOS
 * 
 * SPDX-License-Identifier: Apache-2.0
 */

package com.elixir.eqscameraservice;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

public class BootReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(final Context context, Intent intent) {
        if (!intent.getAction().equals(Intent.ACTION_BOOT_COMPLETED))
            return;

        EqsCameraService.startService(context);
    }
}
