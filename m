Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E6D216E14;
	Mon,  9 Dec 2024 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740161; cv=none; b=JPBgm9WXXwSLY3HiHECday1Wjq8EDr4wSaq5yIoeR9SLZ7+sIKC7bC7SvfUv0Xpn5jbXxJVRHMmy1MyHPsGPoPPytvOsmmd8X8MR2kPIG6Q+TXa/st3KDdEVQ1j+aEPfnzCL+2kdHNzXRdbalkuFDzrn7oTzXvSsp4dbBxZBxZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740161; c=relaxed/simple;
	bh=+bTYXK0jrTom1pGZmyvIVQuYsLJTy8SR4A4zIcAxvdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9rBrSwfGOgZhlvmlnyvyUFGc8l27AMfAx6+8cdiebZ0zbK3hHpNcVWYsn9JS+bmVMI29H+gpNsHNQ07RunWf08cqwNFc69FwghGzV2eSUosyXMxxrg9D2Rb78ejoT/KssBk+DQhtjUuZUO8ugQ287Ma3WAgsBtrokQpEFx/Owg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PweqRT0q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PweqRT0q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OwyB39CTHJItaPJMEkgmfbCR+5h4SkV01S+BaiaQNUE=; b=PweqRT0qTad9szFeFrP/3wFWgV
	G+rE52BJVCWGEtJdcEJBF7uBGFl5C/3zBQqli1dXtNLe2xD/4Z/Z8ZBczPwm4W3lOM8RCjpCNNhNW
	qU2qVTjAN4HhH05MMd3wu0PYTjIcZ+zor4GvWB5ZNXgLZGY7bV6/g7lnB0aeLjwBkstz40RxP6yBx
	rM2jGPOQwECfIV0R7Dbq9aLER8Yf5o3vD7sao85/Z1l4M7howYVQajrqTSKreE5bxK7zWJnqWbKw0
	iXGNpz+IWIJtQWmItGqr+ekrk9KBG2Ts94afNQXCL46iEgXlyn3N8E33vc6tZeQb1yEWpetdcTCYD
	JJw8aUTw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKb0s-00000001HHL-2aAc;
	Mon, 09 Dec 2024 10:29:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DFC9A3003FF; Mon,  9 Dec 2024 11:29:13 +0100 (CET)
Date: Mon, 9 Dec 2024 11:29:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	aruna.ramakrishna@oracle.com, broonie@kernel.org,
	catalin.marinas@arm.com, dave.hansen@linux.intel.com,
	jannh@google.com, jeffxu@chromium.org, joey.gouly@arm.com,
	kees@kernel.org, maz@kernel.org, pierre.langlois@arm.com,
	qperret@google.com, ryan.roberts@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: Re: [RFC PATCH 13/16] arm64: mm: Reset pkey in __tlb_remove_table()
Message-ID: <20241209102913.GJ21636@noisy.programming.kicks-ass.net>
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
 <20241206101110.1646108-14-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206101110.1646108-14-kevin.brodsky@arm.com>

On Fri, Dec 06, 2024 at 10:11:07AM +0000, Kevin Brodsky wrote:
> Page table pages are typically freed via tlb_remove_table() and
> friends. Ensure that the linear mapping for those pages is reset to
> the default pkey when CONFIG_KPKEYS_HARDENED_PGTABLES is enabled.
> 
> This patch is a no-op if CONFIG_KPKEYS_HARDENED_PGTABLES is disabled
> (default).
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/arm64/include/asm/tlb.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> index a947c6e784ed..d1611ffa6d91 100644
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -10,10 +10,14 @@
>  
>  #include <linux/pagemap.h>
>  #include <linux/swap.h>
> +#include <linux/kpkeys.h>
>  
>  static inline void __tlb_remove_table(void *_table)
>  {
> -	free_page_and_swap_cache((struct page *)_table);
> +	struct page *page = (struct page *)_table;
> +
> +	kpkeys_unprotect_pgtable_memory((unsigned long)page_address(page), 1);
> +	free_page_and_swap_cache(page);
>  }

Same as for the others, perhaps stick this in generic code instead of in
the arch code?
