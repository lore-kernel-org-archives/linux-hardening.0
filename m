Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3850CC433E9
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Mar 2021 22:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 030CD64F51
	for <linux-hardening@archiver.kernel.org>; Mon, 15 Mar 2021 22:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhCOWQB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 15 Mar 2021 18:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhCOWPa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 15 Mar 2021 18:15:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CB9C06175F
        for <linux-hardening@vger.kernel.org>; Mon, 15 Mar 2021 15:15:29 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id r16so6159759pfh.10
        for <linux-hardening@vger.kernel.org>; Mon, 15 Mar 2021 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4NJ97PlxHnFzJWJgTtpDT+uKjd7HgYN+0ebu/wLMsHQ=;
        b=GfeWNb1p88yRfbJnymIfERA/ut8kED0Wo7XExiGoNzml+80Z9oey4U0Ro5ATU1yaU2
         HTXnfdZHk6IoQmCWOJmzEb8cMJ+ycjfmtAfwRs9BLtRmg+ZBBxLW7s5f8mLFH9cpacl2
         tnpMFAMPUUJ7b6g/nDRVteP7L4YMejkChexPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4NJ97PlxHnFzJWJgTtpDT+uKjd7HgYN+0ebu/wLMsHQ=;
        b=haw5MB5ULFh6zWX2mgpue9A8B5hX9S9tO+W0znlw/tPdTmdIjBJVpZYXaOHE5oFbnl
         wfQKRTRbuzBu4GXyvFSfLnoFF1fDoODoT4BdwTtGZoG4NFEizZ0M5qXWfYMerwEbHYX4
         Ey2IKnA6o/py1t/B7CA+F1vZMAJV7IAbMRDncU3ezWDgTjI+j8wFA3UlnrK+yUYnJnxz
         x60e7sqFWaYVAFDGtIwXOsiaXfhh+ywOYr7iRVlAyR/NPb6HNgiK+d8kH6omoBeNsz8d
         oFD7Kqg7doZu2RMEUvZixTl4sVo/5fO0Fx0tMGz3PlFxLzpJXeTnjQGuQm9apsIYjLwP
         rG9A==
X-Gm-Message-State: AOAM530YT2kCLI49ioNpv8lJqXUvzDQATklReCxZhco/IuypoKkLW3VH
        rPKWN+0slBnXBeAigQaUujkTJQ==
X-Google-Smtp-Source: ABdhPJyTjnc9LdJf0dvdcKWL6IHisbEo+ZUejO8pNco1fmFRm1nNRoQe3Sx5RQqz8b9aU1cRR2xiPQ==
X-Received: by 2002:a65:6a0c:: with SMTP id m12mr1019256pgu.161.1615846529292;
        Mon, 15 Mar 2021 15:15:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s194sm14685269pfs.57.2021.03.15.15.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 15:15:28 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:15:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Potapenko <glider@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v6 2/6] init_on_alloc: Optimize static branches
Message-ID: <202103151514.AE11A69683@keescook>
References: <20210315180229.1224655-1-keescook@chromium.org>
 <20210315180229.1224655-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315180229.1224655-3-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Mar 15, 2021 at 11:02:25AM -0700, Kees Cook wrote:
> diff --git a/mm/slab.h b/mm/slab.h
> index 076582f58f68..b0977d525c06 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -601,7 +601,8 @@ static inline void cache_random_seq_destroy(struct kmem_cache *cachep) { }
>  
>  static inline bool slab_want_init_on_alloc(gfp_t flags, struct kmem_cache *c)
>  {
> -	if (static_branch_unlikely(&init_on_alloc)) {
> +	if (static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,

Gah, this should be CONFIG_INIT_ON_ALLOC_DEFAULT_ON.

I'll see if there are any more comments before sending a v7...

-Kees

> +				&init_on_alloc)) {
>  		if (c->ctor)
>  			return false;
>  		if (c->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON))
> @@ -613,7 +614,8 @@ static inline bool slab_want_init_on_alloc(gfp_t flags, struct kmem_cache *c)
>  
>  static inline bool slab_want_init_on_free(struct kmem_cache *c)
>  {
> -	if (static_branch_unlikely(&init_on_free))
> +	if (static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
> +				&init_on_free))
>  		return !(c->ctor ||
>  			 (c->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)));
>  	return false;
> -- 
> 2.25.1
> 

-- 
Kees Cook
