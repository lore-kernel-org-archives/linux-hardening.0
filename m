Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5958329D281;
	Mon, 29 Jun 2026 04:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782708208; cv=none; b=as/TRhvNnMq5W1GiqkfedmXzss9pM550MPgLOAmww7SB4Ut13wNHnkU3eAEzfNCfQpfTxabDukTAZIHisZj9mVyH2ZBQd3YHK9e3y1AkjAR7Bvuh36kyLqSBAX5j+aky+ldRmoJPRT/1clgw2I+6Laj+6bwhxWyLrgNYQ2HLKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782708208; c=relaxed/simple;
	bh=unCVjL321DXaQRdotHd/KHT07H1NPIYGYZ67pykHzkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izg7455+0OlNlrg8vgCiApmaF0BgLLpmSFLtvMF1yhQCYayRVlqQ3HLC7g5y5dSRHQl2nhUzAA5J+9uJ7xLddQNLX2SHe++nByQyABTU8yNnUB2CsG96B7fzPD/a6a1EhGAWZz6ou01/xll81g9hmiNVBWKOf4YzkpXW64/V0Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nNDA8CB9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nNDA8CB9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ejAiWdMEnIVX/zERdGSuovRm+wQyGi2KlnG+GaTgKh4=; b=nNDA8CB9pf/u0o69aoat+9xEjK
	UsBg6eeiuDg1NqebWfVELKGI14y9YEGNg0EYgKlkndkXi0HWw80EKssucIj3VYsNe6IAPGi/faXV4
	JDhhS+7O1tZPXM7tsWaZnhu4885fEiZlmdIeyAJvSaUStolJcXo9ZYl33KS39HPeh0anYdPz530jF
	PVCD/lD0L69DXCt1syA5FvaUWuHKR2BfA/GT/v8h3CIJgoM0rpMtQ12Eix3Yyoe93X184Go9Z9HfE
	h2SsOCXFUnWxIF+tjC6pX8VGV3lD3GAiYHZnXotYm1IeHd7YF3QTc1vaRYo4gXXHODPZFOUBrJEqR
	QfX5J9Uw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we3pz-00000002bfS-0vuJ;
	Mon, 29 Jun 2026 04:43:15 +0000
Date: Mon, 29 Jun 2026 05:43:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Xiang Mei <xmei5@asu.edu>, Pedro Falcato <pfalcato@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-hardening@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>,
	Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>,
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>,
	Yan Shoshitaishvili <yans@asu.edu>
Subject: Re: [PATCH] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
Message-ID: <akH34ycu5-q2Yc_D@casper.infradead.org>
References: <20260626173444.2252041-1-xmei5@asu.edu>
 <aj7UNceukU9zYeGH@pedro-suse.lan>
 <CAPpSM+RVFDOYJFT2iwgNYdjbwqF-MmrbYizpLYksd1SLb5bT9g@mail.gmail.com>
 <499a4e15-34a4-421b-946a-c855199fdbf9@zytor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <499a4e15-34a4-421b-946a-c855199fdbf9@zytor.com>

On Sun, Jun 28, 2026 at 07:09:37PM -0700, H. Peter Anvin wrote:
> On 2026-06-26 13:05, Xiang Mei wrote:
> > 
> > Thanks for your questions and attention.
> > 
> > 1) `enter` can do big enough stack pivoting (where we can't find many
> > `add/sub/adc/sbb rsp, ` doing so)
> 
> Say what?
> 
> Using add/sub/lea on %rsp is probably more common than enter, because enter is
> considered kind of slow.
> 
> gcc, I believe, will generate "leave" but not "enter" as a result.
> 
> 
> > 2) `enter` is not rare since we can take part in the instruction.
> 
> This sentence doesn't parse.

They mean that we can jump into the middle of an instruction, and it is
not rare to see a 'c8' byte in the instruction stream.
