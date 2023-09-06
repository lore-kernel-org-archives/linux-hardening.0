Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A199EB8FAF
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Sep 2023 12:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjIFMRZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Sep 2023 08:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjIFMRZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Sep 2023 08:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15F71BB
        for <linux-hardening@vger.kernel.org>; Wed,  6 Sep 2023 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694002595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAHucxdj9KOQiqwrQG5G3puiuXj59YIgbUOHZSj51D4=;
        b=gfLozioXYaswzgr6+UKJKtHzKuOnkP5WQGU4Ap5LAEmk4JlCRVkN3FoN7GnUSvHUZdqkYH
        3+6636yd+3JqrBPmzhWI402/mNu0JnwbnTjHTuCbDN+fXHUYneZndcvgzbsC/k68MZyJNo
        o+yhA5tZXRpqd14NUfBLo69A7ZLYkCc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-EN2Z_vGUM3a1hEaUCcnrhg-1; Wed, 06 Sep 2023 08:16:34 -0400
X-MC-Unique: EN2Z_vGUM3a1hEaUCcnrhg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-521da4c99d4so2791881a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 06 Sep 2023 05:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694002592; x=1694607392;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAHucxdj9KOQiqwrQG5G3puiuXj59YIgbUOHZSj51D4=;
        b=UoZqR49pak9LwGga6H140kVaBse1J1ZLff9VfCsfwgxQqBmcBGHHUmSQYr5eSD2CGK
         a8r0gMWUQ9SVA82SV0gNnYkEs0Hqo2EWSvojdUHpI6Gp9jChGgYQzfDDys9mNDzkx08O
         JWG1CM4VXPMAVNAxbqRLR4ghDWcDJxy6Nipzlx2WFwGdbsSmkm+ptyo/W/793BEopTY6
         qZFmXbGGBykqi79dRYz0ggl4fH8Ukv96qjuhG02DbUNVidZAPEihv/DtWvU9RNGUFCrD
         K6tDg2IntuC7XsKQf+RfRj9vUcEbsu4qjoppM0KldjNj66cMrODQ/8dS0yL8mefQZDZb
         f0rg==
X-Gm-Message-State: AOJu0YyYc0M2Ux0tPhmK3IgptGaUJsV07zLMyHWSybvMwRT5AIsctppD
        BQz3tACzW6++1oNu0EWZtKJtE1RbhfKP+IbaMNbwt8m5UQHK0X508jBg/OZNa2Lq5RDofBr/NEr
        NVCuw2USL0Id3zI4kht4ujUGaO+PL
X-Received: by 2002:aa7:da4d:0:b0:525:6cc7:8092 with SMTP id w13-20020aa7da4d000000b005256cc78092mr2107818eds.13.1694002592486;
        Wed, 06 Sep 2023 05:16:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPPFghIQ4Z3iAsCdA1AIIPJ1b3fWeNYcB2xznceHz9+dt7MmsV9YCoZK80mUp4HAwHBg08eQ==
X-Received: by 2002:aa7:da4d:0:b0:525:6cc7:8092 with SMTP id w13-20020aa7da4d000000b005256cc78092mr2107793eds.13.1694002592080;
        Wed, 06 Sep 2023 05:16:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id r9-20020aa7d589000000b0052a1c0c859asm8444962edq.59.2023.09.06.05.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 05:16:31 -0700 (PDT)
Message-ID: <bce762af-0da7-bb5e-1580-b42803c183f6@redhat.com>
Date:   Wed, 6 Sep 2023 14:16:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] x86/platform/uv: refactor deprecated strcpy and
 strncpy
To:     Ingo Molnar <mingo@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230905-strncpy-arch-x86-platform-uv-uv_nmi-v3-1-3efd6798b569@google.com>
 <ZPhsSzHG6YMViOSk@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZPhsSzHG6YMViOSk@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Ingo,

On 9/6/23 14:10, Ingo Molnar wrote:
> 
> * Justin Stitt <justinstitt@google.com> wrote:
> 
>> Both `strncpy` and `strcpy` are deprecated for use on NUL-terminated
>> destination strings [1].
>>
>> We can see that `arg` and `uv_nmi_action` are expected to be
>> NUL-terminated strings due to their use within `strcmp()` and format
>> strings respectively.
>>
>> With this in mind, a suitable replacement is `strscpy` [2] due to the
>> fact that it guarantees NUL-termination on its destination buffer
>> argument which is _not_ the case for `strncpy` or `strcpy`!
>>
>> In this case, we can drop both the forced NUL-termination and the `... -1` from:
>> |       strncpy(arg, val, ACTION_LEN - 1);
>> as `strscpy` implicitly has this behavior.
>>
>> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
>> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
>>  arch/x86/platform/uv/uv_nmi.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> Note that this commit is already upstream:
> 
>   1e6f01f72855 ("x86/platform/uv: Refactor code using deprecated strcpy()/strncpy() interfaces to use strscpy()")
> 
> Below is the delta your v3 patch has compared to what is upstream - is it 
> really necessary to open code it, instead of using strnchrnul() as your 
> original patch did? Am I missing anything here?

The new version is a result of a review from my because IMHO:

	strscpy(arg, val, strnchrnul(val, sizeof(arg)-1, '\n') - val + 1);

Is really unreadable / really hard to reason about if
this is actually correct and does not contain any
of by 1 bugs.

Note that the diff of v3 compared to the code before v2 landed is
actually smaller now and actually matches the subject of:
"refactor deprecated strcpy and strncpy"

Where as v2 actually touches more code / refactor things
which fall outside of a "one change per patch" approach.
The:

	p = strchr(arg, '\n');
	if (p)
		*p = '\0';

was already there before v2 landed.

I also suggested to do a follow up patch to change things to:

	strscpy(arg, val, sizeof(arg));
	p = strchrnul(arg, '\n');
	*p = '\0';

Which IMHO is much more readable then what has landed
now. But since v2 has already landed I guess the best
thing is just to stick with what we have upstream now...

Regards,

Hans





> 
> Thanks,
> 
> 	Ingo
> 
> --- a/arch/x86/platform/uv/uv_nmi.c
> +++ b/arch/x86/platform/uv/uv_nmi.c
> @@ -202,10 +202,13 @@ static int param_set_action(const char *val, const struct kernel_param *kp)
>  {
>  	int i;
>  	int n = ARRAY_SIZE(valid_acts);
> -	char arg[ACTION_LEN];
> +	char arg[ACTION_LEN], *p;
>  
>  	/* (remove possible '\n') */
> -	strscpy(arg, val, strnchrnul(val, sizeof(arg)-1, '\n') - val + 1);
> +	strscpy(arg, val, sizeof(arg));
> +	p = strchr(arg, '\n');
> +	if (p)
> +		*p = '\0';
>  
>  	for (i = 0; i < n; i++)
>  		if (!strcmp(arg, valid_acts[i].action))
> 

