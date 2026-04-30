Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCFE40B6F4;
	Thu, 30 Apr 2026 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554227; cv=none; b=ahD1HG9h9FUWCHGsBq/dRbcBYouoBYzeMn8lSZ4Dc/hL7CIl5zwZq6LBlxHzI4En2Eta0kr4z6JoQJsShiVnRLxiEyl15XKAEMQefKTNolmVGXmCQVZ9vmX7CDEgIDVGqO0j07nUJOsBlpMuOi6b1axhV0QMe/xcAayxh6JuSG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554227; c=relaxed/simple;
	bh=cBQTATODAw7GU5owkTlr0LLrjvqtSjmzxEuiN88xSno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjr8JL0voywVTI9PfrhSmqlXAihKXmsMe024oXhgaBerVveFno3TEfX3vkmwiYtlIcXzSnTAb0JhXWGeSaATjM4SFjnskAHmXces5dLMGSF9b6hZwhd9nvMzKDv0cseOOVk/dmz7T1rxQjEgwPW9obTpaXYZRuU34Rv9F2p27SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/GHjLbS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/GHjLbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CC1C2BCB3;
	Thu, 30 Apr 2026 13:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777554226;
	bh=cBQTATODAw7GU5owkTlr0LLrjvqtSjmzxEuiN88xSno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P/GHjLbSzFjFrlVHylyxgW146QEiVuSbq9zns8CvEtQWM6rfKglawHpEP2u9xPcYD
	 n3OBk3+Ewlgqev591zz+QCAQgiLG/qP61tXvzAfUfEQLwdQHwTwAU25Aj5LWtq0ssC
	 Py4+RuG35KzGqQGDwDYrQBdOVZdxd0CJdMkCftbMMRJ+Vn4lj8BMpYe90ygfYSWXhL
	 QBkmykY+5Edz3mfHgsWFepJ+dgw1c9jtCr9bUrTjjQDuGQo/DV+Ac3KfT2VPxfrHbG
	 MQEorLNtV9QSlJs1xBmN8laC9jqntUFj6tSOuoQZVm/5hfg77vKNKa3lfHUZSpajL8
	 F0h9gjQtxZnXA==
Message-ID: <6f2bd63a-dc02-4631-a3a5-7ec8e58a4a4e@kernel.org>
Date: Thu, 30 Apr 2026 15:03:38 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] slab: support for compiler-assisted type-based
 slab cache partitioning
Content-Language: en-US
To: Marco Elver <elver@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@gentwo.org>, Harry Yoo <harry@kernel.org>,
 Hao Li <hao.li@linux.dev>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Alexander Potapenko <glider@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com,
 llvm@lists.linux.dev, Andrey Konovalov <andreyknvl@gmail.com>,
 Florent Revest <revest@google.com>, Jann Horn <jannh@google.com>,
 KP Singh <kpsingh@kernel.org>, Matteo Rizzo <matteorizzo@google.com>,
 GONG Ruiqi <gongruiqi1@huawei.com>
References: <20260424132427.2703076-1-elver@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260424132427.2703076-1-elver@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/26 15:24, Marco Elver wrote:

> @@ -938,7 +968,7 @@ void *__kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
>   *	Try really hard to succeed the allocation but fail
>   *	eventually.
>   */
> -static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t flags)
> +static __always_inline __alloc_size(1) void *_kmalloc_noprof(size_t size, gfp_t flags, kmalloc_token_t token)
>  {
>  	if (__builtin_constant_p(size) && size) {
>  		unsigned int index;
> @@ -948,14 +978,16 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
>  
>  		index = kmalloc_index(size);
>  		return __kmalloc_cache_noprof(
> -				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
> +				kmalloc_caches[kmalloc_type(flags, token)][index],

While reviewing this, it occured to me we might have been using _RET_IP_
here in a suboptimal way ever since this was introduced. Since this is all
inlined, shouldn't have we been using _THIS_IP_ to really randomize using
the kmalloc() callsite, and not its parent?

And after this patch, we get the token passed to _kmalloc_noprof()...

>  				flags, size);
>  	}
> -	return __kmalloc_noprof(size, flags);
> +	return __kmalloc_noprof(PASS_KMALLOC_PARAMS(size, NULL, token), flags);

... and used also here for the non-constant-size, where previously
__kmalloc_noprof() (not inline function) would correctly use _RET_IP_ on its
own ...

>  }
> +#define kmalloc_noprof(...)			_kmalloc_noprof(__VA_ARGS__, __kmalloc_token(__VA_ARGS__))

... and the token comes from here. With random partitioning that's
#define __kmalloc_token(...) ((kmalloc_token_t){ .v = _RET_IP_ })

so that AFAIK makes the situation worse as now the cases without constant
size also start randomizing by the parent callsite and not the kmalloc callsite.

But there are many users of __kmalloc_token() and maybe some are corrent in
using _RET_IP_, I haven't checked, maybe we'll need two variants, or further
change things around.

>  #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
>  
> -void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
> +void *_kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_flags, int node);
> +#define kmalloc_nolock_noprof(_s, _f, _n)	_kmalloc_nolock_noprof(PASS_TOKEN_PARAMS(_s, __kmalloc_token(_s)), _f, _n)
>  #define kmalloc_nolock(...)			alloc_hooks(kmalloc_nolock_noprof(__VA_ARGS__))
>  
>  /**

<snip>

>  
> -#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> -#define __KMALLOC_RANDOM_CONCAT(a, b) a ## b
> -#define KMALLOC_RANDOM_NAME(N, sz) __KMALLOC_RANDOM_CONCAT(KMA_RAND_, N)(sz)
> -#define KMA_RAND_1(sz)                  .name[KMALLOC_RANDOM_START +  1] = "kmalloc-rnd-01-" #sz,
> -#define KMA_RAND_2(sz)  KMA_RAND_1(sz)  .name[KMALLOC_RANDOM_START +  2] = "kmalloc-rnd-02-" #sz,
> -#define KMA_RAND_3(sz)  KMA_RAND_2(sz)  .name[KMALLOC_RANDOM_START +  3] = "kmalloc-rnd-03-" #sz,
> -#define KMA_RAND_4(sz)  KMA_RAND_3(sz)  .name[KMALLOC_RANDOM_START +  4] = "kmalloc-rnd-04-" #sz,
> -#define KMA_RAND_5(sz)  KMA_RAND_4(sz)  .name[KMALLOC_RANDOM_START +  5] = "kmalloc-rnd-05-" #sz,
> -#define KMA_RAND_6(sz)  KMA_RAND_5(sz)  .name[KMALLOC_RANDOM_START +  6] = "kmalloc-rnd-06-" #sz,
> -#define KMA_RAND_7(sz)  KMA_RAND_6(sz)  .name[KMALLOC_RANDOM_START +  7] = "kmalloc-rnd-07-" #sz,
> -#define KMA_RAND_8(sz)  KMA_RAND_7(sz)  .name[KMALLOC_RANDOM_START +  8] = "kmalloc-rnd-08-" #sz,
> -#define KMA_RAND_9(sz)  KMA_RAND_8(sz)  .name[KMALLOC_RANDOM_START +  9] = "kmalloc-rnd-09-" #sz,
> -#define KMA_RAND_10(sz) KMA_RAND_9(sz)  .name[KMALLOC_RANDOM_START + 10] = "kmalloc-rnd-10-" #sz,
> -#define KMA_RAND_11(sz) KMA_RAND_10(sz) .name[KMALLOC_RANDOM_START + 11] = "kmalloc-rnd-11-" #sz,
> -#define KMA_RAND_12(sz) KMA_RAND_11(sz) .name[KMALLOC_RANDOM_START + 12] = "kmalloc-rnd-12-" #sz,
> -#define KMA_RAND_13(sz) KMA_RAND_12(sz) .name[KMALLOC_RANDOM_START + 13] = "kmalloc-rnd-13-" #sz,
> -#define KMA_RAND_14(sz) KMA_RAND_13(sz) .name[KMALLOC_RANDOM_START + 14] = "kmalloc-rnd-14-" #sz,
> -#define KMA_RAND_15(sz) KMA_RAND_14(sz) .name[KMALLOC_RANDOM_START + 15] = "kmalloc-rnd-15-" #sz,
> -#else // CONFIG_RANDOM_KMALLOC_CACHES
> -#define KMALLOC_RANDOM_NAME(N, sz)
> +#ifdef CONFIG_KMALLOC_PARTITION_CACHES
> +#define __KMALLOC_PARTITION_CONCAT(a, b) a ## b
> +#define KMALLOC_PARTITION_NAME(N, sz) __KMALLOC_PARTITION_CONCAT(KMA_PART_, N)(sz)
> +#define KMA_PART_1(sz)                  .name[KMALLOC_PARTITION_START +  1] = "kmalloc-part-01-" #sz,
> +#define KMA_PART_2(sz)  KMA_PART_1(sz)  .name[KMALLOC_PARTITION_START +  2] = "kmalloc-part-02-" #sz,
> +#define KMA_PART_3(sz)  KMA_PART_2(sz)  .name[KMALLOC_PARTITION_START +  3] = "kmalloc-part-03-" #sz,
> +#define KMA_PART_4(sz)  KMA_PART_3(sz)  .name[KMALLOC_PARTITION_START +  4] = "kmalloc-part-04-" #sz,
> +#define KMA_PART_5(sz)  KMA_PART_4(sz)  .name[KMALLOC_PARTITION_START +  5] = "kmalloc-part-05-" #sz,
> +#define KMA_PART_6(sz)  KMA_PART_5(sz)  .name[KMALLOC_PARTITION_START +  6] = "kmalloc-part-06-" #sz,
> +#define KMA_PART_7(sz)  KMA_PART_6(sz)  .name[KMALLOC_PARTITION_START +  7] = "kmalloc-part-07-" #sz,
> +#define KMA_PART_8(sz)  KMA_PART_7(sz)  .name[KMALLOC_PARTITION_START +  8] = "kmalloc-part-08-" #sz,
> +#define KMA_PART_9(sz)  KMA_PART_8(sz)  .name[KMALLOC_PARTITION_START +  9] = "kmalloc-part-09-" #sz,
> +#define KMA_PART_10(sz) KMA_PART_9(sz)  .name[KMALLOC_PARTITION_START + 10] = "kmalloc-part-10-" #sz,
> +#define KMA_PART_11(sz) KMA_PART_10(sz) .name[KMALLOC_PARTITION_START + 11] = "kmalloc-part-11-" #sz,
> +#define KMA_PART_12(sz) KMA_PART_11(sz) .name[KMALLOC_PARTITION_START + 12] = "kmalloc-part-12-" #sz,
> +#define KMA_PART_13(sz) KMA_PART_12(sz) .name[KMALLOC_PARTITION_START + 13] = "kmalloc-part-13-" #sz,
> +#define KMA_PART_14(sz) KMA_PART_13(sz) .name[KMALLOC_PARTITION_START + 14] = "kmalloc-part-14-" #sz,
> +#define KMA_PART_15(sz) KMA_PART_14(sz) .name[KMALLOC_PARTITION_START + 15] = "kmalloc-part-15-" #sz,
> +#else // CONFIG_KMALLOC_PARTITION_CACHES
> +#define KMALLOC_PARTITION_NAME(N, sz)
>  #endif

We're renaming the caches visible in /proc/slabinfo. Maybe it's fine as
people who care will just adapt their tools without complaining. Not the
first time we've changes something here.


