Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CDFEE498F
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 18:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379484AbjHRSsd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Aug 2023 14:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379503AbjHRSsV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Aug 2023 14:48:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEB74208
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 11:48:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686be3cbea0so1658684b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692384498; x=1692989298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GP1DcfQVRyZ/pIKJy2r3P+ha5kBKzRQgOLNbP0+yBQs=;
        b=ePIhLMmxprOtmHRcgmlOpi4JqeUCi+e4RdG8FfoL1iL+oNcVBkj0XqtQJnTQxIBI4k
         N240Kufklz5cX2Cv3kEJRxkj6dAYrBnfvoOljZRepjUqNAMdn2IvVDKUNd3y9Lk1Zsx/
         1ujg1FJNf2ZXsaWwM9P4BvfmM5oo41BjtKtEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692384498; x=1692989298;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GP1DcfQVRyZ/pIKJy2r3P+ha5kBKzRQgOLNbP0+yBQs=;
        b=PisLMzqh0GbqVTKcfVJdrPopREAnvdlJa6kaqvxS/Yvkw+5C6Ps8mloAzMj5j4ubJ7
         +/Gxb9OZul5u7CnPODvbtOeOeBBpTTVwWnE9bltHOGdUNJjYLGNZGdgThGL+9kcJxtLx
         4b+kt/zwOpJzY6/EaNYgGD/KQ3sQwCMbjM2Uq2mPfHUZFdDmR3GOvuRvJDufgKNxxwEH
         U5+NiW73gOLx72C7ZvUH8e7GpKg6b3Zf4Phi/D1LZluxarPnqYOSKlEXGRuYN6KUG52x
         RCzvidlWUPUjfPZMCAWu2GVvh/XR87QX7OOJle4b5BtGV1gowHM34j3ysAORbvUsVoGg
         ZIHQ==
X-Gm-Message-State: AOJu0Yw1CEbrR9ll3IY0uN1oSrgWsTJQy1wFdJpx35+2/+330HKbMAQh
        TX9W0AgY+3+mbOmV+juCgKWyCw==
X-Google-Smtp-Source: AGHT+IGq/UUkwq5B2XE8Euk/g23oQaEh8/MVfrEjyY6KOesc26jzK9pN4ZLSFXkSGrYh9NRVjUtvLA==
X-Received: by 2002:a05:6a00:9a3:b0:688:2256:f767 with SMTP id u35-20020a056a0009a300b006882256f767mr70601pfg.5.1692384497561;
        Fri, 18 Aug 2023 11:48:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a62bd09000000b0068844ee18dfsm1841699pff.83.2023.08.18.11.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:48:16 -0700 (PDT)
Date:   Fri, 18 Aug 2023 11:48:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-hardening@vger.kernel.org,
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
Message-ID: <202308181146.465B4F85@keescook>
References: <20230818041740.gonna.513-kees@kernel.org>
 <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
 <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 18, 2023 at 08:17:55PM +0200, Jann Horn wrote:
> On Fri, Aug 18, 2023 at 7:56 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Thu, 17 Aug 2023 21:17:41 -0700 Kees Cook <keescook@chromium.org> wrote:
> >
> > > From: Elena Reshetova <elena.reshetova@intel.com>
> > >
> > > atomic_t variables are currently used to implement reference counters
> > > with the following properties:
> > >  - counter is initialized to 1 using atomic_set()
> > >  - a resource is freed upon counter reaching zero
> > >  - once counter reaches zero, its further
> > >    increments aren't allowed
> > >  - counter schema uses basic atomic operations
> > >    (set, inc, inc_not_zero, dec_and_test, etc.)
> > >
> > > Such atomic variables should be converted to a newly provided
> > > refcount_t type and API that prevents accidental counter overflows and
> > > underflows. This is important since overflows and underflows can lead
> > > to use-after-free situation and be exploitable.
> >
> > ie, if we have bugs which we have no reason to believe presently exist,
> > let's bloat and slow down the kernel just in case we add some in the
> > future?
> 
> Yeah. Or in case we currently have some that we missed.

Right, or to protect us against the _introduction_ of flaws.

> Though really we don't *just* need refcount_t to catch bugs; on a
> system with enough RAM you can also overflow many 32-bit refcounts by
> simply creating 2^32 actual references to an object. Depending on the
> structure of objects that hold such refcounts, that can start
> happening at around 2^32 * 8 bytes = 32 GiB memory usage, and it
> becomes increasingly practical to do this with more objects if you
> have significantly more RAM. I suppose you could avoid such issues by
> putting a hard limit of 32 GiB on the amount of slab memory and
> requiring that kernel object references are stored as pointers in slab
> memory, or by making all the refcounts 64-bit.

These problems are a different issue, and yes, the path out of it would
be to crank the size of refcount_t, etc.

-- 
Kees Cook
