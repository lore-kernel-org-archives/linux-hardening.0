Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67992EB64DD
	for <linux-hardening@archiver.kernel.org>; Tue, 11 Jul 2023 16:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjGKQVu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 11 Jul 2023 12:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjGKQVj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 11 Jul 2023 12:21:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D225010F2
        for <linux-hardening@vger.kernel.org>; Tue, 11 Jul 2023 09:21:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-66f3fc56ef4so4490765b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 11 Jul 2023 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689092497; x=1691684497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRd6MSnrDwuyQ7znWMqv6yCTnL1/DCJOC7bU8PD4YHA=;
        b=gpWbxLEJAvmtMRm+FhOebdn8dZhw/8ODnpNfzpB0MQM3pSJXTeWlGHA4rduGWhj+cX
         Ro43D8BRredizt+GPW75K5Q3Y+Dr3QH6caOSAfHsa+RWAxkbmzOtytqAsA0nIQKnhMse
         Bhf/WZN5knflEGP6D2uaxg9geafaqTw2FfFRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689092497; x=1691684497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRd6MSnrDwuyQ7znWMqv6yCTnL1/DCJOC7bU8PD4YHA=;
        b=TW+bpfHPsCJFSBeVvWlzSK3odincPM65BWVGDSL8CurWW927/E7kAKAqSNx7nh+mJ5
         T04jHfunxhKrNQM7Nckh+xsdFwkX0h90sDvHCOm94txwk0GrmVU9CK2lX7sFXGJPO4sL
         Ap3b57aToonbj7w1n/lkY795I6Z3Y8e+eh5oWVFPInSkI0mP7mrywd3xRxU23wEjXqz1
         HyKvin3OaS5rT+MyN5BOFGf4oXfxiyS7dsm2L0MW4ktEck0AvDxn07A0H0aMpWGv6s4l
         stVSXZLSXlmgVPpvBSQKWPmPUEhvhgZndBQiteANLTs82iuQs5LQBcnUmReOeXMTQBLw
         k8qA==
X-Gm-Message-State: ABy/qLas0CaGC1f//uk+uUrG04ZICMPx2BCc4Pn3b3g988QZS5tnuM7z
        uXbOffRFbqoOe2UpPCVhwzecUA==
X-Google-Smtp-Source: APBJJlGmfygMjusEhLAateZabdJC+NgJo425Y8P55gtNUAQan1lVCm6MeEIhr+Us9T17E8ZvkbTgag==
X-Received: by 2002:a17:90b:1d02:b0:263:114c:52fc with SMTP id on2-20020a17090b1d0200b00263114c52fcmr23830843pjb.12.1689092497290;
        Tue, 11 Jul 2023 09:21:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id dw16-20020a17090b095000b00260cce91d20sm2026175pjb.33.2023.07.11.09.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:21:36 -0700 (PDT)
Date:   Tue, 11 Jul 2023 09:21:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matteo Rizzo <matteorizzo@google.com>,
        Jann Horn <jannh@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/slub: remove freelist_dereference()
Message-ID: <202307110917.DEED145F0@keescook>
References: <20230711134623.12695-3-vbabka@suse.cz>
 <20230711134623.12695-4-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711134623.12695-4-vbabka@suse.cz>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jul 11, 2023 at 03:46:25PM +0200, Vlastimil Babka wrote:
> freelist_dereference() is a one-liner only used from get_freepointer().
> Remove it and make get_freepointer() call freelist_ptr_decode()
> directly to make the code easier to follow.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 07edad305512..c4556a5dab4b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -397,18 +397,14 @@ static inline void *freelist_ptr_decode(const struct kmem_cache *s,
>  	return decoded;
>  }
>  
> -/* Returns the freelist pointer recorded at location ptr_addr. */
> -static inline void *freelist_dereference(const struct kmem_cache *s,
> -					 void *ptr_addr)
> -{
> -	return freelist_ptr_decode(s, *(freeptr_t *)(ptr_addr),
> -			    (unsigned long)ptr_addr);
> -}
> -
>  static inline void *get_freepointer(struct kmem_cache *s, void *object)
>  {
> -	object = kasan_reset_tag(object);
> -	return freelist_dereference(s, (freeptr_t *)(object + s->offset));
> +	unsigned long ptr_addr;
> +	freeptr_t p;
> +
> +	ptr_addr = ((unsigned long)kasan_reset_tag(object)) + s->offset;
> +	p = *(freeptr_t *)(ptr_addr);
> +	return freelist_ptr_decode(s, p, ptr_addr);
>  }
>  
>  #ifndef CONFIG_SLUB_TINY
> -- 
> 2.41.0
> 

I like reducing the complexity here, but I find dropping the "object"
reassignment makes this a bit harder to read. What about:

	object = kasan_reset_tag(object);
	unsigned long ptr_addr = (unsigned long)object + s->offset;
	freeptr_t p = *(freeptr_t *)(ptr_addr);

	return freelist_ptr_decode(s, p, ptr_addr);

?

They're the same result, so either way:

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
