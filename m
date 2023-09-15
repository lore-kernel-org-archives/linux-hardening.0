Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340BDCD37AA
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 20:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbjIOUwf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbjIOUwV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 16:52:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F3035AE
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:50:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c35ee3b0d2so20637295ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694811001; x=1695415801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pixcN5Y1AubjMBamu4r0/OjVDhrvJd2jJgNFr0zPGBA=;
        b=HuODhYelyacRY9HlytTsIm4B7wz8OazwsD1/3T8eipUeYOw7pRmK87nYD+La4M2ERL
         c+7i0KKd0WStxwghrx1gk/tXpFGLX6oCJQ8XsXYFkD4z/28YqyucPyx/EH8c5tVvxeQ4
         l6Cr7hN2AKgTyDnzeP4hXi1kaJYFNVGjzbZTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694811001; x=1695415801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pixcN5Y1AubjMBamu4r0/OjVDhrvJd2jJgNFr0zPGBA=;
        b=fDkWcongBnZZcxjPFmlwa0unJf6wxpi91Oj+Dr56blG7T6LYGqXx7WJWBys0q9HOGX
         ZaCXS2o0VId3/nm4q4Qooin4KewkyjE4ozBb5FlIRSbGm2/A0doGpSwqdu6hqMitf1Ll
         PNxO1M68I27D7HaITxCKCFU+aO4RNdJSsmm9PSe3meqc1FKjehAklDvmMO2+pW2gNYD/
         n9jgwAu/4/dohs/Sv+YO6F43Xf9/TgxiuBaJOlbVSSthQHM84chLiEjyHynDcN5TBFhj
         utMuU9GrCT6uA2vmXwe3/Ifs62kdRWqOAInVrN/QCmz/xKu22WaS4Jk6aXW56jNdVyUR
         pRHg==
X-Gm-Message-State: AOJu0YyEs1uekx5l4Xh3sbpR3LXLQ0Nag5t9k7xFG3EbH5rTOkcOmm1+
        I/hWeYPcPLyaIDvRtYQBbvLP3w==
X-Google-Smtp-Source: AGHT+IFG5RbkUmAUyhtbRZ65uLoK2tgVIeCtTHS/dvTIeIuGjUg4Cs9dHFp2ggbnq+0cI4RujnJy7g==
X-Received: by 2002:a17:902:d4c7:b0:1c1:e52e:49e3 with SMTP id o7-20020a170902d4c700b001c1e52e49e3mr2611409plg.36.1694811001209;
        Fri, 15 Sep 2023 13:50:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902bd9600b001bb9f104328sm3876566pls.146.2023.09.15.13.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:50:00 -0700 (PDT)
Date:   Fri, 15 Sep 2023 13:50:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, luto@kernel.org, peterz@infradead.org,
        jannh@google.com, evn@google.com, poprdi@google.com,
        jordyzomer@google.com
Subject: Re: [RFC PATCH 01/14] mm/slub: don't try to dereference invalid
 freepointers
Message-ID: <202309151349.BEBA203D@keescook>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-2-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915105933.495735-2-matteorizzo@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 15, 2023 at 10:59:20AM +0000, Matteo Rizzo wrote:
> slab_free_freelist_hook tries to read a freelist pointer from the
> current object even when freeing a single object. This is invalid
> because single objects don't actually contain a freelist pointer when
> they're freed and the memory contains other data. This causes problems
> for checking the integrity of freelist in get_freepointer.
> 
> Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
> ---
>  mm/slub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f7940048138c..a7dae207c2d2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1820,7 +1820,9 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>  
>  	do {
>  		object = next;
> -		next = get_freepointer(s, object);
> +		/* Single objects don't actually contain a freepointer */
> +		if (object != old_tail)
> +			next = get_freepointer(s, object);
>  
>  		/* If object's reuse doesn't have to be delayed */
>  		if (!slab_free_hook(s, object, slab_want_init_on_free(s))) {

I find this loop's logic a bit weird, but, yes, this ends up being
correct and avoids needless work.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
