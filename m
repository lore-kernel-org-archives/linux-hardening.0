Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBED76056;
	Tue, 27 Aug 2024 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794341; cv=none; b=RsxbGVEC0/CU0DXynpi7+uxbPwW6xA8vjxRzc+0b9XY8jGQlLxz6tlUI3X2qxt8pJN0Cif+GtTh74hPc4s3SgM8JzncvDv5w5HsCm2UmVMCfRSohlLRf/Sws2bv6RHjWPNq0eSJ6qeDdIBWAftqWq3mWRgB4jXMptvYWqM36zL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794341; c=relaxed/simple;
	bh=CVB7PlTjlvVwgCeFOiuvc32ytM8grPNDLclCvEwsE1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaGrxowWNcqk8MDDLLwmwbnsQddL+OnM7GijgPR+/fxsBl4IXEIxoSBeNX6xEgWAQwmTDtVwCbM7g2fvx9wUqmx7dxv8yZAw58hUjDM3Sd2UO945gTMKLddRqL3c3AWlwhuideJtJGTubr7vTB3kPKLlMW9lBjC8WsvYn4G5dpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EsmTL1hj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r6gO+rhe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EsmTL1hj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r6gO+rhe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EsmTL1hj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r6gO+rhe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EsmTL1hj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r6gO+rhe"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 73C021FB92;
	Tue, 27 Aug 2024 21:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724794335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1p8Uzkwlngkp0JVaiE/6IGnq5C0FBQjwb3xmsQ5sqsk=;
	b=EsmTL1hjBMF5VhELF1EgW7d10PYJz4GULMVRp1fmtDdW2/avBEustrdr1Cr1eid5SZJPE2
	eX93oY/c8/XOJHWe35WtYn+PbRv8Fb1q1O90tP76YlSWVGwaR/7/wqDrpEhgaSgqxm1Phi
	lejtLxruQvP/lonaJ82toSA8E19cxqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724794335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1p8Uzkwlngkp0JVaiE/6IGnq5C0FBQjwb3xmsQ5sqsk=;
	b=r6gO+rheX+JdkfXQ/Jsj6891pn+jHod0O1gBkpik2vdOcJE8Q2vylL16PtIwIH3zwLgUYU
	63mCTgTMRwxdWJAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724794335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1p8Uzkwlngkp0JVaiE/6IGnq5C0FBQjwb3xmsQ5sqsk=;
	b=EsmTL1hjBMF5VhELF1EgW7d10PYJz4GULMVRp1fmtDdW2/avBEustrdr1Cr1eid5SZJPE2
	eX93oY/c8/XOJHWe35WtYn+PbRv8Fb1q1O90tP76YlSWVGwaR/7/wqDrpEhgaSgqxm1Phi
	lejtLxruQvP/lonaJ82toSA8E19cxqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724794335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1p8Uzkwlngkp0JVaiE/6IGnq5C0FBQjwb3xmsQ5sqsk=;
	b=r6gO+rheX+JdkfXQ/Jsj6891pn+jHod0O1gBkpik2vdOcJE8Q2vylL16PtIwIH3zwLgUYU
	63mCTgTMRwxdWJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C7BA13724;
	Tue, 27 Aug 2024 21:32:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f9piDt9FzmZxFAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 27 Aug 2024 21:32:15 +0000
Message-ID: <5c3852e6-4a6a-42d8-85ff-8c1605939454@suse.cz>
Date: Tue, 27 Aug 2024 23:32:14 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] slab: Introduce kmalloc_obj() and family
Content-Language: en-US
To: Kees Cook <kees@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Jann Horn <jannh@google.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Marco Elver <elver@google.com>,
 linux-mm@kvack.org, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20240822231324.make.666-kees@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240822231324.make.666-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,intel.com,kvack.org,vger.kernel.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,gnu.org:url]
X-Spam-Score: -2.80
X-Spam-Flag: NO

+Cc Linus

On 8/23/24 01:13, Kees Cook wrote:
> Introduce type-aware kmalloc-family helpers to replace the common
> idioms for single, array, and flexible object allocations:
> 
> 	ptr = kmalloc(sizeof(*ptr), gfp);
> 	ptr = kzalloc(sizeof(*ptr), gfp);
> 	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
> 	ptr = kcalloc(count, sizeof(*ptr), gfp);
> 	ptr = kmalloc(struct_size(ptr, flex_member, count), gfp);
> 
> These become, respectively:
> 
> 	kmalloc_obj(ptr, gfp);
> 	kzalloc_obj(ptr, gfp);
> 	kmalloc_objs(ptr, count, gfp);
> 	kzalloc_objs(ptr, count, gfp);
> 	kmalloc_flex(ptr, flex_member, count, gfp);

This is indeed better than the previous version. The hidden assignment to
ptr seems still very counter-intuitive, but if it's the only way to do those
validations, the question is then just whether it's worth the getting used
to it, or not.

> These each return the assigned value of ptr (which may be NULL on
> failure). For cases where the total size of the allocation is needed,
> the kmalloc_obj_sz(), kmalloc_objs_sz(), and kmalloc_flex_sz() family
> of macros can be used. For example:
> 
> 	info->size = struct_size(ptr, flex_member, count);
> 	ptr = kmalloc(info->size, gfp);
> 
> becomes:
> 
> 	kmalloc_flex_sz(ptr, flex_member, count, gfp, &info->size);
> 
> Internal introspection of allocated type now becomes possible, allowing
> for future alignment-aware choices and hardening work. For example,
> adding __alignof(*ptr) as an argument to the internal allocators so that
> appropriate/efficient alignment choices can be made, or being able to
> correctly choose per-allocation offset randomization within a bucket
> that does not break alignment requirements.
> 
> Introduces __flex_count() for when __builtin_get_counted_by() is added

"Also introduce __flex_counter() ..."?

> by GCC[1] and Clang[2]. The internal use of __flex_count() allows for
> automatically setting the counter member of a struct's flexible array

But if it's a to-be-implemented feature, perhaps it would be too early to
include it here? Were you able to even test that part right now?

> member when it has been annotated with __counted_by(), avoiding any
> missed early size initializations while __counted_by() annotations are
> added to the kernel. Additionally, this also checks for "too large"
> allocations based on the type size of the counter variable. For example:
> 
> 	if (count > type_max(ptr->flex_count))
> 		fail...;
> 	info->size = struct_size(ptr, flex_member, count);
> 	ptr = kmalloc(info->size, gfp);
> 	ptr->flex_count = count;
> 
> becomes (i.e. unchanged from earlier example):
> 
> 	kmalloc_flex_sz(ptr, flex_member, count, gfp, &info->size);
> 
> Replacing all existing simple code patterns found via Coccinelle[3]
> shows what could be replaced immediately (saving roughly 1,500 lines):
> 
>  7040 files changed, 14128 insertions(+), 15557 deletions(-)

Since that could be feasible to apply only if Linus ran that directly
himself, including him now. Because doing it any other way would leave us
semi-converted forever and not bring the full benefits?

> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=116016 [1]
> Link: https://github.com/llvm/llvm-project/issues/99774 [2]
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/kmalloc_obj-assign-size.cocci [3]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Initial testing looks good. Before I write all the self-tests, I just
> wanted to validate that the new API is reasonable (i.e. it is no longer
> using optional argument counts for choosing the internal API).
> 
>  v3:
>   - Add .rst documentation
>   - Add kern-doc
>   - Return ptr instead of size by default
>   - Add *_sz() variants that provide allocation size output
>   - Implement __flex_counter() logic
>  v2: https://lore.kernel.org/linux-hardening/20240807235433.work.317-kees@kernel.org/
>  v1: https://lore.kernel.org/linux-hardening/20240719192744.work.264-kees@kernel.org/
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Marco Elver <elver@google.com>
> Cc: linux-mm@kvack.org
> ---
>  Documentation/process/deprecated.rst |  41 +++++++
>  include/linux/compiler_types.h       |  22 ++++
>  include/linux/slab.h                 | 174 +++++++++++++++++++++++++++
>  3 files changed, 237 insertions(+)
> 
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 1f7f3e6c9cda..b22ec088a044 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -372,3 +372,44 @@ The helper must be used::
>  			DECLARE_FLEX_ARRAY(struct type2, two);
>  		};
>  	};
> +
> +Open-coded kmalloc assignments
> +------------------------------
> +Performing open-coded kmalloc()-family allocation assignments prevents
> +the kernel (and compiler) from being able to examine the type of the
> +variable being assigned, which limits any related introspection that
> +may help with alignment, wrap-around, or additional hardening. The
> +kmalloc_obj()-family of macros provide this introspection, which can be
> +used for the common code patterns for single, array, and flexible object
> +allocations. For example, these open coded assignments::
> +
> +	ptr = kmalloc(sizeof(*ptr), gfp);
> +	ptr = kzalloc(sizeof(*ptr), gfp);
> +	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
> +	ptr = kcalloc(count, sizeof(*ptr), gfp);
> +	ptr = kmalloc(struct_size(ptr, flex_member, count), gfp);
> +
> +become, respectively::
> +
> +	kmalloc_obj(ptr, gfp);
> +	kzalloc_obj(ptr, gfp);
> +	kmalloc_objs(ptr, count, gfp);
> +	kzalloc_objs(ptr, count, gfp);
> +	kmalloc_flex(ptr, flex_member, count, gfp);
> +
> +For the cases where the total size of the allocation is also needed,
> +the kmalloc_obj_size(), kmalloc_objs_sz(), and kmalloc_flex_sz() family of
> +macros can be used. For example, converting these assignments::
> +
> +	total_size = struct_size(ptr, flex_member, count);
> +	ptr = kmalloc(total_size, gfp);
> +
> +becomes::
> +
> +	kmalloc_flex_sz(ptr, flex_member, count, gfp, &total_size);
> +
> +If `ptr->flex_member` is annotated with __counted_by(), the allocation
> +will automatically fail if `count` is larger than the maximum
> +representable value that can be stored in the counter member associated
> +with `flex_member`. Similarly, the allocation will fail if the total
> +size of the allocation exceeds the maximum value `*total_size` can hold.
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index f14c275950b5..b99deae45210 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -421,6 +421,28 @@ struct ftrace_likely_data {
>  #define __member_size(p)	__builtin_object_size(p, 1)
>  #endif
>  
> +#if __has_builtin(__builtin_get_counted_by)
> +/**
> + * __flex_counter - Get pointer to counter member for the given
> + *		    flexible array, if it was annotated with __counted_by()
> + * @flex: Pointer to flexible array member of an addressable struct instance
> + *
> + * For example, with:
> + *
> + *	struct foo {
> + *		int counter;
> + *		short array[] __counted_by(counter);
> + *	} *p;
> + *
> + * __flex_counter(p->array) will resolve to &p->counter.
> + *
> + * If p->array is unannotated, this returns (void *)NULL.
> + */
> +#define __flex_counter(flex)	__builtin_get_counted_by(flex)
> +#else
> +#define __flex_counter(flex)	((void *)NULL)
> +#endif
> +
>  /*
>   * Some versions of gcc do not mark 'asm goto' volatile:
>   *
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index eb2bf4629157..c37606b9e248 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -686,6 +686,180 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
>  }
>  #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
>  
> +#define __alloc_objs(ALLOC, P, COUNT, FLAGS, SIZE)		\
> +({								\
> +	size_t __obj_size = size_mul(sizeof(*P), COUNT);	\
> +	const typeof(_Generic(SIZE,				\
> +			void *: (size_t *)NULL,			\
> +			default: SIZE)) __size_ptr = (SIZE);	\
> +	typeof(P) __obj_ptr = NULL;				\
> +	/* Does the total size fit in the *SIZE variable? */	\
> +	if (!__size_ptr || __obj_size <= type_max(*__size_ptr))	\
> +		__obj_ptr = ALLOC(__obj_size, FLAGS);		\
> +	if (!__obj_ptr)						\
> +		__obj_size = 0;					\
> +	if (__size_ptr)						\
> +		*__size_ptr = __obj_size;			\
> +	(P) = __obj_ptr;					\
> +})
> +
> +#define __alloc_flex(ALLOC, P, FAM, COUNT, FLAGS, SIZE)			\
> +({									\
> +	size_t __count = (COUNT);					\
> +	size_t __obj_size = struct_size(P, FAM, __count);		\
> +	const typeof(_Generic(SIZE,					\
> +			void *: (size_t *)NULL,				\
> +			default: SIZE)) __size_ptr = (SIZE);		\
> +	typeof(P) __obj_ptr = NULL;					\
> +	/* Just query the counter type for type_max checking. */	\
> +	typeof(_Generic(__flex_counter(__obj_ptr->FAM),			\
> +			void *: (size_t *)NULL,				\
> +			default: __flex_counter(__obj_ptr->FAM)))	\
> +		__counter_type_ptr = NULL;				\
> +	/* Does the count fit in the __counted_by counter member? */	\
> +	if ((__count <= type_max(*__counter_type_ptr)) &&		\
> +	    /* Does the total size fit in the *SIZE variable? */	\
> +	    (!__size_ptr || __obj_size <= type_max(*__size_ptr)))	\
> +		__obj_ptr = ALLOC(__obj_size, FLAGS);			\
> +	if (__obj_ptr) {						\
> +		/* __obj_ptr now allocated so get real counter ptr. */	\
> +		typeof(_Generic(__flex_counter(__obj_ptr->FAM),		\
> +				void *: (size_t *)NULL,			\
> +				default: __flex_counter(__obj_ptr->FAM))) \
> +			__counter_ptr = __flex_counter(__obj_ptr->FAM);	\
> +		if (__counter_ptr)					\
> +			*__counter_ptr = __count;			\
> +	} else {							\
> +		__obj_size = 0;						\
> +	}								\
> +	if (__size_ptr)							\
> +		*__size_ptr = __obj_size;				\
> +	(P) = __obj_ptr;						\
> +})
> +
> +/**
> + * kmalloc_obj - Allocate a single instance of the given structure
> + * @P: Pointer to hold allocation of the structure
> + * @FLAGS: GFP flags for the allocation
> + *
> + * Returns the newly allocated value of @P on success, NULL on failure.
> + * @P is assigned the result, either way.
> + */
> +#define kmalloc_obj(P, FLAGS)				\
> +	__alloc_objs(kmalloc, P, 1, FLAGS, NULL)
> +/**
> + * kmalloc_obj_sz - Allocate a single instance of the given structure and
> + *		 store total size
> + * @P: Pointer to hold allocation of the structure
> + * @FLAGS: GFP flags for the allocation
> + * @SIZE: Pointer to variable to hold the total allocation size
> + *
> + * Returns the newly allocated value of @P on success, NULL on failure.
> + * @P is assigned the result, either way. If @SIZE is non-NULL, the
> + * allocation will immediately fail if the total allocation size is larger
> + * than what the type of *@SIZE can represent.
> + */
> +#define kmalloc_obj_sz(P, FLAGS, SIZE)			\
> +	__alloc_objs(kmalloc, P, 1, FLAGS, SIZE)
> +/**
> + * kmalloc_objs - Allocate an array of the given structure
> + * @P: Pointer to hold allocation of the structure array
> + * @COUNT: How many elements in the array
> + * @FLAGS: GFP flags for the allocation
> + *
> + * Returns the newly allocated value of @P on success, NULL on failure.
> + * @P is assigned the result, either way.
> + */
> +#define kmalloc_objs(P, COUNT, FLAGS)			\
> +	__alloc_objs(kmalloc, P, COUNT, FLAGS, NULL)
> +/**
> + * kmalloc_objs_sz - Allocate an array of the given structure and store
> + *		     total size
> + * @P: Pointer to hold allocation of the structure array
> + * @COUNT: How many elements in the array
> + * @FLAGS: GFP flags for the allocation
> + * @SIZE: Pointer to variable to hold the total allocation size
> + *
> + * Returns the newly allocated value of @P on success, NULL on failure.
> + * @P is assigned the result, either way. If @SIZE is non-NULL, the
> + * allocation will immediately fail if the total allocation size is larger
> + * than what the type of *@SIZE can represent.
> + */
> +#define kmalloc_objs_sz(P, COUNT, FLAGS, SIZE)		\
> +	__alloc_objs(kmalloc, P, COUNT, FLAGS, SIZE)
> +/**
> + * kmalloc_flex - Allocate a single instance of the given flexible structure
> + * @P: Pointer to hold allocation of the structure
> + * @FAM: The name of the flexible array member of the structure
> + * @COUNT: How many flexible array member elements are desired
> + * @FLAGS: GFP flags for the allocation
> + *
> + * Returns the newly allocated value of @P on success, NULL on failure.
> + * @P is assigned the result, either way. If @FAM has been annotated with
> + * __counted_by(), the allocation will immediately fail if @COUNT is larger
> + * than what the type of the struct's counter variable can represent.
> + */
> +#define kmalloc_flex(P, FAM, COUNT, FLAGS)		\
> +	__alloc_flex(kmalloc, P, FAM, COUNT, FLAGS, NULL)
> +
> +/**
> + * kmalloc_flex_sz - Allocate a single instance of the given flexible
> + *		     structure and store total size
> + * @P: Pointer to hold allocation of the structure
> + * @FAM: The name of the flexible array member of the structure
> + * @COUNT: How many flexible array member elements are desired
> + * @FLAGS: GFP flags for the allocation
> + * @SIZE: Pointer to variable to hold the total allocation size
> + *
> + * Returns the newly allocated value of @P on success, NULL on failure.
> + * @P is assigned the result, either way. If @FAM has been annotated with
> + * __counted_by(), the allocation will immediately fail if @COUNT is larger
> + * than what the type of the struct's counter variable can represent. If
> + * @SIZE is non-NULL, the allocation will immediately fail if the total
> + * allocation size is larger than what the type of *@SIZE can represent.
> + */
> +#define kmalloc_flex_sz(P, FAM, COUNT, FLAGS, SIZE)	\
> +	__alloc_flex(kmalloc, P, FAM, COUNT, FLAGS, SIZE)
> +
> +#define kzalloc_obj(P, FLAGS)				\
> +	__alloc_objs(kzalloc, P, 1, FLAGS, NULL)
> +#define kzalloc_obj_sz(P, FLAGS, SIZE)			\
> +	__alloc_objs(kzalloc, P, 1, FLAGS, SIZE)
> +#define kzalloc_objs(P, COUNT, FLAGS)			\
> +	__alloc_objs(kzalloc, P, COUNT, FLAGS, NULL)
> +#define kzalloc_objs_sz(P, COUNT, FLAGS, SIZE)		\
> +	__alloc_objs(kzalloc, P, COUNT, FLAGS, SIZE)
> +#define kzalloc_flex(P, FAM, COUNT, FLAGS)		\
> +	__alloc_flex(kzalloc, P, FAM, COUNT, FLAGS, NULL)
> +#define kzalloc_flex_sz(P, FAM, COUNT, FLAGS, SIZE)	\
> +	__alloc_flex(kzalloc, P, FAM, COUNT, FLAGS, SIZE)
> +
> +#define kvmalloc_obj(P, FLAGS)				\
> +	__alloc_objs(kvmalloc, P, 1, FLAGS, NULL)

Wonder if there is really a single struct (not array) with no flex array
that could need kvmalloc? :)

> +#define kvmalloc_obj_sz(P, FLAGS, SIZE)			\
> +	__alloc_objs(kvmalloc, P, 1, FLAGS, SIZE)
> +#define kvmalloc_objs(P, COUNT, FLAGS)			\
> +	__alloc_objs(kvmalloc, P, COUNT, FLAGS, NULL)
> +#define kvmalloc_objs_sz(P, COUNT, FLAGS, SIZE)		\
> +	__alloc_objs(kvmalloc, P, COUNT, FLAGS, SIZE)
> +#define kvmalloc_flex(P, FAM, COUNT, FLAGS)		\
> +	__alloc_flex(kvmalloc, P, FAM, COUNT, FLAGS, NULL)
> +#define kvmalloc_flex_sz(P, FAM, COUNT, FLAGS, SIZE)	\
> +	__alloc_flex(kvmalloc, P, FAM, COUNT, FLAGS, SIZE)
> +
> +#define kvzalloc_obj(P, FLAGS)				\
> +	__alloc_objs(kvzalloc, P, 1, FLAGS, NULL)
> +#define kvzalloc_obj_sz(P, FLAGS, SIZE)			\
> +	__alloc_objs(kvzalloc, P, 1, FLAGS, SIZE)
> +#define kvzalloc_objs(P, COUNT, FLAGS)			\
> +	__alloc_objs(kvzalloc, P, COUNT, FLAGS, NULL)
> +#define kvzalloc_objs_sz(P, COUNT, FLAGS, SIZE)		\
> +	__alloc_objs(kvzalloc, P, COUNT, FLAGS, SIZE)
> +#define kvzalloc_flex(P, FAM, COUNT, FLAGS)		\
> +	__alloc_flex(kvzalloc, P, FAM, COUNT, FLAGS, NULL)
> +#define kvzalloc_flex_sz(P, FAM, COUNT, FLAGS, SIZE)	\
> +	__alloc_flex(kvzalloc, P, FAM, COUNT, FLAGS, SIZE)
> +
>  #define kmem_buckets_alloc(_b, _size, _flags)	\
>  	alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
>  

