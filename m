Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B664DEE498F
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 20:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379944AbjHRURD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Aug 2023 16:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380020AbjHRURA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Aug 2023 16:17:00 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57743C0A
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 13:16:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bda9207132so10928215ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 13:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692389817; x=1692994617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B+0NDXVHi3NlSMpHGIebBNg86FuRtmvH4hOGN+BnELk=;
        b=DEtglTYYGcSHksSA2FN1gDlsR56zI+g/nYhimB696kBmZPBAzlOy75JkBBhM78FxWD
         oSNsu7vBKQxacSZZS6GIB1wbIFqgWxN1ttYlgzN3NSr44W9CiSm+fZ35PaWWCYGvnm8+
         6YrmffZmW7gRRwpACCuvTbm29E1nDgHWb/p/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692389817; x=1692994617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+0NDXVHi3NlSMpHGIebBNg86FuRtmvH4hOGN+BnELk=;
        b=ldLDEkJSx+bWxrBymHCh2O9QYEIwuVsGxyBgY15LaShGi1/FlUKFXYFpcTnvbBrObB
         IpxaGjwxxPR/EX6FcWoDBs6cpG5mdaVZmifzYdE2DxwGWOi7Gcl7NUmNQDkwHXX+kgIW
         yuHdpdPVeNeo1zUS1zYG7GIS59m4kndCyBhe+KGukTi/DEje9SEWD3+IDc0P7xBZTzFi
         jiR4D9sRpOT03YN6N/jkR7EKQvWy5V9xQoEgKqtjK/WC5Q+hwvGNr4c2S+5oIoQBdjUq
         nC4pV7Txdf0FGmXnjhWfeaI10rRzZMB8ausMUZjmv93PHWTohOMxtMNwBky63dEKtOtK
         3rew==
X-Gm-Message-State: AOJu0YwxVaZIl0WWjDzgvlm2Zio9RRT6CGBtNDP95W8s8vmZjw2Qce0X
        3j1iridS+1Uizprr/2aUZBEI3Mck9gYmHHVY9u8=
X-Google-Smtp-Source: AGHT+IHZo6wrfhDwquWf5UNY2LXx3igOOehSqRlr11vbqJ0GFmbmxugVK09ccVdL+k2/cm6nXXXjeQ==
X-Received: by 2002:a17:903:41c4:b0:1b8:6a09:9cf9 with SMTP id u4-20020a17090341c400b001b86a099cf9mr310762ple.26.1692389817079;
        Fri, 18 Aug 2023 13:16:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bi9-20020a170902bf0900b001bd99fd1114sm2140559plb.288.2023.08.18.13.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 13:16:56 -0700 (PDT)
Date:   Fri, 18 Aug 2023 13:16:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, linux-hardening@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
Message-ID: <202308181252.C7FF8B65BC@keescook>
References: <20230818041740.gonna.513-kees@kernel.org>
 <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
 <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
 <202308181146.465B4F85@keescook>
 <20230818123148.801b446cfdbd932787d47612@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230818123148.801b446cfdbd932787d47612@linux-foundation.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 18, 2023 at 12:31:48PM -0700, Andrew Morton wrote:
> On Fri, 18 Aug 2023 11:48:16 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > On Fri, Aug 18, 2023 at 08:17:55PM +0200, Jann Horn wrote:
> > > On Fri, Aug 18, 2023 at 7:56 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > On Thu, 17 Aug 2023 21:17:41 -0700 Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > > From: Elena Reshetova <elena.reshetova@intel.com>
> > > > >
> > > > > atomic_t variables are currently used to implement reference counters
> > > > > with the following properties:
> > > > >  - counter is initialized to 1 using atomic_set()
> > > > >  - a resource is freed upon counter reaching zero
> > > > >  - once counter reaches zero, its further
> > > > >    increments aren't allowed
> > > > >  - counter schema uses basic atomic operations
> > > > >    (set, inc, inc_not_zero, dec_and_test, etc.)
> > > > >
> > > > > Such atomic variables should be converted to a newly provided
> > > > > refcount_t type and API that prevents accidental counter overflows and
> > > > > underflows. This is important since overflows and underflows can lead
> > > > > to use-after-free situation and be exploitable.
> > > >
> > > > ie, if we have bugs which we have no reason to believe presently exist,
> > > > let's bloat and slow down the kernel just in case we add some in the
> > > > future?
> > > 
> > > Yeah. Or in case we currently have some that we missed.
> > 
> > Right, or to protect us against the _introduction_ of flaws.
> 
> We could cheerfully add vast amounts of code to the kernel to check for
> the future addition of bugs.  But we don't do that, because it would be
> insane.

This is a slippery-slope fallacy and doesn't apply. Yes, we don't add vast
amounts of code for that and that isn't the case here. This is fixing a
known weakness of using atomic reference counts, with a long history of
exploitation, on a struct used for enforcing security boundaries, solved
with the kernel's standard reference counting type. As I mentioned in
the other arm[1] of this thread, I think the question is better "Why is
this NOT refcount_t? What is the benefit, and why does that make struct
cred special?"

> > > Though really we don't *just* need refcount_t to catch bugs; on a
> > > system with enough RAM you can also overflow many 32-bit refcounts by
> > > simply creating 2^32 actual references to an object. Depending on the
> > > structure of objects that hold such refcounts, that can start
> > > happening at around 2^32 * 8 bytes = 32 GiB memory usage, and it
> > > becomes increasingly practical to do this with more objects if you
> > > have significantly more RAM. I suppose you could avoid such issues by
> > > putting a hard limit of 32 GiB on the amount of slab memory and
> > > requiring that kernel object references are stored as pointers in slab
> > > memory, or by making all the refcounts 64-bit.
> > 
> > These problems are a different issue, and yes, the path out of it would
> > be to crank the size of refcount_t, etc.
> 
> Is it possible for such overflows to occur in the cred code?  If so,
> that's a bug.  Can we fix that cred bug without all this overhead? 
> With a cc:stable backport.  If not then, again, what is the non
> handwavy, non cargoculty justification for adding this overhead to
> the kernel?

The only overhead is on slow-path for the error conditions. There is no
_known_ bug in the cred code today, but there might be unknown flaws,
or new flaws or unexpected reachability may be introduced in the future.
That's the whole point of making kernel code defensive. I've talked about
this (with lots of data to support it) at length before[2], mainly around
the lifetime of exploitable flaws: average lifetime is more than 5 years
and we keep introducing them in code that uses fragile types or ambiguous
language features. But I _haven't_ had to talk much about reference
counting since 2016 when we grew a proper type for it. :)

Let's get the stragglers fixed.

-Kees

[1] https://lore.kernel.org/lkml/202308181131.045F806@keescook/
[2] https://outflux.net/slides/2021/lss/kspp.pdf (see slides 4, 5, 6)
    https://outflux.net/slides/2019/lss/kspp.pdf (see slides 4, 5, 6)
    https://outflux.net/slides/2018/lss/kspp.pdf (see slides 3, 4)
    https://outflux.net/slides/2017/lss/kspp.pdf (see slides 5, 6, 13)
    https://outflux.net/slides/2017/ks/kspp.pdf (see slides 3, 4, 12)
    https://outflux.net/slides/2016/lss/kspp.pdf (see slides 5, 6, 12, 20)
    https://outflux.net/slides/2016/ks/kspp.pdf (see slides 17, 21)
    https://outflux.net/slides/2015/ks/security.pdf (see slides 4, 13)

-- 
Kees Cook
