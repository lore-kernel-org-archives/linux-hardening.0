Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CE0C433E0
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Mar 2021 12:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AED164FE7
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Mar 2021 12:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhCJMwt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 10 Mar 2021 07:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCJMwR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 10 Mar 2021 07:52:17 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4387C061761
        for <linux-hardening@vger.kernel.org>; Wed, 10 Mar 2021 04:52:16 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 18so11989743pfo.6
        for <linux-hardening@vger.kernel.org>; Wed, 10 Mar 2021 04:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BK42rEfZDnxMm7tn7QJoRMRkMDyVR3i3bNbcPekdIg=;
        b=h3fEZUkobZr1jCHE1WazBNRG4q6cvgfOa2N+PfxLN8F7RZJkzgxy8/c570n7v1gsgE
         wSVCeFTC/83l9s7h3AlU7OrKC5RGtvsuxScUqY6IJhXjcghZQ8EL07clpakh4MTYsG7o
         6KoC27yoGboGzxYaB+5W8my72cxKXJZYwPWTh6e8c4ZfV+hRQj3DRwvP3l72LQhNw298
         sOkfAxTRzwbtQwEezjar0b8cKncz7NqR60/GEO5Od0xr52s3xXhE73SXrE4cXBPxJIlS
         lmmdDl8v0ikLdUjBpWCTlgfWxaqXztaooul2c927TtNy00/RKZdi/4PbDlNVnuRV13n1
         rroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BK42rEfZDnxMm7tn7QJoRMRkMDyVR3i3bNbcPekdIg=;
        b=Q2A+V83x2ZsMHk3bIj9AjR7e5Q29J7ytZv7r7YSVnMOSkT25gf8Uubd95V/tOx0DJ1
         X1x4sF6HBs0kR+qBXqrFaJGC+21b5l6Y0KD8+R2/3yWF7syWUXD8mBqpiGrODtGKIDlo
         476TSUle1nQxy8pF3HU0jYOtztwzYBjLE27Db92hQDYgGNhgTgmZ9JHM2b05+HsFzfvZ
         TzeUQDr7HXzOh5BRyM4HnULecaSe4/MSJ2qOZu5sKnt5cc14eDMbSTJwsuT7B2GdRFCF
         OlyBYrRCaPPNwUBdOpgJXhfZCTspEr1WH9H3KQ56xnp2jgwDkIjywm+TGSgAJpfxB73g
         20yg==
X-Gm-Message-State: AOAM5327x24mpJbwB1JnQvTu026xU6laSI5omlfAIYidJgzFmQQWKXZL
        SN5HEOWcUQHfl5lQXh++sL8M9HJqLu3cjCm4Aql3MQ==
X-Google-Smtp-Source: ABdhPJz6Al6cQ9o2Jkic0AM6aT+uI8HXaIO3FGRdEqDpDV6bZgYd+QRynVKdHFUIi1JAN2QCB/oYogOY84k0cBj6NyQ=
X-Received: by 2002:a63:455d:: with SMTP id u29mr2647321pgk.286.1615380735994;
 Wed, 10 Mar 2021 04:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20210309214301.678739-1-keescook@chromium.org> <20210309214301.678739-4-keescook@chromium.org>
In-Reply-To: <20210309214301.678739-4-keescook@chromium.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 10 Mar 2021 13:52:04 +0100
Message-ID: <CAAeHK+xog8-DP1o=1qqKgSP7Hii2Yjah6oyowNE3zSNVW5pRSw@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] init_on_alloc: Unpessimize default-on builds
To:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Mar 9, 2021 at 10:43 PM Kees Cook <keescook@chromium.org> wrote:
>
> Right now, the state of CONFIG_INIT_ON_ALLOC_DEFAULT_ON (and
> ...ON_FREE...) did not change the assembly ordering of the static branch
> tests. Use the new jump_label macro to check CONFIG settings to default
> to the "expected" state, unpessimizes the resulting assembly code.
>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Link: https://lore.kernel.org/lkml/CAG_fn=X0DVwqLaHJTO6Jw7TGcMSm77GKHinrd0m_6y0SzWOrFA@mail.gmail.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/mm.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bf341a9bfe46..2ccd856ac0d1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2874,7 +2874,8 @@ static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
>  DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
>  static inline bool want_init_on_alloc(gfp_t flags)
>  {
> -       if (static_branch_unlikely(&init_on_alloc))
> +       if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
> +                               &init_on_alloc))
>                 return true;
>         return flags & __GFP_ZERO;
>  }
> @@ -2882,7 +2883,8 @@ static inline bool want_init_on_alloc(gfp_t flags)
>  DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
>  static inline bool want_init_on_free(void)
>  {
> -       return static_branch_unlikely(&init_on_free);
> +       return static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
> +                                  &init_on_free);
>  }
>
>  extern bool _debug_pagealloc_enabled_early;

Should we also update slab_want_init_on_alloc() and slab_want_init_on_free()?
