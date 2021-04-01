Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED0CC433ED
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 06:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE7F600EF
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 06:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhDAGcF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Apr 2021 02:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhDAGbm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Apr 2021 02:31:42 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FB1C061788
        for <linux-hardening@vger.kernel.org>; Wed, 31 Mar 2021 23:31:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d8so496720plh.11
        for <linux-hardening@vger.kernel.org>; Wed, 31 Mar 2021 23:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hfTiBhDabA7pBPLjBpIi4iWvrEHL2e3DeE4vbI5tAiE=;
        b=INuoEL/r01BHe5/0yKi04SaL6KiDFwaY3kVglmh8y1egtrKhBcEeVSMQq834wTyuHZ
         qDvvBOvmZArmoVNPOp/MXHjJ9+bCFSVaPsePM0Sw+bRDQEqjhousEsLqTQ9dRxVkOvYx
         HBppUlDY7Djx+X/wpLnFxgFe7TiS6kNvMLqwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hfTiBhDabA7pBPLjBpIi4iWvrEHL2e3DeE4vbI5tAiE=;
        b=P34VB7VtiguMYTNb1s6HURF4TVlWyL1d1UBAMIvJ3IdkI3y0pzTbGACjza0o/d8lQI
         DuhTk2bJhaKxW5+NOiGGht1gYVGBYEjW7RiBVGerY+OkYlUVH/wQWzeZLpC2N+9DxpPa
         VcnX104O9+HJ5Y1BwIZkaOkX43k0n7o26ArPuzT4GpeQIoLJ/2nXZXW873GwqFXrWRst
         g5eCcQIH4+CoIkX+PAewLZEWbcOEM/ihkFIcMSjDebD414JOcvhkz6bX89zN5IwiRibL
         qpZMN0GmGV24BXnU+o6meFqVBB62mySK6GDmyICEOum23q9lUI/BGqtFIH9l3LcQu+rh
         twxA==
X-Gm-Message-State: AOAM5320fRPDQ9gqjZwUfqARWsB6zeu/aHpwapuvyQ7w4Vrn4HBA+b/h
        V8N02b76bgesMQq3JTOisHjpaA==
X-Google-Smtp-Source: ABdhPJybf6kMo+xaigSfWlgtmn9ANKW+eH5leA3QXT6lgzLQyGzKLYlDgQSa+C8d5xDIMNkOgP5Eag==
X-Received: by 2002:a17:902:6b43:b029:e6:3d73:e9fb with SMTP id g3-20020a1709026b43b02900e63d73e9fbmr6546739plt.37.1617258701439;
        Wed, 31 Mar 2021 23:31:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gf20sm4300574pjb.39.2021.03.31.23.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:31:40 -0700 (PDT)
Date:   Wed, 31 Mar 2021 23:31:39 -0700
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
Message-ID: <202103312329.394CCA13CF@keescook>
References: <20210330205750.428816-1-keescook@chromium.org>
 <20210330205750.428816-4-keescook@chromium.org>
 <87im5769op.ffs@nanos.tec.linutronix.de>
 <202103311453.A840B7FC5@keescook>
 <87v9973q54.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9973q54.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Apr 01, 2021 at 12:38:31AM +0200, Thomas Gleixner wrote:
> On Wed, Mar 31 2021 at 14:54, Kees Cook wrote:
> > On Wed, Mar 31, 2021 at 09:53:26AM +0200, Thomas Gleixner wrote:
> >> On Tue, Mar 30 2021 at 13:57, Kees Cook wrote:
> >> > +/*
> >> > + * Do not use this anywhere else in the kernel. This is used here because
> >> > + * it provides an arch-agnostic way to grow the stack with correct
> >> > + * alignment. Also, since this use is being explicitly masked to a max of
> >> > + * 10 bits, stack-clash style attacks are unlikely. For more details see
> >> > + * "VLAs" in Documentation/process/deprecated.rst
> >> > + * The asm statement is designed to convince the compiler to keep the
> >> > + * allocation around even after "ptr" goes out of scope.
> >> 
> >> Nit. That explanation of "ptr" might be better placed right at the
> >> add_random...() macro.
> >
> > Ah, yes! Fixed in v9.
> 
> Hmm, looking at V9 the "ptr" thing got lost ....

I put the comment inline in the macro directly above the asm().

> > Do you want to take this via -tip (and leave off the arm64 patch until
> > it is acked), or would you rather it go via arm64? (I've sent v9 now...)
> 
> Either way is fine.

Since the arm64 folks have been a bit busy, can you just put this in
-tip and leave off the arm64 patch for now?

Thanks!

-- 
Kees Cook
