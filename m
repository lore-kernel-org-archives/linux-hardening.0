Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514FCC4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 06:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356D2604AC
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 06:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239191AbhHRGVL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238376AbhHRGU4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 02:20:56 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EEEC061A3F
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 23:16:48 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k14so1168595pga.13
        for <linux-hardening@vger.kernel.org>; Tue, 17 Aug 2021 23:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qiIiGr/kHO0o1yd85XRx1S/oZrG0a2JVuYsGSPTdPKo=;
        b=TVddYFx6MZtUu6Gxm5/eq0JnenoYTy2o0WAaLORc6h1rDy3BlAe2MfSQ47sEsZq8aI
         rnkdVNPYX5ygc3HUGUQrRXKtNe8UxzUZbp49tIfPnQpFN+mMiPemA6Att138bqInZkIs
         KMMMUh77ITc3FJ3DEFh+jNbzkZpixYigdra/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qiIiGr/kHO0o1yd85XRx1S/oZrG0a2JVuYsGSPTdPKo=;
        b=rp6h8hzLbIEpF+U2hnEVGJ58Ki/4GP9DSKexq8hDAxV35ydWibGR3bQ2Ni4I1YfyA8
         zvxBNLLx3qgTD+ZgxiEPSfFRjLDd336kALFXqCMJ9q6//7RM39pQuRWrJNrH+E+qNYG5
         wxFiDZCduGlU2ldWsDyEXNZZ7ij8ZhgaFD83XifG5ztb4sBG/F+KDi4dnkIQ6iGypbdf
         RSC0LxOCaJKbABXXFBN0W3yh21eaCAf36GdmsBQ2xfX1/CxDEpBgpbhg8iEQzs88YPAY
         gwyteAPglLXku0pBIEDCH0xWtmuC3+r/e5yHBHmH0fXC8TIFLYWZsiJdusgt1gfBjME+
         O/Hw==
X-Gm-Message-State: AOAM532VDTjzyUBvrd7Io3vxuiV8SEB/374c6c6opQMJZHeFmauHxWyB
        kF4HYXxdiu6yfNpOMbzWqI2clw==
X-Google-Smtp-Source: ABdhPJzejJTLjdMfXxVAJFIQjmpX7APIS6kpuwCjVMxxOkuNDs4SSrs+ZQmfcYcc43+NKU1r5qPLjQ==
X-Received: by 2002:a63:5fcc:: with SMTP id t195mr7237993pgb.146.1629267408588;
        Tue, 17 Aug 2021 23:16:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l11sm4943382pfd.187.2021.08.17.23.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:16:48 -0700 (PDT)
Date:   Tue, 17 Aug 2021 23:16:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/5] slab: Add __alloc_size attributes for better bounds
 checking
Message-ID: <202108172312.7032A3E@keescook>
References: <20210818050841.2226600-1-keescook@chromium.org>
 <20210818050841.2226600-3-keescook@chromium.org>
 <f3e56f56c36b32dc76e174886008a2a1ecf3fefa.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3e56f56c36b32dc76e174886008a2a1ecf3fefa.camel@perches.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 17, 2021 at 10:31:32PM -0700, Joe Perches wrote:
> On Tue, 2021-08-17 at 22:08 -0700, Kees Cook wrote:
> > As already done in GrapheneOS, add the __alloc_size attribute for
> > regular kmalloc interfaces, to provide additional hinting for better
> > bounds checking, assisting CONFIG_FORTIFY_SOURCE and other compiler
> > optimizations.
> []
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> []
> > @@ -181,7 +181,7 @@ int kmem_cache_shrink(struct kmem_cache *);
> >  /*
> >   * Common kmalloc functions provided by all allocators
> >   */
> > -void * __must_check krealloc(const void *, size_t, gfp_t);
> > +void * __must_check krealloc(const void *, size_t, gfp_t) __alloc_size(2);
> 
> I suggest the __alloc_size attribute be placed at the beginning of the
> function declaration to be more similar to the common __printf attribute
> location uses.

Yeah, any consistent ordering suggestions are welcome here; thank you!
These declarations were all over the place, and trying to follow each
slightly different existing style made my eyes hurt. :)

> __alloc_size(2)
> void * __must_check krealloc(const void *, size_t, gfp_t);
> 
> I really prefer the __must_check to be with the other attribute and that
> function declarations have argument names too like:
> 
> __alloc_size(2) __must_check
> void *krealloc(const void *ptr, size_t size, gfp_t gfp);

I'm happy with whatever makes the most sense.

> but there are a _lot_ of placement of __must_check after the return type
> 
> Lastly __alloc_size should probably be added to checkpatch

Oh, yes! Thanks for the reminder.

> Maybe:
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 161ce7fe5d1e5..1a166b5cf3447 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -489,7 +489,8 @@ our $Attribute	= qr{
>  			____cacheline_aligned|
>  			____cacheline_aligned_in_smp|
>  			____cacheline_internodealigned_in_smp|
> -			__weak
> +			__weak|
> +			__alloc_size\s*\(\s*\d+\s*(?:,\s*d+\s*){0,5}\)

Why the "{0,5}" bit here? I was expecting just "?". (i.e. it can have
either 1 or 2 arguments.)

>  		  }x;
>  our $Modifier;
>  our $Inline	= qr{inline|__always_inline|noinline|__inline|__inline__};
> 
> 

-- 
Kees Cook
