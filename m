Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27191C2FC04
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 03:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347782AbjHQDFq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Aug 2023 23:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347865AbjHQDFh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Aug 2023 23:05:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471F21728
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 20:05:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68890d565b5so1037155b3a.2
        for <linux-hardening@vger.kernel.org>; Wed, 16 Aug 2023 20:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692241536; x=1692846336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JjkCKPeKm6ogP/ShsR+emc2XvsubzSVeh7r2pF2pbQQ=;
        b=hn0HQ1W7c4IHxj2qoAlQTZYwFBjY1W4GBb14yIgY5r4OvcBuWGRF1514enk+cTMWGt
         fqvCDk4p8ok8ZQ5fpUSb4nr9/AzN41ehuZ1+qEt2dyaU6zsHQ5niFHrbcL/yrx/45gy8
         Y2v2pYz1PfVyllJ+LC4KdRdLgepyEHPS1rEoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692241536; x=1692846336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjkCKPeKm6ogP/ShsR+emc2XvsubzSVeh7r2pF2pbQQ=;
        b=ihyAWjGzQcnDrR5otZd5AFKGihcggmAEeAUkCaJ3XaJ2mskXC+orOm/GSPt/LR4ypj
         +rhyfgnzsNWG0/0KSjL7LYevK1SA9aw2Z8JwSHMPsA1SuR2Y2Gk97yp+FJlJ2RzJfHck
         8HxBitp6dMSldzlZ0EXkWgld1V4AgbKcvqsYks3IjlYRmKCwRp9OQzXrInLJ4enDIzG8
         cg+3buXNspr8o7TQCqXI16PzPahkdDaafOjv3cesUjNGmWI1KOXKil9InbVTcp1pQR1s
         ZCI+WOP/rV8cCZEPNiMZpKMTGP+U+hczA86VtyAUZbgWW4KSzxZrIRBLwulq3D0mOKKC
         QGaA==
X-Gm-Message-State: AOJu0YxmqZtvx4yiyo4nXgnv98w9YuDbOdkftmQ/1rhFJXqwv2aZGc6F
        7DgEJYU0Wl7zrsz/ENJBgaDY7eU2QChho0jqTyo=
X-Google-Smtp-Source: AGHT+IFLsGy8iDKX2ppQ7wdbrc0+XKb4Vcpjjn6WLqBiyVpvsLc1nE7KyyBkAq20Bz3N0oBP/pGwRA==
X-Received: by 2002:a05:6a21:66c9:b0:142:8314:c6e4 with SMTP id ze9-20020a056a2166c900b001428314c6e4mr3583436pzb.61.1692241535764;
        Wed, 16 Aug 2023 20:05:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g15-20020aa7874f000000b0068875a862adsm2650562pfo.98.2023.08.16.20.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 20:05:34 -0700 (PDT)
Date:   Wed, 16 Aug 2023 20:05:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: struct_size() using sizeof() vs offsetof()
Message-ID: <202308161913.91369D4A@keescook>
References: <74e8cf91-d095-33e3-c548-34d80b691089@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74e8cf91-d095-33e3-c548-34d80b691089@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 17, 2023 at 02:23:21AM +0200, Alejandro Colomar wrote:
> Hi Kees, Gustavo,

Hi!

> I've been discussing with a friend about the appropriateness of sizeof()
> vs offsetof() for calculating the size of a structure with a flexible
> array member (FAM).
> 
> After reading Jens Gustedt's blog post about it[1], we tried some tests,
> and we got some interesting results that discouraged me from using sizeof().
> See below.

When struct_size() was originally implemented this topic came up, and we
opted for potential over-estimation rather than using offsetof() which
could result in under-allocation, and using max() of two different
calculations just seemed like overkill. Additionally, almost all cases of
struct_size() was replacing a literal open-coded version of

	sizeof(*ptr) + sizeof(*ptr->array) * count

So avoiding a difference in calculation was nice too.

> But then, said friend pointed to me that the kernel uses sizeof() in
> struct_size(), and we wondered why you would have chosen it.  It's safe
> as long as you _know_ that there's no padding, or that the alignment of
> the FAM is as large as the padding (which you probably know in the kernel),
> but it seems safer to use
> 
> 	MAX(sizeof(s), offsetof(s, fam) + sizeof_member(s, fam) * count)

Ironically, this has been under careful examination recently by GCC[1]
too. Though that has mainly been looking at it from the perspective
of how __builtin_object_size() should behave in the face of the new
__counted_by attribute.

> The thing is, if there's any trailing padding in the struct, the FAM may
> overlap the padding, and the calculation with sizeof() will waste a few
> bytes, and if misused to get the location of the FAM, the problem will be
> bigger, as you'll get a wrong location.

Luckily, the _location_ of the FAM is well-defined by the compiler, so
that won't be a problem. However, yes, we can risk wasting some bytes.

> So, I just wanted to pry what and especially why the kernel chose to prefer
> a simple sizeof().

We opted for simple over complex, with the understanding that
over-allocation will be a relatively rare issue that will only waste
limited space (as opposed to potential under-allocation and risking
writing beyond the end of the region).

Here's some example I worked through:

https://godbolt.org/z/9aGjqon9v

But, yes, at the end of the day, struct_size() could be defined as
max(sizeof, offsetof-based struct-size).

Note that struct_size() has been designed to have two additional
behaviors:
 - be usable as a constant expression
 - saturate at SIZE_MAX

So as long as the max() could do the same (which it should be able to),
it'd likely be fine. I'm open to patches as long as we can validate any
binary differences found in allmodconfig builds. :)

-Kees

[1] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/626672.html

-- 
Kees Cook
