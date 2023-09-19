Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CA1CE79A8
	for <linux-hardening@archiver.kernel.org>; Tue, 19 Sep 2023 15:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjISPtD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 19 Sep 2023 11:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjISPtC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 19 Sep 2023 11:49:02 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4404C93
        for <linux-hardening@vger.kernel.org>; Tue, 19 Sep 2023 08:48:56 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76e09202322so395096785a.3
        for <linux-hardening@vger.kernel.org>; Tue, 19 Sep 2023 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695138535; x=1695743335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FUFBX34Vi8T0jyulMhlIaJzOiGzxRBHm/K7XuTUIix8=;
        b=2C5Kk5jBdwO+wUlff1qDFpyRMIcxfsXG0zhn/m974GNZGjX0pAGZ6eSmSFEL0OW4bt
         +8T3IDEao5L9LIn8uOR2xPdvTjkQgjJaPrIXIPdO1SxL/wjgm8xAs0Ooydb03PEG5sF6
         dI43xBKUG72kujk/cfWdrPhLq3azvQM5I6g0zJFNtxJzUVD+QbsR8Zwe7lLQOKUZ7DEd
         KKsqvH6IBzbttJHVieNhDfxhqZHTpzVmEtQ/yKALHmq659qZNdJX8ZA2AU9SfO0lta+1
         fYwoN8+tVm+97N72m2yF+c3z67fWIF6fa+VxKaZmNbzHHdCeNuaM46rHrk0m0I5aQEvZ
         98EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695138535; x=1695743335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUFBX34Vi8T0jyulMhlIaJzOiGzxRBHm/K7XuTUIix8=;
        b=eaXfPXW0iPwKK5sgsmmFBFuSJYTOugoMVmDMRQ7ueUJk+e7BbG0GmiDHtx14Xt3FIe
         r1dRtLz5ICTm8Os6wWJ5u2BU5HiOnv97PWPqmYpOjWNi3wbSI1D9NNsYdbPfrBgIoJ+4
         3m0l26c5FmfDx2ZHPCpECa4AMGcApcXT+DbiD43ieSOtRy1rWn6WS+pYUneLGxot1o5C
         0No80PnHFYw+NTYjQS1KBkH3uTYj61EBhlxRq/1wc8zWRDf5/HQXlTMaIbulGAagpV5r
         s2NThEGsm1ejnJ8rn4UEwywUZBHQxKUhgETgQYtd8VdRb9+/M+j6sB1f5RtNfraY8aH8
         6U4w==
X-Gm-Message-State: AOJu0YxCu12lvhh6Tx/qAMvLuKcpHw1JwPrXmKTROhfXi/EZSDslY5C2
        aGaHfoGdpgSXDSZJE+yPrj3IIRxtteNZ7kppavu6B6+F5loD9BJrsdG2MJlK
X-Google-Smtp-Source: AGHT+IE3bOOMkBS+atNtSPIXMOTa2Ld22Qs9HTCkKcTaipggWake8IjLOlnyddu6BbylehDROBRn01dZ36CiD5ewpnY=
X-Received: by 2002:a05:6214:5d0e:b0:658:2d42:75e4 with SMTP id
 me14-20020a0562145d0e00b006582d4275e4mr4698272qvb.47.1695138535174; Tue, 19
 Sep 2023 08:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
 <7a4f5128-28fd-3c5f-34c2-1c34f4448174@intel.com> <1d7573c0-ebbc-6ed2-f152-1045eb0542f9@os.amperecomputing.com>
 <CAHKB1w+rVyww0UrHhzeGfPA7FM482Z-7ApzXvekVqLHvTDAV3Q@mail.gmail.com>
 <ZQiLX0W2Tcr+wdJT@gmail.com> <CAHk-=wgGzB4u-WZsDpdgjwX1w5=9CLE0gorhaNFD09P1FUGeuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgGzB4u-WZsDpdgjwX1w5=9CLE0gorhaNFD09P1FUGeuQ@mail.gmail.com>
From:   Matteo Rizzo <matteorizzo@google.com>
Date:   Tue, 19 Sep 2023 17:48:42 +0200
Message-ID: <CAHKB1w+9GgY_e6J+rZ4zDaXrPZab5xteTuDEH0Z2hWe6x-pT5g@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Prevent cross-cache attacks in the SLUB allocator
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>,
        Dave Hansen <dave.hansen@intel.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org, jannh@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 18 Sept 2023 at 20:05, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> ... and equally importantly, what about DMA?

I'm not exactly sure what you mean by this, I don't think this should
affect the performance of DMA.

> Or what about the fixed-size slabs (aka kmalloc?) What's the point of
> "never re-use the same address for a different slab", when the *same*
> slab will contain different kinds of allocations anyway?

There are a number of patches out there (for example the random_kmalloc
series which recently got merged into v6.6) which attempt to segregate
kmalloc'd objects into different caches to make exploitation harder.
Another thing that we would like to have in the future is to segregate
objects by type (like XNU's kalloc_type
https://security.apple.com/blog/towards-the-next-generation-of-xnu-memory-safety/)
which makes exploiting use-after-free by type confusion much harder or
impossible.

All of these mitigations can be bypassed very easily if the attacker can
mount a cross-cache attack, which is what this series attempts to prevent.
This is not only theoretical, we've seen attackers use this all the time in
kCTF/kernelCTF submissions (for example
https://ruia-ruia.github.io/2022/08/05/CVE-2022-29582-io-uring/).

> I think the whole "make it one single compile-time option" model is
> completely and fundamentally broken.

Wouldn't making this toggleable at boot time or runtime make performance
even worse?

--
Matteo
