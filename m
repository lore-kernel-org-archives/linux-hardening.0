Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1EE31716F
	for <linux-hardening@vger.kernel.org>; Mon,  4 May 2026 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929788; cv=none; b=c/NWzKykJZJLsHHL8Cl+LdlhznWCg/udcQtKubcAw1+msWbf5ZcYdRpbvor/HLAkndJCvym15fmJDt+AqJiqyvGbNSHIVGrYBAe4rmQhxayRk0qbU0y5Hiwwws+I3yfQVzeFdBD3ipUibVlBVCfCNAVzl6OXUT0ycpNoefv4j9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929788; c=relaxed/simple;
	bh=KZ9hGIdTsGnZ8NOGTupuIQLH8lJmHaX97JFhAZBXiOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbWGcQ3ndFrnr4iHqBGhdJoNntgh6bRLDud7ybgIsPj8JHnGC4dW26gNGw0Rrn5XGcZKi2+hFYI75xpfpC7bxxZSVadUtDDCvv14RVG6DD5i4UHdTlvqqYQqa3GU9UNgrBxphloamxThyIKfyO7kU34WyO3bBR5evYaLs5AX6WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gAN727wL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAN727wL"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so43636015e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 04 May 2026 14:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929785; x=1778534585; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igyU2nx2iftItHLeQpILR+qCdofiKDiQQ2B3kQIIdT0=;
        b=gAN727wLdVBGRLnCVb/rcO9iZcIiEIGMYtmTGAtlo6VFbrcWOO0htajhVW3PCLFdlx
         g7XytLlFTpE8LAQK1x68Er9l5MQrSg6wGrzq7LVvQyoDX8u8grYJgnn+3flbw8plISjM
         TR+nYc60eL7HWJLxbGx970A2Q0E72665XTPDhS3MCMu01YuHr1Ln6sQ0X6zRT5rfmilo
         Gp18k9WYU5MAz7zE5F/clL6GkEYiHtVMce3600FoCuXB3CLHLrHc4mEBpyDdySYMdLZH
         yvoryNdQibVwDmGJyXg9TvT7IUU7puGOTXSzmiOAnIP6q3vA4OATF83/xZbsRpds5Aig
         QKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929785; x=1778534585;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=igyU2nx2iftItHLeQpILR+qCdofiKDiQQ2B3kQIIdT0=;
        b=nvzn/GYk+i4j03NgYDUXKn6apLSWbv4Z6nIC0u5BIOKERhJeiAGrMb8dzZeWz2qIHN
         N4MLPcofkZuWs0urOWvgBaRD02JpRHd83hctSfYpTGxE4Swtcv5fZ+yG6eKA2bd+Tvm8
         QXMX4DfN/4tnsmnGb+1nJ+4f4MGDjp1n6LUAFzG/63ri8cNlDXQ5k++rqAU2XAL7Czwc
         J264AA8gXeK5xMzcKl5i59qAFCLLdCMNW+6OdUqfVntnbjm2sAAyQ9S5NXA5vYFV2dbE
         DQlJEiN7InBbTcj9sL8uF3F/kOP/5V/yUv6pCEdjyunC78++ZeZjtIKnvS32kX2xYUZO
         gbOg==
X-Forwarded-Encrypted: i=1; AFNElJ9aX+iE77JWtg6YHgP4zW5lvIQ/jySyMZ6hLy0OwcTqymbtDG+kQ9xVpVdTucY1gE+XIDeEMzhzWhrx3HtJQtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRlCxi+XUwGckMPKb1gc/4vIGcDUciXOGWeNh83GYeA6GdTg/Z
	YYc3Dk0/MDdaTsMPxBl+BLxWIiU84sdx7NrQU04TSqOMJtAhNmZ4eslMjPuE6lvk9g==
X-Gm-Gg: AeBDievUpPr5E40AAqJ6ijr5JE2blOx/Zc9nrCc2IWom07z36bVP08F7jahl3DRNj5h
	cj/gk1zQ2lwSk8NM25K7k1P1paTDYWUe7yDYrAqh2Y4olsFeMe65i0ret4NbI3o3HG1iuuoflkF
	IUAiOJjzW8uDD3XPO84rSJbo54YfWubZarpH+QHDaq5eX5mK7Gi0TZlIKe/3iEc6gCXw4n9/b2+
	TkKfPwTU5TVN1uy75SNshe8QA9ZFLq8vhuxyPAFwXiCMC5MBiZ02OCy7aGCuW+3AFbrPo2lhikM
	f+3aK8Y90iZGvsvJneNxUth/rcZMyiIwwzIHGOYZzUI9rzGGDzPOB3+1IoDlVUocaN32H5hZd6Z
	NYdEemWMgD+gH0uI2zSWNBIO4QAri8KJQjnemyhxsRweF+Z1e4Qg0iwfEnLLxUhd1Jw5Xphbppl
	HaXol+DzCvECYWqfXI4TQe6wW8OrQgE4oPnugzTAgJrMQmkmlqGlI3bvYp/e0bTvpAMTmNrZY+1
	mQOHnOnrA==
X-Received: by 2002:a05:600c:a30a:b0:489:1a3a:9e45 with SMTP id 5b1f17b1804b1-48d18cea8damr2194915e9.26.1777929784562;
        Mon, 04 May 2026 14:23:04 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:2834:9:fba5:1281:871d:3fd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb694fcsm323128615e9.3.2026.05.04.14.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 14:23:03 -0700 (PDT)
Date: Mon, 4 May 2026 23:22:56 +0200
From: Marco Elver <elver@google.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com,
	llvm@lists.linux.dev, Andrey Konovalov <andreyknvl@gmail.com>,
	Florent Revest <revest@google.com>, Jann Horn <jannh@google.com>,
	KP Singh <kpsingh@kernel.org>,
	Matteo Rizzo <matteorizzo@google.com>,
	GONG Ruiqi <gongruiqi1@huawei.com>
Subject: Re: [PATCH v3 1/2] slab: support for compiler-assisted type-based
 slab cache partitioning
Message-ID: <afkOMIPu1WNFE9MS@elver.google.com>
References: <20260424132427.2703076-1-elver@google.com>
 <6f2bd63a-dc02-4631-a3a5-7ec8e58a4a4e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f2bd63a-dc02-4631-a3a5-7ec8e58a4a4e@kernel.org>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Thu, Apr 30, 2026 at 03:03PM +0200, Vlastimil Babka (SUSE) wrote:
> On 4/24/26 15:24, Marco Elver wrote:
> 
> > @@ -938,7 +968,7 @@ void *__kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
> >   *	Try really hard to succeed the allocation but fail
> >   *	eventually.
> >   */
> > -static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t flags)
> > +static __always_inline __alloc_size(1) void *_kmalloc_noprof(size_t size, gfp_t flags, kmalloc_token_t token)
> >  {
> >  	if (__builtin_constant_p(size) && size) {
> >  		unsigned int index;
> > @@ -948,14 +978,16 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
> >  
> >  		index = kmalloc_index(size);
> >  		return __kmalloc_cache_noprof(
> > -				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
> > +				kmalloc_caches[kmalloc_type(flags, token)][index],
> 
> While reviewing this, it occured to me we might have been using _RET_IP_
> here in a suboptimal way ever since this was introduced. Since this is all
> inlined, shouldn't have we been using _THIS_IP_ to really randomize using
> the kmalloc() callsite, and not its parent?
> 
> And after this patch, we get the token passed to _kmalloc_noprof()...
> 
> >  				flags, size);
> >  	}
> > -	return __kmalloc_noprof(size, flags);
> > +	return __kmalloc_noprof(PASS_KMALLOC_PARAMS(size, NULL, token), flags);
> 
> ... and used also here for the non-constant-size, where previously
> __kmalloc_noprof() (not inline function) would correctly use _RET_IP_ on its
> own ...
> 
> >  }
> > +#define kmalloc_noprof(...)			_kmalloc_noprof(__VA_ARGS__, __kmalloc_token(__VA_ARGS__))
> 
> ... and the token comes from here. With random partitioning that's
> #define __kmalloc_token(...) ((kmalloc_token_t){ .v = _RET_IP_ })
> 
> so that AFAIK makes the situation worse as now the cases without constant
> size also start randomizing by the parent callsite and not the kmalloc callsite.
> 
> But there are many users of __kmalloc_token() and maybe some are corrent in
> using _RET_IP_, I haven't checked, maybe we'll need two variants, or further
> change things around.

Good catch. I don't think we need multiple variants (otherwise the TYPED
variant would be broken) - we're moving token generation to the callers
(not even inlined anymore) with all this macro magic.

I think this is all we need:

--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -503,7 +503,7 @@ int kmem_cache_shrink(struct kmem_cache *s);
 typedef struct { unsigned long v; } kmalloc_token_t;
 #ifdef CONFIG_KMALLOC_PARTITION_RANDOM
 extern unsigned long random_kmalloc_seed;
-#define __kmalloc_token(...) ((kmalloc_token_t){ .v = _RET_IP_ })
+#define __kmalloc_token(...) ((kmalloc_token_t){ .v = _THIS_IP_ })
 #elif defined(CONFIG_KMALLOC_PARTITION_TYPED)
 #define __kmalloc_token(...) ((kmalloc_token_t){ .v = __builtin_infer_alloc_token(__VA_ARGS__) })
 #endif

Plus a paragraph in the commit message.  Let me add that.
