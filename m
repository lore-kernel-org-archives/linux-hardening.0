Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6957145B16
	for <linux-hardening@vger.kernel.org>; Tue, 30 Sep 2025 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759213271; cv=none; b=bLoZaMIqst2vUEkS0H+2tXs+p2Li1Tse/VnBZLnFW/dUfexBZK7fSaQV9OFyuWWHlP6PMum7st+o5tutNRf6hv479tPa2cWBv1asNIcSrnacAdJTZzEVWhc+Fh8ZP+ymJ/K9kCg8RakgXuh8kkk6J/oxc7wFz0M8WaVzWfFV8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759213271; c=relaxed/simple;
	bh=tN/WjEXtXCyRPFXqnSGBRckXOWqPAStUMy9jp8ujCaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BujIS+7uV7Zfdl33sJmSngxuG2eYcEWYiK9Hcz3LiOIESOX9vPHRIKUWn4ji/Rp7LxVsMCPis3FbvVe5JJq+gM7dW3++mWhmMvRRnKBo0nwHIv7qQSfP029yPU1aWweKa+UDRVc0a+yeaIErJurcYlmlY4dDBKrsOr7glQVOXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh0QMqn3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh0QMqn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19954C4CEF0;
	Tue, 30 Sep 2025 06:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759213271;
	bh=tN/WjEXtXCyRPFXqnSGBRckXOWqPAStUMy9jp8ujCaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nh0QMqn3Wbcy0/Qq3Bs+cAd6GHRatE0AQBul3BMeb4UokTt4vKuzFN4AXbwSlLmO3
	 nP36uxSsAyL2LiLWXM0aS8lMWqJzRh60bSRUxbFfz51Q5hinRfRlj/P8xtxjtNFk5D
	 QU+uq5A2bNbB4k62+YDNxwGWHioKzX/JuYcfZ5vvytzi5nJaDCfwlvyl5sKG3AvxEn
	 2fZQoVTOLkpADygxvJp2b/sJeFQuvwP74sa/sK+8GtHs8QgkqfDTatroUCINtNNMN6
	 iETwgbCoRmTTdpI9gOcfKpHezFx0N+RmQ8kwhvNqyDAJ8zEPGignR8gm54CNLAt7Rt
	 eKzt7mWpQ3sTA==
Date: Mon, 29 Sep 2025 23:21:10 -0700
From: Kees Cook <kees@kernel.org>
To: Martin Uecker <uecker@tugraz.at>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jeff Law <jeffreyalaw@gmail.com>,
	Jan Hubicka <hubicka@ucw.cz>,
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
	Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 1/7] typeinfo: Introduce KCFI typeinfo mangling API
Message-ID: <202509292318.D9BC37B@keescook>
References: <20250926023737.it.616-kees@kernel.org>
 <20250926030252.2387681-1-kees@kernel.org>
 <def69866c55cfb9ae3b32cecec0ca667b6fc627d.camel@tugraz.at>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <def69866c55cfb9ae3b32cecec0ca667b6fc627d.camel@tugraz.at>

On Mon, Sep 29, 2025 at 12:34:02PM +0200, Martin Uecker wrote:
> Am Donnerstag, dem 25.09.2025 um 20:02 -0700 schrieb Kees Cook:
> 
> > 
> > An important aspect of the C++ typeinfo behavior that is retained here
> > is that typedefs are treated as pass-through except when the underlying
> > type lacks a tag (i.e. anonymous struct, union, or enum). This provides a
> > distinction between those typedefs and typedefs used to provide _aliases_
> > (u8, uint16_t).
> > 
> > In the future, an additional "strict mode" builtin helper pair could
> > also be added to follow strict ISO C type equivalency instead of the
> > existing typeinfo used here, but that is out of scope for this patch.
> 
> The ISO C mode would be *less* strict.  Or in other words,
> the current version would reject valid C programs at run-time.

Ah, gotcha.

> I try to point out the differences below.
> 
> 
> 
> > +
> > +    /* Test pointer types */
> > +    TEST_STRING(char*, "Pc");
> > +    TEST_STRING(int*, "Pi");
> > +    TEST_STRING(void*, "Pv");
> > +    TEST_STRING(const char*, "PKc");
> 
> > +
> > +    /* Test array types */
> > +    TEST_STRING(int[10],  "A10_i");
> > +    TEST_STRING(char[20], "A20_c");
> > +    TEST_STRING(short[],  "A_s");
> > +
> > +    /* Test basic function types */
> > +    extern void func_void(void);
> > +    extern void func_char(char x);
> > +    extern void func_short(short x);
> > +    extern void func_int(int x);
> > +    extern void func_long(long x);
> > +    TEST_STRING(func_void,  "FvvE");
> > +    TEST_STRING(func_char,  "FvcE");
> > +    TEST_STRING(func_short, "FvsE");
> > +    TEST_STRING(func_int,   "FviE");
> > +    TEST_STRING(func_long,  "FvlE");
> > +
> > +    /* Test functions with unsigned types */
> > +    extern void func_unsigned_char(unsigned char x);
> > +    extern void func_unsigned_short(unsigned short x);
> > +    extern void func_unsigned_int(unsigned int x);
> > +    TEST_STRING(func_unsigned_char,  "FvhE");
> > +    TEST_STRING(func_unsigned_short, "FvtE");
> > +    TEST_STRING(func_unsigned_int,   "FvjE");
> > +
> > +    /* Test functions with signed types */
> > +    extern void func_signed_char(signed char x);
> > +    extern void func_signed_short(signed short x);
> > +    extern void func_signed_int(signed int x);
> > +    TEST_STRING(func_signed_char,  "FvaE");
> > +    TEST_STRING(func_signed_short, "FvsE");
> > +    TEST_STRING(func_signed_int,   "FviE");
> > +
> > +    /* Test functions with pointer types */
> > +    extern void func_void_ptr(void *x);
> > +    extern void func_char_ptr(char *x);
> > +    extern void func_short_ptr(short *x);
> > +    extern void func_int_ptr(int *x);
> > +    extern void func_int_array(int arr[]); /* Decays to "int *".  */
> > +    extern void func_long_ptr(long *x);
> > +    TEST_STRING(func_void_ptr,  "FvPvE");
> > +    TEST_STRING(func_char_ptr,  "FvPcE");
> > +    TEST_STRING(func_short_ptr, "FvPsE");
> > +    TEST_STRING(func_int_ptr,   "FvPiE");
> > +    TEST_STRING(func_int_array, "FvPiE");
> > +    TEST_STRING(func_long_ptr,  "FvPlE");
> > +
> > +    /* Test functions with const qualifiers */
> > +    extern void func_const_void_ptr(const void *x);
> > +    extern void func_const_char_ptr(const char *x);
> > +    extern void func_const_short_ptr(const short *x);
> > +    extern void func_const_int_ptr(const int *x);
> > +    extern void func_const_long_ptr(const long *x);
> > +    TEST_STRING(func_const_void_ptr,  "FvPKvE");
> > +    TEST_STRING(func_const_char_ptr,  "FvPKcE");
> > +    TEST_STRING(func_const_short_ptr, "FvPKsE");
> > +    TEST_STRING(func_const_int_ptr,   "FvPKiE");
> > +    TEST_STRING(func_const_long_ptr,  "FvPKlE");
> 
> 
> This ok, but there is a proposal to relax the rules for
> qualifiers, so in the future preserving all qualifiers
> might be too strict for C.
> 
> 
> 
> > +    /* Test 2D VLA with fixed dimension: should be all the same.  */
> > +    extern void func_vla_2d_first(int n, int arr[n][10]);
> > +    extern void func_vla_2d_empty(int n, int arr[][10]);
> > +    extern void func_vla_2d_ptr(int n, int (*arr)[10]);
> > +    TEST_STRING(func_vla_2d_first, "FviPA10_iE");
> > +    TEST_STRING(func_vla_2d_empty, "FviPA10_iE");
> > +    TEST_STRING(func_vla_2d_ptr,   "FviPA10_iE");
> > +
> > +    /* Test 2D VLA with both dimensions variable: should be all the same.  */
> > +    extern void func_vla_2d_both(int rows, int cols, int arr[rows][cols]);
> > +    extern void func_vla_2d_second(int rows, int cols, int arr[][cols]);
> > +    extern void func_vla_2d_star(int rows, int cols, int arr[*][cols]);
> > +    TEST_STRING(func_vla_2d_both,   "FviiPA_iE");
> > +    TEST_STRING(func_vla_2d_second, "FviiPA_iE");
> > +    TEST_STRING(func_vla_2d_star,   "FviiPA_iE");
> 
> While the top-most decays to a pointer, the deeper arrays are stay but
> are compatible between the fixed and variable case.  So according to
> C rules, they would all need to be canonicalized to the same.

Okay, thanks for the notes! How do you want me to phrase the commit log
for this patch as far as the potential future mode/builtins?

And do you think the existing builtin names are okay? I think "typeinfo"
has a very specific current meaning, so I think the names I have here
are good for this mode.

-- 
Kees Cook
