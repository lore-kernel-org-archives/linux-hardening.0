Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1151A9FBD
	for <linux-hardening@vger.kernel.org>; Mon, 29 Sep 2025 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759142525; cv=none; b=bc+/nTXA0fJDcYhRFUWWT4TZE+pMZecWegpejca+sAKVgznqnlP1W76lH/a8ue/2Wm5udPDcLjA+CR1A9euZZJmAiyZNB5OK4wj9RklpvigokfGEgIJd8MKRz/sPdgSaQkVEbZO6Owmx6t2NMCvcaGItlgOa8cguqIuZWJ+5JOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759142525; c=relaxed/simple;
	bh=92nNF0MisSGO7XjJIOtSWw+upx9L/GfZzLWmQRLowF0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WFX5jGrisTXTwPiWqh5mFhw8pz/PUTDieq05Fc1zOwavrpYy1Lsvu7k5ymIOgut76NH+Cts9daVmvq7RIl7XO9RVO+c0+qLH2/UrQXKNJe5AzPQ4wVkgu+VJNGXnvk9kPqmVtQW4zsdxpWFJ85JTUysO9fGm7SG1jtdLVtlq6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=MZH1QuEW; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="MZH1QuEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1759142045;
	bh=/Oz0xNdsdc/CPxhjB2peQq4FepE8F6ixD5DkISHNqGc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MZH1QuEWlj77tQVzLGmyo78Y1mhpGaX0Af7jKSV3rMhzlSGs+3AMl2xQGMPGeWm9t
	 etx6W0D13kL8EIwYeZqDCVtg4IrO20cGWFZNr4FKGoelm5P/nXi8X+SU+nj0RcscbU
	 3Sma1dnHE8Uof9I+siP6iBied12LAC1cqO4fBLV8=
Received: from vra-174-12.tugraz.at (vra-174-12.tugraz.at [129.27.174.12])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4cZyGf3kr6z9rwy;
	Mon, 29 Sep 2025 12:34:02 +0200 (CEST)
Message-ID: <def69866c55cfb9ae3b32cecec0ca667b6fc627d.camel@tugraz.at>
Subject: Re: [PATCH v4 1/7] typeinfo: Introduce KCFI typeinfo mangling API
From: Martin Uecker <uecker@tugraz.at>
To: Kees Cook <kees@kernel.org>, Qing Zhao <qing.zhao@oracle.com>
Cc: Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>, 
 Richard Biener <rguenther@suse.de>, Joseph Myers <josmyers@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,  Ard Biesheuvel	 <ardb@kernel.org>,
 Jeff Law <jeffreyalaw@gmail.com>, Jan Hubicka <hubicka@ucw.cz>,  Richard
 Earnshaw <richard.earnshaw@arm.com>, Richard Sandiford
 <richard.sandiford@arm.com>, Marcus Shawcroft	 <marcus.shawcroft@arm.com>,
 Kyrylo Tkachov <kyrylo.tkachov@arm.com>, Kito Cheng	
 <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew
 Waterman	 <andrew@sifive.com>, Jim Wilson <jim.wilson.gcc@gmail.com>, Dan
 Li	 <ashimida.1990@gmail.com>, Sami Tolvanen <samitolvanen@google.com>,
 Ramon de C Valle <rcvalle@google.com>, Joao Moreira
 <joao@overdrivepizza.com>, Nathan Chancellor	 <nathan@kernel.org>, Bill
 Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org, 
	linux-hardening@vger.kernel.org
Date: Mon, 29 Sep 2025 12:34:02 +0200
In-Reply-To: <20250926030252.2387681-1-kees@kernel.org>
References: <20250926023737.it.616-kees@kernel.org>
	 <20250926030252.2387681-1-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: 0.0
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.117

Am Donnerstag, dem 25.09.2025 um 20:02 -0700 schrieb Kees Cook:

>=20
> An important aspect of the C++ typeinfo behavior that is retained here
> is that typedefs are treated as pass-through except when the underlying
> type lacks a tag (i.e. anonymous struct, union, or enum). This provides a
> distinction between those typedefs and typedefs used to provide _aliases_
> (u8, uint16_t).
>=20
> In the future, an additional "strict mode" builtin helper pair could
> also be added to follow strict ISO C type equivalency instead of the
> existing typeinfo used here, but that is out of scope for this patch.

The ISO C mode would be *less* strict.  Or in other words,
the current version would reject valid C programs at run-time.

I try to point out the differences below.



> +
> +    /* Test pointer types */
> +    TEST_STRING(char*, "Pc");
> +    TEST_STRING(int*, "Pi");
> +    TEST_STRING(void*, "Pv");
> +    TEST_STRING(const char*, "PKc");

> +
> +    /* Test array types */
> +    TEST_STRING(int[10],  "A10_i");
> +    TEST_STRING(char[20], "A20_c");
> +    TEST_STRING(short[],  "A_s");
> +
> +    /* Test basic function types */
> +    extern void func_void(void);
> +    extern void func_char(char x);
> +    extern void func_short(short x);
> +    extern void func_int(int x);
> +    extern void func_long(long x);
> +    TEST_STRING(func_void,  "FvvE");
> +    TEST_STRING(func_char,  "FvcE");
> +    TEST_STRING(func_short, "FvsE");
> +    TEST_STRING(func_int,   "FviE");
> +    TEST_STRING(func_long,  "FvlE");
> +
> +    /* Test functions with unsigned types */
> +    extern void func_unsigned_char(unsigned char x);
> +    extern void func_unsigned_short(unsigned short x);
> +    extern void func_unsigned_int(unsigned int x);
> +    TEST_STRING(func_unsigned_char,  "FvhE");
> +    TEST_STRING(func_unsigned_short, "FvtE");
> +    TEST_STRING(func_unsigned_int,   "FvjE");
> +
> +    /* Test functions with signed types */
> +    extern void func_signed_char(signed char x);
> +    extern void func_signed_short(signed short x);
> +    extern void func_signed_int(signed int x);
> +    TEST_STRING(func_signed_char,  "FvaE");
> +    TEST_STRING(func_signed_short, "FvsE");
> +    TEST_STRING(func_signed_int,   "FviE");
> +
> +    /* Test functions with pointer types */
> +    extern void func_void_ptr(void *x);
> +    extern void func_char_ptr(char *x);
> +    extern void func_short_ptr(short *x);
> +    extern void func_int_ptr(int *x);
> +    extern void func_int_array(int arr[]); /* Decays to "int *".  */
> +    extern void func_long_ptr(long *x);
> +    TEST_STRING(func_void_ptr,  "FvPvE");
> +    TEST_STRING(func_char_ptr,  "FvPcE");
> +    TEST_STRING(func_short_ptr, "FvPsE");
> +    TEST_STRING(func_int_ptr,   "FvPiE");
> +    TEST_STRING(func_int_array, "FvPiE");
> +    TEST_STRING(func_long_ptr,  "FvPlE");
> +
> +    /* Test functions with const qualifiers */
> +    extern void func_const_void_ptr(const void *x);
> +    extern void func_const_char_ptr(const char *x);
> +    extern void func_const_short_ptr(const short *x);
> +    extern void func_const_int_ptr(const int *x);
> +    extern void func_const_long_ptr(const long *x);
> +    TEST_STRING(func_const_void_ptr,  "FvPKvE");
> +    TEST_STRING(func_const_char_ptr,  "FvPKcE");
> +    TEST_STRING(func_const_short_ptr, "FvPKsE");
> +    TEST_STRING(func_const_int_ptr,   "FvPKiE");
> +    TEST_STRING(func_const_long_ptr,  "FvPKlE");


This ok, but there is a proposal to relax the rules for
qualifiers, so in the future preserving all qualifiers
might be too strict for C.



> +    /* Test 2D VLA with fixed dimension: should be all the same.  */
> +    extern void func_vla_2d_first(int n, int arr[n][10]);
> +    extern void func_vla_2d_empty(int n, int arr[][10]);
> +    extern void func_vla_2d_ptr(int n, int (*arr)[10]);
> +    TEST_STRING(func_vla_2d_first, "FviPA10_iE");
> +    TEST_STRING(func_vla_2d_empty, "FviPA10_iE");
> +    TEST_STRING(func_vla_2d_ptr,   "FviPA10_iE");
> +
> +    /* Test 2D VLA with both dimensions variable: should be all the same=
.  */
> +    extern void func_vla_2d_both(int rows, int cols, int arr[rows][cols]=
);
> +    extern void func_vla_2d_second(int rows, int cols, int arr[][cols]);
> +    extern void func_vla_2d_star(int rows, int cols, int arr[*][cols]);
> +    TEST_STRING(func_vla_2d_both,   "FviiPA_iE");
> +    TEST_STRING(func_vla_2d_second, "FviiPA_iE");
> +    TEST_STRING(func_vla_2d_star,   "FviiPA_iE");

While the top-most decays to a pointer, the deeper arrays are stay but
are compatible between the fixed and variable case.  So according to
C rules, they would all need to be canonicalized to the same.

Martin

