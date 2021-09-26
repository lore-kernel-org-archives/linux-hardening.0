Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A6EC433FE
	for <linux-hardening@archiver.kernel.org>; Sun, 26 Sep 2021 11:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C26F6103B
	for <linux-hardening@archiver.kernel.org>; Sun, 26 Sep 2021 11:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhIZLeA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 26 Sep 2021 07:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230309AbhIZLeA (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 26 Sep 2021 07:34:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A646860FED;
        Sun, 26 Sep 2021 11:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632655944;
        bh=Nyf6ewIDShuX8FXOPmkb/30L2yrtLO3R5Tz0tD+fZW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FYJieOOfSJ0j6fXY+Tm2kme99uWr0T1KCEBG03yeZsxY6/+fmh4DVAY0c0UWb6zFP
         s2vgwmsqP7UGd5ZrG5UWPsMCB4CSb3t5MrzzFekNjQr6E65eUL2/LVV2Ic9O84N0eN
         QzMXS10VIDczAfrE/NukFiqd7Qg1OopENQWR5z1Q=
Date:   Sun, 26 Sep 2021 13:32:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: Switch to common use of
 attributes
Message-ID: <YVBaQAFVX1CeQUPE@kroah.com>
References: <20210926111908.6950-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926111908.6950-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Sep 26, 2021 at 01:19:08PM +0200, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, to avoid open-coded arithmetic in the kzalloc() call inside the
> create_attr_set() function the code must be refactored. Using the
> struct_size() helper is the fast solution but it is better to switch
> this code to common use of attributes.
> 
> Then, remove all the custom code to manage hotkey attributes and use the
> attribute_group structure instead, refactoring the code accordingly.
> Also, to manage the optional hotkey attributes (hotkey_tablet_mode and
> hotkey_radio_sw) use the is_visible callback from the same structure.
> 
> Moreover, now the hotkey_init_tablet_mode() function never returns a
> negative number. So, the check after the call can be safely removed.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
> Hi,
> 
> Following the suggestions made by Greg I have switch the code to common
> use of attributes. However this code is untested. If someone could test
> it would be great.

Much better, thanks.

But, I have a few questions here:

> @@ -3161,9 +3106,7 @@ static void hotkey_exit(void)
>  	hotkey_poll_stop_sync();
>  	mutex_unlock(&hotkey_mutex);
>  #endif
> -
> -	if (hotkey_dev_attributes)
> -		delete_attr_set(hotkey_dev_attributes, &tpacpi_pdev->dev.kobj);
> +	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);

Why do you have to manually add/remove these groups still?

A huge hint that something is going wrong is when you have to call a
sysfs_*() call from within a driver.  There should be proper driver_*()
calls for you instead to get the job done.

As this is a platform device, why not set the dev_groups variable in the
platform_driver field so that these attribute groups get added and
removed automatically?

An example commit to look at that shows how this was converted for one
driver is 5bd08a4ae3d0 ("platform: x86: hp-wmi: convert platform driver
to use dev_groups").  See if that helps here as well.

thanks,

greg k-h
