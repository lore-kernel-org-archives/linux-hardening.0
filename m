Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8F2D061A
	for <linux-hardening@vger.kernel.org>; Thu, 18 Sep 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218972; cv=none; b=TuRUegPS9T25CxzF2SB3ySPW4QwwkWhTIrMUqHHUE3v/jIPaXI4DRslDZHABl0nJt9jz4qmDAnhhgD9TGZgaSB+wc+sSBrnMZ65ErP7irtbSFci1NBhRdlvjp0c7Whzk0AhInGFXqp+H8zu/ajnLB1nQY6uDWFfp3iGa+dwO4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218972; c=relaxed/simple;
	bh=kjBEt6MkG40/z+YfS1eNEbyv+uFn4J3WFEAYfkviYKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGAB5wBLxBEe9jUg4oaj9KtL9sQBoa/JJmoouFWuWGiZyvEDCjoDfKa37nTbQBjyjHKXfMZe5znNZzfbqTEVyQ3Za/V/TNH5NkO7lsgA5r4sE/5c/aZ88d+XIqlmurBUYKYC1TP2kIn4u2FMub8yD8wvujAIM3BTiThZy6tRsz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4vLrupD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4vLrupD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF412C4CEE7;
	Thu, 18 Sep 2025 18:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758218971;
	bh=kjBEt6MkG40/z+YfS1eNEbyv+uFn4J3WFEAYfkviYKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g4vLrupDPEZ6b8/r5L7XoTVZ6exD96CMRIXfjs4zjXeguX3kDuOQAavCkOgiOsEg9
	 k2vxyvp2BUO9lS0adXxSjB7zp+9+3StoMgtHkqzBmzDZCRRzr3a417GbGobNMkZMMV
	 LlWNlxuwtbRUNFPGINVXTRRt+J2fZNur8TBZ0/Dfu8kds2Y1u9MXg9TwMwcBl+yytq
	 6EM7GUgHSDAT6M2n0k61h0aHwHQ2ODW6pOY3HVWvzZBDYW8cmefezAejiAUuxOO5d5
	 ba7+YOcaMXWl6Z3uAFgziElaJh/DTexKp3+6tbhABnzx7xeySYsmskCS7/6rN/gM1H
	 OCt6uHWlmlhCQ==
Date: Thu, 18 Sep 2025 11:09:31 -0700
From: Kees Cook <kees@kernel.org>
To: Martin Uecker <uecker@tugraz.at>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Jan Hubicka <hubicka@ucw.cz>,
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
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] typeinfo: Introduce KCFI typeinfo mangling API
Message-ID: <202509181009.CBFE970D@keescook>
References: <20250913231256.make.519-kees@kernel.org>
 <20250913232404.2690431-1-kees@kernel.org>
 <D6E2A1BD-5D42-4492-B190-A2B845D8B0EE@oracle.com>
 <8d93c033c8060e79d2f0374a97827172f79ebdf8.camel@tugraz.at>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d93c033c8060e79d2f0374a97827172f79ebdf8.camel@tugraz.at>

On Thu, Sep 18, 2025 at 09:20:52AM +0200, Martin Uecker wrote:
> Am Mittwoch, dem 17.09.2025 um 17:56 +0000 schrieb Qing Zhao:
> > Hi, 
> > 
> > > On Sep 13, 2025, at 19:23, Kees Cook <kees@kernel.org> wrote:
> > > 
> > > To support the KCFI typeid and future type-based allocators,
> 
> What I find problematic though is that this is not based on GNU / ISO C
> rules but on stricter Linux kernel rules.   I think such builtin should
> have two versions.  
> 
> So maybe
> 
> __builtin_typeinfo_hash_strict // strict
> __builtin_typeinfo_hash_canonical // standard
> 
> or similar, or maybe instead have a flag argument so that we can
> other options which may turn out to be important in the future
> (such as ignoring  qualifiers or supporting newer languag features).

Can you send me a patch to gcc/testsuite/gcc.dg/builtin-typeinfo.c
that shows what differences you mean? Because AFAICT, this C version
matches the C++ typeinfo implementation. There isn't a need for these
hashes to be comparable in a way that they could be used to, for
example, reimplement __builtin_types_compatible_p. It's called
"typeinfo" and that has a specific meaning currently...

Given:

    typedef int arr10[10];
    typedef int arr_unknown[];
    typedef int *arr;
    typedef struct named { int a; int b; } named_t;
    typedef struct { int a; int b; } nameless_t;
    typedef void (*func_arr10)(int[10]);
    typedef void (*func_arr_unknown)(int[]);
    typedef void (*func_ptr)(int*);
    typedef void (*func_named(named_t*);
    typedef void (*func_nameless(nameless_t*);

C++ typeinfo(...).name() shows:

  int[10]:		A10_i
  int[]:		A_i
  int *:		Pi
  named_t:		5named
  nameless_t:		10nameless_t
  void(*)(int[10]):	PFvPiE
  void(*)(int[]):	PFvPiE
  void(*)(int*):	PFvPiE
  void(*)(named_t*):	PFvP5namedE
  void(*)(nameless_t*):	PFvP10nameless_tE

This __builtin_typeinfo_name(...) shows:

  int[10]:		A10_i
  int[]:		A_i
  int *:		Pi
  __builtin_compatible_types_p(int[10], int[]): true
  __builtin_compatible_types_p(int[], int*):	false
  named_t:		5named
  nameless_t:		10nameless_t
  void(*)(int[10]):	PFvPiE
  void(*)(int[]):	PFvPiE
  void(*)(int*):	PFvPiE
  void(*)(named_t*):	PFvP5namedE
  void(*)(nameless_t*):	PFvP10nameless_tE

What would you want the "Strict ISO C" builtin to do instead?

-Kees

-- 
Kees Cook
