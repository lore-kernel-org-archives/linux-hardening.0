Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71122FA373E
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Oct 2022 18:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiJYSiL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Oct 2022 14:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiJYSiK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Oct 2022 14:38:10 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E5DF53D3
        for <linux-hardening@vger.kernel.org>; Tue, 25 Oct 2022 11:38:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b11so5572974pjp.2
        for <linux-hardening@vger.kernel.org>; Tue, 25 Oct 2022 11:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6v7OmtMJ2b16XOxoV0FAPi5R9UZMGGxZ5W+ahrXitU=;
        b=acruGIdn9/xBNnQh1BycNFAI8FriRd/SRPwLinDXVN7o5iRN9oVVanxX4jocckw8KE
         rrBPuGxGWZ6Cez1O8LJl8D6ply4tTfSQNhWiQMsDvh5dJmerpIlgmpxfcO7HCTqyhiz1
         5iKemh60aO1Vx52mirB7pUeRtXXBIv5O+XBxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6v7OmtMJ2b16XOxoV0FAPi5R9UZMGGxZ5W+ahrXitU=;
        b=2c89uU3nTa5AbuRc0zW241stZY0fi+szwTtm8rjDbdmSfJU8ODI1NhLVGk16UUa3pt
         u0LRb1trfGNkdPpOd6HmNQWLjajltg+sc0z6aKzageh5dKyrxmO3AKwq8+H6vAhw82cq
         lW9F8yz361crwBGpL/mDB5iXk1kI/8OTuIp+wweY5qFpVlTz655zqd0ukJLMGSfzCWSV
         jSqExD6BCLTZpzv1MArbU7Y96/ILIyfdXbxVE4ByzDeVDcTv41OCE0Kut6fJFLNi9qsk
         1dyUI+aQOakCWcOcm/8TKVo6yKN1BQqSs5dqc0yYtnAb5LbMEyfyCdcMfmF23xae8vwl
         smrg==
X-Gm-Message-State: ACrzQf1Mxs7o/G+9cJTz+KGa3KFRl3D96VSD1Pzrt7Fom4t9S5Y01kiq
        W9lECzGhviW+SeM8UK9CRCTW6w==
X-Google-Smtp-Source: AMsMyM5rGUo3WGRSfCNWAsvk0fN3/AawwDye31UvQzmNmzr7avz0RZdscsKFX344zjBDmEmPlJNpAA==
X-Received: by 2002:a17:903:181:b0:185:5696:97c2 with SMTP id z1-20020a170903018100b00185569697c2mr39858718plg.160.1666723088910;
        Tue, 25 Oct 2022 11:38:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3-20020a63fd43000000b004393c5a8006sm1568091pgj.75.2022.10.25.11.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 11:38:08 -0700 (PDT)
Date:   Tue, 25 Oct 2022 11:38:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm: Make ksize() a reporting-only function
Message-ID: <202210251125.BAE72214E2@keescook>
References: <20221022180455.never.023-kees@kernel.org>
 <fabffcfd-4e7f-a4b8-69ac-2865ead36598@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fabffcfd-4e7f-a4b8-69ac-2865ead36598@suse.cz>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 25, 2022 at 01:53:54PM +0200, Vlastimil Babka wrote:
> On 10/22/22 20:08, Kees Cook wrote:
> > With all "silently resizing" callers of ksize() refactored, remove the
> > logic in ksize() that would allow it to be used to effectively change
> > the size of an allocation (bypassing __alloc_size hints, etc). Users
> > wanting this feature need to either use kmalloc_size_roundup() before an
> > allocation, or use krealloc() directly.
> > 
> > For kfree_sensitive(), move the unpoisoning logic inline. Replace the
> > some of the partially open-coded ksize() in __do_krealloc with ksize()
> > now that it doesn't perform unpoisoning.
> > 
> > [...]
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> > ---
> > This requires at least this be landed first:
> > https://lore.kernel.org/lkml/20221021234713.you.031-kees@kernel.org/
> 
> Don't we need all parts to have landed first, even if the skbuff one is the
> most prominent?

Yes, though, I suspect there will be some cases we couldn't easily find.

Here are the prerequisites I'm aware of:

in -next:
  36875a063b5e ("net: ipa: Proactively round up to kmalloc bucket size")
  ab3f7828c979 ("openvswitch: Use kmalloc_size_roundup() to match ksize() usage")
  d6dd508080a3 ("bnx2: Use kmalloc_size_roundup() to match ksize() usage")

reviewed, waiting to land (should I take these myself?)
  btrfs: send: Proactively round up to kmalloc bucket size
    https://lore.kernel.org/lkml/20220923202822.2667581-8-keescook@chromium.org/
  dma-buf: Proactively round up to kmalloc bucket size
    https://lore.kernel.org/lkml/20221018090858.never.941-kees@kernel.org/

partially reviewed:
  igb: Proactively round up to kmalloc bucket size
    https://lore.kernel.org/lkml/20221018092340.never.556-kees@kernel.org/

unreviewed:
  coredump: Proactively round up to kmalloc bucket size
    https://lore.kernel.org/lkml/20221018090701.never.996-kees@kernel.org/
  devres: Use kmalloc_size_roundup() to match ksize() usage
    https://lore.kernel.org/lkml/20221018090406.never.856-kees@kernel.org/

needs updating:
  mempool: Use kmalloc_size_roundup() to match ksize() usage
    https://lore.kernel.org/lkml/20221018090323.never.897-kees@kernel.org/
  bpf: Use kmalloc_size_roundup() to match ksize() usage
    https://lore.kernel.org/lkml/20221018090550.never.834-kees@kernel.org/

-- 
Kees Cook
