Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248E2ECAA24
	for <linux-hardening@archiver.kernel.org>; Thu, 25 Aug 2022 17:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbiHYRS3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 25 Aug 2022 13:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242468AbiHYRST (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 25 Aug 2022 13:18:19 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C495FBCCD7
        for <linux-hardening@vger.kernel.org>; Thu, 25 Aug 2022 10:18:18 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bh13so18457661pgb.4
        for <linux-hardening@vger.kernel.org>; Thu, 25 Aug 2022 10:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=gnMljPJ/lm4q/RBQXlsRGj0qaMzhOLblX5QXKQT9GOA=;
        b=p1XusnwBuXPciTUrnlwiAdph5OC6EkXk+q666UtGjiflFY51AQZo97IAR+bXvBE5mc
         6ZnwuE95uHUD9rAwsuB/gtyXhWQJwLI85ad5uXmJjUUNquSP3RzKzdeAlXyC99WVlm3R
         Y2lh8kQTg0EL/k5qB2L6VdySGhKh+I7I+ijgqd5xFk6Le4GhtS0Nk9THw5+VUlFpCYJI
         /HFiss9A50VlnXbP24JxGRhOojtOvQi3M31evuhjT92gnr7Fx1EAGVDT8Ys06xTC9MIS
         tZSV/bVEufRX/bA3tqR1mhypO9d7NYqoJHS6MHJy5HTfpGDzxuI3okYr/7DFGgHTxpRS
         t0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gnMljPJ/lm4q/RBQXlsRGj0qaMzhOLblX5QXKQT9GOA=;
        b=Ry2Xq/MumNG39TSSfYO05SmTG57QBTmpcZEkqNxpQkFuCmL5InTtIgbtRfKufINatr
         aPJH5+WiziHXp1v2q3C3Oni3RmdmWULP6SGefh4jA4VeSw6/LTj2YtC8tBV2zWzPBrig
         2M0skAXf6dbdKSpNwESTtb95kyiByLuk160oQfnr5Lwlm6BDFpUjjAsFClLw2WiZjY0k
         mwWjirZO04+LDlmrqyiEijTVXL7Eu5ZMhmakGcPxwpDHuexPYlsy480Ushm0e60C8AAf
         IyEdNXTZR5ZqwYSminHaquv72YhWKRcAwreBDsTCns/c+rdrC9vI94nZvi5tyStOspEi
         U+TA==
X-Gm-Message-State: ACgBeo1HmevmaoDQq87XZ9EC4wjbZ6ro47muxXe4hVVSz2rnAglD9Hco
        W8WsEGZ/ler1v0H795uLfWyq8Yt4nsjANg==
X-Google-Smtp-Source: AA6agR6tK/D5enD9fgdi0ecU+FGxTwOMoe8z3P512kBNwxfyORCYzrkGCt7PVHxGWuY2Ef4fCuM4Vw==
X-Received: by 2002:a63:494a:0:b0:41c:f29e:2a2e with SMTP id y10-20020a63494a000000b0041cf29e2a2emr78650pgk.477.1661447898207;
        Thu, 25 Aug 2022 10:18:18 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l63-20020a622542000000b00535e49245d6sm15216396pfl.12.2022.08.25.10.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 10:18:17 -0700 (PDT)
Date:   Thu, 25 Aug 2022 17:18:13 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH] x86/mm: Refuse W^X violations
Message-ID: <Yweu1dvkJ8aV+C+T@google.com>
References: <YwdpwykpV9RB+4tL@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwdpwykpV9RB+4tL@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 25, 2022, Peter Zijlstra wrote:
> 
> x86 has STRICT_*_RWX, but not even a warning when someone violates it.
> 
> Add this warning and fully refuse the transition.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 1abd5438f126..9e9bef3f36b3 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -579,6 +579,30 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
>  	return __pgprot(pgprot_val(prot) & ~forbidden);
>  }
>  
> +/*
> + * Validate and enforce strict W^X semantics.
> + */
> +static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long start,
> +				  unsigned long pfn, unsigned long npg)
> +{
> +	unsigned long end;
> +

I think this needs

	if (!(__supported_pte_mask & _PAGE_NX))
		return new;

to play nice with non-PAE 32-bit kernels.

> +	if (!((pgprot_val(old) ^ pgprot_val(new)) & (_PAGE_RW | _PAGE_NX)))
> +		return new;
> +
> +	if ((pgprot_val(new) & (_PAGE_RW | _PAGE_NX)) != _PAGE_RW)
> +		return new;
> +
> +	end = start + npg * PAGE_SIZE - 1;
> +	WARN(1, "CPA refuse W^X violation: %016llx -> %016llx range: 0x%016lx - 0x%016lx PFN %lx\n",

WARN_ONCE() to avoid eternal spam if something does go sideways?

> +	     (unsigned long long)pgprot_val(old),
> +	     (unsigned long long)pgprot_val(new),
> +	     start, end, pfn);
> +
> +	/* refuse the transition into WX */
> +	return old;
> +}
