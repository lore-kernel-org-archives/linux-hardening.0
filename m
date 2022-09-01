Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62F7ECAAD1
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Sep 2022 19:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiIATXy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Sep 2022 15:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiIATXv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Sep 2022 15:23:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9609F79A43
        for <linux-hardening@vger.kernel.org>; Thu,  1 Sep 2022 12:23:50 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x19so16532430pfr.1
        for <linux-hardening@vger.kernel.org>; Thu, 01 Sep 2022 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Vm0uQ/sY5O71PZ9K3kfky1K1MJP/dEE1ST/6nlXuCiQ=;
        b=IMD784az1hIpI8Ft/FU2MdkAJ1H1MjHqWT56y23RNznWUUIDtSSx7jDwmhAIc2BpCQ
         uiI8JzqkRWtCpHaoaN/dCRjWY8LIGFsnt8ZwlxE5jkLDCK1kv3frIOKpWf/yde5IzFPE
         xykP8CXw3wOpbTbd1ZmInhl6uwmNzpLVrYFV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Vm0uQ/sY5O71PZ9K3kfky1K1MJP/dEE1ST/6nlXuCiQ=;
        b=WU6g8PfKJzhP2O5rYxptX+vfKIVigfWBqSY9/kPSzTuod6yg/J6bbtgrT9WFsLOc7x
         KrtnpqMjljQrUxaLoNCAXSArPh0TNJzyc55ya9dLwHjpPAXdqltNpIjz9d6Wuwa/Ekhq
         Y//+DZ9WvLtc9a1ofBa2mjGVwV3x7L2qVIfbvp/fkY6/SzXgUc25aU9AI22Trs3+hzwJ
         FsoV5xnk+YOQvRdYt+PjFLj7q13fHcTzkX7TBGYZe0JrYLDpcbMLC7cdESOKy8dgo8gH
         o/E0lvevH+13WqAUf/dDaJwVlN1r2cHrLX39j3CCbkWt7nGqD5Tqe6IN/CQ9yJ4q3OSw
         nz1w==
X-Gm-Message-State: ACgBeo08vaXsYj1HS+p3yyzMbwYTgjfiY7dFkWGkYUUY3qg4NUJ7ZGpI
        DgSVCcaiNbEcUEu2sZ464VtC7g==
X-Google-Smtp-Source: AA6agR64SvyNakRH221PbngURFtoyO3Ty2l6obptZjl4wanmcHYi83gkIv38T3XsyJA7uRGf4LwVcA==
X-Received: by 2002:a05:6a00:2489:b0:52f:9d31:c1ce with SMTP id c9-20020a056a00248900b0052f9d31c1cemr32744848pfv.51.1662060230087;
        Thu, 01 Sep 2022 12:23:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w11-20020a170902ca0b00b00174f62a14e5sm7762821pld.153.2022.09.01.12.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 12:23:49 -0700 (PDT)
Date:   Thu, 1 Sep 2022 12:23:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] string: Introduce strtomem() and strtomem_pad()
Message-ID: <202209011221.6E2B9A870@keescook>
References: <20220831230006.1016236-1-keescook@chromium.org>
 <CAMuHMdX1H_ssPDJH47kcXhmoAZzYEgJC2zaMp-d_2+VriZYAoA@mail.gmail.com>
 <202209011123.27D7D67@keescook>
 <CAMuHMdW3Wruazi=A+0HcWu8juzp+NdXPt7rtxtyhYjRLnD3QCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW3Wruazi=A+0HcWu8juzp+NdXPt7rtxtyhYjRLnD3QCw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 01, 2022 at 09:14:26PM +0200, Geert Uytterhoeven wrote:
> Hi Kees,
> 
> On Thu, Sep 1, 2022 at 8:35 PM Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Sep 01, 2022 at 10:39:19AM +0200, Geert Uytterhoeven wrote:
> > > > --- a/include/linux/string.h
> > > > +++ b/include/linux/string.h
> > > > @@ -260,6 +260,49 @@ static inline const char *kbasename(const char *path)
> > > >  void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
> > > >                     int pad);
> > > >
> > > > +/**
> > > > + * strtomem_pad - Copy NUL-terminated string to non-NUL-terminated buffer
> > > > + *
> > > > + * @dest: Pointer of destination character array (marked as __nonstring)
> > > > + * @src: Pointer to NUL-terminated string
> > > > + * @pad: Padding character to fill any remaining bytes of @dest after copy
> > > > + *
> > > > + * This is a replacement for strncpy() uses where the destination is not
> > > > + * a NUL-terminated string, but with bounds checking on the source size, and
> > > > + * an explicit padding character. If padding is not required, use strtomem().
> > > > + *
> > > > + * Note that the size of @dest is not an argument, as the length of @dest
> > > > + * must be discoverable by the compiler.
> > > > + */
> > > > +#define strtomem_pad(dest, src, pad)   do {                            \
> > > > +       const size_t _dest_len = __builtin_object_size(dest, 1);        \
> > > > +                                                                       \
> > > > +       BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||                \
> > > > +                    _dest_len == (size_t)-1);                          \
> > >
> > > I think you want to include __must_be_array(dest) here.
> >
> > I didn't do that for the cases where we may be writing to non-array
> > destinations (e.g. see the cast from u64 in the strncpy use in
> > tools/perf/arch/x86/util/intel-pt.c). Since what we need to know is the
> > object size, it does not strictly need to be an array.
> 
> IC.  That does mean we cannot catch silly mistakes where the
> caller passes a pointer instead of the address of an array?

It's okay to pass a pointer as long as the compiler can reason about the
size of the object being pointed at (which is what __bos() does here).

> > > > +       for (int i = 2; i < sizeof(wrap.output); i++)
> > >
> > > unsigned int i (everywhere)
> >
> > I guess, but why? This could even be u8.
> 
> sizeof() is unsigned, so using int may cause signed/unsigned comparison
> warnings.

Do we have those warnings enabled anywhere? I thought solving that
warning was Sisyphean. But I guess, yes, better to avoid adding yet
more. :)

-- 
Kees Cook
