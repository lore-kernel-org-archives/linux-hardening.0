Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A5A1DE894;
	Wed, 15 Apr 2026 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257348; cv=none; b=uamfXFzPt7ao1qQpyxasC6bKuHjQAVMnLEC7d2yK3jkgVvhs62jh5/Ks5ZZ2U8Luj97vMg7wNj6fb27DglRx8DiBDT77t1QkNhRJ8nM+Eypj2jUvVD+lKuT7OwOouB5Wi+kliqCk4Z1XiGzRwceNKTT09hzjRzj8+zM2+DAwXgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257348; c=relaxed/simple;
	bh=z0QU7fIOckdevNLl67N0jcDETXgA9vaaD8hk9Cxb5qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXaSkJGe1N9v2h1gJtqKJHToPd5/mS2EYasijaI+EnkjHrBBTPBbOcxT4jvEPFyV1nSzCDJfUGviB9mUfPMKfixq/BH4C0KcozrUQwYE2Y4dDEzWEnlYj5nzeqZc3OnJJ4OkCNX2bwzJ1jWfTn1LgDkvu/roA7EMj3j/H0W8kSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXZiN4Zq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXZiN4Zq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF21DC19424;
	Wed, 15 Apr 2026 12:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776257347;
	bh=z0QU7fIOckdevNLl67N0jcDETXgA9vaaD8hk9Cxb5qw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CXZiN4ZqESEYgUFpVgLn6tlcj+2qfkWqnd43zukiIHbjVv2ZE4SxZ6zDVRTEcVnvq
	 3hri9KVxRpa7GkD0tvkUgf+ziy+2LNNYtQfklJ+lii2z2GHW4LUeA0qwmM8txAokwc
	 MTmB7AEeBJZseE++VGbhqHuPq5aywAxF9etEtKNwedUPNbMXcwfvf5uig7hQP5/laP
	 lpLSB+yzM2Em7R43Asp4sVRT978MX0ODbqO3SsOK47wAAiZKA1Z5SZSSomUVxZf4dZ
	 ClbT7G0fzTDeI3zPLamwjM0vxQzw6an4+SVJoKIdx2Ql6S2PM+TaIBFiXGWR5MBvGM
	 Q0WVKdiDDmzXg==
Message-ID: <1c8e2cd6-4b50-4891-8a2d-6a45623e805f@kernel.org>
Date: Wed, 15 Apr 2026 14:48:54 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/30] pkeys-based page table hardening
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org
References: <20260227175518.3728055-1-kevin.brodsky@arm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260227175518.3728055-1-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/26 18:54, Kevin Brodsky wrote:
> NEW in v6: support for large block mappings through a dedicated page table
> allocator (patch 14-17)

Heh, I had to read till the very end to realize that this is an RFC, and
then saw your other mail.

I can recommend using b4 for patch management, where you can configure a
sticky prefix through

	b4 prep --set-prefixes RFC

And using "b4 send" to automate all the rest.


> 
> Threat model
> ============
> 
> The proposed scheme aims at mitigating data-only attacks (e.g.
> use-after-free/cross-cache attacks). In other words, it is assumed that
> control flow is not corrupted, and that the attacker does not achieve
> arbitrary code execution. Nothing prevents the pkey register from being
> set to its most permissive state - the assumption is that the register
> is only modified on legitimate code paths.
> 
> A few related notes:
> 
> - Functions that set the pkey register are all implemented inline.
>   Besides performance considerations, this is meant to avoid creating
>   a function that can be used as a straightforward gadget to set the
>   pkey register to an arbitrary value.
> 
> - kpkeys_set_level() only accepts a compile-time constant as argument,
>   as a variable could be manipulated by an attacker. This could be
>   relaxed but it seems unlikely that a variable kpkeys level would be
>   needed in practice.
> 

I see a lot of value for that also as a debugging mechanism. I hear that
other people had private patches that would attempt to only map leaf
pages in the direct map in pte_offset_map_lock() and friends. I assume
there are some tricky bits to that (concurrent access to page tables).

What's the general take regarding the thread model you describe vs. MTE?

Regarding use-after-free, I'd assume KASAN would achieve something
similar. And with MTE "reasonably" fast. Or what is the biggest
difference you see, there?

I'd assume that one difference would be, that not even match-all
pointers could accidentally modify page tables.

In the future, would you think that both mechanisms (pkey PT table
protection + KASAN) would be active at the same time, or wouldn't there
really be a lot of value in having both enabled?

[...]

> 
> 
> Open questions
> ==============
> 
> A few aspects in this RFC that are debatable and/or worth discussing:
> 
> - Can the pkeys block allocator be abstracted into something more
>   generic? This seems desirable considering other use-cases for changing
>   attributes of regions of the linear map, but the handling of page
>   tables while splitting may be difficult to integrate in a generic
>   allocator.
> 
> - There is currently no restriction on how kpkeys levels map to pkeys
>   permissions. A typical approach is to allocate one pkey per level and
>   make it writable at that level only. As the number of levels
>   increases, we may however run out of pkeys, especially on arm64 (just
>   8 pkeys with POE). Depending on the use-cases, it may be acceptable to
>   use the same pkey for the data associated to multiple levels.
> 
> 
> Any comment or feedback is highly appreciated, be it on the high-level
> approach or implementation choices!

How crucial would the dedicated page table allocator be for a first up
streamed version?

Assuming we introduce this as a debugging feature first, it would be
perfectly reasonable to just disallow large block mappings in the direct
map when enabled.

That means, we could merge basic support first and think about how to
deal with page tables in a different way with most of the pkey details
out of the picture.

-- 
Cheers,

David
