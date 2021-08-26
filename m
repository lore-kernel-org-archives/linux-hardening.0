Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC17EC432BE
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 13:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B9760F35
	for <linux-hardening@archiver.kernel.org>; Thu, 26 Aug 2021 13:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbhHZN6N (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 26 Aug 2021 09:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242741AbhHZN6I (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 26 Aug 2021 09:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629986235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SB1xZS0lLb7+YD7d9V95k8rH91VhprXycgXNPBnXe0M=;
        b=CXWwkhcvPCAHulTviKZSZ+IVulmj9Ee6YA5Pb2KryxUNhU26H6C5HYLLjs7AD3thgpUFGB
        zr4klXor2FbjZY+EidIFb66lLukCC/SQsqOcl14tBjmVt0v//BbSP9pQGPkIV/VRZEcLuN
        d5R4JnxAYgtQCvUKbwJn8JuuNqUsWXY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-QKd5Wi5RNdSmOGEdm7SpXQ-1; Thu, 26 Aug 2021 09:57:14 -0400
X-MC-Unique: QKd5Wi5RNdSmOGEdm7SpXQ-1
Received: by mail-ej1-f72.google.com with SMTP id x6-20020a170906710600b005c980192a39so1230680ejj.9
        for <linux-hardening@vger.kernel.org>; Thu, 26 Aug 2021 06:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SB1xZS0lLb7+YD7d9V95k8rH91VhprXycgXNPBnXe0M=;
        b=YVIBQnjc4V9fU8dULfXJesM0qQnAP7k4qFyH282hEd6/YGgCybPso8NX9l60JmcxAT
         1h+GkKzJ4sUvfLoe60nwaw5CJDyCmq84eH2hMWOfDZIdeKPgwK2VqV6DDix/a9GJbjSS
         2s8bDQ3hcmsIFjQVGQLavilQt8YM09fb8ZIGmk/50onOBq14a48nsrBcsuqvS/LJOyzy
         go5qvDNLU82aP8h48zCTTYG2wFXL3y9zG/vMYUX8vBEbaFbZruByWnxiBABxIE94UYyz
         FW30PPcNF+NbJiWIq88VbmcnkBaXXX2QCEGoWq9GwvkjbBdZ3qL+gVEWNT21ylsh2jzX
         l6TQ==
X-Gm-Message-State: AOAM530bNNgrdgQ4JuEJAYWp0iQwX3FmtpbvkCCLaKlt8eXD/usyTHD9
        AhrljEOBCycmZtrertOJqZwXcb9s69c/jKH3WEy+IrGmcjGehQwLhS6p6UzLeBUGCZpPDbI2Xms
        KwqP7uA96dHkYZlgCXe914aREQLSZJ3EH4H17sd46C/LtwgJqSbX670UFzDDFyHj0W1QM/h/10R
        z350RU
X-Received: by 2002:a17:907:a06c:: with SMTP id ia12mr4422689ejc.377.1629986232989;
        Thu, 26 Aug 2021 06:57:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT4NK/3oTiPEdb8osu2jmYpLf8dXmFzeAQwv52kaLJG3MjwBm9TByAVPQ8dI3x4YaffBuL6Q==
X-Received: by 2002:a17:907:a06c:: with SMTP id ia12mr4422660ejc.377.1629986232778;
        Thu, 26 Aug 2021 06:57:12 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id v1sm1544438ejd.31.2021.08.26.06.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 06:57:12 -0700 (PDT)
Subject: Re: [PATCH][RFC] platform/x86: dell-smbios-wmi: Avoid false-positive
 memcpy() warning
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        Andy Lavr <andy.lavr@gmail.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210825160749.3891090-1-keescook@chromium.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7107d06d-784e-c643-c4eb-50e9f277bd38@redhat.com>
Date:   Thu, 26 Aug 2021 15:57:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825160749.3891090-1-keescook@chromium.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On 8/25/21 6:07 PM, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring fields.
> 
> Since all the size checking has already happened, use input.pointer
> (void *) so memcpy() doesn't get confused about how much is being
> written.
> 
> Avoids this false-positive warning when run-time memcpy() strict
> bounds checking is enabled:
> 
> memcpy: detected field-spanning write (size 4096) of single field (size 36)
> WARNING: CPU: 0 PID: 357 at drivers/platform/x86/dell/dell-smbios-wmi.c:74 run_smbios_call+0x110/0x1e0 [dell_smbios]
> 
> Note: is there a missed kfree() in the marked error path?
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <mgross@linux.intel.com>
> Cc: Mario Limonciello <mario.limonciello@dell.com>
> Cc: "Pali Rohár" <pali@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Dell.Client.Kernel@dell.com
> Cc: platform-driver-x86@vger.kernel.org
> Reported-by: Andy Lavr <andy.lavr@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thank you, I've applied the patch, minus the:

/* output.pointer memory allocation leak? */

Comment, instead I'll submit (and also apply right-away)
a patch to add the missing kfree()

Regards,

Hans


	
> ---
>  drivers/platform/x86/dell/dell-smbios-wmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-smbios-wmi.c b/drivers/platform/x86/dell/dell-smbios-wmi.c
> index 33f823772733..c410d6d920b8 100644
> --- a/drivers/platform/x86/dell/dell-smbios-wmi.c
> +++ b/drivers/platform/x86/dell/dell-smbios-wmi.c
> @@ -69,9 +69,10 @@ static int run_smbios_call(struct wmi_device *wdev)
>  		if (obj->type == ACPI_TYPE_INTEGER)
>  			dev_dbg(&wdev->dev, "SMBIOS call failed: %llu\n",
>  				obj->integer.value);
> +		/* output.pointer memory allocation leak? */
>  		return -EIO;
>  	}
> -	memcpy(&priv->buf->std, obj->buffer.pointer, obj->buffer.length);
> +	memcpy(input.pointer, obj->buffer.pointer, obj->buffer.length);
>  	dev_dbg(&wdev->dev, "result: [%08x,%08x,%08x,%08x]\n",
>  		priv->buf->std.output[0], priv->buf->std.output[1],
>  		priv->buf->std.output[2], priv->buf->std.output[3]);
> 

