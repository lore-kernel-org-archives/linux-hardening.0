Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FCDCA0EC2
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Sep 2023 21:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348688AbjIKV3s (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbjIKJuj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 11 Sep 2023 05:50:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91828116
        for <linux-hardening@vger.kernel.org>; Mon, 11 Sep 2023 02:50:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52c96d5df86so10664a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 11 Sep 2023 02:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694425833; x=1695030633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7Crep/nXO31QV2GDdfwJy1xW9/XIy7CcW7VYLyAKr4=;
        b=UVwrOyVMpJ+zem9j/ShJPV0zvkz5kAQs3Viz6usv+QKir34taXmlQCB3ArCR3kM931
         z93smwqRjorrhgTYBR6/B4uUH33Sf2I1fJ4/bLDHg4ZHE1aBR8ZOe6CgUsXeNuL9L4/e
         pLU3afTGX0PFFMu5+PRv19n1pvR1X3eJWeyhNjiapr8xVz8XpL6Y2tfYMrpd1ykcvG3p
         31Ljhj4kaTYQ1VQ6C0rJiDTgIQTjiAawYy8F7unyMhLQu06l1JcDDVva+5ubBtdXIbTD
         V9+SobZiuSmkTC5CmmUZUpVz2jq92DAATUnStODqCPcHT/2g+KOobsRZ6NtculmBeHnl
         82lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425833; x=1695030633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7Crep/nXO31QV2GDdfwJy1xW9/XIy7CcW7VYLyAKr4=;
        b=Cw94c39wV0Lm0+kc/ynGQ9dAW4dROKshIye2/VPGAAtw5MmrPAj3/IoBAVY12ryocn
         fsJvhVcv1wpRMheuMmfxhYtI3bChexvq80DRVWTlvTMfIwdfNUlgyzIA+6O/l4lU3LyM
         DVGsQSvOaJ3PiFP28LQxLVqgZq/bfsWswJpy92I67iy1cx8+ZQVPIKGvJY7SViSP8CCn
         JAXnBXN0duqamTq/8RISup0Z/TMVUmFUPjE+95xTn5vF7Wr+jammXQV1JT5WM/mZWasB
         +ggSkvYJOSpjbTZF1vI13WIAH9I6EmeOLdDD7peK1z4alHnAurW/SaxGSaQOQFr6SFgI
         kEVA==
X-Gm-Message-State: AOJu0Yz0uLiaqo6qMT3K24+cKAqmQAwesMCR3ii885cOP1i44dlvsaft
        0vW7GhiDj4BLvQuVxI7fXegiTMeIctElPvN5/iP20g==
X-Google-Smtp-Source: AGHT+IEnufPO9OzBEQuYnjHfCtigVlILM0MT8OrU9srZCX0K/h7wQ9Eugsdqm9Ngd6OahcB6Ilp1x+eyS5q6FsKxT1M=
X-Received: by 2002:a50:954d:0:b0:523:193b:5587 with SMTP id
 v13-20020a50954d000000b00523193b5587mr323171eda.6.1694425832864; Mon, 11 Sep
 2023 02:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230825211426.3798691-1-jannh@google.com> <CACT4Y+YT6A_ZgkWTF+rxKO_mvZ3AEt+BJtcVR1sKL6LKWDC+0Q@mail.gmail.com>
 <CAG48ez34DN_xsj7hio8epvoE8hM3F_xFoqwWYM-_LVZb39_e9A@mail.gmail.com>
In-Reply-To: <CAG48ez34DN_xsj7hio8epvoE8hM3F_xFoqwWYM-_LVZb39_e9A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Sep 2023 11:50:19 +0200
Message-ID: <CACT4Y+YcBeshE811w5KSyYpBqaQ3S_-aKanOGZcHCQvHWHc4Tg@mail.gmail.com>
Subject: Re: [PATCH] slub: Introduce CONFIG_SLUB_RCU_DEBUG
To:     Jann Horn <jannh@google.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 28 Aug 2023 at 16:40, Jann Horn <jannh@google.com> wrote:
>
> On Sat, Aug 26, 2023 at 5:32=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com=
> wrote:
> > On Fri, 25 Aug 2023 at 23:15, Jann Horn <jannh@google.com> wrote:
> > > Currently, KASAN is unable to catch use-after-free in SLAB_TYPESAFE_B=
Y_RCU
> > > slabs because use-after-free is allowed within the RCU grace period b=
y
> > > design.
> > >
> > > Add a SLUB debugging feature which RCU-delays every individual
> > > kmem_cache_free() before either actually freeing the object or handin=
g it
> > > off to KASAN, and change KASAN to poison freed objects as normal when=
 this
> > > option is enabled.
> > >
> > > Note that this creates a 16-byte unpoisoned area in the middle of the
> > > slab metadata area, which kinda sucks but seems to be necessary in or=
der
> > > to be able to store an rcu_head in there without triggering an ASAN
> > > splat during RCU callback processing.
> >
> > Nice!
> >
> > Can't we unpoision this rcu_head right before call_rcu() and repoison
> > after receiving the callback?
>
> Yeah, I think that should work. It looks like currently
> kasan_unpoison() is exposed in include/linux/kasan.h but
> kasan_poison() is not, and its inline definition probably means I
> can't just move it out of mm/kasan/kasan.h into include/linux/kasan.h;
> do you have a preference for how I should handle this? Hmm, and it
> also looks like code outside of mm/kasan/ anyway wouldn't know what
> are valid values for the "value" argument to kasan_poison().
> I also have another feature idea that would also benefit from having
> something like kasan_poison() available in include/linux/kasan.h, so I
> would prefer that over adding another special-case function inside
> KASAN for poisoning this piece of slab metadata...
>
> I guess I could define a wrapper around kasan_poison() in
> mm/kasan/generic.c that uses a new poison value for "some other part
> of the kernel told us to poison this area", and then expose that
> wrapper with a declaration in include/mm/kasan.h? Something like:
>
> void kasan_poison_outline(const void *addr, size_t size, bool init)
> {
>   kasan_poison(addr, size, KASAN_CUSTOM, init);
> }

Looks reasonable.

> > What happens on cache destruction?
> > Currently we purge quarantine on cache destruction to be able to
> > safely destroy the cache. I suspect we may need to somehow purge rcu
> > callbacks as well, or do something else.
>
> Ooh, good point, I hadn't thought about that... currently
> shutdown_cache() assumes that all the objects have already been freed,
> then puts the kmem_cache on a list for
> slab_caches_to_rcu_destroy_workfn(), which then waits with an
> rcu_barrier() until the slab's pages are all gone.

I guess this is what the test robot found as well.

> Luckily kmem_cache_destroy() is already a sleepable operation, so
> maybe I should just slap another rcu_barrier() in there for builds
> with this config option enabled... I think that should be fine for an
> option mostly intended for debugging.

This is definitely the simplest option.
I am a bit concerned about performance if massive cache destruction
happens (e.g. maybe during destruction of a set of namespaces for a
container). Net namespace is slow to destroy for this reason IIRC,
there were some optimizations to batch rcu synchronization. And now we
are adding more.
But I don't see any reasonable faster option as well.
So I guess let's do this now and optimize later (or not).
