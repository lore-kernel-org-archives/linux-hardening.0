Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B48C71153
	for <linux-hardening@archiver.kernel.org>; Mon, 28 Aug 2023 14:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjH1OkZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 28 Aug 2023 10:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjH1OkU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 28 Aug 2023 10:40:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE84132
        for <linux-hardening@vger.kernel.org>; Mon, 28 Aug 2023 07:40:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fef2fafee2so121755e9.0
        for <linux-hardening@vger.kernel.org>; Mon, 28 Aug 2023 07:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693233610; x=1693838410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2UbLxhYqoo5RujlArsNRFXdGVrlcSizT9E5D+JEpAc=;
        b=MY2Ms4p01VDARLLYyDuGjTRafr6ajxadr+5qBJJyeFxtTqZtBvsbWiU2P+OvCZd0tE
         nr2k2gjZ8btB/ikUWq5yJ8IHSi25UMeBvUBO4vjcJvtGC7BMdP62otxoIRHLhOoWVKvN
         unlLrvgg/DDEBzXleZsUVnE53p0gmby2K+p6VdzpjfdbY+4pqQMtJozbU6PQ0OnD8KhO
         FOiMPZrwRaS7sjyS/I50VF/dge0wyo5GwHotaJsUdx7kd+FOS4N0vYBGVC4ZUWVGql6r
         x4hWflo2fM5H1xvbEA311948iwPYyuRkYttDSjrsWWvcEk00aoOxbjSE7PPeZ/ke+Usf
         ioHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693233610; x=1693838410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2UbLxhYqoo5RujlArsNRFXdGVrlcSizT9E5D+JEpAc=;
        b=WVI4VoNjq1F57qllNwcGBxdksaoGmOJsurfK9JroaaWjHGz0j/QFviqwsHFuuYM0Md
         0kqaYPn3AItXJEb+JwlZSoMvEal7bCujj6yJZF2/WGkSirVPuZMpC1eSep2EqO5ATS5C
         JOmACWnfWiDX1UC1IJIa54miSPSYcLfmvjCjgVezyslUj6LZCJg8lT4F07oNuogJqTyC
         8ek0CFNIHMdOyRm8ppn6oKnYv95NI0rFytDqyc+j/8yq5RrHd+4+KqLMSqOftes7SEwh
         /fiP9RisyZc8rLAHyCt+ggFV4DcFHLtL7Wu8P0fwfRBQ3KBY6W8NMubKnHeq87iahQeu
         gKzQ==
X-Gm-Message-State: AOJu0YwUOM6LLso90qQYXPjXCcMKAt7pGgmdK1EcLz5ZUgUEWognyGbJ
        KZAPv1N5Oo+m0KQO4wccsKPaAyScm/dduZqtSXsuVg==
X-Google-Smtp-Source: AGHT+IG89PQvGlyyexU2ilvXeGop6BLWwAi3Qpxw0oEo0DLUWmBEPba4+VZw3sP1uOUhmoGBub9dfKhA7O/cwHW0Vho=
X-Received: by 2002:a05:600c:1da6:b0:400:c6de:6a20 with SMTP id
 p38-20020a05600c1da600b00400c6de6a20mr306793wms.3.1693233610358; Mon, 28 Aug
 2023 07:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230825211426.3798691-1-jannh@google.com> <CACT4Y+YT6A_ZgkWTF+rxKO_mvZ3AEt+BJtcVR1sKL6LKWDC+0Q@mail.gmail.com>
In-Reply-To: <CACT4Y+YT6A_ZgkWTF+rxKO_mvZ3AEt+BJtcVR1sKL6LKWDC+0Q@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 28 Aug 2023 16:39:33 +0200
Message-ID: <CAG48ez34DN_xsj7hio8epvoE8hM3F_xFoqwWYM-_LVZb39_e9A@mail.gmail.com>
Subject: Re: [PATCH] slub: Introduce CONFIG_SLUB_RCU_DEBUG
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Sat, Aug 26, 2023 at 5:32=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com> =
wrote:
> On Fri, 25 Aug 2023 at 23:15, Jann Horn <jannh@google.com> wrote:
> > Currently, KASAN is unable to catch use-after-free in SLAB_TYPESAFE_BY_=
RCU
> > slabs because use-after-free is allowed within the RCU grace period by
> > design.
> >
> > Add a SLUB debugging feature which RCU-delays every individual
> > kmem_cache_free() before either actually freeing the object or handing =
it
> > off to KASAN, and change KASAN to poison freed objects as normal when t=
his
> > option is enabled.
> >
> > Note that this creates a 16-byte unpoisoned area in the middle of the
> > slab metadata area, which kinda sucks but seems to be necessary in orde=
r
> > to be able to store an rcu_head in there without triggering an ASAN
> > splat during RCU callback processing.
>
> Nice!
>
> Can't we unpoision this rcu_head right before call_rcu() and repoison
> after receiving the callback?

Yeah, I think that should work. It looks like currently
kasan_unpoison() is exposed in include/linux/kasan.h but
kasan_poison() is not, and its inline definition probably means I
can't just move it out of mm/kasan/kasan.h into include/linux/kasan.h;
do you have a preference for how I should handle this? Hmm, and it
also looks like code outside of mm/kasan/ anyway wouldn't know what
are valid values for the "value" argument to kasan_poison().
I also have another feature idea that would also benefit from having
something like kasan_poison() available in include/linux/kasan.h, so I
would prefer that over adding another special-case function inside
KASAN for poisoning this piece of slab metadata...

I guess I could define a wrapper around kasan_poison() in
mm/kasan/generic.c that uses a new poison value for "some other part
of the kernel told us to poison this area", and then expose that
wrapper with a declaration in include/mm/kasan.h? Something like:

void kasan_poison_outline(const void *addr, size_t size, bool init)
{
  kasan_poison(addr, size, KASAN_CUSTOM, init);
}

> What happens on cache destruction?
> Currently we purge quarantine on cache destruction to be able to
> safely destroy the cache. I suspect we may need to somehow purge rcu
> callbacks as well, or do something else.

Ooh, good point, I hadn't thought about that... currently
shutdown_cache() assumes that all the objects have already been freed,
then puts the kmem_cache on a list for
slab_caches_to_rcu_destroy_workfn(), which then waits with an
rcu_barrier() until the slab's pages are all gone.

Luckily kmem_cache_destroy() is already a sleepable operation, so
maybe I should just slap another rcu_barrier() in there for builds
with this config option enabled... I think that should be fine for an
option mostly intended for debugging.
