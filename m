Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9990C61DA4
	for <linux-hardening@archiver.kernel.org>; Thu,  2 Feb 2023 19:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBBTxQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 2 Feb 2023 14:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjBBTxK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 2 Feb 2023 14:53:10 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF9F27D43
        for <linux-hardening@vger.kernel.org>; Thu,  2 Feb 2023 11:53:08 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b5so3002477plz.5
        for <linux-hardening@vger.kernel.org>; Thu, 02 Feb 2023 11:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lTJ0ccmZsF7Gg5dE4Vjs5n4bqhK7TAIoBM6qr3Xy8w4=;
        b=YN5MfCYS9gxj2QhBXI5KZocZd2/htBFUyHiPsf05F0lToYbpyrMYoG9TWZEgiRbSVv
         SMFgP8p2olPX8yxJClMKUUp7onRh5Gw6s/YAO554whyR4NC5QTERa5Kfz0h0vSalaFFg
         bvcKN3nThGyybsFOl+wAqARj7RXbivXFmP2+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTJ0ccmZsF7Gg5dE4Vjs5n4bqhK7TAIoBM6qr3Xy8w4=;
        b=Q1rF5n2XbxBXFIYQDjuJfEf7y7XU51Dg9InpVPucr1zVzEcXS8PPN63wJfWELgTq/6
         +rXgAOqQ+y6InQZmpN+JnVr4x/Pl/AjEJhk060JiUCukDd1ZsDsufta1m274+8ZrpryQ
         MG84IFWJn2ZDa+57BWI/5qqBeEgI/JEHOFOcTyptF+7v2QANiudFv6n03OMucfGxQpEz
         oUSqLJXNy2YldNKajOVDNusBpc12BWAeAfOIvHqSpNf05Y9wnubRYVxtE3IuJ+ILn/xk
         KArAQp4oK4NsPiQyS1EjMmuli58WdKYfOS2wGjay9IoJVgxUhvEReRUwluhmUWQOzD2O
         o0/g==
X-Gm-Message-State: AO0yUKVbFqH4zZsBCFah6+b5GvEn8TVizsBxz67m7kK82BKzvU4ki5YK
        vx8M8RclyEwSWAYHcRGYMIQR3g==
X-Google-Smtp-Source: AK7set8zRQbILHV+ugTiEd3WSZDmH7kswxREZghs4AgHCKTSZ4UsdVx2ugsfHod8HCyxVOJB0iJYzw==
X-Received: by 2002:a17:902:f38c:b0:192:b43e:272 with SMTP id f12-20020a170902f38c00b00192b43e0272mr5651044ple.53.1675367588277;
        Thu, 02 Feb 2023 11:53:08 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v16-20020a17090331d000b001948cc9c2fbsm52725ple.133.2023.02.02.11.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 11:53:06 -0800 (PST)
Message-ID: <63dc14a2.170a0220.beb2a.0275@mx.google.com>
X-Google-Original-Message-ID: <202302021952.@keescook>
Date:   Thu, 2 Feb 2023 19:53:06 +0000
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 5/6] driver core: Add __alloc_size hint to devm allocators
References: <20221101222520.never.109-kees@kernel.org>
 <20221101223321.1326815-5-keescook@chromium.org>
 <CAMSo37W3gRkP02tSCxGX71ZDAt3WgPZrkTRTM6J1iQ4gvUS9vg@mail.gmail.com>
 <CANDhNCogJrvt=yEXFK-xVmGjkcRxSNGZUqUeNw2MV9bFRrwPdQ@mail.gmail.com>
 <63dbf04a.630a0220.2608a.0149@mx.google.com>
 <CANDhNCoJJs_jSAdr6uved=cK=-6+nzSJq3e_E3HgtiXHZXkVww@mail.gmail.com>
 <63dc0a89.170a0220.49507.0091@mx.google.com>
 <CAMj1kXHTwFH-OADZ5nZXfZyuH-x7XJL3DMyiz2Tr_nCuup+xFA@mail.gmail.com>
 <CAKwvOd=cuDb2NNK4uoUTYTLryFig47hvDQ08ta5XhjHsEhAG4A@mail.gmail.com>
 <CABCJKuc+GvTHXu-CVedZs6CvPKJ8ySrVztkP2V3dsWn70xf7hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKuc+GvTHXu-CVedZs6CvPKJ8ySrVztkP2V3dsWn70xf7hA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 02, 2023 at 11:49:42AM -0800, Sami Tolvanen wrote:
> On Thu, Feb 2, 2023 at 11:31 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Thu, Feb 2, 2023 at 11:20 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 2 Feb 2023 at 20:10, Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Thu, Feb 02, 2023 at 10:56:29AM -0800, John Stultz wrote:
> > > > > That said, making sense of the error message isn't completely trivial
> > > > > either. I've been seeing a few cases recently of some of the new
> > > > > compiler tooling (I pinged you earlier on a CFI one) causing errors
> > > > > that developers aren't really sure how to address.  I know sometimes
> > > > > it's not easy to surface the errors with context to what was wrong,
> > > > > but at the risk of intense bike shedding, is there some way to provide
> > > > > something like "Likely array bounds error" instead of just "BRK
> > > > > handler: Fatal exception"?
> > > >
> > > > Yeah, this is a result of the size trade-off that resulted in config
> > > > CONFIG_UBSAN_TRAP -- there ends up being no message about what went
> > > > wrong. I'd really like to have cleaner handling of this -- perhaps what
> > > > was done for KCFI could be applied to UBSAN as well, though this is an
> > > > area I don't know well myself. (i.e. encoding "this was a UBSAN trap"
> > > > in the trap itself.)
> > > >
> > > > Sami or Ard, is this something that could be improved for arm64?
> > > >
> > >
> > > -ENOCONTEXT, so I am going to assume this is about runtime
> > > instrumentation that needs some kind of 'panic' function which it will
> > > invoke if some condition is met that should never occur?
> > >
> > > We already use brk with different immediate values in the opcode, so
> > > the arch layer already has what we need. Is this a limitation in the
> > > compiler, perhaps, where it always emits the same brk opcode?
> >
> > Yeah, we'd need to update both the compiler to produce the encoding,
> > and the kernel to recognize the encoding and do something special.
> 
> A quick look at Clang's source code suggests that Intrinsic::ubsantrap
> already accepts the handler ID (from the SanitizerHandler enum) as an
> argument and the arm64 LLVM back-end appears to encode the value as an
> immediate for the brk instruction. I didn't confirm that this actually
> works, but perhaps we just need to teach the kernel about the possible
> values?

Oh excellent. Yeah, if that's all that's needed here that would be
great. What are the values?

-- 
Kees Cook
