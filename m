Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265222F872
	for <linux-hardening@vger.kernel.org>; Fri, 22 Aug 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857038; cv=none; b=UaspJM81mNRKYsXXVTgq+98Dz6JgrQy27cb8m3tEkfl+7er34zPOKtF/4gNFIxNSsQCoAYuYGfbiJs6QaxtxVVRhmHP0FBB8n8qQVzsTen0cjcJTldEEnhApVhpi9ZqM3SHNkv2TfxJ8lAA4FFSZxQIw5AnktCVN/8C3Vaao4bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857038; c=relaxed/simple;
	bh=sbCBKcHt+c/Q4R+FgRGXe3e2bGUwC4W9lFkdO9hTanY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abiPAbICsDHrht9QbY/ZHxwX5HyY0mpmmLajTbPCFsxLuBkjsMARDKVuHEupQYZ9DFlRwkvUFyPngHh7XRAnOmVn3d5F4O1R9du2QGqtgaKKfH5+JsM04sATgm4nrVuaE0Mx/T5sQiWlED4sphVNDrAGL5EtFHZEygZBCFtFLB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q5cKyfF+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q5cKyfF+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LSpRcYgMV4yfzp+80xhTCTz2rhuCdiK9GUosugzgRmU=; b=q5cKyfF+FkK52bTYcrydVyQjCq
	aujrZ9xw8gwumGSSYV3wPG3XSIB6poAp7Zx2YazKMeLSUJJrtNg/GGhkNLwijHIVHIhnwv8I5SnOZ
	fsVQ4fgfvCpuN8XCwzUV75Jeq0LQ1hEBW99QVL5JCqDeLB0camvyKh+AXyH87PNz6JeiPkuFOXzO1
	xpgQXinh57J7BB/czgjJiV5JYgWF+yhk5Oys0FE0P/IvlaXYb0UZ69A+7CylCBkoJ+ue8VSc1xpdo
	g2fVWH63QDR6CvJg3LCMhBzIwNOffULN/zFhdoou0Zgi+8hwCtNEckfbJAUlHbkzeZtnhgf2yPD3p
	6ef0m1Yg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upOcd-00000006RZb-0sok;
	Fri, 22 Aug 2025 10:03:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CA399300342; Fri, 22 Aug 2025 12:03:46 +0200 (CEST)
Date: Fri, 22 Aug 2025 12:03:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>, Richard Biener <rguenther@suse.de>,
	Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	Joseph Myers <josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [RFC PATCH 3/7] kcfi: Add core Kernel Control Flow Integrity
 infrastructure
Message-ID: <20250822100346.GI3419281@noisy.programming.kicks-ass.net>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-3-kees@kernel.org>
 <CALvbMcA+8iHo+zCCvs4UdAg9PVQVtgOno-rtMS4i5YajrjkyGw@mail.gmail.com>
 <20250821091220.GM4067720@noisy.programming.kicks-ass.net>
 <q93o5262-po30-8n51-o17s-qrn0q96o51qp@fhfr.qr>
 <20250821142500.GS4067720@noisy.programming.kicks-ass.net>
 <15D39DFE-C110-442E-BF34-A850680767BE@oracle.com>
 <202508212211.77BED858A8@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202508212211.77BED858A8@keescook>

On Thu, Aug 21, 2025 at 10:15:31PM -0700, Kees Cook wrote:
> On Thu, Aug 21, 2025 at 06:09:08PM +0000, Qing Zhao wrote:
> > > On Aug 21, 2025, at 10:25, Peter Zijlstra <peterz@infradead.org> wrote:

> > > kCFI changes every function to have a preamble like (with IBT and
> > > retpolines and all the modern crap on):
> > 
> > Does “every function” mean all the function in the compilation? Not only the function whose address is taken? 
> 
> I tried to explain the specific logic on how the set of functions getting
> preambles is chosen in this other reply:
> https://lore.kernel.org/linux-hardening/202508211258.8DEE293@keescook/
> 
> If that didn't answer your question, let me know and I'll try again. :)

One detail that might be interesting is that ENDBR and the __cfi_\func
preamble should be the same condition. The way these features are
exposed doesn't make this obvious.

And in fact, marking an address taken function with __noendbr will
result in a function that has a __cfi_\func preamble, but no ENDBR
(clang-20). 

And while there is both a __noendbr and __nocfi attribute, they are
*VERY* different from one another. Where __noendbr inhibits the emission
of ENDBR and basically marks the function as impossible to reach with an
indirect call, the __nocfi attribute inhibits the CALL modification.

Notably, there is no function attribute to inhibit the __cfi_\func
preamble (and I'm arguing __noendbr should have that effect).


OTOH a function without __cfi_\func preamble but with ENDBR is 'unsafe',
but usable with a __nocfi call (typically reserved for calling external
code, like firmware). Anyway, we don't currently have means of
expressing this to the compiler (also, I don't care much in this case --
I think we should taint the kernel on EFI calls :-).
