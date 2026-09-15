Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E0409281;
	Tue, 15 Sep 2026 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455402; cv=none; b=Yhs4qBzCRujwyws2V9FmUDiUeObIQe+vGfW4usRF+oM9q0K2a6ofm+2u3aLpkEymnLPt3MLnWVZeotPw/kR40Rngm/aBZqoLEaJwPpVGqjMVpJCA8j/BKt+fEabcgxXKM8HrBSnAKkyUNXc2/qA6pDNGEVvEsDNdAiz9NLmiR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455402; c=relaxed/simple;
	bh=NeRBepR5Zz7RMQ5iLba4Tw0X/ZIZN1DT6n2hYyHWm34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ED0TuMxFFenRBxT+O8Fx733bqh6uuNciUe+tnC5WANsVPQk7sZG+DT1MuAiw5jn2q+NLYaLOR9NW6vUOwiOMYz3M9iYQ4BcFbPXXG5YnH2J1Mjvqn+UUwcnnOF6m4O68Q7/uH9YTsWG9Zx5M156Lwjnp9pgiGptBhejuefYq6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opLVeqeS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opLVeqeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEBA1F000FF;
	Tue, 15 Sep 2026 06:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789455401;
	bh=iUEddWOFS6fHOKRXcDJByNFtvflAjvsvy6k9vJ5MeeA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=opLVeqeSzjUOWD0xEMAImiR1vGyYsNRwzSINVrs0Y80Qg2LwBZDphmrn2M4SV1Nyb
	 /8pF3RZ8meeD53mow/pnbwsz5co4vUanf8laLU+l1kO5uOYSu2y8KUzouxH/yPcLZ9
	 1U0JfdLQbOwV0PWPU2egm1tVXQ9Hfm9vYJGeoGAdCfFTC1fGNKHv16O5pYS/Pfm8/A
	 NOeriloIpP3EV6Urreb1nb35DS2Hc73oF8TRop8SdNUmdacfRJzZQpSWaHh9RloR/H
	 LSRXvv1cqlBRSC0aSNjXItyOi/V93hxWzAovC80ypUPpIFBCur5wZ4ppDz3UZ/dw5N
	 F+nrsYv9SPueA==
Message-ID: <436ca5b3-ac0b-4313-9ed3-66c73181686c@kernel.org>
Date: Tue, 15 Sep 2026 08:56:35 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Move default_gfp() into gfp_types.h
To: Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 linux-mm@kvack.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20260914223212.i.829-kees@kernel.org>
 <20260914223219.901347-1-kees@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260914223219.901347-1-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/26 00:32, Kees Cook wrote:
> Using default_gfp() only depends on the GFP_KERNEL value. Move
> default_gfp() into gfp_types.h so that future use in devres.h doesn't
> require pulling in all of gfp.h.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Incidentally I was thinking if default_gfp(...) usage should be extended
also for the legacy kmalloc() API. Because it's going to still have users,
buffers are needed for many things that are not objects (structs). Mike is
converting many unnecessary page allocator usages to kmalloc(PAGE_SIZE, ...)
often with GFP_KERNEL, so that would be neater too...

> ---
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: "Liam R. Howlett" <liam@infradead.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Brendan Jackman <brendan.jackman@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: <linux-mm@kvack.org>
> ---
>  include/linux/gfp.h       | 4 ----
>  include/linux/gfp_types.h | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 872bc53f32ec..b62e2fd53cb4 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -13,10 +13,6 @@
>  struct vm_area_struct;
>  struct mempolicy;
>  
> -/* Helper macro to avoid gfp flags if they are the default one */
> -#define __default_gfp(a,b,...) b
> -#define default_gfp(...) __default_gfp(,##__VA_ARGS__,GFP_KERNEL)
> -
>  static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
>  {
>  	return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index 190191411009..b1cd143f3c42 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -382,4 +382,8 @@ enum {
>  			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
>  #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
>  
> +/* Helper macro to avoid gfp flags if they are the default one */
> +#define __default_gfp(a,b,...) b
> +#define default_gfp(...) __default_gfp(,##__VA_ARGS__,GFP_KERNEL)
> +
>  #endif /* __LINUX_GFP_TYPES_H */

