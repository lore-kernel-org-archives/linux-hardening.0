Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB72EBB89
	for <linux-hardening@vger.kernel.org>; Fri, 22 Aug 2025 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851073; cv=none; b=dKsp3Jv0KASMv39f6Jg4JsntW22nk5gFXwVwOE2fTCvShvjzU1mWX463cd9pNZwQA9yeqeYfPmW0DzFQiy3uYv+LHpbD5jzsb6LwzLqUq0al7/K1iCeuLG3QnkYeD8lWGCurHoAfWWL/Je2psHAHn5v6oGC4bmJUTgVISXUcGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851073; c=relaxed/simple;
	bh=Zd154Y6dtJ3a43+HK3yqLDY+DRIH/SSFfdTMKpQnKRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FC03E60sc4V9WKEiILmi25BpE6xXYHSM/9CEfq+Jn6ILna2Fqx47I08fprR5zt0ilSD2ToxPDJLW7QdpBGxg8YhZTZMnzqHZSGoA0Zry40JyfUZZKirin+Jo09D4o3qmSdA59oECJfHFF2VQySkZkTRZjLdEU92bo9ro3lt+uIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZeNYSB8d; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZeNYSB8d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=vC+MYu2fwp51BJ/SBcJaihv35nkf6fiSqHKCZf4Ewag=; b=ZeNYSB8d2hu0vVDcI2BYa/sSvj
	tyftHEmrcjhK30qmcc3IIzdeOC2/TogtyYa0nLGg+srmoDnI2/ICJs2Xum9UolMAaY/txJbPyDRPg
	rH3ahwH68o7l4Y5jk8ajLacpAHXbD4LKt2vN7QNrr4Y4N4bpKOBASX2XEsvIiXoVKdelkPLnFkrR4
	EtHa2tqiosTGblWWOVDRRej/yePsD5m0ejEtDBqWbK919SeKmmqm9CxitjWUD4Gg4oRyPTetEXnsU
	zvoauoXdn8mcil/lUPk8nSDmLFafe2FplhtlD/24zRTjn9N5foXbZJB/BVWYS+jzhubkM5fWivkeP
	52M3ZE/g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upN4P-00000000rmm-1Rfg;
	Fri, 22 Aug 2025 08:24:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 67159300342; Fri, 22 Aug 2025 10:24:20 +0200 (CEST)
Date: Fri, 22 Aug 2025 10:24:20 +0200
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
Message-ID: <20250822082420.GB1386988@noisy.programming.kicks-ass.net>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-3-kees@kernel.org>
 <CALvbMcA+8iHo+zCCvs4UdAg9PVQVtgOno-rtMS4i5YajrjkyGw@mail.gmail.com>
 <20250821091220.GM4067720@noisy.programming.kicks-ass.net>
 <CA+=Sn1koTTQaXDnAVWtVU6ACWwhD08NR5nDJO236Pmcoi2X9qA@mail.gmail.com>
 <20250822075115.GE3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822075115.GE3419281@noisy.programming.kicks-ass.net>

On Fri, Aug 22, 2025 at 09:51:15AM +0200, Peter Zijlstra wrote:
> On Thu, Aug 21, 2025 at 02:22:30AM -0700, Andrew Pinski wrote:
> > On Thu, Aug 21, 2025, 2:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Thu, Aug 21, 2025 at 01:16:56AM -0700, Andrew Pinski wrote:
> > >
> > > > > +/* Compute KCFI type ID for a function declaration or function type
> > > > > (internal) */
> > > > > +static uint32_t
> > > > > +compute_kcfi_type_id (tree fntype_or_fndecl)
> > > > > +{
> > > > > +  if (!fntype_or_fndecl)
> > > > > +    return 0;
> > > > > +
> > > > > +  const char *canonical_name = mangle_function_type
> > > (fntype_or_fndecl);
> > > > > +  uint32_t base_type_id = kcfi_hash_string (canonical_name);
> > > > >
> > > >
> > > > Now I am curious why this needs to be a mangled function name? Since the
> > > > function in C the symbol is just its name.
> > > > Is there documentation that says the hash needs to be based on all of the
> > > > function arguments types?
> > >
> > > The whole point of kCFI is to limit the targets of indirect calls to
> > > functions of the same signature. The actual function name is immaterial.
> > >
> > 
> > 
> > So then just hash the function argument types. It only needs to be
> > consistent for the objects that are compiled together right?
> 
> Function argument and return; but yes that could be done. Ideally the
> kCFI implementation would be compatible between compilers. Specifically
> rust is based on llvm and therefore generates kCFI that is compatible
> with clang. Being able to mix GCC and rust code (as the kernel does)
> would be nice.

FWIW, Kees, for this to actually work, we need this
CFI_ICALL_NORMALIZE_INTEGERS thing supported. Rust gets really upset
about LP64's whole 'long' vs 'long long' trainwreck :/

That is the -fsanitize-cfi-icall-experimental-normalize-integers
argument for clang (omg so long).
