Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE4BC433B4
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Mar 2021 21:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94ADC61075
	for <linux-hardening@archiver.kernel.org>; Wed, 31 Mar 2021 21:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhCaVzE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 31 Mar 2021 17:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhCaVy7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 31 Mar 2021 17:54:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37080C06174A
        for <linux-hardening@vger.kernel.org>; Wed, 31 Mar 2021 14:54:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m11so15496137pfc.11
        for <linux-hardening@vger.kernel.org>; Wed, 31 Mar 2021 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rtsfbkg65ln578BueP2qKUJ2W4TVYylDnpFNvn0AmZY=;
        b=lFIjHUpJ6J2bChkAW6VFomn72sxkplIQywWFLHMael4kNCA63jvDhP8bxintcnt5bw
         KQBjDW0tdgan1Mw+ew9YOivDWjvq1y/RLhovgps8HPve8vSaz1UqvITEKhuq5UCgL/Wz
         NM80b1+1PpQm7Vs1o0Fx6Yx2NIh0Uno3lLAkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rtsfbkg65ln578BueP2qKUJ2W4TVYylDnpFNvn0AmZY=;
        b=q5Af6lB0yVrG5/50m18zUoffIAvcjzj4CzXtDC9s5rlcum0sjfMFi+YuZsyAnrERfS
         GhnWz80b9OZD1uOmR3x8PGh4Npydivz4Oc0isodfRmq8S60jziJr4jbfSk2pMvTLR+ko
         7ZltQDzAZ7oC77mOPfOnnD8nw+gMP36C3PGRhHncp1LMprznSx4K8EGGIfY3q5v/967W
         vRYU7chSFyIs8225lntWfk5SsPgxXVmEM/rRCEYB0pUqW3D3uSJ9EfxMszNWhj7YHdrU
         sz9AudP/fCi1h2F8cpnvRcFS7Q4sE0y4s8eu7BWKwUrZ7Oj75BhGUGPGNa9uAzTDl2fI
         b/pQ==
X-Gm-Message-State: AOAM531QRNmf+FAZRen7Lw0ICtN4Ml1v4I6BhscfuwXf3eOyL6g6pD1f
        ifnb+N/Ca6mJDGL3iKS/liXHSA==
X-Google-Smtp-Source: ABdhPJy+ITLzRDWVQZ4QLokxo3xwGBU2j8b+z7YKdSsnEN/k5kQuDOdpvQny/ml71yhjeB4NsIqJiQ==
X-Received: by 2002:a05:6a00:22c6:b029:201:1166:fdad with SMTP id f6-20020a056a0022c6b02902011166fdadmr4839743pfj.58.1617227698663;
        Wed, 31 Mar 2021 14:54:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y5sm3199222pfl.191.2021.03.31.14.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 14:54:58 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:54:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] stack: Optionally randomize kernel stack offset
 each syscall
Message-ID: <202103311453.A840B7FC5@keescook>
References: <20210330205750.428816-1-keescook@chromium.org>
 <20210330205750.428816-4-keescook@chromium.org>
 <87im5769op.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im5769op.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 31, 2021 at 09:53:26AM +0200, Thomas Gleixner wrote:
> On Tue, Mar 30 2021 at 13:57, Kees Cook wrote:
> > +/*
> > + * Do not use this anywhere else in the kernel. This is used here because
> > + * it provides an arch-agnostic way to grow the stack with correct
> > + * alignment. Also, since this use is being explicitly masked to a max of
> > + * 10 bits, stack-clash style attacks are unlikely. For more details see
> > + * "VLAs" in Documentation/process/deprecated.rst
> > + * The asm statement is designed to convince the compiler to keep the
> > + * allocation around even after "ptr" goes out of scope.
> 
> Nit. That explanation of "ptr" might be better placed right at the
> add_random...() macro.

Ah, yes! Fixed in v9.

> Other than that.
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thank you for the reviews!

Do you want to take this via -tip (and leave off the arm64 patch until
it is acked), or would you rather it go via arm64? (I've sent v9 now...)

-- 
Kees Cook
