Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52381287276
	for <linux-hardening@vger.kernel.org>; Fri, 22 Aug 2025 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852964; cv=none; b=YF9E1HHQYvzPt/dAImDNXl+LveywFDDUouEJdBd/q7POcEhxOc4JDD+iusHdvJaVtQJwK7sTHG6hBtDN3U10PV+iNZCNZGbRRAhfWf2pV4FHVreqjO8keGPvFdALFYidVRTfVYeuJuco2fLZyux+egnJVGJz1DhhoNodNa8F904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852964; c=relaxed/simple;
	bh=Mid0ILdRnfKnQQr8LQzl0fafR8QaPxtpIyzumbhIMHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvcjB5vCUeLsk0iwGXPbz2UBeiKydcle2T3MhI3GILTm6YoE1AOaxVo2SNB0Ho5/FotFLMsciZZLZIZ86PmhecdkmdKV8JwYmhsTa1I1cMOsjin9kJ4sEaMLo5opRVuBwAps95GxO7f7vsW87AZipIQM5dpisxfG67PASAMbcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sQ9g6h8h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sQ9g6h8h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Nr+eZMYFa+2jSoKD62jqGuRObp/r0Z6PkgbzazBrCTI=; b=sQ9g6h8hyuDao10vMjuFTVZDdM
	jKo/DjB+o86oqpxIDGuPGaK+izfJxKbXN43Pt2SReOUbaHrmneduHsXzSAZCgwMZXPrXn5ldNRND+
	gU5oN9Qqam5UVtfdHf3j305KDngP9Gw6m0QPJYn2zA8vacgln5OxCDiFhqbHICRPFG3Zpr9vwyg1D
	lgHbhh7ZJPADS7uvpPtwgrqa7LLADe+feXO5CCyYablK0Tc7Rp/9iIvqM8sku644d6jG5NeZIX1Vi
	71DiQdhx8axcU/a4V9vtU8+w1JR2vwhZILSvLMWxkCRmE8xoMmQ1s07i769PKsOI5gdRy2H820Ctv
	YSb9rYHQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upNYw-00000005jE7-0Zen;
	Fri, 22 Aug 2025 08:55:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B4815302F27; Fri, 22 Aug 2025 10:55:53 +0200 (CEST)
Date: Fri, 22 Aug 2025 10:55:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] x86: Add x86_64 Kernel Control Flow Integrity
 implementation
Message-ID: <20250822085553.GG3419281@noisy.programming.kicks-ass.net>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-4-kees@kernel.org>
 <20250821092935.GN4067720@noisy.programming.kicks-ass.net>
 <202508210916.71079E4BA8@keescook>
 <20250822081915.GF3419281@noisy.programming.kicks-ass.net>
 <202508220135.A0ABFC1@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508220135.A0ABFC1@keescook>

On Fri, Aug 22, 2025 at 01:36:43AM -0700, Kees Cook wrote:
> On Fri, Aug 22, 2025 at 10:19:15AM +0200, Peter Zijlstra wrote:
> > Anyway, I might be able to deal with the indirect call not being r11,
> > but it'll take a bit of prodding. Also it will shatter my plans to move
> > the hash to eax to save a few bytes in instruction encoding. Let me go
> > poke around with that UDB patch see what's possible.
> 
> I think I have it mostly working to force r11 when doing kcfi and
> retpoline now, though I'm seeing a few glitches still. I'll keep working
> on it.

Awesome, thanks!
