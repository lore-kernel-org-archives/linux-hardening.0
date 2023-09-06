Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43306EB8FB7
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Sep 2023 11:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjIFLnl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Sep 2023 07:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjIFLnl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Sep 2023 07:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F575A8
        for <linux-hardening@vger.kernel.org>; Wed,  6 Sep 2023 04:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694000572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bv8FRcBYInuJYLkwqfgxJID/HzOrFldgc8979yDFysA=;
        b=V20aR8hMabl0gqpxMNmG/1F8jJEJQarGsHAqbNZmWl2ZtL/DVmur19V9zZuLJz9W3nE2at
        fNCDATxy4dWO0AIxb3O3BSMQB3O4mKGHqehV8VB1u8qz8IVeYaCgWtfgEBZQhuWNsV+l+i
        UusKH4zTVLIJITDCfuKPx31kvuO8a6M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-MxHLIsuiNeWhHBKWV2hCuA-1; Wed, 06 Sep 2023 07:42:51 -0400
X-MC-Unique: MxHLIsuiNeWhHBKWV2hCuA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a9d5e60944so19702466b.2
        for <linux-hardening@vger.kernel.org>; Wed, 06 Sep 2023 04:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694000570; x=1694605370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bv8FRcBYInuJYLkwqfgxJID/HzOrFldgc8979yDFysA=;
        b=EUzj4HJeSq8X+XPxHP783z189oaKmDviTiVDIi4LVdbwDKjlNXL9HjSTLaCKwgIpb7
         MNjwCfL09kEaaXuqnOCmk32ZmJq2HbX/d8W26p5hCOJN3zWtDSMaMfUUEBpOoYazVHDU
         6aRPtHUvhlOl+UmLgcKmZRJqdwZpVfkCsKeQOkNe0c0YLiNANPfG3BS6pPHTywjIyjV9
         AZt+c7gQYLViIVJ8TxIxlRJTIUP7hk7bjEIbqrw2cbQxDvsfWkl+Lp2vIKtvEZb27nqz
         BPMklOJOSYC6Cq0w9GrHJCePlmmsFmxTXAj7FodhKpseLoh7MLGcuE2N2l+FnNoWjc4W
         HdKg==
X-Gm-Message-State: AOJu0Yzkpljp4uGH7h13WriAhW9OEHcW8YEatBZvWnYF7MZT6nFubh49
        twJTzR/PmMCmRmTNoPbYPK9Z2FYK9eCm4eiTvzBO5qv2Lu8jAhFfXpCuuXXt7mki+95rekjaNNm
        KstKf4QwWefXr6SEqvdmSwd189kCW
X-Received: by 2002:a17:906:70d6:b0:9a4:88af:b82 with SMTP id g22-20020a17090670d600b009a488af0b82mr1852934ejk.77.1694000569977;
        Wed, 06 Sep 2023 04:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1vMN1CVC5tjxitjd3WxVaM3mu/drrsRgRkHZMQh2TL0v6oo8YChJo7cIX3ahLFpg12WsSMQ==
X-Received: by 2002:a17:906:70d6:b0:9a4:88af:b82 with SMTP id g22-20020a17090670d600b009a488af0b82mr1852925ejk.77.1694000569684;
        Wed, 06 Sep 2023 04:42:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f2-20020a1709064dc200b0099c53c4407dsm8903902ejw.78.2023.09.06.04.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 04:42:48 -0700 (PDT)
Message-ID: <ddd2a7f7-be50-4256-20de-0392d0cd539f@redhat.com>
Date:   Wed, 6 Sep 2023 13:42:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] x86/platform/uv: refactor deprecated strcpy and
 strncpy
To:     Justin Stitt <justinstitt@google.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230905-strncpy-arch-x86-platform-uv-uv_nmi-v3-1-3efd6798b569@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230905-strncpy-arch-x86-platform-uv-uv_nmi-v3-1-3efd6798b569@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On 9/5/23 23:54, Justin Stitt wrote:
> Both `strncpy` and `strcpy` are deprecated for use on NUL-terminated
> destination strings [1].
> 
> We can see that `arg` and `uv_nmi_action` are expected to be
> NUL-terminated strings due to their use within `strcmp()` and format
> strings respectively.
> 
> With this in mind, a suitable replacement is `strscpy` [2] due to the
> fact that it guarantees NUL-termination on its destination buffer
> argument which is _not_ the case for `strncpy` or `strcpy`!
> 
> In this case, we can drop both the forced NUL-termination and the `... -1` from:
> |       strncpy(arg, val, ACTION_LEN - 1);
> as `strscpy` implicitly has this behavior.
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v3:
> - Use sizeof instead of strlen (thanks Andy and Dimitri)
> - Drop unrelated changes regarding strnchrnul (thanks Hans)
> - Link to v2: https://lore.kernel.org/r/20230824-strncpy-arch-x86-platform-uv-uv_nmi-v2-1-e16d9a3ec570@google.com

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
> Changes in v2:
> - use `sizeof` on destination string instead of `strlen` (thanks Andy, Kees and Dimitri)
> - refactor code to remove potential new-line chars (thanks Yang Yang and Andy)
> - Link to v1: https://lore.kernel.org/r/20230822-strncpy-arch-x86-platform-uv-uv_nmi-v1-1-931f2943de0d@google.com
> ---
> Note: build-tested only
> ---
>  arch/x86/platform/uv/uv_nmi.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
> index a60af0230e27..dd30fb2baf6c 100644
> --- a/arch/x86/platform/uv/uv_nmi.c
> +++ b/arch/x86/platform/uv/uv_nmi.c
> @@ -205,8 +205,7 @@ static int param_set_action(const char *val, const struct kernel_param *kp)
>  	char arg[ACTION_LEN], *p;
>  
>  	/* (remove possible '\n') */
> -	strncpy(arg, val, ACTION_LEN - 1);
> -	arg[ACTION_LEN - 1] = '\0';
> +	strscpy(arg, val, sizeof(arg));
>  	p = strchr(arg, '\n');
>  	if (p)
>  		*p = '\0';
> @@ -216,7 +215,7 @@ static int param_set_action(const char *val, const struct kernel_param *kp)
>  			break;
>  
>  	if (i < n) {
> -		strcpy(uv_nmi_action, arg);
> +		strscpy(uv_nmi_action, arg, sizeof(uv_nmi_action));
>  		pr_info("UV: New NMI action:%s\n", uv_nmi_action);
>  		return 0;
>  	}
> @@ -959,7 +958,7 @@ static int uv_handle_nmi(unsigned int reason, struct pt_regs *regs)
>  
>  		/* Unexpected return, revert action to "dump" */
>  		if (master)
> -			strncpy(uv_nmi_action, "dump", strlen(uv_nmi_action));
> +			strscpy(uv_nmi_action, "dump", sizeof(uv_nmi_action));
>  	}
>  
>  	/* Pause as all CPU's enter the NMI handler */
> 
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230822-strncpy-arch-x86-platform-uv-uv_nmi-474e5295c2c1
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

