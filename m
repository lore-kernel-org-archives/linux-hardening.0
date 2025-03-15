Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F8178CF8;
	Sat, 15 Mar 2025 04:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742014444; cv=none; b=DWw/seYC4E7sWiMwA/kdTM0nWfPp842i4e281ZUEsoD9BUxpnbD5kIn1m1z1onk31tPmWWAqNhYmqaYDm7vVCIaT874+10X1eeKXujP2LyIqrRL7g1cCV3Uy2qYXJmDuPGc2g5W4Dy0ohteRMuhu/U1NAZGQHytltjdC5RoCncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742014444; c=relaxed/simple;
	bh=/FDqs1pCJojhK5Llb/7LM7tQKfHwOZ5rzRm+N/z2LRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0CPsWioDTpd7e54xbrfmrjElQ8igIrdsXMEVTJ1jXMEiHNUPKw1ePOMjFkpiI+UxfYKnwQzjEpJRnXRvby9t51FHBkQwiFrEWtT7tt4HZ9n6/T+ctf7sUoWEzAnhgHOChPNoxnV2t1Go9O5DfzXM0OFqDObBttq+SFhUUcvjtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mqtd67zN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mqtd67zN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=mQhJm5J645ymleMXzmsLIqdcp5cZsngAWaCVY5IJcSs=; b=mqtd67zNyJUoUFSs7XIGr5xFoJ
	mscSRcTffByeTyIAvzLMxBfoOfWy7K5r3StiTmBZ1Arbty+J7EGX+I0onfk7rxJfjd2Ut6WtZsjVc
	jE8X4+ML4TKxY5UXsXA4J4chq+AgGvkNgKm7czCQ9ZSVIKNXhiklRwUjiTCbP2CGQp++vmBxiXZ+U
	yqGAF98jhSOvpcYlzc9/i//rvH51voF9nO+HBq6nY/MOdiYrDmaAZXufutswWt92Orf9JnL78CZEk
	j+4WDLiz96mKNT/Ow2Frfj5NZhJ1AQAxOA7P2qxk2fy7fpDpkiUwbxRxiGTtRSDWi26lcOaFwIc07
	v0WfOg6A==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ttJWw-0000000338B-2bOV;
	Sat, 15 Mar 2025 04:53:51 +0000
Message-ID: <03d69156-1cee-43bc-901b-5f85f3aa7575@infradead.org>
Date: Fri, 14 Mar 2025 21:53:41 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] compiler_types: Introduce __flex_counter() and
 family
To: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Miguel Ojeda <ojeda@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Marco Elver <elver@google.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-hardening@vger.kernel.org, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jakub Kicinski <kuba@kernel.org>, Yafang Shao <laoar.shao@gmail.com>,
 Tony Ambardar <tony.ambardar@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jan Hendrik Farr <kernel@jfarr.cc>, Alexander Potapenko <glider@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 llvm@lists.linux.dev
References: <20250315025852.it.568-kees@kernel.org>
 <20250315031550.473587-1-kees@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250315031550.473587-1-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kees,


On 3/14/25 8:15 PM, Kees Cook wrote:


> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 0c7e3dcfe867..e2b81cb5576e 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -440,4 +440,40 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>  #define DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)	\
>  	_DEFINE_FLEX(TYPE, NAME, MEMBER, COUNT, = { .obj.COUNTER = COUNT, })
>  
> +/**
> + * typeof_flex_counter() - Return the type of the counter variable of a given
> + *                         flexible array member annotated by __counted_by().
> + * @FAM: Pointer to the flexible array member within a given struct.
> + *
> + * Returns "size_t" if no annotation exists.

Please use
 * Returns: <text>
instead so that kernel-doc can make a special doc section for it.

Same for patch 2/2.

> + */
> +#define typeof_flex_counter(FAM)				\
> +	typeof(_Generic(__flex_counter(FAM),			\
> +			void *: (size_t)0,			\
> +			default: *__flex_counter(FAM)))
> +
> +/** can_set_flex_counter() - Check if the counter associated with the given

Needs a newline between /** and the function name, as in set_flex_counter() below.

> + *                           flexible array member can represent a value.
> + * @FAM: Pointer to the flexible array member within a given struct.
> + * @COUNT: Value to check against the __counted_by annotated @FAM's counter.
> + */
> +#define can_set_flex_counter(FAM, COUNT)			\
> +	(!overflows_type(COUNT, typeof_flex_counter(FAM)))
> +
> +/**
> + * set_flex_counter() - Set the counter associated with the given flexible
> + *                      array member that has been annoated by __counted_by().
> + * @FAM: Pointer to the flexible array member within a given struct.
> + * @COUNT: Value to store to the __counted_by annotated @FAM's counter.
> + *
> + * This is a no-op if no annotation exists. Count needs to be checked with
> + * can_set_flex_counter(FAM, COUNT) before using this function.
> + */
> +#define set_flex_counter(FAM, COUNT)				\
> +({								\
> +	*_Generic(__flex_counter(FAM),				\
> +		  void *:  &(size_t){ 0 },			\
> +		  default: __flex_counter(FAM)) = (COUNT);	\
> +})
> +
>  #endif /* __LINUX_OVERFLOW_H */

-- 
~Randy

