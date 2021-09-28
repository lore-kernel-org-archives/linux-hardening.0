Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF95C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 28 Sep 2021 16:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F646128B
	for <linux-hardening@archiver.kernel.org>; Tue, 28 Sep 2021 16:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbhI1QGE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 28 Sep 2021 12:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241568AbhI1QGE (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 28 Sep 2021 12:06:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2824661213;
        Tue, 28 Sep 2021 16:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632845064;
        bh=J8bFtSzTPHaRP/w8oi0vQlkr/QaRHZmeo8GXZahHSbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=He9qUGzYllosNeEAs8t1CTwdoeA7T1MSIsNyRYUserRpGTvnpD4VZs9kHNVWnERDm
         pv8rHG8VE2FxQfD6OVwlb6m1fy7ohQoOZsvoo/AZlYvMiaAOpl2d7cCEeGEnp+QJOp
         JQqIqZXNWZ8UJnXgX9i/1ps47uvxa8fUHptJog9E=
Date:   Tue, 28 Sep 2021 18:04:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Len Baker <len.baker@gmx.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: Switch to common use of
 attributes
Message-ID: <YVM9BhHcMRVnEder@kroah.com>
References: <20210926111908.6950-1-len.baker@gmx.com>
 <YVBaQAFVX1CeQUPE@kroah.com>
 <50135c0e-e291-509f-2286-a1e443fdf4f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50135c0e-e291-509f-2286-a1e443fdf4f3@redhat.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 28, 2021 at 04:55:25PM +0200, Hans de Goede wrote:
> Hi All,
> 
> On 9/26/21 1:32 PM, Greg Kroah-Hartman wrote:
> > On Sun, Sep 26, 2021 at 01:19:08PM +0200, Len Baker wrote:
> >> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> >> and Conventions" documentation [1], size calculations (especially
> >> multiplication) should not be performed in memory allocator (or similar)
> >> function arguments due to the risk of them overflowing. This could lead
> >> to values wrapping around and a smaller allocation being made than the
> >> caller was expecting. Using those allocations could lead to linear
> >> overflows of heap memory and other misbehaviors.
> >>
> >> So, to avoid open-coded arithmetic in the kzalloc() call inside the
> >> create_attr_set() function the code must be refactored. Using the
> >> struct_size() helper is the fast solution but it is better to switch
> >> this code to common use of attributes.
> >>
> >> Then, remove all the custom code to manage hotkey attributes and use the
> >> attribute_group structure instead, refactoring the code accordingly.
> >> Also, to manage the optional hotkey attributes (hotkey_tablet_mode and
> >> hotkey_radio_sw) use the is_visible callback from the same structure.
> >>
> >> Moreover, now the hotkey_init_tablet_mode() function never returns a
> >> negative number. So, the check after the call can be safely removed.
> >>
> >> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> >>
> >> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Signed-off-by: Len Baker <len.baker@gmx.com>
> >> ---
> >> Hi,
> >>
> >> Following the suggestions made by Greg I have switch the code to common
> >> use of attributes. However this code is untested. If someone could test
> >> it would be great.
> > 
> > Much better, thanks.
> 
> This indeed is much better and a great cleanup, thanks.
> 
> > 
> > But, I have a few questions here:
> > 
> >> @@ -3161,9 +3106,7 @@ static void hotkey_exit(void)
> >>  	hotkey_poll_stop_sync();
> >>  	mutex_unlock(&hotkey_mutex);
> >>  #endif
> >> -
> >> -	if (hotkey_dev_attributes)
> >> -		delete_attr_set(hotkey_dev_attributes, &tpacpi_pdev->dev.kobj);
> >> +	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);
> > 
> > Why do you have to manually add/remove these groups still?
> > 
> > A huge hint that something is going wrong is when you have to call a
> > sysfs_*() call from within a driver.  There should be proper driver_*()
> > calls for you instead to get the job done.
> > 
> > As this is a platform device, why not set the dev_groups variable in the
> > platform_driver field so that these attribute groups get added and
> > removed automatically?
> 
> The thinkpad_acpi code talks to the ACPI object representing the
> ThinkPad embedded-controller and that has a lot of different sub-functionalities
> which may or may not be present depending on the model laptop as well
> as on the hw-configuration of the model.
> 
> The code is organized around all the different sub-functions with there
> being a separate init + exit function for each sub-function, including
> with first detecting in the init function if the functionality is present
> (e.g. don't register SW_TABLETMODE_SW evdev reporting when the device
> is not convertible / don register a WWAN rfkill if there is no WWAN modem).
> 
> Many (but not all) of the sub-functions come with a few sysfs-attributes
> under /sys/bus/platform/devices/thinkpad_acpi/ many of the separate
> function_init functions therefor call sysfs_create_group() for their own
> set of sysfs-attributes, if the function is present on the machine.
> 
> > An example commit to look at that shows how this was converted for one
> > driver is 5bd08a4ae3d0 ("platform: x86: hp-wmi: convert platform driver
> > to use dev_groups").  See if that helps here as well.
> 
> Right, that results in a very nice cleanup. But there all the attributes
> were always registered before the patch so throwing them together in a
> ATTRIBUTE_GROUPS(hp_wmi) makes a ton of sense.
> 
> Here however we have all the separate function_init() blocks each
> conditionally adding their own attributes if the function is present,
> so that is different.
> 
> Currently there already are 8 separate sysfs_create_group() calls in
> the thinkpad_acpi code, so even if we want to refactor this (I'm not
> sure that we do) then doing so would fall outside of the scope of this
> patch.
> 
> Greg, since this resolves / defers your remark and since this otherwise
> is a nice cleanup I'm going to merge this version of this patch now.

Ok, but having this all in one big list of attributes does work.  You
can have multiple attribute groups listed together (that's why it's a
list of attribute groups, not just one attribute group that the driver
core is expecting.)

You just put the logic of "is this group needed or not?" in the
is_visible() callback for that group.  You then don't need the
function_init() blocks to do anything with sysfs except maybe set a
device variable of "I have type foo" for the is_visible() callback to
check.

Yes, it's not obvious, but should clean up a lot of code in the end.

thanks,

greg k-h
