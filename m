Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672129BDA8
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786313; cv=none; b=dCJqQIsUYN1LqBjP74K+yPETvGVjOC2YqLlN04l/iNdSiJ62nrxQbmEsZf7oJLdVO4mHYzgC6C4UDQjE8FMzruoVpLr1GdpX3ku8/2mhFuQ5nFdzaIt+brjsWYp8pprni2oedNK0bzvfSZy9q9oyanpqE0jGsMZLHbugjW1F5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786313; c=relaxed/simple;
	bh=y4DoN253EQlq8bsfQq61eUatgXGvq55EoMRF53Yfn0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouRX6mQESvPO+i7wHivG+GNRLdYk+vhjx80TtSs1ItNTPkN3yyXcFhwA7gKhqMiCCcYvfidCWjugyNJ1ZNu1CMvP0edp5jmvi+nISR20W8sP0/qLoYVTtcEW7SBOxP8WCAfAFBEyTGkFip6DM6g3V9ls7gmPEyE2VaheTowpu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aDuBZE2+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aDuBZE2+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e9kMV4vY6kwakeMVJ8z6qT97kb1IiRen+iiNXAIUDiU=; b=aDuBZE2+EqMsxfQGQAp0U1lkSv
	nXOjGswOFLgZsqbfTfDBV7U5YzgQJ22zs3BVdzz1cCBrb7fG6FsFNxZLPAuaupH5I7PwbjSA5tlaU
	+Psbz5W801uh9RanilbqALxseZRp17C06J1uJxoTrDY24FY33ypjDtCEUoAiDmaX360W/lWjL537d
	OHbDvkPi29hyGrwhRPDI3kHZdlCsQ/RrcPtgDErox6EM5F3go0UWI9VYMLYeS8Z0aXNELyqQ8fK8c
	LsXs72VQANAPh9o13TmjHKxlg2YA0AdLjoWRcPREoJkmdGMiM7n5c+kNsufoDUZ21Eo8NX8wuAR8W
	e2yHJmsQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up6Ds-00000008iKK-3Lv1;
	Thu, 21 Aug 2025 14:25:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 71DD73002ED; Thu, 21 Aug 2025 16:25:00 +0200 (CEST)
Date: Thu, 21 Aug 2025 16:25:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Richard Biener <rguenther@suse.de>
Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	Kees Cook <kees@kernel.org>, Qing Zhao <qing.zhao@oracle.com>,
	gcc-patches@gcc.gnu.org, Joseph Myers <josmyers@redhat.com>,
	Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 3/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <20250821142500.GS4067720@noisy.programming.kicks-ass.net>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-3-kees@kernel.org>
 <CALvbMcA+8iHo+zCCvs4UdAg9PVQVtgOno-rtMS4i5YajrjkyGw@mail.gmail.com>
 <20250821091220.GM4067720@noisy.programming.kicks-ass.net>
 <q93o5262-po30-8n51-o17s-qrn0q96o51qp@fhfr.qr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q93o5262-po30-8n51-o17s-qrn0q96o51qp@fhfr.qr>

On Thu, Aug 21, 2025 at 01:01:37PM +0200, Richard Biener wrote:
> On Thu, 21 Aug 2025, Peter Zijlstra wrote:
> 
> > On Thu, Aug 21, 2025 at 01:16:56AM -0700, Andrew Pinski wrote:
> > 
> > > > +/* Compute KCFI type ID for a function declaration or function type
> > > > (internal) */
> > > > +static uint32_t
> > > > +compute_kcfi_type_id (tree fntype_or_fndecl)
> > > > +{
> > > > +  if (!fntype_or_fndecl)
> > > > +    return 0;
> > > > +
> > > > +  const char *canonical_name = mangle_function_type (fntype_or_fndecl);
> > > > +  uint32_t base_type_id = kcfi_hash_string (canonical_name);
> > > >
> > > 
> > > Now I am curious why this needs to be a mangled function name? Since the
> > > function in C the symbol is just its name.
> > > Is there documentation that says the hash needs to be based on all of the
> > > function arguments types?
> > 
> > The whole point of kCFI is to limit the targets of indirect calls to
> > functions of the same signature. The actual function name is immaterial.
> 
> What's the attack vector and how does kCFI achieve mitigating it?

Any of the attacks that can result in scribbling a function pointer.
Typically a buffer overflow I suppose.


The way kCFI works is by changing the indirect call ABI. Traditionally
the indirect call is simply:

  load-pointer-into-reg
  call *%reg

kCFI changes every function to have a preamble like (with IBT and
retpolines and all the modern crap on):

__cfi_\func:
  movl $0x12345678, %eax
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
\func:
  endbr64
  ...
   
And every indirect call site to:

  load-pointer-into-r11
  movl $(-0x12345678), %r10d
  addl $-15(%r11), %r10d
  je   2f
1:ud2
  .pushsection .kcfi_traps
  .long 1b - .
  .popsection
2:cs call __x86_indirect_thunk_r11 

Where 0x12345678 is the appropriate signature hash.


So if the loaded pointer is scribbled somehow, the hash embedded at the
callsite no longer matches the hash in the function preamble and #UD.

The kernel is also going to rewrite this if the hardware supports IBT,
into a FineIBT sequence (with too many variants :-/), but I'll spare you
those details.

Those people interested can find it here:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/alternative.c#n1298



