Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D0D2D1F40;
	Mon, 21 Sep 2026 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997161; cv=none; b=tST2NESHKcqLk9F4aXr5rigLCsbO34xr/zURbtw3wUk52Wddr5ziyUAnsqM5u3VnpgydEHdcZChjg8NDZOoHA6SsXQs2uci+OTZIZg6h3lUwOR0TRPDk60zV8ncVVVvysH05zslMvRwD9+ZEGYjC18RnDv3O99DSolHXlIEbcJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997161; c=relaxed/simple;
	bh=aYT/iyOMEgHj4yw3FJVCVyq3YjOS6CPp2Yeui/eo/go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhauxXs2iHDAPMmDzl6RRvqqAHunckoYbTP4Di6mAU3Ho9BTbAzZfcv6oNt1ikrHBJdq9af8u040FrXMcH/Nhge45pwu9d3UEONA5t4287DvdMIpdvUJTz876zopmYQncruK9i+2CUEA8z51MjMkkibmy5goVfB89ydxbGp+FkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpJoC3Mz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpJoC3Mz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ABF1F000FF;
	Mon, 21 Sep 2026 13:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789997159;
	bh=nha8ML1H2R/fcgwZZbQPRhZtrvRZFsoDZhBO+DEOQYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hpJoC3Mzq7wrz0POCEfSBz/THghFV/1UuOP96ueguC1IWtsaaCw1hl2On2e0gqGZH
	 4cxUib8+dZJEVj76tS8YCx8JopQ7260IhSMfPBpgSoyY/3EbuxVyc1B2PRhlb+zDuC
	 0qLOTQe5MVh39Zd43qG1+7gjkJJkr9/eJHznJlQfYBhf53YilE6Gp4ataI5yLzrntG
	 7BiGtB8EgjOSwmnYtxKW3v0OsA1YsjTN7ubyYEe9ql5crvYSVmOlzbk0zqJUimvOmJ
	 a/EGup8aLynu8hNlSzoRiqa+zAk+pC0nlNzzoDAxmQK0Q/PThNESdnCPbNNHNu+UyA
	 qpDCowVNO0jWw==
Date: Mon, 21 Sep 2026 14:25:57 +0100
From: Harry Yoo <harry@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	Pedro Falcato <pfalcato@suse.de>, Kuniyuki Iwashima <kuniyu@google.com>, 
	linux-hardening@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 6/7] mm/slab: Let a bucket set handle __GFP_ACCOUNT
Message-ID: <arEvspsSl3bLyYgs@thinkstation>
References: <20260921075811.too.775-kees@kernel.org>
 <20260921075820.1718334-6-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921075820.1718334-6-kees@kernel.org>

On Mon, Sep 21, 2026 at 12:58:17AM -0700, Kees Cook wrote:
> A bucket set holds one row of caches, cloned from KMALLOC_NORMAL, and an
> allocation of any other kmalloc type falls back to the general caches.
> Extend this to handle __GFP_ACCOUNT, so that a single bucket user can
> isolate either GFP_KERNEL or GFP_KERNEL_ACCOUNT allocations, as is
> needed for skb data, where AF_UNIX uses:
> 
> 	sk->sk_allocation = GFP_KERNEL_ACCOUNT;
> 
> The coverage is selected at bucket creation time:
> 
> 	b = kmem_buckets_create_types(name, flags, 0, INT_MAX, NULL,
> 				      BIT(KMEM_BUCKET_NORMAL) |
> 				      BIT(KMEM_BUCKET_CGROUP));
> 
> The prior kmem_buckets_create() function keeps its name and defaults
> to only KMEM_BUCKET_NORMAL, leaving existing users as-is.
> 
> Only the accounted type is offered. Nothing wants a reclaimable or
> no-obj-ext row, and of the twelve places passing GFP_DMA to an skb
> allocator, all rare hardware: b44, b43legacy, prestera and s390 ctcm.
> 
> The choice is made at creation rather than every set getting every type
> because the rows, when populated, are not free. Each holds 13 caches, and
> a cache is a 1208 byte struct plus an unconditional per-cpu allocation,
> a node struct, and an entry in /proc/slabinfo and under /sys/kernel/slab.
> 
> KMEM_BUCKET_CGROUP collapses to KMEM_BUCKET_NORMAL without CONFIG_MEMCG,
> exactly as KMALLOC_CGROUP does, so NR_KMEM_BUCKET_TYPES is 1 there and a
> bucket set is the same single row it is today. Where the type is asked for
> but the system is not creating caches of it (under "cgroup.memory=nokmem")
> the row is aliased to the normal one, as new_kmalloc_cache() does for the
> general caches, so those allocations stay isolated rather than falling
> back to the general caches.
> 
> Built and tests pass (and skip as expected) on ARCH=x86_64 defconfig
> with GCC 16.2.0 in all combinations of CONFIG_SLAB_BUCKETS=y/n and
> CONFIG_MEMCG=y/n/y+"cgroup.memory=nokmem".
> 
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Harry Yoo <harry@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hao Li <hao.li@linux.dev>
> Cc: Christoph Lameter <cl@gentwo.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: <linux-mm@kvack.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: <linux-hardening@vger.kernel.org>
> ---
>  include/linux/slab.h   |  45 ++++++++++++-
>  mm/slab.h              |  23 ++++++-
>  lib/tests/slub_kunit.c |  65 +++++++++++++++---
>  mm/slab_common.c       | 145 ++++++++++++++++++++++++++++++++---------
>  4 files changed, 235 insertions(+), 43 deletions(-)
> 
> diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
> index 823607e06248..58f800582170 100644
> --- a/lib/tests/slub_kunit.c
> +++ b/lib/tests/slub_kunit.c
> @@ -723,15 +723,63 @@ static void test_kmem_buckets_type_fallback(struct kunit *test)
>  				      "expected a DMA cache, got %s", c->name);
>  	}
>  
> -	/* Nor can one that has to be accounted. */
> -	if (IS_ENABLED(CONFIG_MEMCG) && !mem_cgroup_kmem_disabled()) {


Didn't take a deeper look at this yet but this is causing an error:

MODPOST Module.symvers
ERROR: modpost: lib/tests/slub_kunit.ko: symbol 'mem_cgroup_kmem_disabled' undefined!
make[3]: *** [../scripts/Makefile.modpost:147: Module.symvers] Error 1
make[2]: *** [/var/lib/jenkins/agent/workspace/harry-linux/ARCH/x86_64/COMPILER/clang/DEBUG/light/PREEMPT/lazy/src/Makefile:2179: modpost] Error 2
make[1]: *** [/var/lib/jenkins/agent/workspace/harry-linux/ARCH/x86_64/COMPILER/clang/DEBUG/light/PREEMPT/lazy/src/Makefile:248: __sub-make] Error 2
make[1]: Leaving directory '/var/lib/jenkins/agent/workspace/harry-linux/ARCH/x86_64/COMPILER/clang/DEBUG/light/PREEMPT/lazy/src/build'
make: *** [Makefile:248: __sub-make] Error 2
Build step 'Execute shell' marked build as failure

-- 
Cheers,
Harry / Hyeonggon
