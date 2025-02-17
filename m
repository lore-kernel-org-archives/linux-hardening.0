Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF1D21C19E;
	Mon, 17 Feb 2025 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798010; cv=none; b=qiaCutV5zTeZJniBDi7cNETtrlnxjZ3wXIB8SbTHRJTm8kDSLQ2YEa0/ElmF24fJxNYagUeQR4N+0VNChl1zKKK33oSUvIL+CecZDsGSeZsC1Dtt+1hhVBOqpK0FsTH+IfNrW7DHDHCJYMjNjw9SUlph0Ji/c3BuQ1mL6n88H8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798010; c=relaxed/simple;
	bh=/Qj/NoOlFutO0wEcWfBTyUizqtHvMPVlYhAQkYbV1yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+9tx2TZm2PnxETFbyRUFvfrCTGB6lRjXy6HgYr/MJlfo4Panx9v3TrHL9xNPQcw1zv5bFPqQz2pzUtz1he68VFg5u0tdtFLRyn/efnMaxwy8C6xXdpSB5bZ8d/0qza7bdEf3sri4Bm8agKbkKBHu2DKbChZmAue7PsBOSQ/y7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h3l1/k/O; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h3l1/k/O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sx6hFMIPXfm6dAtS5cNhSjXA/ycePeZapi16K1yeE78=; b=h3l1/k/OvC4Jc0nxZY4uLEWjP4
	9/SAjCROevxT8NWT6f/geMBF4JoCXsJMEHe06SaTC0krSeJ0RA/4iZUUNtguf5gzUseZ7dzkrGWNA
	fUmfLbvdQm3bP+eoAPUDZsdXSaRub6M/tv1b2BRS0uRDy1AUJIDjesgqHra9wBNAWgR/fVw+8ubRA
	2oWnMaB5wBbTdRuSc2l02MSMES+GEs1axrIODGXcubIjhXJVq+Sm+ZH4F3kVvNssu9pMnfIAcerQw
	kcMWBNGQHxSDQs+RVPx3AydmpZJlhqgTiOkMZb/8Naw8Pf9GQHLL5T5FHUyJq6ff3z7ck1Lp9ueQl
	VCALhX3g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tk0w6-00000001pRD-0kW3;
	Mon, 17 Feb 2025 13:13:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0E159300756; Mon, 17 Feb 2025 14:13:21 +0100 (CET)
Date: Mon, 17 Feb 2025 14:13:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
	jannh@google.com, jmill@asu.edu, joao@overdrivepizza.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	luto@kernel.org, samitolvanen@google.com,
	scott.d.constable@intel.com, x86@kernel.org
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <20250217131321.GO14028@noisy.programming.kicks-ass.net>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <202502131224.D6F5A235@keescook>
 <6641d1e0-7151-4857-bb0e-db555d4cdf50@citrix.com>
 <202502131248.B6CC333@keescook>
 <20250214095751.GF21726@noisy.programming.kicks-ass.net>
 <20250215210729.GA25168@noisy.programming.kicks-ass.net>
 <20250217130629.37f556b0@pumpkin>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217130629.37f556b0@pumpkin>

On Mon, Feb 17, 2025 at 01:06:29PM +0000, David Laight wrote:
> On Sat, 15 Feb 2025 22:07:29 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Feb 14, 2025 at 10:57:51AM +0100, Peter Zijlstra wrote:
> > > On Thu, Feb 13, 2025 at 12:53:28PM -0800, Kees Cook wrote:
> > >   
> > > > Right, the "if they can control a function pointer" is the part I'm
> > > > focusing on. This attack depends on making an indirect call with a
> > > > controlled pointer. Non-FineIBT CFI will protect against that step,
> > > > so I think this is only an issue for IBT-only and FineIBT, but not CFI
> > > > nor CFI+IBT.  
> > > 
> > > Yes, the whole caller side validation should stop this.  
> > 
> > And I think we can retro-fit that in FineIBT. Notably the current call
> > sites look like:
> > 
> > 0000000000000060 <fineibt_caller>:
> >   60:   41 ba 78 56 34 12       mov    $0x12345678,%r10d
> >   66:   49 83 eb 10             sub    $0x10,%r11
> >   6a:   0f 1f 40 00             nopl   0x0(%rax)
> >   6e:   41 ff d3                call   *%r11
> >   71:   0f 1f 00                nopl   (%rax)
> 
> I tried building a fineibt kernel (without LTO) and that isn't what I
> see in the object files.
> (I not trying to run it, just do some analysis.)
> While the call targets have a 16 byte preamble it is all nops apart
> from a final 'mov $hash,%rax'.
> The call site loads $-hash and adds -4(target) and checks for zero.
> It is too small to be patchable into the above.

Right after that comes the retpoline site, which is another 6 bytes
(assuming you have indirect-branch-cs-prefix, which all kCFI enabled
compilers should have).

You need to go read arch/x86/kernel/alternative.c search for FineIBT

