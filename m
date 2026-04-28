Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CA2428828;
	Tue, 28 Apr 2026 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777379253; cv=none; b=lhJ2LMJ/OS7x/0hdWtXrsh89hEbsyaty6VjUktOT41kKD7g0ZsJNyHxG1bTDUwTn3NLHtcSvOjNA1AcxAjXtMr0dkdiIDGq/r3H17RaDE3T19ol9/6kFQ6akZXejYkwX11xr7vN32kfB56cZNoGFdQANJ7bq1HiLXGBCHBVGxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777379253; c=relaxed/simple;
	bh=oXW2BuxDEEJJgDVSv85Sq/XrKA16JupO5CMfYwPGdtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6O2SUTlldwNzbQgaXPlvdZJh2k7R0y1xkiV0MU6aq90J14hoG43fpiOqs3Kl/Pqv3r+63l3zdP4DX37zk/GGitFqk2KpJnZRmWm5elYKc0qD0CH+SH2QryPKJc00v11E62e256y+HP5eXfc1DScgVlr7aoBaD2Juu/X2Zgf8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtFCNgTA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtFCNgTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0504EC2BCAF;
	Tue, 28 Apr 2026 12:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777379252;
	bh=oXW2BuxDEEJJgDVSv85Sq/XrKA16JupO5CMfYwPGdtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TtFCNgTA2p/mjwznidoIND1qLBGVv3UQduA0gVwAsewf5q1TlbcO5jwTODxHc5JoN
	 h1RCw0V5QVuBkeotKfTgdSjuW5CO2ySjpRm4tI+y7L7FuAqaa7Dp9QQ69H7u8Ehn7i
	 IC7yJnJQPhLrycdgF17ueA+2wox7S8UIsB00pQqIZomyw2wX/EU2MWDh84xmHzN0sV
	 DJ7XTFv3JBHxH6uuIy352oeNt9n8HWU1MprKg+AIjkg/gVuoVf2oa5dWa2tLl2fAmA
	 c0QmFGBXbzw9Lt5wv4wdPuEWr6Ri4UVEuxyRnGA4fOBleln596cayCqahje7lwUg0V
	 cLm2ZHZXfE+BQ==
Date: Tue, 28 Apr 2026 14:27:23 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 02/15] mm: Make empty_zero_page __ro_after_init
Message-ID: <afCnq17NWvM4T4vC@kernel.org>
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427153416.2103979-19-ardb+git@google.com>

On Mon, Apr 27, 2026 at 05:34:19PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The empty zero page is used to back any kernel or user space mapping
> that is supposed to remain cleared, and so the page itself is never
> supposed to be modified.
> 
> So make it __ro_after_init rather than __page_aligned_bss: on most
> architectures, this ensures that both the kernel's mapping of it and any
> aliases that are accessible via the kernel direct (linear) map are
> mapped read-only, and cannot be used (inadvertently or maliciously) to
> corrupt the contents of the zero page.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/mm_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f9f8e1af921c..6ca01ed2a5a4 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -57,7 +57,7 @@ unsigned long zero_page_pfn __ro_after_init;
>  EXPORT_SYMBOL(zero_page_pfn);
>  
>  #ifndef __HAVE_COLOR_ZERO_PAGE
> -uint8_t empty_zero_page[PAGE_SIZE] __page_aligned_bss;
> +uint8_t empty_zero_page[PAGE_SIZE] __ro_after_init __aligned(PAGE_SIZE);
>  EXPORT_SYMBOL(empty_zero_page);
>  
>  struct page *__zero_page __ro_after_init;
> -- 
> 2.54.0.rc2.544.gc7ae2d5bb8-goog
> 

-- 
Sincerely yours,
Mike.
