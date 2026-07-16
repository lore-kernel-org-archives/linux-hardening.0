Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8929514ABE
	for <linux-hardening@vger.kernel.org>; Thu, 16 Jul 2026 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784160452; cv=none; b=bTSEmOEY4exhGix30OLx+QVkoZvM1T8f0nALtlLLBv/FycR1F2CZ2HK4iieBtQSD+gwo9I+lrGbpJTuRzlbk7uKVFAbeGB/+XnTvGTCoX/07Y87Q5Z7z6Z5ty8oZMjJqdlhXVnUeZvqSGR71IPymbgypoTEGYqF502npNtOWaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784160452; c=relaxed/simple;
	bh=wgfCW1fSMpPq5KPCVAFP4tFRDSMFClIEEhDz4TrrvuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBj7qLS0aWzy5PppagGO+esKlG9YxwXlHV0VIxCAbgSD0b8BLI5uXTS4sYnZisi9NuSU+F7UZGdYF0aZtSn7Ujkh2YqZ2xW/es/UVAc+I6qwmp8ztCejqLQ/kTZujxjuH3pSPHP1e/LYOpLnrtNJ3+7H3iNEVGB375E+3/TLVlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTEPREWa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTEPREWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172611F000E9;
	Thu, 16 Jul 2026 00:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784160451;
	bh=jBjAzWrBA3w+7FwdLM+T0DWeylnBp9ucm659cw/T3JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZTEPREWa+f11LPaKdf1YaGggT2ujvEQYk0LdQW45hTNey2pxthVUICwdQwzT3+V4R
	 yiPCnePe48funqANNfmGqIIbsZQMDbpcWxc4DFA5MvXE5gq1MSXneRw4OPBu35Hqcg
	 aMiNBeKJjnxM/ZVbnCqUxFWvVKbKoKBlQvnEVaOW7DKjG6cPTEJQxi4P1xhMogO/t9
	 cLaJwi6wCA+NBxORvmYnhKoseAiIA04CfYI87zWn8VtrrOXbYfi+m2StgqDbSVuw5d
	 UmJqaD/p3lH6H1v5zn1rdSB2RMpoV1l3wCQweGqGnVa4W0GM62rSJ3CpX457Q7a8Nf
	 +QD4c7nBBhd1g==
Date: Wed, 15 Jul 2026 17:07:30 -0700
From: Kees Cook <kees@kernel.org>
To: Andrea Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v13 1/7] kcfi: Introduce KCFI typeinfo mangling API
Message-ID: <202607151636.1AA31A76@keescook>
References: <20260618204530.work.910-kees@kernel.org>
 <20260618204539.824446-1-kees@kernel.org>
 <CALvbMcCiQ1b0KDrJHS-irGMWNEk5oWaWs31KQor2ZHPSVewQ=A@mail.gmail.com>
 <202607151151.AB5F1BD0@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202607151151.AB5F1BD0@keescook>

On Wed, Jul 15, 2026 at 12:06:17PM -0700, Kees Cook wrote:
> On Sat, Jun 27, 2026 at 03:00:42PM -0700, Andrea Pinski wrote:
> > On Thu, Jun 18, 2026 at 1:45 PM Kees Cook <kees@kernel.org> wrote:
> > > [...]
> > > +
> > > +    printf("\n================================================================\n");
> > > +    printf("Passed: %d Failed: %d (%d total tests)\n", pass, fail, pass + fail);
> > > +    return fail;
> > > +}
> > 
> > It would be a good idea to add a random generated testing here. See
> > testsuite/objc.dg/gnu-encoding and testsuite/gcc.dg/compat for
> > examples.
> 
> Okay, thanks for the pointer; I'll see what I can come up with. I
> generally dislike random testing since they may appear to be "flaky"
> when they trip, but I'll give it a shot.

I don't see anything we can do valuably here. There's no round-trip
parsing going on (there's no independent oracle). For the existing
mangling tests, I have hard-coded all the expected strings/hashes. I have
gone through the TYPE enums, though, and added a few other missed types
for the mangler. But I built a python-based fuzzer anyway, just to see if
I could find any other combinatorial ICEs, in case I missed some mixture,
and I could only crash the ToT GCC frontend. :P It's okay in 16.1?

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=126284

-Kees

-- 
Kees Cook
