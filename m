Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708773F9C5;
	Sat, 22 Nov 2025 00:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763771444; cv=none; b=M942xdEZy6lKi4g1fcJjXDB/u6VFhdq3H3EedFwn/x2LR6F1Qj7J42QaBLiPVsYq+oENLsEJjjrYRBmqEkGwRskajSDH9SG5ftZ83HIkim1raMUYP5RCllg/M6rHRcywRZcGfSb/atz6gj0DAYaO4jO3/J4HSZGRlv6JcSDsLM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763771444; c=relaxed/simple;
	bh=HrtqBDzf+I3rKg+UOEYgJj3ACzu3sah0DecsWx8zL74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fewar+zTFB0ka/vTiw7j9UmFGakQ/AtD1i5htFl6QP12922Q29kIhRuoYDXmcA1a8MmBaNHSMbF4pposvXOqBtpHQsnqhbRZmN6cYRKHG4htOs8gooOw9EvNgba1Vft2feWJFLkwV3jlLpQl3xl4Td5PyYGzuxfplf48aefLnHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXNhbq0i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXNhbq0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BC8C4CEF1;
	Sat, 22 Nov 2025 00:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763771443;
	bh=HrtqBDzf+I3rKg+UOEYgJj3ACzu3sah0DecsWx8zL74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXNhbq0iFJqvm+8e+PfetKLRUs0dvxWyh4wKv1MUYoYDttoC19RFCdiculI5ThaBF
	 wY+KhdoV1023JPv5UQPO8/Jb7HJmkkgB+PI0fhqxOm1yKcXQBI/vBE0KVCu2yru5gR
	 x0wqamHVgXXGR9VZNOiO+xAigOLeYN7WkLZmlSiuaRdO23ovq/h4waRwZRwuHqch7v
	 RaAmQ+anT2MyJ53JD5y/DZlMlAsuOBKE53ahGW5iYhq6bGBdh8m/qvndDiGFN4lICe
	 6FOf7Vqrd5CVI0Dts/dPCadwR34Ag6tqIJfAnX8qv9vPz6KTwaOz8IM/pMd+El12Ph
	 dmf1eGGDJFVSw==
Date: Fri, 21 Nov 2025 16:30:43 -0800
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Uros Bizjak <ubizjak@gmail.com>, Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] memblock: annotate struct memblock_type with
 __counted_by_ptr
Message-ID: <202511211525.05CB7E1AEC@keescook>
References: <20251121193957.1655580-1-morbo@google.com>
 <20251121193957.1655580-3-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121193957.1655580-3-morbo@google.com>

On Fri, Nov 21, 2025 at 07:39:44PM +0000, Bill Wendling wrote:
> Add the '__counted_by_ptr' attribute to the 'regions' field of 'struct
> memblock_type'. The 'regions' field is an array of 'struct
> memblock_region' and its size is tracked by the 'max' field, which
> represents the total number of allocated regions.

As part of any counted_by annotation patch, there needs to be discussion
in the commit log about how it's been shown to be a safe annotation
to make. e.g. in this case, if all allocations of "regions" have a
corresponding "max" assignment, etc. If just "git grep" can't find them
all, using something like Coccinelle or CodeQL to search for struct
memblock_type::regions assignments can work.

Here's what I used in the past for flexible arrays, but it was slow
due to Coccinelle needing --recursive-includes to see the structs,
but should be adaptable for counted_by on pointers:

@flex_match@
identifier STRUCT, COUNTED, ARRAY;
type COUNTED_TYPE, ARRAY_TYPE;
attribute name __counted_by;
@@

        struct STRUCT {
                ...
                COUNTED_TYPE COUNTED;
                ...
                ARRAY_TYPE ARRAY[] __counted_by(COUNTED);
        };

@missed_counted_assignment@
identifier flex_match.STRUCT;
struct STRUCT *P;
identifier flex_match.COUNTED;
identifier flex_match.ARRAY;
identifier ALLOC =~ ".*alloc.*";
@@

        P = ALLOC(...);
        ... when != P->COUNTED
*       P->ARRAY


> This annotation allows the Kernel Address Sanitizer (KASAN) to detect
> out-of-bounds accesses to the 'regions' array.

I think you mean UBSan here (and CONFIG_FORTIFY_SOURCE)?

> ---
>  include/linux/memblock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 221118b5a16e..ba7f7c999a45 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -91,7 +91,7 @@ struct memblock_type {
>  	unsigned long cnt;
>  	unsigned long max;
>  	phys_addr_t total_size;
> -	struct memblock_region *regions;
> +	struct memblock_region *regions __counted_by_ptr(max);
>  	char *name;
>  };

For the handful of places I spot checked, yeah, it looks like a nice
annotation.

-Kees

-- 
Kees Cook
