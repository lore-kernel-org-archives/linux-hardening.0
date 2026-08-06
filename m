Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34C7363096;
	Thu,  6 Aug 2026 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037107; cv=none; b=RBXhepd/3j7/itShA+qvLcKVq5iyIUEgI+h2OJbPXQT7A1jxfNzqCz7ic6+P/s9ggis7hmiSL9J185WzyyrEvW28wKuwaTmpR+eLj+9dxbj/J2N1cY3JwEj218prG/t4GLly9+EEQbBzW03gtdzx8OiG2ZvDqrSDGU3O7TN/7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037107; c=relaxed/simple;
	bh=AhcrVHr6+jq30zIn1P9QM3sr9cDBgQoQ4ZIeZyUxQSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmlDxExP0g8FjOKHsVhUHy3JWsvgfxoQuKKW0oVZcA30omiDss0I/UhruHyzwYx2REBNXE0FM322IsEHcRXIeAuOOkCEKLZpIqgxQ5+eCogMT3mnU1p+o5LnJ8vSOjOT66cTicAneEzJ1XvgZpEpVP0eLnWkqerTDjXFS49DAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bYA5Ghpa; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bYA5Ghpa"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4C7B153B;
	Thu,  6 Aug 2026 10:24:58 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B33093F632;
	Thu,  6 Aug 2026 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786037102; bh=AhcrVHr6+jq30zIn1P9QM3sr9cDBgQoQ4ZIeZyUxQSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYA5GhpaUY05y013HcJbTOZeCAEESZNvj6InXLaN9sz61mjcDdLXGRoTUUgQpovzx
	 Qw8F9Zl/PmFU82FmeLpFymEQgKVkH3CYyVgM0qN+i73hzdt/QUioHIy888DzkxXTe8
	 s0Nm9iQKH/LnLqi4EQ6z4o3RIjsxThoZltRW6L4k=
Date: Thu, 6 Aug 2026 18:24:55 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Bence Csokas <bence.csokas@arm.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] overflow: Support sub-union members in struct_size()
Message-ID: <anTDZ7KtfeTw7jHt@J2N7QTR9R3>
References: <20260728114912.122417-3-bence.csokas@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728114912.122417-3-bence.csokas@arm.com>

Hi Bence,

As discussed elsewhere, I don't think this is right, but it really
depends on how struct_size_t() is expected to be used. We probably need
better documentation for that...

On Tue, Jul 28, 2026 at 01:49:13PM +0200, Bence Csokas wrote:
> Original definition of struct_size() assumed that the total size of an
> object with a flex-array member can be calculated simply by adding the
> flex-array size to what sizeof() returns. This is however not the case
> if the struct has a union inside it, and `member` refers to a field
> inside that sub-union:
> 
>   struct my_inner {
>     int a;
>     char b[];
>   };
> 
>   struct my_outer {
>     char c;
>     union {
>       struct my_inner inner;
>       long l;
>     };
>   };
> 
>   /* This will give the wrong result */
>   struct_size_t(struct my_outer, inner.b, n_elems);

Can you please explain what's wrong specifically? How are you expecting
to use the result?

My understanding is that struct_size_t() is meant to be used to
determine the size to allocate. Over-estimating by a small margin isn't
a functional issue.

> Replacing sizeof() by the offsetof() of the member fixes this.

That will under-estimate the size of the structure, by ignoring the
static footprint. For your example above, imagine you called:

  struct_size_t(struct my_outer, inner.b, 1) 

Where sizeof(long) == 8, that will provide a result that *smaller* than
sizeof(struct my_outer), missing the last 3 bytes of 'l'.

It's possible that 'l' is the active member at some point in time.  At
allocation we need to allocate *the largest possible size* that will be
used, but we're not guaranteeing that the flexible member is alway used.

Consider a case with a tagged union, where another field is used to
determine the active union member.

For example, something like:

| struct foo_elem {
|	/* some small set of fields */
| 	...
| };
| 
| struct source {
|	/* some large set of fields */
| 	...
| };
| 
| struct foo {
| 	int	nr_elems;
| 	bool	completed;
| 
| 	/* 
| 	 * When !completed, use @source.
| 	 * When completed, results have been placed in @elems.
| 	 */
| 	union {
| 		struct source source;
| 		struct foo_elem elems[];
| 	};
| };

The current behaviour for struct_size[_t]() will ensure sufficient space
is always allocated, whereas what you proposed might not. That could
lead to memory corruption, etc, which would be a worse than
over-allocating.

Mark.

> Existing users specifying non-union members should not be affected.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> 
> Signed-off-by: Bence Csokas <bence.csokas@arm.com>
> ---
>  include/linux/overflow.h | 4 ++--
>  include/linux/stddef.h   | 8 ++++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index a8cb6319b4fb..a11c1135f617 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -433,8 +433,8 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
>   */
>  #define struct_size(p, member, count)					\
>  	__builtin_choose_expr(__is_constexpr(count),			\
> -		sizeof(*(p)) + flex_array_size(p, member, count),	\
> -		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
> +		offsetofp((p), member) + flex_array_size(p, member, count),	\
> +		size_add(offsetofp((p), member), flex_array_size(p, member, count)))
>  
>  /**
>   * struct_size_t() - Calculate size of structure with trailing flexible array
> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> index e1851c50c89b..b8f0dbd2de55 100644
> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -32,6 +32,14 @@ enum {
>  #define offsetofend(TYPE, MEMBER) \
>  	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
>  
> +/**
> + * offsetofp() - Get the offset of a struct field from a pointer to the struct
> + *
> + * @P: Pointer to the structure
> + * @MEMBER: The member within the structure to get the end offset of
> + */
> +#define offsetofp(P, MEMBER) offsetof(typeof(*(P)), MEMBER)
> +
>  /**
>   * struct_group() - Wrap a set of declarations in a mirrored struct
>   *
> 
> base-commit: 62cc90241548d5570ee68e01aaba6506964e9811
> -- 
> 2.54.0
> 
