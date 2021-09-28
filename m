Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4050DC433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 28 Sep 2021 14:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166FC60F24
	for <linux-hardening@archiver.kernel.org>; Tue, 28 Sep 2021 14:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241318AbhI1O5J (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 28 Sep 2021 10:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241265AbhI1O5J (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 28 Sep 2021 10:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632840929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1tsDh6YLJRJVvMNgciG5IrKowgU5pvDWEHe56at1gM=;
        b=iy7jaQzZWGmZ/l2AZwjBUZ8/QLZVa8oJ1qT4Jmq66ohA4/DeLQJUCDgCmQccm3Ql3fTAeS
        qW3sSgj9UYRrixEWb7nleQnRMtX0+JIhw4ii1WFa5Q8Th1Z27EyCwDpyrtFOPi6HT7+dm3
        t3qvVcsetz0E8C0yCLBHB47dehqx0js=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-pJHKmH4CPA6OIUv1fa7TlA-1; Tue, 28 Sep 2021 10:55:28 -0400
X-MC-Unique: pJHKmH4CPA6OIUv1fa7TlA-1
Received: by mail-ed1-f72.google.com with SMTP id m20-20020aa7c2d4000000b003d1add00b8aso22172082edp.0
        for <linux-hardening@vger.kernel.org>; Tue, 28 Sep 2021 07:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h1tsDh6YLJRJVvMNgciG5IrKowgU5pvDWEHe56at1gM=;
        b=CymTQ270UiBSVthNpTpv+AzKTQ8tMbwk2NfUH5L+h7O4s5AexdL0StIYZmvZvwZALz
         FGSHYRHOhyCwgx+vKybp+BNpAotyANw2uFvaXaithhL5ij/3fFE6qr6ySuQEe2P7zpno
         4QdNzGuRjLW737TbAb9j4UCl7ceqhf2Mt4QjQNTT8BgydR1IOn8H6falAt34J23k/JqE
         BxrRz+qHY4VPdhHT9sKIfXWf0kgHYjQlPkY2frui25JbBbW7QMyyoK2FMScCr69mP2gx
         CXmLEIxGANZr17VVSn/K8ATtu9dZZReTDKdCMJxmEre0LCOXFEvBgCYb4O/EIfxP0bs7
         qGUA==
X-Gm-Message-State: AOAM530AotwxyOa9+3dY8JL4GFRtrey2bBQUydLkNhkonLvJjn4q7tZt
        +TsIXyZG4+awaGhIdJLPCl+RggIEr+MVMUTjUkoaZiTImiQQttH7fDA3IGzwV76teVOiQdPSo7w
        bzV7u16W5lvQQDIHTX3eCBk329W8z
X-Received: by 2002:a17:906:7f01:: with SMTP id d1mr7233539ejr.318.1632840926572;
        Tue, 28 Sep 2021 07:55:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS5yBFuwSLcJg5mxtyACkXxKi0wMBSw+WcYEEdtvHABfNgyidxO8bV0CX3nV8KT0UKTzPI0Q==
X-Received: by 2002:a17:906:7f01:: with SMTP id d1mr7233511ejr.318.1632840926322;
        Tue, 28 Sep 2021 07:55:26 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d16sm10517546ejk.39.2021.09.28.07.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 07:55:25 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: Switch to common use of
 attributes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Baker <len.baker@gmx.com>
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210926111908.6950-1-len.baker@gmx.com>
 <YVBaQAFVX1CeQUPE@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <50135c0e-e291-509f-2286-a1e443fdf4f3@redhat.com>
Date:   Tue, 28 Sep 2021 16:55:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVBaQAFVX1CeQUPE@kroah.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi All,

On 9/26/21 1:32 PM, Greg Kroah-Hartman wrote:
> On Sun, Sep 26, 2021 at 01:19:08PM +0200, Len Baker wrote:
>> As noted in the "Deprecated Interfaces, Language Features, Attributes,
>> and Conventions" documentation [1], size calculations (especially
>> multiplication) should not be performed in memory allocator (or similar)
>> function arguments due to the risk of them overflowing. This could lead
>> to values wrapping around and a smaller allocation being made than the
>> caller was expecting. Using those allocations could lead to linear
>> overflows of heap memory and other misbehaviors.
>>
>> So, to avoid open-coded arithmetic in the kzalloc() call inside the
>> create_attr_set() function the code must be refactored. Using the
>> struct_size() helper is the fast solution but it is better to switch
>> this code to common use of attributes.
>>
>> Then, remove all the custom code to manage hotkey attributes and use the
>> attribute_group structure instead, refactoring the code accordingly.
>> Also, to manage the optional hotkey attributes (hotkey_tablet_mode and
>> hotkey_radio_sw) use the is_visible callback from the same structure.
>>
>> Moreover, now the hotkey_init_tablet_mode() function never returns a
>> negative number. So, the check after the call can be safely removed.
>>
>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
>>
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Len Baker <len.baker@gmx.com>
>> ---
>> Hi,
>>
>> Following the suggestions made by Greg I have switch the code to common
>> use of attributes. However this code is untested. If someone could test
>> it would be great.
> 
> Much better, thanks.

This indeed is much better and a great cleanup, thanks.

> 
> But, I have a few questions here:
> 
>> @@ -3161,9 +3106,7 @@ static void hotkey_exit(void)
>>  	hotkey_poll_stop_sync();
>>  	mutex_unlock(&hotkey_mutex);
>>  #endif
>> -
>> -	if (hotkey_dev_attributes)
>> -		delete_attr_set(hotkey_dev_attributes, &tpacpi_pdev->dev.kobj);
>> +	sysfs_remove_group(&tpacpi_pdev->dev.kobj, &hotkey_attr_group);
> 
> Why do you have to manually add/remove these groups still?
> 
> A huge hint that something is going wrong is when you have to call a
> sysfs_*() call from within a driver.  There should be proper driver_*()
> calls for you instead to get the job done.
> 
> As this is a platform device, why not set the dev_groups variable in the
> platform_driver field so that these attribute groups get added and
> removed automatically?

The thinkpad_acpi code talks to the ACPI object representing the
ThinkPad embedded-controller and that has a lot of different sub-functionalities
which may or may not be present depending on the model laptop as well
as on the hw-configuration of the model.

The code is organized around all the different sub-functions with there
being a separate init + exit function for each sub-function, including
with first detecting in the init function if the functionality is present
(e.g. don't register SW_TABLETMODE_SW evdev reporting when the device
is not convertible / don register a WWAN rfkill if there is no WWAN modem).

Many (but not all) of the sub-functions come with a few sysfs-attributes
under /sys/bus/platform/devices/thinkpad_acpi/ many of the separate
function_init functions therefor call sysfs_create_group() for their own
set of sysfs-attributes, if the function is present on the machine.

> An example commit to look at that shows how this was converted for one
> driver is 5bd08a4ae3d0 ("platform: x86: hp-wmi: convert platform driver
> to use dev_groups").  See if that helps here as well.

Right, that results in a very nice cleanup. But there all the attributes
were always registered before the patch so throwing them together in a
ATTRIBUTE_GROUPS(hp_wmi) makes a ton of sense.

Here however we have all the separate function_init() blocks each
conditionally adding their own attributes if the function is present,
so that is different.

Currently there already are 8 separate sysfs_create_group() calls in
the thinkpad_acpi code, so even if we want to refactor this (I'm not
sure that we do) then doing so would fall outside of the scope of this
patch.

Greg, since this resolves / defers your remark and since this otherwise
is a nice cleanup I'm going to merge this version of this patch now.

Regards,

Hans

