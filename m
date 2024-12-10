Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB491A0B13;
	Tue, 10 Dec 2024 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833632; cv=none; b=adqVhDcWbFNk4XFQqlpNnhl7noB7H7ZhSVKaJhBJiss4aBzA0y5yrrTsitRpx7q6oSu68q01LeCxrZw727h7GurgjZnjDuEpD9lrLOsqRp3iRGBQVQTzlizO4tC7rWzT+o4xisG5g3KM9oviBe+5aZP53ChBWA92sZYL4a2H4Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833632; c=relaxed/simple;
	bh=Ld7f7CMd9xrazwJHZykGooWo4/LKyuhiYTmOVOjFPJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hd2KAaL0oTQ2UhNKCrTWpb0cS3gsUfA/PYlwAt7nVxh6KGYKhy+HMCvaNlMaiiSlMlq9ZMP7u8H544Xiggkq9ZbeKG8zKL8lVDEzzkw/xRwn2A9l0EXoVnPbOG1ad8rFN03i9xemNxRCY0Pj/PpHVU3Y/OntGUnZM/+zRiCatNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hKa2p7rV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hKa2p7rV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=asCEkZ3HCMfe18rmMzExk2UpUIh0/XmzWsDd0egaSEE=; b=hKa2p7rV6W6OYuRhhTC5cTHhbX
	Mibcsrrs8SjTX3g20J3q7QPDl+implsVlKonWpylxnP+N+wxtWhlG68ClpotTryZZSFfZRxVMix++
	sh1nXGFNHkNywwDlvTMmYoSiSpAFoTpFYDjXTxZ8sef+yrUsPE2P9ASGMkewddJ5wXfT0c9fuu2ft
	Pum2Zn+EdEdNyych9lY3bvQ6VTfj40Nl/NWq4JuI05VTbLgARL+/cw58v+k5FbrJTfLnBpShxERwk
	Js+aVVY2wESMtDDRQqbZLATemXaaonTg8zBavBMXdtsjh9jhi6BPjRFPvDhcsyLSc5jx434T3FkTN
	sSVxtwuQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKzKU-00000003fsB-3SEN;
	Tue, 10 Dec 2024 12:27:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6598430035F; Tue, 10 Dec 2024 13:27:06 +0100 (CET)
Date: Tue, 10 Dec 2024 13:27:06 +0100
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
Message-ID: <20241210122706.GO8562@noisy.programming.kicks-ass.net>
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
 <20241206101110.1646108-14-kevin.brodsky@arm.com>
 <20241209102913.GJ21636@noisy.programming.kicks-ass.net>
 <7124d7f4-1d4c-4497-94d8-243af2ed071a@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7124d7f4-1d4c-4497-94d8-243af2ed071a@arm.com>

On Tue, Dec 10, 2024 at 10:28:44AM +0100, Kevin Brodsky wrote:
> On 09/12/2024 11:29, Peter Zijlstra wrote:
> > On Fri, Dec 06, 2024 at 10:11:07AM +0000, Kevin Brodsky wrote:
> >> [...]
> >>
> >> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> >> index a947c6e784ed..d1611ffa6d91 100644
> >> --- a/arch/arm64/include/asm/tlb.h
> >> +++ b/arch/arm64/include/asm/tlb.h
> >> @@ -10,10 +10,14 @@
> >>  
> >>  #include <linux/pagemap.h>
> >>  #include <linux/swap.h>
> >> +#include <linux/kpkeys.h>
> >>  
> >>  static inline void __tlb_remove_table(void *_table)
> >>  {
> >> -	free_page_and_swap_cache((struct page *)_table);
> >> +	struct page *page = (struct page *)_table;
> >> +
> >> +	kpkeys_unprotect_pgtable_memory((unsigned long)page_address(page), 1);
> >> +	free_page_and_swap_cache(page);
> >>  }
> > Same as for the others, perhaps stick this in generic code instead of in
> > the arch code?
> 
> This should be doable, with some refactoring. __tlb_remove_table() is
> currently called from two functions in mm/mmu_gather.c, I suppose I
> could create a wrapper there that calls
> kpkeys_unprotect_pgtable_memory() and then __tlb_remove_table(). Like in
> the p4d case I do however wonder how robust this is, as
> __tlb_remove_table() could end up being called from other places.

I don't foresee other __tlb_remove_table() users, this is all rather
speicific code. But if there ever were to be new users, it is something
they would have to take into consideration.
