Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763872E4270
	for <linux-hardening@vger.kernel.org>; Thu, 21 Aug 2025 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767554; cv=none; b=pKiXuo0C3pEwfSTuJZnZOZTKArnKZFpvx9jZVZMJ7a3SnjVWK74w7mGE06a0ie4L1ilV/gI0J7qSScAVOsf8ZSZSeeCCcDtAPT6trCA+PRv0a06Uap9QH/LDxMj17FQGo1wKyCXRTsSk7a3vLDfLYtcZMcFpyjVI30ydO8LAULs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767554; c=relaxed/simple;
	bh=zTsCd+wO7daq1Egnbg5owCghCTZOTDDTgc+44vGpAMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hokYVk9caOi/2U/avWVtf2Qz2pqazOEiMZa3iR+IyktfQJIGk+CYn4K5OEFkjsgsRobZqFwBv9PTJHNbMJnW12Y+aZoDFbL/BoZ/0RuyF7KVXIzsFGkAau8X11iskOf6Spnc2Z+djVjWXqM0+J9qZ5EHGIIZRt4rCF1RqZSx8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=niTQJenl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="niTQJenl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=33BFAsTu3c5JAkbtEVKaVNTUH9RaOaClZC+LoOPHjlQ=; b=niTQJenlo40qfsClzpouiffQpc
	+e8YZHurxyBtYoEJT+AD/2/crZx0kemmqqsaQ8p7PE82DUvwVlxi5Q/a226K5VW04TJ6rYNWC63+Q
	eJk34UATOyeHnwHli+1zAGt/+H5UxUsA65rmfy9Z2ojVr1VPGj/YutTpcvmcXDnFAq4kVRhnyU0lX
	TUPXmv1e8CC8xtSYjeKlp2fOmbHlPjs3kyn1E79kQD8F1vbsksPk2YWSI0q9EbhOZBPDQ7azfpj7Q
	7xsb4KyNSLgYft4gK7N/pw3Ey7rSxY6OxN3UHVoNGjiujBSoqnaTJrGhtJOKfUolNhNaM9eDsOnj1
	T2/QxJ8Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up1LJ-000000048JA-0V9f;
	Thu, 21 Aug 2025 09:12:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B8E563002C5; Thu, 21 Aug 2025 11:12:20 +0200 (CEST)
Date: Thu, 21 Aug 2025 11:12:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Kees Cook <kees@kernel.org>, Qing Zhao <qing.zhao@oracle.com>,
	gcc-patches@gcc.gnu.org, Joseph Myers <josmyers@redhat.com>,
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
Message-ID: <20250821091220.GM4067720@noisy.programming.kicks-ass.net>
References: <20250821064202.work.893-kees@kernel.org>
 <20250821072708.3109244-3-kees@kernel.org>
 <CALvbMcA+8iHo+zCCvs4UdAg9PVQVtgOno-rtMS4i5YajrjkyGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvbMcA+8iHo+zCCvs4UdAg9PVQVtgOno-rtMS4i5YajrjkyGw@mail.gmail.com>

On Thu, Aug 21, 2025 at 01:16:56AM -0700, Andrew Pinski wrote:

> > +/* Compute KCFI type ID for a function declaration or function type
> > (internal) */
> > +static uint32_t
> > +compute_kcfi_type_id (tree fntype_or_fndecl)
> > +{
> > +  if (!fntype_or_fndecl)
> > +    return 0;
> > +
> > +  const char *canonical_name = mangle_function_type (fntype_or_fndecl);
> > +  uint32_t base_type_id = kcfi_hash_string (canonical_name);
> >
> 
> Now I am curious why this needs to be a mangled function name? Since the
> function in C the symbol is just its name.
> Is there documentation that says the hash needs to be based on all of the
> function arguments types?

The whole point of kCFI is to limit the targets of indirect calls to
functions of the same signature. The actual function name is immaterial.
