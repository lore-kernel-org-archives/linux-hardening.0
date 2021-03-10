Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FC1C433DB
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Mar 2021 21:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007C764FC4
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Mar 2021 21:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhCJVD4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 10 Mar 2021 16:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhCJVDw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 10 Mar 2021 16:03:52 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86ACC061756
        for <linux-hardening@vger.kernel.org>; Wed, 10 Mar 2021 13:03:52 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id e6so12220137pgk.5
        for <linux-hardening@vger.kernel.org>; Wed, 10 Mar 2021 13:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kgZRDWg+E5eBmEuNfvh5FPMkh8S3VA4zLnMLimy3dco=;
        b=YN0Z/Vhtni4MgeYq5ZXFSPAnmyYH+lkZC+AUrGdL1FSjOP6FTEcki8jRb9CpsNidan
         bTf6DVBu9IZ9qccH7IA+cOlRe8qbtBRf7N3rHBrgr/zXFmg3FnjjA8PO7MJE/yIDO1/a
         qFVyvQ+I7V0ur72vLR6/jxgCfMQLRlBhrNqzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kgZRDWg+E5eBmEuNfvh5FPMkh8S3VA4zLnMLimy3dco=;
        b=mdTnuuiNK7WCEEd34DGbpVCq/JUT317uYToqtte1mZEfC2w46aX6ZqQaiC6xcD8Khw
         ssr6Pz5emERDgKjPtry4VJaNd2D3Ifm9+u6xX8Wg2X1nMwfSYQwxGbK1VCa5QuxjcTS7
         YTNK3SowTYvSqh+OlhavHdQshj+Ftm+yjMrmbjV1CQMzOKGkrrP1mJBdhXo3pakzoqbd
         MFgw9rMBW7PhvFFIKW5UseyHcGym4jZ5CiEmIBDz2xLFS2SH6THq7EoXtT8J2qyv0tkF
         neFYlfGSch3SnY2s4UkhS2kLavsZ9vWKd1rtGShqLk54IjnuiLdCHKl81XaZM7qCikd/
         r9CQ==
X-Gm-Message-State: AOAM532kFXQqmZ2+39I8yxXv9yL2trfeusoLiGpDHoYWoGoYoXvVvobM
        AJqKwL5NWLO08aPLhgppszfQmA==
X-Google-Smtp-Source: ABdhPJx0EQbJUnNqWnWy4ORz94xOvLvvXICL3tLfic8hpJEypnFS58ssYytUjMkPtAFORl44nriB/w==
X-Received: by 2002:aa7:9154:0:b029:1ee:fa0d:24dd with SMTP id 20-20020aa791540000b02901eefa0d24ddmr4403109pfi.17.1615410232053;
        Wed, 10 Mar 2021 13:03:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m7sm236760pjc.54.2021.03.10.13.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:03:51 -0800 (PST)
Date:   Wed, 10 Mar 2021 13:03:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 3/7] init_on_alloc: Unpessimize default-on builds
Message-ID: <202103101303.6E6569C1@keescook>
References: <20210309214301.678739-1-keescook@chromium.org>
 <20210309214301.678739-4-keescook@chromium.org>
 <CAAeHK+xog8-DP1o=1qqKgSP7Hii2Yjah6oyowNE3zSNVW5pRSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xog8-DP1o=1qqKgSP7Hii2Yjah6oyowNE3zSNVW5pRSw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 10, 2021 at 01:52:04PM +0100, Andrey Konovalov wrote:
> On Tue, Mar 9, 2021 at 10:43 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Right now, the state of CONFIG_INIT_ON_ALLOC_DEFAULT_ON (and
> > ...ON_FREE...) did not change the assembly ordering of the static branch
> > tests. Use the new jump_label macro to check CONFIG settings to default
> > to the "expected" state, unpessimizes the resulting assembly code.
> >
> > Reviewed-by: Alexander Potapenko <glider@google.com>
> > Link: https://lore.kernel.org/lkml/CAG_fn=X0DVwqLaHJTO6Jw7TGcMSm77GKHinrd0m_6y0SzWOrFA@mail.gmail.com/
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/mm.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index bf341a9bfe46..2ccd856ac0d1 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2874,7 +2874,8 @@ static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
> >  DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
> >  static inline bool want_init_on_alloc(gfp_t flags)
> >  {
> > -       if (static_branch_unlikely(&init_on_alloc))
> > +       if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
> > +                               &init_on_alloc))
> >                 return true;
> >         return flags & __GFP_ZERO;
> >  }
> > @@ -2882,7 +2883,8 @@ static inline bool want_init_on_alloc(gfp_t flags)
> >  DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
> >  static inline bool want_init_on_free(void)
> >  {
> > -       return static_branch_unlikely(&init_on_free);
> > +       return static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
> > +                                  &init_on_free);
> >  }
> >
> >  extern bool _debug_pagealloc_enabled_early;
> 
> Should we also update slab_want_init_on_alloc() and slab_want_init_on_free()?

Whoops! Thank you; I will update and resend. :)

-- 
Kees Cook
