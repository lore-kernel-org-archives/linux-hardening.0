Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3213246EC;
	Sat,  9 May 2026 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778324700; cv=none; b=WgeV1Ue+51yW252SrqUIIit0AB4oHP8Zm43QrPk/IGpj3llqKl/dmsN7Dj2ffnIjxo3obCKGXPsniC0dqaRMP9w7ARTDgft435HmSThfyq+Sy4/52w9/XBR9E9pzWmEEewM6xu8rpBRUOHWVXmIdZ59oZPBTnHTt7sRqylW7H+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778324700; c=relaxed/simple;
	bh=DOaC/TlxANKYqj189x/Vjom6E7tSoJDFYVcRTh38yA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcuGi6uX3Y2r3dIwWFsfHMr+pybqFKOeG1VIXPJX+YYk9Kfk1W65DJqXffiucsHQyGwcXffQwPx78YjGhuoFtyuklaj/8+p1luDovusUBuPDRHTD5sS51u/a5NVJVy70N+7S0ya7k+PQs6eS86Z/MA2S7W+zn7cM6Q2k6PJD3TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=iYHwp/XR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WWrwA2q5; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="iYHwp/XR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WWrwA2q5"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A1D357A00BC;
	Sat,  9 May 2026 07:04:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 09 May 2026 07:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778324696; x=
	1778411096; bh=6oOr15lhB2hYKh+9zKzPi4kv7JyYr4PGQI35DlaGm7s=; b=i
	YHwp/XRv0gFo5lo0yIQ7J3BAhxjKzc3qK9tshRBnSUZQ7Mp9aH96+Wpnu1y3GWU3
	UXBfnZHHE6GUePMKSrbBXQJuHtmVhe/9KdUqGG9+g4zhdo82l7Zcl1wNVDqlWfBm
	0HyAlYwth+3lEoTET+zje/53ySJiy7rVG5PyRC/qflCORE5ANufiF3gyvsqWuejS
	ZVvEM4pS0vD0A/QbxyDRXtHCw20oKudQDFFA2vBKGA/Scp+UFHsrubM4oYb3YfFc
	0c7fd9TxoTejQVLLp8+rWmDTLqsAcWkkeCMi+qXc9w4jFWta2dg1XrRt9DqPoEyz
	mI4Y4mK1w9pcw9kRHdNuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778324696; x=1778411096; bh=6oOr15lhB2hYKh+9zKzPi4kv7JyYr4PGQI3
	5DlaGm7s=; b=WWrwA2q5wWAbrLhsibxkrHgSeKPAYsHWw5tDREWL+X9KWWCjoOm
	Tj0iUCm3Rmp6aAVYyK0yk+R+NKby83yPn53wIwthTfHnJz78Oa+JTVE6rGNRep91
	2Of0ERtNC5HHgqoOtjNNXOjXKmsdfZCqArYTECWPnOhPpkIjBdwdNRjI3iayuNW0
	Ku4e941xohI8IdchY9oU3+dABYK1gmmjISegRnmXW+cjZopAT5nlGzrBtEgMXa3y
	qCIx5172E05QgX+I87hfNYsFpD260mMQHZrZOJhi9LrA3VMcHTU3EerU5NK3G0iJ
	4UA1Q7m4UdN+qOzIBTgOpGiEV+Tkcj6jVig==
X-ME-Sender: <xms:1xT_acQi0EO7qMXtDm8A4xH3bnC6oCtAL9JeMPzrFxCVmjuR-8BfRA>
    <xme:1xT_aWNmGsd7QfhleS57DWKqiyZWzDjMW8wMj61CqFebOs00fkcCo1J_GMYeQxRep
    mzAKkJ7NWCjvQhaeV2Rr38xPLdnBsTdqskHhcNt4OXctLA0IyfBgD8>
X-ME-Received: <xmr:1xT_aRHVXMYQDA8sKpZv8qc0jHN-p59Ib5Xi6t33yZoI8iHSHcCjEf_3clsKnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudeftdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepfeetheejudeujeeikeetudelvdevkeefuddtkedvtdehtdetieeu
    ieetjeeugedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeef
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghruggsodhgihhtsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopehmrghr
    khdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopegrrhgusgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprhihrghnrdhrohgsvghrthhssegrrhhmrdgtohhm
X-ME-Proxy: <xmx:1xT_aWga9cOpYE_pyhIBjzdsgHr_rfOj1BkR1y3iWOZMCR7O-JxLzQ>
    <xmx:1xT_aVwT2YD9zGiOAPeWGTEZQ_AWNb9NzZ_CYTvN5hhr7Mxo-WSoZQ>
    <xmx:1xT_aSrdIdu-kum0CJwm9VQK2P8SdtM--gColK0Mkz7qx_7Oip9pCw>
    <xmx:1xT_abXbuN040Cx3-DrAvxcS65Gg5Dm0uUpPzmm_pOfKKNSxKF2kYw>
    <xmx:2BT_aavA9QRV2e0u10CUCCw742gCNFuNq8s1eS7dSWg3LPMBFYhS18xw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 07:04:54 -0400 (EDT)
Date: Sat, 9 May 2026 12:04:47 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 02/15] mm: Make empty_zero_page __ro_after_init
Message-ID: <af8UEuy-gfLj6DSV@thinkstation>
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-19-ardb+git@google.com>
 <3d1a6b5c-f3bf-462f-879a-cdb5b60868ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1a6b5c-f3bf-462f-879a-cdb5b60868ac@kernel.org>

On Tue, Apr 28, 2026 at 09:51:09PM +0200, David Hildenbrand (Arm) wrote:
> On 4/27/26 17:34, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > The empty zero page is used to back any kernel or user space mapping
> > that is supposed to remain cleared, and so the page itself is never
> > supposed to be modified.
> > 
> > So make it __ro_after_init rather than __page_aligned_bss: on most
> > architectures, this ensures that both the kernel's mapping of it and any
> > aliases that are accessible via the kernel direct (linear) map are
> > mapped read-only, and cannot be used (inadvertently or maliciously) to
> > corrupt the contents of the zero page.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  mm/mm_init.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index f9f8e1af921c..6ca01ed2a5a4 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -57,7 +57,7 @@ unsigned long zero_page_pfn __ro_after_init;
> >  EXPORT_SYMBOL(zero_page_pfn);
> >  
> >  #ifndef __HAVE_COLOR_ZERO_PAGE
> > -uint8_t empty_zero_page[PAGE_SIZE] __page_aligned_bss;
> > +uint8_t empty_zero_page[PAGE_SIZE] __ro_after_init __aligned(PAGE_SIZE);
> >  EXPORT_SYMBOL(empty_zero_page);
> >  
> >  struct page *__zero_page __ro_after_init;
> 
> I am no expert on BSS etc, but from what I understand, we'll still get zeroed
> page-aligned memory. I don't know if there is any other impact on not having it
> in bss.page_aligned. I assume no

IIUC, unlike BSS, it will be part of the kernel image. So kernel image
size will grow by PAGE_SIZE. But compressor will eat it as it is all
zeros, so it should be okay.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
