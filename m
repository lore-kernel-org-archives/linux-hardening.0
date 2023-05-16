Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD0FC77B7F
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 19:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjEPTeQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 15:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEPTeP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 15:34:15 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F753C33
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 12:34:13 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64388cf3263so10350383b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684265653; x=1686857653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NjomB45/tUXiCEV6Zx/tTP1f+pkWwWrPq8cCPi1RJqc=;
        b=bNHc1U0CtPLI3FNYS2/3S7VOUmvNc8ETG2uTFHiP/LSmRcJAmNmEa1HQKz+0QsyCYV
         3LJuktipJLdpM/MdCXUc32xdnPqgSUNSmKg5rGOpcm325DRNUYPUPtaRhkMspnvwt+oR
         bB+y6nAPpHmohxYRaYqX0u/i97y1iy2CyL9sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684265653; x=1686857653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjomB45/tUXiCEV6Zx/tTP1f+pkWwWrPq8cCPi1RJqc=;
        b=OMfkD1ra41nzkoCZQcP+fHnVn8EC8H2Db/hDVHhPFZQ+nKBRdj/vPu5cWPILtpnHjs
         N+3UAFJ4IlrWHJV+tS/ADPbiNQIwHa0FVyfvysDjWdHSZVPimKFDkuz2yWdHwlBgaQfV
         hvJ/Aj8YFbDaOqbeJctnfYUXapeXFkbaSfvQPfgtQ4OkoHGZOtlSnUcAeyc6AZx2kykN
         7mCMWxu4Zlqc7crKTzaq0thMY7NuoNyfNQAJDzDU9wgZNtVjE5vc1BLGVEWJIayOx8CO
         KOZP62vXlLYUZ3n19ieGWzqxnjvJcpGdGFwS6KQ0HzZ+i6fFI9IoH2XrQLfqMh1tKP0x
         9M3A==
X-Gm-Message-State: AC+VfDxb7IvG3XZc0ntHLR8gTeNX9GZrQBeIAmbAPp5S5gs4vE7r9ErE
        u7TtsUw7s1lqF2AyC/HU4jdG1Q==
X-Google-Smtp-Source: ACHHUZ58B7WESNKne+9oMKYnTHer8L35nMXOvyVf4ZrSBq07pY0pLhMKLIfNUzXFqoCSIzJ7rgsnDw==
X-Received: by 2002:a05:6a00:1141:b0:64a:ff32:7349 with SMTP id b1-20020a056a00114100b0064aff327349mr16158832pfm.32.1684265652878;
        Tue, 16 May 2023 12:34:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g19-20020aa78753000000b00634b91326a9sm14259716pfo.143.2023.05.16.12.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 12:34:12 -0700 (PDT)
Date:   Tue, 16 May 2023 12:34:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>, Jann Horn <jannh@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        kasan-dev@googlegroups.com, Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH RFC v2] Randomized slab caches for kmalloc()
Message-ID: <202305161204.CB4A87C13@keescook>
References: <20230508075507.1720950-1-gongruiqi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508075507.1720950-1-gongruiqi1@huawei.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

For new CCs, the start of this thread is here[0].

On Mon, May 08, 2023 at 03:55:07PM +0800, GONG, Ruiqi wrote:
> When exploiting memory vulnerabilities, "heap spraying" is a common
> technique targeting those related to dynamic memory allocation (i.e. the
> "heap"), and it plays an important role in a successful exploitation.
> Basically, it is to overwrite the memory area of vulnerable object by
> triggering allocation in other subsystems or modules and therefore
> getting a reference to the targeted memory location. It's usable on
> various types of vulnerablity including use after free (UAF), heap out-
> of-bound write and etc.

I heartily agree we need some better approaches to deal with UAF, and
by extension, heap spraying.

> There are (at least) two reasons why the heap can be sprayed: 1) generic
> slab caches are shared among different subsystems and modules, and
> 2) dedicated slab caches could be merged with the generic ones.
> Currently these two factors cannot be prevented at a low cost: the first
> one is a widely used memory allocation mechanism, and shutting down slab
> merging completely via `slub_nomerge` would be overkill.
> 
> To efficiently prevent heap spraying, we propose the following approach:
> to create multiple copies of generic slab caches that will never be
> merged, and random one of them will be used at allocation. The random
> selection is based on the address of code that calls `kmalloc()`, which
> means it is static at runtime (rather than dynamically determined at
> each time of allocation, which could be bypassed by repeatedly spraying
> in brute force). In this way, the vulnerable object and memory allocated
> in other subsystems and modules will (most probably) be on different
> slab caches, which prevents the object from being sprayed.

This is a nice balance between the best option we have now
("slub_nomerge") and most invasive changes (type-based allocation
segregation, which requires at least extensive compiler support),
forcing some caches to be "out of reach".

> 
> The overhead of performance has been tested on a 40-core x86 server by
> comparing the results of `perf bench all` between the kernels with and
> without this patch based on the latest linux-next kernel, which shows
> minor difference. A subset of benchmarks are listed below:
> 
> 			control		experiment (avg of 3 samples)
> sched/messaging (sec)	0.019		0.019
> sched/pipe (sec)	5.253		5.340
> syscall/basic (sec)	0.741		0.742
> mem/memcpy (GB/sec)	15.258789	14.860495
> mem/memset (GB/sec)	48.828125	50.431069
> 
> The overhead of memory usage was measured by executing `free` after boot
> on a QEMU VM with 1GB total memory, and as expected, it's positively
> correlated with # of cache copies:
> 
> 		control		4 copies	8 copies	16 copies
> total		969.8M		968.2M		968.2M		968.2M
> used		20.0M		21.9M		24.1M		26.7M
> free		936.9M		933.6M		931.4M		928.6M
> available	932.2M		928.8M		926.6M		923.9M

Great to see the impact: it's relatively tiny. Nice!

Back when we looked at cache quarantines, Jann pointed out that it
was still possible to perform heap spraying -- it just needed more
allocations. In this case, I think that's addressed (probabilistically)
by making it less likely that a cache where a UAF is reachable is merged
with something with strong exploitation primitives (e.g. msgsnd).

In light of all the UAF attack/defense breakdowns in Jann's blog
post[1], I'm curious where this defense lands. It seems like it would
keep the primitives described there (i.e. "upgrading" the heap spray
into a page table "type confusion") would be addressed probabilistically
just like any other style of attack. Jann, what do you think, and how
does it compare to the KCTF work[2] you've been doing?

In addition to this work, I'd like to see something like the kmalloc
caches, but for kmem_cache_alloc(), where a dedicated cache of
variably-sized allocations can be managed. With that, we can split off
_dedicated_ caches where we know there are strong exploitation
primitives (i.e. msgsnd, etc). Then we can carve off known weak heap
allocation caches as well as make merging probabilistically harder.

I imagine it would be possible to then split this series into two
halves: one that creates the "make arbitrary-sized caches" API, and the
second that applies that to kmalloc globally (as done here).

> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
> 
> v2:
>   - Use hash_64() and a per-boot random seed to select kmalloc() caches.

This is good: I was hoping there would be something to make it per-boot
randomized beyond just compile-time.

So, yes, I think this is worth it, but I'd like to see what design holes
Jann can poke in it first. :)

-Kees

[0] https://lore.kernel.org/lkml/20230508075507.1720950-1-gongruiqi1@huawei.com/
[1] https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html
[2] https://github.com/thejh/linux/commit/a87ad16046f6f7fd61080ebfb93753366466b761

-- 
Kees Cook
