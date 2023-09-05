Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9B9CA0FFA
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Sep 2023 16:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343760AbjIEQX2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354344AbjIEKxT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Sep 2023 06:53:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33C1199
        for <linux-hardening@vger.kernel.org>; Tue,  5 Sep 2023 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693911148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iA7IdFpDwtnuDlVKS2NZegEsBXTaUrliGdVa1RbXg5w=;
        b=Qj6ZDnyS7yXyCbOlCMPjBvjwiar6aneO3Zx/V0lfhxKwA/3EhShSjcfLLHdmEFJUmVMCLX
        x2cHAuL2+aF0v8yhvSKQaW9PrKLPWypxtlgYiegnBHRWruYjfM1WWzxG9uyHX9UBCSDH5j
        4X9jtCHa7tAhVPK1BB8JKOSriwiGmek=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-7-mB870HPyOcbNy9WF9Bog-1; Tue, 05 Sep 2023 06:52:27 -0400
X-MC-Unique: 7-mB870HPyOcbNy9WF9Bog-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a355cf318so180228066b.2
        for <linux-hardening@vger.kernel.org>; Tue, 05 Sep 2023 03:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693911145; x=1694515945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iA7IdFpDwtnuDlVKS2NZegEsBXTaUrliGdVa1RbXg5w=;
        b=dz3AgoUqillv62fqwYUblT8Jm7HcP1BrY9JEcvA48hq/QuZnv3tietLci6BneV50Tv
         L7xgF3EpdkVW007BK8h46MCogrzK8qzu0/GyDvMfcDp5HE6AF8L6itYIvqiMc8fvM1Nn
         v+KszfpMDFFbMB8qNltMp5yE8VjkyuPGeVZqTn8pQtcEwg4zDFyEWXJqe30N2aGcHBRN
         04fsAVf2HqsNbQjp8CXh9KtcgBel+sVbfjgn3Kt2reV1kpU+S9+IZ09kywVbEV00m7Nz
         Rta7rIeJHwyuTPcmKKaEc6N6/RdC6nA/K3Mrp7UN0dEGR8+vOsvXENj9er8kOPNj69pK
         2TEA==
X-Gm-Message-State: AOJu0YyWYNiNFcsLvp999yb2fh2LxpgTBPkBan7wMj/aswZk0Ka8MoDP
        4HbK+dKvf8kyv1X+Dyme2NKunWIBMLmmrh8EHgd8p01x33y3kTpuxICYt6Rn+YMpEVlyiHHyc70
        QC0IbVErBK7uWe+vuct3zMXHXL9tL
X-Received: by 2002:a17:906:cc18:b0:9a5:ce62:6e19 with SMTP id ml24-20020a170906cc1800b009a5ce626e19mr8533481ejb.69.1693911145442;
        Tue, 05 Sep 2023 03:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP3ELd8tEEkkAjXou7dlgTGLonfFfdHBVi8/VthBpLHkYSyll3QShK2Y6WgqpuYr5U998Zpg==
X-Received: by 2002:a17:906:cc18:b0:9a5:ce62:6e19 with SMTP id ml24-20020a170906cc1800b009a5ce626e19mr8533467ejb.69.1693911145117;
        Tue, 05 Sep 2023 03:52:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id vi18-20020a170907d41200b0098ec690e6d7sm7430529ejc.73.2023.09.05.03.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 03:52:24 -0700 (PDT)
Message-ID: <685e4951-e283-835c-5cce-ddd802fadf62@redhat.com>
Date:   Tue, 5 Sep 2023 12:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] x86/platform/uv: refactor deprecated strcpy and
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
        linux-hardening@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
References: <20230824-strncpy-arch-x86-platform-uv-uv_nmi-v2-1-e16d9a3ec570@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230824-strncpy-arch-x86-platform-uv-uv_nmi-v2-1-e16d9a3ec570@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Justin,

On 8/24/23 20:52, Justin Stitt wrote:
> Both `strncpy` and `strcpy` are deprecated for use on NUL-terminated
> destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy` or `strcpy`!
> 
> In this case, we can drop both the forced NUL-termination and the `... -1` from:
> |       strncpy(arg, val, ACTION_LEN - 1);
> as `strscpy` implicitly has this behavior.
> 
> Also include slight refactor to code removing possible new-line chars as
> per Yang Yang's work at [3]. This reduces code size and complexity by
> using more robust and better understood interfaces.
> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://lore.kernel.org/all/202212091545310085328@zte.com.cn/ [3]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Co-developed-by: Yang Yang <yang.yang29@zte.com.cn>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - use `sizeof` on destination string instead of `strlen` (thanks Andy, Kees and Dimitri)
> - refactor code to remove potential new-line chars (thanks Yang Yang and Andy)
> - Link to v1: https://lore.kernel.org/r/20230822-strncpy-arch-x86-platform-uv-uv_nmi-v1-1-931f2943de0d@google.com
> ---
> Note: build-tested only
> 
> Another thing, Yang Yang's patch [3] had some review from Andy regarding
> the use of `-1` and `+1` in and around the strnchrnul invocation. I
> believe Yang Yang's original implementation is correct but let's also
> just use sizeof(arg) instead of ACTION_LEN.
> 
> Here's a godbolt link detailing some findings around the new-line
> refactor in response to Andy's feedback: https://godbolt.org/z/K8drG3oq5
> ---
>  arch/x86/platform/uv/uv_nmi.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
> index a60af0230e27..913347b2b9ab 100644
> --- a/arch/x86/platform/uv/uv_nmi.c
> +++ b/arch/x86/platform/uv/uv_nmi.c
> @@ -202,21 +202,17 @@ static int param_set_action(const char *val, const struct kernel_param *kp)
>  {
>  	int i;
>  	int n = ARRAY_SIZE(valid_acts);
> -	char arg[ACTION_LEN], *p;
> +	char arg[ACTION_LEN];
>  
>  	/* (remove possible '\n') */
> -	strncpy(arg, val, ACTION_LEN - 1);
> -	arg[ACTION_LEN - 1] = '\0';
> -	p = strchr(arg, '\n');
> -	if (p)
> -		*p = '\0';
> +	strscpy(arg, val, strnchrnul(val, sizeof(arg) - 1, '\n') - val + 1);

I have 25 years of C-programming experience and even I
cannot read this.

It seems to me that you are trying to use the length
argument to not copy the '\n' here.

While at the same time using strnchr(..., sizeof(arg) ...)
instead of normal strchr() to make sure you don't pass\
a value bigger then sizeof(arg) as length to strscpy().

Please do not do this it is needlessly complicated and
makes the code almost impossible to read / reason about.

What the original code was doing, first copying at
most ACTION_LEN - 1 bytes into arg and then ensuring
0 termination, followed by stripping '\n' from the
writable copy we have just made is much cleaner.

IMHO this patch should simple replace the strncpy()
+ 0 termination with a strscpy() and not make
any other changes, leading to:

	/* (remove possible '\n') */
	strscpy(arg, val, sizeof(arg));
	p = strchr(arg, '\n');
	if (p)
		*p = '\0';

See how this is much much more readable /
much easier to wrap ones mind around ?

And then as a *separate* followup patch
you could simplify this further by using strchrnul():

	/* (remove possible '\n') */
	strscpy(arg, val, sizeof(arg));
	p = strchrnul(arg, '\n');
	*p = '\0';

But again that belongs in a separate patch
since it is not:

"refactor deprecated strcpy and strncpy"

Regards,

Hans






>  
>  	for (i = 0; i < n; i++)
>  		if (!strcmp(arg, valid_acts[i].action))
>  			break;
>  
>  	if (i < n) {
> -		strcpy(uv_nmi_action, arg);
> +		strscpy(uv_nmi_action, arg, sizeof(uv_nmi_action));
>  		pr_info("UV: New NMI action:%s\n", uv_nmi_action);
>  		return 0;
>  	}
> @@ -959,7 +955,7 @@ static int uv_handle_nmi(unsigned int reason, struct pt_regs *regs)
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
> base-commit: 706a741595047797872e669b3101429ab8d378ef
> change-id: 20230822-strncpy-arch-x86-platform-uv-uv_nmi-474e5295c2c1
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

