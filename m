Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D63C07E9D
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 13:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiI0NPr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Sep 2022 09:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiI0NPh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Sep 2022 09:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D36E5FD8
        for <linux-hardening@vger.kernel.org>; Tue, 27 Sep 2022 06:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664284534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YG830RNjkEtnpnaFh8Xp0Sr5T2atOHoB+aLCGfBa7L4=;
        b=UR4IAhY6YOfYaHJo9oXI5c1qvl8Qz8C2u2d6wtFNBFsnFieinq4m7rTTLJheESOcynolZE
        zAhiNyjOCL05x/nCd5p44259MT7VBtaESsDj/xl2EQuzgalIK7XlrgMoa50iTBA+XsMoWN
        +RHp0E6fFd1wUcbR84e+N65YlhRDlpc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-J-A6q9DfMwSrqaYyBrYqmQ-1; Tue, 27 Sep 2022 09:15:33 -0400
X-MC-Unique: J-A6q9DfMwSrqaYyBrYqmQ-1
Received: by mail-ed1-f70.google.com with SMTP id z13-20020a05640240cd00b0045276a79364so7727667edb.2
        for <linux-hardening@vger.kernel.org>; Tue, 27 Sep 2022 06:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YG830RNjkEtnpnaFh8Xp0Sr5T2atOHoB+aLCGfBa7L4=;
        b=dr59tkrVGuGg2V5AnnQ+bp4WewmbMKml9eAzGEw6XFIkwSUycFJE/PO1zpYRRK0dYu
         yH2f84wfMhRmBggfOnLYLr/+8IvS0ETCdas3D29aTTd4LBmTXSXAGr1uDepXTjJiawMH
         bClUhyB29Sm5FxCjvCDx3/WKTtYM+hmvnfj6W4CRnmQWugf3PpwBKnQKjjiF8MXBH5kx
         742q2fkEpI2/uDjy13DiWqfJ3fP31yAa+IUtTpyNXHXU9Nsvr5HTRfB44rdP15zUqloz
         HOScFKgwJIw3JymDtVgevgQfUlTCZIRMax+Hsivxr0g+tbIoyvc2qDdBlwEDEDdmGatj
         /KAw==
X-Gm-Message-State: ACrzQf1TacaP6L1GpiqGgIunmnwoypt9t2R9L9w0EjJg1nTj9zDM1f4Y
        zrAi40oxFHZqd1WybxjDMTOKhvZL/TctAKPQjcoNj9hIIHdx3V7ZAUQuX6eWzvtLHHhcPSn9Xos
        8Yp9Aci42S1IE0aANS3dZ2KCVbNzb
X-Received: by 2002:a05:6402:2489:b0:454:11de:7698 with SMTP id q9-20020a056402248900b0045411de7698mr27881452eda.214.1664284532185;
        Tue, 27 Sep 2022 06:15:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6WRE1um0JP7ZvO78Ux6QnKgEFnIaBzjBceT9Puib3zcNo/CSOhHzoREvV7PNzyjRN38Oa8NQ==
X-Received: by 2002:a05:6402:2489:b0:454:11de:7698 with SMTP id q9-20020a056402248900b0045411de7698mr27881433eda.214.1664284531980;
        Tue, 27 Sep 2022 06:15:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906318200b0078116c361d9sm814628ejy.10.2022.09.27.06.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 06:15:31 -0700 (PDT)
Message-ID: <62b2133e-05ec-1a09-8214-b2b847c0e97e@redhat.com>
Date:   Tue, 27 Sep 2022 15:15:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] platform/surface: Split memcpy() of struct ssam_event
 flexible array
To:     Kees Cook <keescook@chromium.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220927004011.1942739-1-keescook@chromium.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220927004011.1942739-1-keescook@chromium.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On 9/27/22 02:40, Kees Cook wrote:
> To work around a misbehavior of the compiler's ability to see into
> composite flexible array structs (as detailed in the coming memcpy()
> hardening series[1]), split the memcpy() of the header and the payload
> so no false positive run-time overflow warning will be generated.
> 
> [1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org
> 
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/surface/surface_acpi_notify.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/platform/surface/surface_acpi_notify.c
> index 44e317970557..50500e562963 100644
> --- a/drivers/platform/surface/surface_acpi_notify.c
> +++ b/drivers/platform/surface/surface_acpi_notify.c
> @@ -355,7 +355,8 @@ static u32 san_evt_bat_nf(struct ssam_event_notifier *nf,
>  	INIT_DELAYED_WORK(&work->work, san_evt_bat_workfn);
>  	work->dev = d->dev;
>  
> -	memcpy(&work->event, event, sizeof(struct ssam_event) + event->length);
> +	work->event = *event;
> +	memcpy(work->event.data, event->data, event->length);
>  
>  	queue_delayed_work(san_wq, &work->work, delay);
>  	return SSAM_NOTIF_HANDLED;


