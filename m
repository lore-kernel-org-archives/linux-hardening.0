Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9592E22A7
	for <linux-hardening@vger.kernel.org>; Fri, 22 Aug 2025 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849088; cv=none; b=iV32zKyn+7TqsWHcZ1if20T6/TTONIjgbYNgY5sHygaAQmLZ9IZfaNDbOickOx2d2oVcJTHcHB94o4w1mwPqjkZ74XxBd54lzSB+/rYNn8B2isw9zq1bKazlKq2pxuCwQ+J8LJVohR2tgeQJKqMIz9kpSWecF2gJfTzFcGE+DDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849088; c=relaxed/simple;
	bh=EzVFnCtDPX3VewuD7a5xpbgi83YXbGVIxJr1/roBtno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baumDMO0b1vde0RX8c2VexRm3dqd0tZ0SlQJqj1UQvds3tGRkdsHs07xO+ZhSe3mDOd/AWkC41rp5wywcb5q2/WP0Lxv6/WY9RR8kLV98xqkBDq2cVQSGSXEOStYbs3a0/R7+B10ROCW1/jjhzL7fEPxW1Dkwjz2VcbaUMbbS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pu2Ms+rA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pu2Ms+rA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=DRb4kG7LHA7kCWIdk5laWn/cggdazE/gWNLQbrC/2QE=; b=Pu2Ms+rA4vF2n4gbY4tcfu9dRa
	e4a9mcPP6v0J7DuT3nNiE6BqwFvwD0s6sPBLd08dO3sXEexOWJl4K5nG7VyZYfvdAXGHVQndUTeCp
	HeRGxvWtDDLwp14PajZ6s4rT5AZ20v93ZWwjEl6HD8Q9gcIDC53jOnDcsrZdcuBkolMFsR0Zg65UQ
	eORzEeW52y7Z3D9nChJuM8F/mE0jJlhWBfFPTieE0WRiqMJOZtNmkCHeMAGv3vdqy2S6u8B2zQZ4/
	TFMajrGPUcqE60LJLvVtsRQpb10Q/TFrsQ6FEE7GugYqcmyP0qhkYKmilu7bZkLSgIRBJoz1oTWT9
	A52HpV0A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upMYO-000000059d5-12EP;
	Fri, 22 Aug 2025 07:51:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3463C300342; Fri, 22 Aug 2025 09:51:15 +0200 (CEST)
Date: Fri, 22 Aug 2025 09:51:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Pinski <pinskia@gmail.com>
Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	Kees Cook <kees@kernel.org>, Qing Zhao <qing.zhao@oracle.com>,
	GCC Patches <gcc-patches@gcc.gnu.org>,
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
Subject: Re: [RFC PATCH 3/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <20250822075115.GE3419281@noisy.programming.kicks-ass.net>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-3-kees@kernel.org>
 <CALvbMcA+8iHo+zCCvs4UdAg9PVQVtgOno-rtMS4i5YajrjkyGw@mail.gmail.com>
 <20250821091220.GM4067720@noisy.programming.kicks-ass.net>
 <CA+=Sn1koTTQaXDnAVWtVU6ACWwhD08NR5nDJO236Pmcoi2X9qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+=Sn1koTTQaXDnAVWtVU6ACWwhD08NR5nDJO236Pmcoi2X9qA@mail.gmail.com>

On Thu, Aug 21, 2025 at 02:22:30AM -0700, Andrew Pinski wrote:
> On Thu, Aug 21, 2025, 2:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
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
> > > > +  const char *canonical_name = mangle_function_type
> > (fntype_or_fndecl);
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
> >
> 
> 
> So then just hash the function argument types. It only needs to be
> consistent for the objects that are compiled together right?

Function argument and return; but yes that could be done. Ideally the
kCFI implementation would be compatible between compilers. Specifically
rust is based on llvm and therefore generates kCFI that is compatible
with clang. Being able to mix GCC and rust code (as the kernel does)
would be nice.
