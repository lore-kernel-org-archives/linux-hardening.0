Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE1B3839A3;
	Mon,  8 Jun 2026 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904394; cv=none; b=c4ssPonwpnOrS4tIZ+MZhOv4Xyg6xiATTJLhiUZYcpQUreFKl9NuIhEfutZzdY3F8U1cxoPgCdiYHNzcSgqA/1iNwmrGg0yQhaGT5uuTnpDsMZ1C9z83DUzvBHnerF/QUWJQsay38n6nq1iZu/6S+ZFLad/Q3SYeIFFs8d4mWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904394; c=relaxed/simple;
	bh=+BOKFQV0KT8sz9ClxbiHowEXEsGD4Xg2I3Yh/kqc88I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Crx1wY7kYVokApxLueYumh1Fh9pUCo0Iq9Vsll5MyOHhJyTKsL1PL3Uu3YF+3U8HnA6eipZlsQPY29pUGidDID+huU5Zz/T0glfKH3XX0mLil81uOSiqqmvT3Pnjc3p4Pb6HN1ji9Y0FR7qtHhaBpA5bQ/j6skO63rwiymPbJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKVxHHpk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKVxHHpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2471F00893;
	Mon,  8 Jun 2026 07:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780904393;
	bh=oFXj61iq7NVS/Dg2bghSDW8PukDo+it9Sj1z6NSrpwk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CKVxHHpk8X3NtAd+6WoAvNfNyINzICT8pCwrYI2TVmm050HhSwfks93/zAutElxza
	 4tPWhLQ6K1hw4KWdO1wOeyHmbfV936RKqj13Jv0Xi5q35H7AtaxWIT7+1O76wI7gy5
	 P2IXuwD5Lt7fFADxxf4LO/kAyazaTWluWn1EoucDP6hl3yf68+/GAn8Bcjur1jyXlQ
	 OwU68dwWG3EqtZDNqw/MH/7N9Nu9jEHmK9cXMfib/jwb0NnQReogXh97T6mtcScsAJ
	 L64TFd2h/+Ic6T0Hn0/CaiHYsBkPfDN8dzLMJNb5RYcrbEtQtf0tycscG4oWIfdeQ7
	 cWXJbEYjCouUQ==
Message-ID: <7906bad7-4e64-40c0-a724-f55ac44e12ab@kernel.org>
Date: Mon, 8 Jun 2026 09:39:49 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/mm/slab: document cache isolation with
 SLAB_NO_MERGE
Content-Language: en-US
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260606155856.15548-1-med08elkadiri@gmail.com>
 <20260607070645.9559-1-med08elkadiri@gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260607070645.9559-1-med08elkadiri@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/26 09:06, Mohammed EL Kadiri wrote:
> Add documentation to slab.rst explaining when and how to use
> SLAB_NO_MERGE to protect security-critical slab caches from
> cross-cache heap exploitation.
> 
> The document covers:
> - When to use SLAB_NO_MERGE and what it communicates
> - How to verify merge status on a running system
> - Tradeoffs (memory cost vs performance)
> - Relationship to CONFIG_RANDOM_KMALLOC_CACHES, SLAB_TYPESAFE_BY_RCU,
>   and the slab_nomerge boot parameter
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> ---
> Changes in v2 (per Jonathan Corbet and Matthew Wilcox feedback):
> - Add content to existing slab.rst instead of creating new file
> - Fix markup: use plain function() without additional formatting
> - Use slab terminology consistently, not SLUB
> - Remove How merging works section (implementation internals)
> - Remove cross-cache attack class section (redundant)
> - Remove Bounded allocation volume criteria
> - Rephrase unmergeability guidance per Matthew Wilcox suggestion
> - Add Assisted-by tag per coding-assistants.rst
>  Documentation/mm/slab.rst | 60 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/Documentation/mm/slab.rst b/Documentation/mm/slab.rst
> index 2bcc58ada302..c485bd257c44 100644
> --- a/Documentation/mm/slab.rst
> +++ b/Documentation/mm/slab.rst
> @@ -4,6 +4,66 @@
>  Slab Allocation
>  ===============
>  
> +Cache isolation with SLAB_NO_MERGE
> +===================================
> +
> +The slab allocator merges caches with compatible size, alignment, and flags
> +to reduce memory fragmentation. While this improves memory efficiency, it
> +allows objects of different types to share the same slab. This enables
> +cross-cache heap exploitation, where a use-after-free in one object type can
> +be leveraged to corrupt an unrelated type.
> +
> +SLAB_NO_MERGE prevents a cache from being merged, ensuring it receives a
> +dedicated slab. A freed slot in an isolated cache can only be reallocated as
> +the same object type.
> +
> +When to use SLAB_NO_MERGE
> +--------------------------
> +
> +SLAB_NO_MERGE should be considered for caches holding security-critical
> +objects whose corruption leads directly to privilege escalation, such as
> +credentials, cryptographic keys, or capability sets.
> +
> +It is harmless to specify SLAB_NO_MERGE even if the cache is already
> +unmergeable for other reasons (e.g., it has a constructor or a non-zero
> +usersize). The flag communicates intent and ensures the cache remains
> +isolated if those other properties change in the future.
> +
> +Verifying merge status
> +-----------------------
> +
> +To check whether a cache is merged on a running system::
> +
> +    # Check how many other caches share its slab
> +    cat /sys/kernel/slab/<cache_name>/aliases
> +
> +    # aliases > 0 means other types share this cache's slab
> +
> +Tradeoffs
> +----------
> +
> +**Memory**: Isolated caches may have partially-filled slabs that cannot be
> +used by other types. The overhead is typically a few extra pages.
> +
> +**Performance**: Zero impact on kmem_cache_alloc() and kmem_cache_free().
> +The only effect is at boot when the cache is created.
> +
> +Relationship to other mitigations
> +----------------------------------
> +
> +CONFIG_RANDOM_KMALLOC_CACHES creates multiple copies of each kmalloc size
> +class and randomly assigns allocations among them. It only affects kmalloc()
> +users and does not affect named caches created with kmem_cache_create().
> +
> +SLAB_TYPESAFE_BY_RCU delays freeing the slab by an RCU grace period. It
> +does not delay object slot reuse and does not prevent cross-cache merging.
> +It solves a different problem: safe lockless access to freed-and-reallocated
> +objects of the same type.
> +
> +The slab_nomerge boot parameter disables merging for all caches globally.
> +SLAB_NO_MERGE provides the same protection selectively for individual caches
> +without the global memory cost.

Matthew already pointed out in v1 that these last 2 are unnecessary.

I think this is approach unproductive, sorry. IIUC a newcomer to the
community, with help of a LLM (I however appreciate the openness about it,
with Assisted-by: tag), but multiple senior people have to provide input to
hopefully make it into an acceptable shape. This SLAB_NO_MERGE flag isn't
that crucial to go through all of this. We could just add a comment about
security use cases to the comment above #define SLAB_NO_MERGE and that's it.

So please considers other ways of getting involved in the community (which
is otherwise welcome), as this is not a great one. Thanks.

> +
>  Functions and structures
>  ========================
>  

