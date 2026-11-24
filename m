Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795539230;
	b=JQcSyQ+0+b28e6kLjTTGzhsJIT8WKg9CjnSgZPVI1usqKxhCrRmyFIF43/2zy9ARPnJH
	 vwJtQagq++UN6+FsYRXyY7l53tKQkGSvU9HHUTSradP315yi6KfYrhWzisla0OHaUAiDb
	 43ELSSCn7pwz80KVOAQT9g65a4ttwh8K/9zJi+Dzrd+kyiaSEfXM8m6MQz4ie31d3V2T1
	 ZzDOgJUE1Nyl1NG7bDVap4ZWXVT3iaAlqkwPNdSvqgP0rqW4XA8cEpR3ZCRmlSzkhGcfu
	 RrG/80BGipQ8uXpG6cuaFI5dgAKPDTr/Apdu7hMxy8pPdhW4dtz8DaP+YrUyhMy5dJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539230;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TGS0p3l5aUvQSsnJUtozcXV+gafJYP1vaRPZ8q+1yVs=;
	b=SaEHNv2Cy+3jtGuhn8PPDnZGRXvZ9EFoLdoEI9YLvhjPT88SZAvMKj3k4djkCfg2tVme
	 3cCRMtylwWnVwuNJlvSQLOIZ+tSYfXr9SsGWV6gpfJ5KC+yj9dUx3TCL+U7xvmpbRB229
	 buRPpiUr7z8KDCLgwFZsXTUSzjKl3cTk46SB7OwJxulRwm22wBqjGh3t6+L1EHJyCQPUn
	 IEboFCNYp1qw7FCbi7JNiOEF2hW+kDWviakmcl0Kf1pSsicLlX5sdDh+Y1vaczCLy3zgO
	 SHB3oc1BVfKwGbJI1X9zRoZUdWZhv20zh+CDh02kBxbsPX3tgKkv4r6JQHGOwEY9KpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W+Q/DLky";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD0606A330;
	Tue, 24 Nov 2026 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+Q/DLky
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D721F000EB;
	Tue, 24 Nov 2026 16:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795539230;
	bh=TGS0p3l5aUvQSsnJUtozcXV+gafJYP1vaRPZ8q+1yVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W+Q/DLkygKoWveglsObwnQuDQHgHhVTLQBYYieM2oxOIAYtQwAL3WEOF2DLCZL2rS
	 SLsGk1yYj0c5ZhKJxzpeyjJzcVtuG2Se1RWtmT4trrESXCTrIN8m7qgE0VbXPKsRE4
	 mdcWRycOFo5nBnfBLfr9yrKwu1fySVR64C0gXTQ28Y4kaOOAsfR/hzNg3tWVrgnBTR
	 l019oR6l78Ai6rXpy1paM+/c2kolkIcYvlIhh8nQz0ome6zV/4CRCET1tE2TVg2AFU
	 6l+uALjhvT1IN939gxT23Xpl+bUli61HeqMiWL/7rK/0tONu2P735MhETaICOWf/ir
	 wcG9si/y7Wosw==
Date: Tue, 24 Nov 2026 16:53:48 +0000
From: Harry Yoo <harry@kernel.org>
To: arina.kharlamova@mbzuai.ac.ae
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] slab: fix the kernel-doc of kmalloc_flex() on counter
 overflowy
Message-ID: <awWxR-AsjwmkLE1Z@thinkstation>
References: <20261124-slab-doc-v1-1-9f14dfce47c8@mbzuai.ac.ae>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124-slab-doc-v1-1-9f14dfce47c8@mbzuai.ac.ae>

Hi Arina,

On Tue, Nov 24, 2026 at 03:58:53AM +0400, Arina Kharlamova via B4 Relay wrote:
> From: Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>

Please consider improving readability of the commit message and the
comment. LLMs are good at writing a bunch of "technically correct" texts
that are completely unreadable by human.

> Commit fa5c82f4d2bb ("slab.h: disable completely broken overflow handling
> in flex allocations") removed the overflows_flex_counter_type() check from
> __alloc_flex(), but left the kernel-doc of __alloc_flex() and
> kmalloc_flex(), and the text in deprecated.rst, saying that the
> allocation fails when COUNT cannot be represented by the __counted_by()
> counter.

Good catch.

Hmm, commit fa5c82f4d2bb says it needs to be inserted into
__set_flex_counter but conditionally but apparently there is no
follow-up. Kees?

> The code instead allocates COUNT elements and stores COUNT into the
> counter, truncated to the counter's type. With a u8 counter,
> kmalloc_flex(*p, array, 256) returns a 256-element object whose counter
> is 0.

> With compilers that lack __builtin_counted_by_ref() the counter is
> not written at all.

Yup, which is benign as the counter is only used by hardening checks,
right?

And they should be skipped with such a compiler?

> A caller that relies on the documented check and does not bound COUNT
> itself gets an object whose __counted_by() size is smaller than the
> allocation. Accesses inside the allocation are then reported by
> UBSAN_BOUNDS, and readers that loop up to the counter see fewer elements.

Good point but a counter overflow is an obvious bug so this explanation
is unnecessary and verbose.

> Make the documentation describe what the code does, and fix the
> Returns: text of overflows_flex_counter_type(), which still describes
> the inverted logic that the same commit corrected.

Ok.

> Returning NULL, as the old text described, is not done here. Some
> callers allocate one element more than the counter can hold and then set
> the counter themselves: ext4_htree_store_dirent() calls kzalloc_flex()
> with ent_name->len + 1 elements for a struct whose name_len is a __u8,
> so a 255-byte name would then fail with -ENOMEM.

again, this pagraph doesn't add much value in the commit message IMHO.

> Found while checking a summary of the kmalloc_obj() family against the
> v7.0 to v7.4-rc2 text of slab.h with a battery of inputs compiled by
> GCC 15.2, with the help of an AI coding assistant (Claude); I reviewed
> the analysis and the patch. A KUnit case (not part of this patch) that
> calls kmalloc_flex() with a u8 counter and COUNT 256 gets a non-NULL
> object with the counter 0 on v7.4-rc2 (UML, GCC 15.2.0); with
> UBSAN_BOUNDS, writing element 255 of that object reports "index 255 is
> out of range for type 'u32 [*]'". This patch changes comments only;
> scripts/kernel-doc -Wall reports the same warnings for slab.h and
> overflow.h before and after it.

again, we don't really put a paragraph like this in the commit message.

> Fixes: fa5c82f4d2bb ("slab.h: disable completely broken overflow handling in flex allocations")
> Signed-off-by: Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>
> ---
>  Documentation/process/deprecated.rst |  8 ++++----
>  include/linux/overflow.h             |  5 +++--
>  include/linux/slab.h                 | 15 +++++++++------
>  3 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 22a5e62c92ea..f8b7fb6f9629 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -405,7 +405,7 @@ become, respectively::
>  	__auto_type ptr = kmalloc_obj(struct foo [, gfp] );
>  
>  The argument gfp is optional, the default value is GFP_KERNEL.
> -If `ptr->flex_member` is annotated with __counted_by(), the allocation
> -will automatically fail if `count` is larger than the maximum
> -representable value that can be stored in the counter member associated
> -with `flex_member`.
> +If `ptr->flex_member` is annotated with __counted_by(), the counter
> +member associated with `flex_member` is set to `count` on compilers that
> +support it. `count` is not checked against the type of the counter, so
> +the caller must make sure it fits.
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index d0f04436343e..6ce610dbc12e 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -566,8 +566,9 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
>   * @FAM: Member name of the FAM within @TYPE.
>   * @COUNT: Value to check against the __counted_by annotated @FAM's counter.
>   *
> - * Returns: true if @COUNT can be represented in the @FAM's counter. When
> - * @FAM is not annotated with __counted_by(), always returns true.
> + * Returns: true if @COUNT cannot be represented in the @FAM's counter.
> + * When @FAM is not annotated with __counted_by(), or the compiler cannot
> + * resolve the counter, @COUNT is checked against size_t.
>   */
>  #define overflows_flex_counter_type(TYPE, FAM, COUNT)		\
>  	(overflows_type(COUNT, typeof_flex_counter(((TYPE *)NULL)->FAM)))
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index ad645967a3ee..69fa9066137f 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -1091,10 +1091,13 @@ void *kmalloc_nolock(size_t size, gfp_t gfp_flags, int node);
>   * @FAM: The name of the flexible array member of @TYPE structure.
>   * @COUNT: how many @FAM elements to allocate space for.
>   *
> + * If @FAM is annotated with __counted_by() and the compiler supports
> + * __builtin_counted_by_ref(), the counter member is set to @COUNT. @COUNT
> + * is not checked against the type of that member: a value it cannot
> + * represent is stored truncated, so the caller must bound @COUNT.
> + *
>   * Returns: Newly allocated pointer to @TYPE with @COUNT-many trailing
> - * @FAM elements, or NULL on failure or if @COUNT cannot be represented
> - * by the member of @TYPE that counts the @FAM elements (annotated via
> - * __counted_by()).
> + * @FAM elements, or NULL on failure.
>   */
>  #define __alloc_flex(KMALLOC, GFP, TYPE, FAM, COUNT)			\
>  ({									\
> @@ -1137,9 +1140,9 @@ void *kmalloc_nolock(size_t size, gfp_t gfp_flags, int node);
>   * @...: optional GFP flags for the allocation (GFP_KERNEL when not specified).
>   *
>   * Returns: newly allocated pointer to @VAR_OR_TYPE on success, NULL on
> - * failure. If @FAM has been annotated with __counted_by(), the allocation
> - * will immediately fail if @COUNT is larger than what the type of the
> - * struct's counter variable can represent.
> + * failure. If @FAM has been annotated with __counted_by(), the struct's
> + * counter variable is set to @COUNT when the compiler supports it. @COUNT
> + * must fit in the type of that variable; it is not checked.
>   */
>  #define kmalloc_flex(VAR_OR_TYPE, FAM, COUNT, ...) \
>  	__alloc_flex(kmalloc, default_gfp(__VA_ARGS__), typeof(VAR_OR_TYPE), FAM, COUNT)
> 
> ---
> base-commit: 9b95c9eeec894e969d590f45f9b760e88ba92876
> change-id: 20261124-slab-doc-1894ca04d006
> 
> Best regards,
> --  
> Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>

-- 
Cheers,
Harry / Hyeonggon
