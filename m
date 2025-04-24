Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339322147F6;
	Thu, 24 Apr 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485913; cv=none; b=SdyZT28xP4FszBNi8ZgfOkPDCvaHkbRomYe0jt4wMNZD+8joqbVOA4wseu3VibtP/8o979iqBj0taZ+qRS46magM7mrnePi+e355zdHYE21kQtrXgTAmlhodCjTp3BLw7EL605rkRNnZtExSO0ReAZD1awdblgNJSh2tO6bvIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485913; c=relaxed/simple;
	bh=15vRsUE0bDXeqQTgh2kUDIT+VRozCY31BdgeStUR/M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nION++yxj5aB09oS+c89ruiNmhYz56XTqzHXP5Jf3eAFI7AuhnL6H8sszHqzcSbwT4iEYCFfa/KCi/hexH9lYL24dG8bd4ibWLS2sb16xBxC+a52sCHMPGSLRJrRYayD4sxeScSU7BqUMmUbRfxxz0bqNQYqSgtdwbZzMr6OU3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIOomLFT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIOomLFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7193C4CEE3;
	Thu, 24 Apr 2025 09:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745485912;
	bh=15vRsUE0bDXeqQTgh2kUDIT+VRozCY31BdgeStUR/M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIOomLFTA32COw9i8Mv1mpV5Y4V63i1JGQc6qx8dJ9njwQwWpAnkL6ThhOAtCg8dH
	 2fQmcOS9B80t5Q8s9cFqB/tTu/9iOKjsfDL8VUzoLss+2r2Zb5bDLwNo5DwcW9nipx
	 RoY4qWXhiK8btBDAeFRWR0T28PeS8qITapO12PN6HIPz8m+hqGienY+sr9k9X/etyb
	 oU0tmOKsdEG/X7IimcgLEsJiWKxM7ULVhBZkvHVsG3kKnLW3obx2Wq6QMn5y5PheDn
	 pdr0glpa1vkwoxidfVrxXaMYlGlBS5kpimxy1ISQNcihWrQmTeqSyvjO7Lh8JVNFvm
	 hakoQIDL9XSuw==
Date: Thu, 24 Apr 2025 11:11:47 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Erhard Furtner <erhard_f@mailbox.org>,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm: vmalloc: Support more granular vrealloc() sizing
Message-ID: <aAoAU4vhrpxiXaLF@pollux>
References: <20250424023119.work.333-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424023119.work.333-kees@kernel.org>

On Wed, Apr 23, 2025 at 07:31:23PM -0700, Kees Cook wrote:
> Introduce struct vm_struct::requested_size so that the requested
> (re)allocation size is retained separately from the allocated area
> size. This means that KASAN will correctly poison the correct spans
> of requested bytes. This also means we can support growing the usable
> portion of an allocation that can already be supported by the existing
> area's existing allocation.
> 
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Closes: https://lore.kernel.org/all/20250408192503.6149a816@outsider.home/
> Fixes: 3ddc2fefe6f3 ("mm: vmalloc: implement vrealloc()")
> Signed-off-by: Kees Cook <kees@kernel.org>

Good catch!

One question below, otherwise

	Reviewed-by: Danilo Krummrich <dakr@kernel.org>

> @@ -4088,14 +4093,27 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
>  	 * would be a good heuristic for when to shrink the vm_area?
>  	 */
>  	if (size <= old_size) {
> -		/* Zero out spare memory. */
> -		if (want_init_on_alloc(flags))
> +		/* Zero out "freed" memory. */
> +		if (want_init_on_free())
>  			memset((void *)p + size, 0, old_size - size);
> +		vm->requested_size = size;
>  		kasan_poison_vmalloc(p + size, old_size - size);
>  		kasan_unpoison_vmalloc(p, size, KASAN_VMALLOC_PROT_NORMAL);
>  		return (void *)p;
>  	}
>  
> +	/*
> +	 * We already have the bytes available in the allocation; use them.
> +	 */
> +	if (size <= alloced_size) {
> +		kasan_unpoison_vmalloc(p, size, KASAN_VMALLOC_PROT_NORMAL);
> +		/* Zero out "alloced" memory. */
> +		if (want_init_on_alloc(flags))
> +			memset((void *)p + old_size, 0, size - old_size);
> +		vm->requested_size = size;
> +		kasan_poison_vmalloc(p + size, alloced_size - size);

Do we need this? We know that old_size < size <= alloced_size. And since
previously [p + old_size, p + alloced_size) must have been poisoned,
[p + size, p + alloced_size) must be poisoned already?

Maybe there was a reason, since in the above (size <= old_size) case
kasan_unpoison_vmalloc() seems unnecessary too.
