Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188948;
	b=uKDayrLQTtVnj80pl0XtAegrYngZLFPCxNYzXOW7RdAxoQY7Nb6DuGmJR3ofFaLaUGJu
	 wNq/EXyJQuinnvgdU+drjRu6opKbTzjeuVJsnB1ZdRxoMaS3Gal2FNklfhcFSoi5iyRjA
	 aL1avAXGzldNzK5XHVneYiINoEASeOdJqrzLsb5IEbwjF6tsxAW+XOlodDWZTXGS/TBrv
	 /9O/83+tOWA3YQVWkMHfrvKVE6JK4CORRKwJwyjbXa60NZTIJS3WGCaoZbxor+EuXvNJC
	 u+HoyC1O2LvTlRICwKDP0rfA0I0SLOViErTyRFiwVMMJHTJNQjkJVMVdbJUVq8S583Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188948;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bKXnlJQcC9lfAbgfnChAxO8on9ok8Uo3r9Z9pVLG5Sk=;
	b=4FKTB7RiZV2tOlpzoLw9V3M1ZpFGb6wNa8loXa5iuKnIg9hvh0xncaVd/CCvi7j0vak+
	 IZhdnBMO7ZuMN30s23eQEZfTqzcEbv1ElIYU9DBTKIWWzzJRJhitmpycINVINapOhlqYU
	 oj/EsE7217lcnllg+/2CGMBAZtaidTljao+Xep0ewRhM//A794oceVzmhHPL6/N8b6A2D
	 OPzo03dxZFKs+mraBn5hMYcqKXfowrwjfA5TN6uY/HJMwpSYWuTHKgfpARkTBp6sLrM+J
	 zSLfUFb5GgtVUb2xA7nLpOeB+ys99W5cHuXAcpCjXc2MVWV61d8s3nhUfd8u7qPIUaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=IRPa7TpP;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DDA606A320;
	Fri, 20 Nov 2026 15:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49DDA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=IRPa7TpP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bKXnlJQcC9lfAbgfnChAxO8on9ok8Uo3r9Z9pVLG5Sk=; b=IRPa7TpPHsnT/ra5sUUE6nmmkB
	8P1n6yQJcq2GMDGyQVtbMxn/cHc2WefNjB+1CK32Sfiu6DNPMmx26zU8dhlcPCq40gidiOBIcY7iB
	KN+LKbEXNQqt8X4f35Vx3I5QNA7Sig73odA4e4EktGdzeFQotc9n6Ye5Z5XjamXEMxqX4o528r8EW
	g0Oyllqz/wWvtxVWw64I3NyvSDfzYlQ6f/YwdPB3Migc10cTTulsKbcwEGnOOfx+Lh45Biw70tdh1
	lXQbT1xTmv3HmstzqOZACeZKU09nHai+NRCoQRDviBCMb/nx0E7ZDaDkV9/wFC1djHfRHQlM5Eu7Z
	+wJT5scQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQeL-00000000uYP-3mJ7;
	Fri, 20 Nov 2026 15:35:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DFD2E3008D6; Fri, 20 Nov 2026 16:35:39 +0100 (CET)
Date: Fri, 20 Nov 2026 16:35:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Usama Arif <usama.arif@linux.dev>, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	kees@kernel.org, hpa@zytor.com, gustavoars@kernel.org,
	ardb@kernel.org, hca@linux.ibm.com, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, riel@surriel.com,
	shakeel.butt@linux.dev, kernel-team@meta.com, rkeilty@meta.com,
	atish.patra@linux.dev, dgreid@meta.com
Subject: Re: [PATCH 2/2] x86/kstack_erase: Use REP STOSQ for large stack fills
Message-ID: <20261120153539.GW2668564@noisy.programming.kicks-ass.net>
References: <20261119213147.1094488-1-usama.arif@linux.dev>
 <20261119213147.1094488-3-usama.arif@linux.dev>
 <20261120104534.GO2668564@noisy.programming.kicks-ass.net>
 <20261120140200.53ec2557@pumpkin>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120140200.53ec2557@pumpkin>

On Fri, Nov 20, 2026 at 02:02:00PM +0000, David Laight wrote:
> On Fri, 20 Nov 2026 11:45:34 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Nov 19, 2026 at 01:31:08PM -0800, Usama Arif wrote:
> > > +#ifdef CONFIG_X86_64
> > > +#define __stackleak_poison __stackleak_poison
> > > +static __always_inline void __stackleak_poison(unsigned long erase_low,
> > > +					       unsigned long erase_high,
> > > +					       unsigned long poison)
> > > +{
> > > +	unsigned long count;
> > > +
> > > +	/* Short spans do not amortize the startup cost of REP STOSQ. */
> > > +	if (erase_high <= erase_low + 512) {
> > > +		while (erase_low < erase_high) {
> > > +			*(unsigned long *)erase_low = poison;
> > > +			erase_low += sizeof(unsigned long);
> > > +		}
> > > +		return;
> > > +	}
> > > +
> > > +	count = (erase_high - erase_low) / sizeof(unsigned long);
> > > +	asm volatile("rep stosq"
> > > +		     : "+D" (erase_low), "+c" (count)
> > > +		     : "a" (poison)
> > > +		     : "memory");
> > > +}
> > > +#endif  
> > 
> > Gemini seems to suggest 16-32 words would be sufficient to amortize the
> > REP STOS setup.
> 
> That really does sound like wishful thinking.
> Especially if you go back a few generations on the cpu architecture.

How old? I mean, Interlagos old, sure, but nobody should care about
performance there I think.

AFAICT Nehalem and later should be good with the 16-32 words. As would
all the various Zen chips.
