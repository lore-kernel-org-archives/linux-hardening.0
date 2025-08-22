Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A72D1DD543
	for <linux-hardening@vger.kernel.org>; Fri, 22 Aug 2025 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755839732; cv=none; b=ebvkJ7cCZhVQevSgYR13ZlS2z+l8KLqMxh8kKLoNBp2eZ/h590thNHR8IGyv/AXmIU6ZLzkCjs2GA5vqhkDK3eoN53IDdDIVfx8yZ/EUdiorAO3qMImJudoPT5F4lxI3d4uBJDcYpdvDnhB6DYUOSYLWukP6aTYxL2tjLjNsVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755839732; c=relaxed/simple;
	bh=nsm8RvFd+KrNwKVTevP/oeZ81jy9SHfROVrCq1z+Mu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAZJX7OYN2XHUusWPQQCkcHrxWPuxYcfsrbuAFT1pWRVLAbmRmX7vShzgSfW3a5a5WvqAJ2PZMYEeZlhHW1Ic6MVQiih8fkMUzEJaSmxiwLB2o9Zf0UXLsEqunMzJSOkOXReqL/kSrEWU36SToKScxxzBGWvpQKA02/umnjqrwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDHpjXri; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDHpjXri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C18C4CEF1;
	Fri, 22 Aug 2025 05:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755839731;
	bh=nsm8RvFd+KrNwKVTevP/oeZ81jy9SHfROVrCq1z+Mu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sDHpjXriijMuMwUNRh/+PMuKGPKXOaZSPL8QmVtGM/Haa6obzV+CwihC9V9IYG1uH
	 UqOc/4gN5jsNK4PcUY5iKfUdI1tXdwC1IJxeoW3oRcuDZcDyBQCQXbjnIpwdOKafdd
	 eIB5UV5ksTfWSXd0vuCWk4URC1FRaD0iDBj2eOC+aNz76tLyIcCK+gFhUwvyw39ImK
	 U3A3ow6bbl7uyh+CeT6M1deuOjhL2W4YvEgGvVWpxgmNaC//qoCMvh1mA4mEx/e/iD
	 i2vFnpnWF0+f/2fnoIz8hNmoBkY5IrNyDqaKAqyJFELE5AOGGjVghTnqrRlgWC8V6T
	 0cOITuqgMjGPw==
Date: Thu, 21 Aug 2025 22:15:31 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Richard Biener <rguenther@suse.de>,
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
Message-ID: <202508212211.77BED858A8@keescook>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-3-kees@kernel.org>
 <CALvbMcA+8iHo+zCCvs4UdAg9PVQVtgOno-rtMS4i5YajrjkyGw@mail.gmail.com>
 <20250821091220.GM4067720@noisy.programming.kicks-ass.net>
 <q93o5262-po30-8n51-o17s-qrn0q96o51qp@fhfr.qr>
 <20250821142500.GS4067720@noisy.programming.kicks-ass.net>
 <15D39DFE-C110-442E-BF34-A850680767BE@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15D39DFE-C110-442E-BF34-A850680767BE@oracle.com>

On Thu, Aug 21, 2025 at 06:09:08PM +0000, Qing Zhao wrote:
> > On Aug 21, 2025, at 10:25, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Thu, Aug 21, 2025 at 01:01:37PM +0200, Richard Biener wrote:
> >> On Thu, 21 Aug 2025, Peter Zijlstra wrote:
> >> 
> >>> On Thu, Aug 21, 2025 at 01:16:56AM -0700, Andrew Pinski wrote:
> >>> 
> >>>>> +/* Compute KCFI type ID for a function declaration or function type
> >>>>> (internal) */
> >>>>> +static uint32_t
> >>>>> +compute_kcfi_type_id (tree fntype_or_fndecl)
> >>>>> +{
> >>>>> +  if (!fntype_or_fndecl)
> >>>>> +    return 0;
> >>>>> +
> >>>>> +  const char *canonical_name = mangle_function_type (fntype_or_fndecl);
> >>>>> +  uint32_t base_type_id = kcfi_hash_string (canonical_name);
> >>>>> 
> >>>> 
> >>>> Now I am curious why this needs to be a mangled function name? Since the
> >>>> function in C the symbol is just its name.
> >>>> Is there documentation that says the hash needs to be based on all of the
> >>>> function arguments types?
> >>> 
> >>> The whole point of kCFI is to limit the targets of indirect calls to
> >>> functions of the same signature. The actual function name is immaterial.
> >> 
> >> What's the attack vector and how does kCFI achieve mitigating it?
> > 
> > Any of the attacks that can result in scribbling a function pointer.
> > Typically a buffer overflow I suppose.
> > 
> > 
> > The way kCFI works is by changing the indirect call ABI. Traditionally
> > the indirect call is simply:
> > 
> >  load-pointer-into-reg
> >  call *%reg
> > 
> > kCFI changes every function to have a preamble like (with IBT and
> > retpolines and all the modern crap on):
> 
> Does “every function” mean all the function in the compilation? Not only the function whose address is taken? 

I tried to explain the specific logic on how the set of functions getting
preambles is chosen in this other reply:
https://lore.kernel.org/linux-hardening/202508211258.8DEE293@keescook/

If that didn't answer your question, let me know and I'll try again. :)

-Kees

-- 
Kees Cook
