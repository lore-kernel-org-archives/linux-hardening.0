Return-Path: <SRS0=DAdQ=DP=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47772C43457
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 17:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57E321D7D
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Oct 2020 17:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klLxhSd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbgJHROV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Oct 2020 13:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbgJHROV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Oct 2020 13:14:21 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30129C061755
        for <linux-hardening@vger.kernel.org>; Thu,  8 Oct 2020 10:14:21 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 33so6561597edq.13
        for <linux-hardening@vger.kernel.org>; Thu, 08 Oct 2020 10:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MjSvq6hWT8/96s0xDFZsUEstTcT5YR2t+LBbq3YVkao=;
        b=klLxhSd3oAlnTsYIcjtHGEZXhchm33gVu8+7BSp8Hb2U1bPvJY+LcC8B79kTzmBMBz
         dtKWJgMataIg1aB0r0un6QWDh+uyjnuBYe9cCDNHvi6sFoheCWes8NdS1RNx0pEMl3g3
         lodEjtS/qN+lj9ujZpYEejIQKI0tMBgcQKBc6aLcC2pN6yYoDpmicgZms4TRF2aS0YYv
         im6YWnuBFVCc6c8CPgDMSEe9/4GLkYonngLUcDq21g6CHt3SsdQ4lCo/FY0Zb2WwiV0T
         +Ix6lKC1MUkRXzn/ncyr4YBTkYUc8f14Qs1LbSB0cdAnTo1FQTRtI6pLBmGzBYcJnT1e
         8qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MjSvq6hWT8/96s0xDFZsUEstTcT5YR2t+LBbq3YVkao=;
        b=nv+rvpcHjNvnuroHftg7ZfmT0jrNOCDVkchP+RQDzP79y7sT7RL380v+jXGyWW8ZYN
         JSJgPp/Mg9iBRxEYzaDyN1j3uYa2rFSzhDvxNwUDXEQo95WoOSnEXx4rxqA3/da8f3pd
         tMNg+FJhIVNI2c8kr6N1dgJB9/FiquHqczZlCXoWh9mDGcVuvfNQy09FODlA/EIw6Cpj
         DgNz2NyWQKobX1sVeecH60461VMxXujuy8xCyTVOPJRO+xka1czFgWgWeqYoWOk4cWIJ
         Uh2X3U7KPe/nQFhNU6Wq15M61qyUFB9zVCx9m4oD3z5qKRU8frvyJUQ3I+xrcLVYGyju
         OoTg==
X-Gm-Message-State: AOAM531eDrSSRRziKQR6U2sPpXeN1BsIZX8huNtmfVcWPDS0Yb8RB+Sn
        R81bEbAskI6J6HvW4A1cc/zCpdJgOtt2haoBor60KQ==
X-Google-Smtp-Source: ABdhPJw9MIyzoIJ1RLkj1psEZdczlqGKc8hD9QTN82HG81+KramekP5nE/vjSddJehw19xkI1eQJ24eCc0Fp86x1xZg=
X-Received: by 2002:a05:6402:b0e:: with SMTP id bm14mr10478897edb.259.1602177259365;
 Thu, 08 Oct 2020 10:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201008165408.38228-1-toiwoton@gmail.com>
In-Reply-To: <20201008165408.38228-1-toiwoton@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 8 Oct 2020 19:13:51 +0200
Message-ID: <CAG48ez1OU9PFQ06mf4L59SEmi6Vwxnao8RuVXH=dCiyMhqVwYA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] mm: Optional full ASLR for mmap() and mremap()
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 8, 2020 at 6:54 PM Topi Miettinen <toiwoton@gmail.com> wrote:
> Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
> enables full randomization of memory mappings created with mmap(NULL,
> ...). With 2, the base of the VMA used for such mappings is random,
> but the mappings are created in predictable places within the VMA and
> in sequential order. With 3, new VMAs are created to fully randomize
> the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
> even if not necessary.
[...]
> +       if ((flags & MREMAP_MAYMOVE) && randomize_va_space >= 3) {
> +               /*
> +                * Caller is happy with a different address, so let's
> +                * move even if not necessary!
> +                */
> +               new_addr = arch_mmap_rnd();
> +
> +               ret = mremap_to(addr, old_len, new_addr, new_len,
> +                               &locked, flags, &uf, &uf_unmap_early,
> +                               &uf_unmap);
> +               goto out;
> +       }

You just pick a random number as the address, and try to place the
mapping there? Won't this fail if e.g. the old address range overlaps
with the new one, causing mremap_to() to bail out at "if (addr +
old_len > new_addr && new_addr + new_len > addr)"?

Also, on Linux, the main program stack is (currently) an expanding
memory mapping that starts out being something like a couple hundred
kilobytes in size. If you allocate memory too close to the main
program stack, and someone then recurses deep enough to need more
memory, the program will crash. It sounds like your patch will
randomly make such programs crash.

Also, what's your strategy in general with regards to collisions with
existing mappings? Is your intention to just fall back to the classic
algorithm in that case?

You may want to consider whether it would be better to store
information about free memory per subtree in the VMA tree, together
with the maximum gap size that is already stored in each node, and
then walk down the tree randomly, with the randomness weighted by free
memory in the subtrees, but ignoring subtrees whose gaps are too
small. And for expanding stacks, it might be a good idea for other
reasons as well (locking consistency) to refactor them such that the
size in the VMA tree corresponds to the maximum expansion of the stack
(and if an allocation is about to fail, shrink such stack mappings).
