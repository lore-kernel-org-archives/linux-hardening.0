Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD01CA0EC3
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Sep 2023 02:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbjILCum (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbjILCuc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 11 Sep 2023 22:50:32 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFA869C67
        for <linux-hardening@vger.kernel.org>; Mon, 11 Sep 2023 16:12:29 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a9a6a7a824so3234181b6e.1
        for <linux-hardening@vger.kernel.org>; Mon, 11 Sep 2023 16:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694473875; x=1695078675; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cQYSEPVjdWUsd7o+3V8/FiE1Fuh3XipjtHvOOZSgOwY=;
        b=kXBzN6DhfU18dFIaLPFVKNwiD75HF0rRDFsUzzCIcACCpaxaHYDrWbeLYiktuzAl70
         zsoQ7+VSpIuuL5KFjVhRIXPKKc4jpqVmVkXyKvaSmibRdeQxjgo1yoSCBJ6neKHJ8IrR
         FuRP0Ktgq/zjGnSpYlD9lJxoNH4jExBpj7tFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694473875; x=1695078675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQYSEPVjdWUsd7o+3V8/FiE1Fuh3XipjtHvOOZSgOwY=;
        b=JKJzyw9HQ+FJeK1ad1z1IO9l2PUVQcKd0ufj66TehLdUAR7EtR91wPb9M0nZf7Wy/J
         qaFfwv5aoYIHSyDrv7bEo7TDYTLiAFdfp/RJZDi9IBJmBrK6xvGsXDLIMJD1yd8hWG1f
         S5Nscpcr797j/CnrhrCKTCLLJv1ZiEYrInzs6BudHHXs8rSFi0EPYgVd0WJtdftZkYvb
         3Dz/+brCbizinR0P0zUUTWUmY3sLABRTyIZLfrNLAjWI81MMgefGz2SyzpvL4e4ZxBP8
         BMmtH4jG3UgthmcAlnrvuSdUegAlmbOKtsXu15zwQ3lQ6pEpT8c7+fs+Z9APFbQrYDZU
         JsdA==
X-Gm-Message-State: AOJu0YwEKCMaJtmXx2G37+YjgK+npw+wozYeOymAwuwXzFuVsnmClD3D
        pEfivl4k8qZDcvM+uYsv6Lx/invnOaywo/ipA+Y=
X-Google-Smtp-Source: AGHT+IG3HeocsPT3k/k788MsyUecmkaP+/Gvq4BeZ0yHot7638R5mqQQmQNC/GLej1PL60e+LZfgRw==
X-Received: by 2002:a17:902:e748:b0:1bb:8cb6:3f99 with SMTP id p8-20020a170902e74800b001bb8cb63f99mr1080109plf.14.1694470335094;
        Mon, 11 Sep 2023 15:12:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902778c00b001bc6536051bsm6949622pll.184.2023.09.11.15.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 15:12:14 -0700 (PDT)
Date:   Mon, 11 Sep 2023 15:12:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     jvoisin <julien.voisin@dustri.org>
Cc:     gongruiqi@huaweicloud.com, 42.hyeyoo@gmail.com,
        akpm@linux-foundation.org, aleksander.lobakin@intel.com,
        cl@linux.com, dennis@kernel.org, dvyukov@google.com,
        elver@google.com, glider@google.com, gongruiqi1@huawei.com,
        iamjoonsoo.kim@lge.com, jannh@google.com, jmorris@namei.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, paul@paul-moore.com, pedro.falcato@gmail.com,
        penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
        serge@hallyn.com, tj@kernel.org, vbabka@suse.cz,
        wangweiyang2@huawei.com, xiujianfeng@huawei.com,
        laurentsimon@google.com
Subject: Re: [PATCH v5] Randomized slab caches for kmalloc()
Message-ID: <202309111428.6F36672F57@keescook>
References: <20230714064422.3305234-1-gongruiqi@huaweicloud.com>
 <e14c547e-bb3f-4ede-8f0a-dcaa548fe5af@dustri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e14c547e-bb3f-4ede-8f0a-dcaa548fe5af@dustri.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 11, 2023 at 11:18:15PM +0200, jvoisin wrote:
> I wrote a small blogpost[1] about this series, and was told[2] that it
> would be interesting to share it on this thread, so here it is, copied
> verbatim:

Thanks for posting!

> Ruiqi Gong and Xiu Jianfeng got their
> [Randomized slab caches for
> kmalloc()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c6152940584290668b35fa0800026f6a1ae05fe)
> patch series merged upstream, and I've and enough discussions about it to
> warrant summarising them into a small blogpost.
> 
> The main idea is to have multiple slab caches, and pick one at random
> based on
> the address of code calling `kmalloc()` and a per-boot seed, to make
> heap-spraying harder.
> It's a great idea, but comes with some shortcomings for now:
> 
> - Objects being allocated via wrappers around `kmalloc()`, like
> `sock_kmalloc`,
>   `f2fs_kmalloc`, `aligned_kmalloc`, … will end up in the same slab cache.

I'd love to see some way to "unwrap" these kinds of allocators. Right
now we try to manually mark them so the debugging options can figure out
what did the allocation, but it's not complete by any means.

I'd kind of like to see a common front end that specified some set of
"do stuff" routines. e.g. to replace devm_kmalloc(), we could have:

	void *alloc(size_t usable, gfp_t flags,
		    size_t (*prepare)(size_t, gfp_t, void *ctx),
		    void * (*finish)(size_t, gfp_t, void *ctx, void *allocated)
		    void * ctx)

	ssize_t devm_prep(size_t usable, gfp_t *flags, void *ctx)
	{
		ssize_t tot_size;

		if (unlikely(check_add_overflow(sizeof(struct devres),
					size, &tot_size)))
			return -ENOMEM;

		tot_size = kmalloc_size_roundup(tot_size);
		*flags |= __GFP_ZERO;

		return tot_size;
	}

	void *devm_finish(size_t usable, gfp_t flags, void *ctx, void *allocated)
	{
		struct devres *dr = allocated;
		struct device *dev = ctx;

		INIT_LIST_HEAD(&dr->node.entry);
		dr->node.release = devm_kmalloc_release;

		set_node_dbginfo(&dr->node, "devm_kzalloc_release", usable);
		devres_add(dev, dr->data);
		return dr->data;
	}

	#define devm_kmalloc(dev, size, gfp)	\
		alloc(size, gfp, devm_prep, devm_finish, dev)

And now there's no wrapper any more, just a routine to get the actual
size, and a routine to set up the memory and return the "usable"
pointer.

> - The slabs needs to be pinned, otherwise an attacker could
> [feng-shui](https://en.wikipedia.org/wiki/Heap_feng_shui) their way
>   into having the whole slab free'ed, garbage-collected, and have a slab for
>   another type allocated at the same VA. [Jann Horn](https://thejh.net/)
> and [Matteo Rizzo](https://infosec.exchange/@nspace) have a [nice
>   set of
> patches](https://github.com/torvalds/linux/compare/master...thejh:linux:slub-virtual-upstream),
>   discussed a bit in [this Project Zero
> blogpost](https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html),
>   for a feature called [`SLAB_VIRTUAL`](
> https://github.com/torvalds/linux/commit/f3afd3a2152353be355b90f5fd4367adbf6a955e),
>   implementing precisely this.

I'm hoping this will get posted to LKML soon.

> - There are 16 slabs by default, so one chance out of 16 to end up in
> the same
>   slab cache as the target.

Future work can make this more deterministic.

> - There are no guard pages between caches, so inter-caches overflows are
>   possible.

This may be addressed by SLAB_VIRTUAL.

> - As pointed by
> [andreyknvl](https://twitter.com/andreyknvl/status/1700267669336080678)
>   and [minipli](https://infosec.exchange/@minipli/111045336853055793),
>   the fewer allocations hitting a given cache means less noise,
>   so it might even help with some heap feng-shui.

That may be true, but I suspect it'll be mitigated by the overall
reduction shared caches.

> - minipli also pointed that "randomized caches still freely
>   mix kernel allocations with user controlled ones (`xattr`, `keyctl`,
> `msg_msg`, …).
>   So even though merging is disabled for these caches, i.e. no direct
> overlap
>   with `cred_jar` etc., other object types can still be targeted (`struct
>   pipe_buffer`, BPF maps, its verifier state objects,…). It’s just a
> matter of
>   probing which allocation index the targeted object falls into.",
>   but I considered this out of scope, since it's much more involved;
>   albeit something like
> [`CONFIG_KMALLOC_SPLIT_VARSIZE`](https://github.com/thejh/linux/blob/slub-virtual/MITIGATION_README)
>   wouldn't significantly increase complexity.

Now that we have a mechanism to easily deal with "many kmalloc buckets",
I think we can easily start carving out specific variable-sized caches
(like msg_msg). Basically doing a manual type-based separation.

So, yeah, we're in a better place that we were before, and better
positioned to continue to make improvements here. I think an easy win
would be doing this last one: separate out the user controlled
variable-sized caches and give them their own distinct buckets outside
of the 16 random ones. Can you give that a try and send patches?

-Kees

-- 
Kees Cook
