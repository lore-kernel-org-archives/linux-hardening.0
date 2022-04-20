Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CBDC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Apr 2022 02:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244213AbiDTCsD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 19 Apr 2022 22:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239192AbiDTCsC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 19 Apr 2022 22:48:02 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8B524F37
        for <linux-hardening@vger.kernel.org>; Tue, 19 Apr 2022 19:45:18 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s14so515857plk.8
        for <linux-hardening@vger.kernel.org>; Tue, 19 Apr 2022 19:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1syVurlPdZtVxfD77EA07da6Q0rSSJ2SEOZ9IIvMxUw=;
        b=TGBBcj36GCla9UWEXP4zSj1zN0lOz5f2ul/fVLRyFgR+Vmtff+G7616OT5lwErhECF
         9l49f5c5cC6fMMAfxNJcj0Bb8iXOIzz6GM+mMs2I7aEAwJCy25tk/uj4wogq/zPS9Qgq
         2cK93xOr7di3AU/YzmT6A8NyM/aHbOBD2bq2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1syVurlPdZtVxfD77EA07da6Q0rSSJ2SEOZ9IIvMxUw=;
        b=3rE8YZ0PMMCIljp2mmXaPfcYmRf73oul3MgIkOEiy0pKpEjimY0q9fYQkf+KeZ/FfE
         tA8rIWQni79OlD8FMBPsW+WdMbjQZiREAJkWOtNQ8T12deFCjCVD7qXgABFBngUMs5T0
         qf5Ub/PIS9qk0oTcrawBW3ebdp5l5i5BbckIdqh895J2FZ69RRgJdm8zwuNXJxFKR8+p
         1krIYSAyKiBhnFE9nUBaOT1z3Rb+hvGspGLnd1uSvZyAkIOgJNMJEe4zxbwzz6A3CQwg
         l5+YNNJsH8hCS3ty9vMt9/C59en63ig/E2CyH6UVyxwsm2zrCsEFf/kPmVJk08XwYuP8
         JdRA==
X-Gm-Message-State: AOAM530H/uld/EGdMPjvS/4rZXkhLIhgvKJtbHrsVdtoI2VopR25oNwJ
        z5iHgPI2i6euEIme6/6ueUT8RA==
X-Google-Smtp-Source: ABdhPJyY7WO8H0dT1tmNr/jgQbtrjy7gcp4/rbnWxhnW4FecMs7HlQysjTPVoOohhl8xgekBtwjY2w==
X-Received: by 2002:a17:90a:31cb:b0:1d2:8998:61f9 with SMTP id j11-20020a17090a31cb00b001d2899861f9mr1854240pjf.186.1650422717621;
        Tue, 19 Apr 2022 19:45:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n3-20020a056a000d4300b0050ac8dbfd0csm745637pfv.163.2022.04.19.19.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 19:45:17 -0700 (PDT)
Date:   Tue, 19 Apr 2022 19:45:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     joao@overdrivepizza.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 10/11] linux/interrupt: Fix prototype matching
 property
Message-ID: <202204191942.3C273AB@keescook>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-11-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420004241.2093-11-joao@overdrivepizza.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Apr 19, 2022 at 05:42:40PM -0700, joao@overdrivepizza.com wrote:
> Unions will make function pointers with different prototypes be used through
> the same call. This leads into the same call instruction being used for
> calling functions with different prototypes, making them unsuitable for
> prototype-based fine-grained CFI.

Why? Shouldn't the callers be using different prototypes?

> Fix this CFI policy violation by removing the function pointer union in
> the tasklet struct.

The good news is that tasklet is on the way out the door[1], so this may
quickly become a non-issue, but also to that end, this fix is hardly a
problem for a deprecated API...

-Kees

[1] https://lore.kernel.org/linux-hardening/20220419211658.11403-1-apais@linux.microsoft.com/

> 
> Signed-off-by: Joao Moreira <joao@overdrivepizza.com>
> ---
>  include/linux/interrupt.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index f40754caaefa..8d5504b0f20b 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -650,10 +650,8 @@ struct tasklet_struct
>  	unsigned long state;
>  	atomic_t count;
>  	bool use_callback;
> -	union {
> -		void (*func)(unsigned long data);
> -		void (*callback)(struct tasklet_struct *t);
> -	};
> +	void (*func)(unsigned long data);
> +	void (*callback)(struct tasklet_struct *t);
>  	unsigned long data;
>  };
>  
> -- 
> 2.35.1
> 

-- 
Kees Cook
