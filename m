Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2206E468C07
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195866; cv=none; b=GcguUUZPLv9ZUD3MoJq6XxI+x4F1P1p2zyAQEqUeeqFV5yqf0qjR7NKcMI7S1Pi6GPa9xffUsBud4Q6Qb9O1p8MR8t4tX8kOW+X6xD2uXYqT+jJkUri/2P50v/rJVrfYLto28u5WcCjl6t7DvWKVFE4b0YfSUoFU8iDn9e6pQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195866; c=relaxed/simple;
	bh=EK7KelVZ2wC0+UYnsZtd2iO/AwEBZ7cLa+lyCnL/VkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJWDm22CZf7JtkVwfSZTC8PgqI6XDQvTR874THG765skCwJtRyHyF8NPxF+48dgQlDmgWV6pAksKKN766sF1gdmuh8F9nt1aamF40z4kW4/ZosN614+qCZS1ZNlMjqGqJ04jP42Li/tekNtvwut1hGQnBLvljRj86cCKBeo1ulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8TDoHB/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8TDoHB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB7A1F0089B;
	Mon,  5 Oct 2026 10:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791195864;
	bh=vo5U90grpvc9T6sDv4Q5xTxEfmSKGfOdLjAAiaiUgWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C8TDoHB/3uV2ak8MmMBegNoNyFm7DtuGpjwBrRCxgeJGbTSjSWgALvhTBR5Fpet93
	 ewJi3kcSNLQzm78Lba2e1wnyJ6mWFsGPcTKttHvFlMY8M8QnRterxD34XtArsORvHK
	 awX77rmW++hlsJ0kHvtLV8jMBvyfWz6I9DujiE+bRALi3l8VU48JTEr03I6i/uzJDd
	 7Ew1sQ/YPkhUO3s0kVouqd5qvAc/c1qqSzxprIA9kysr5L+hvdfb2jAQLkz1M8/6gh
	 B8+3DVjeYBoPdIDa3YHlg2wEfAbHlRZZdLdVstn8n7Yj5X7ejquo3gimY0ybNaTxpH
	 zAY1MT+GallTw==
Date: Mon, 5 Oct 2026 03:24:24 -0700
From: Kees Cook <kees@kernel.org>
To: Juergen Christ <jchrist@linux.ibm.com>
Cc: Andrea Pinski <andrew.pinski@oss.qualcomm.com>,
	Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
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
	Osterlund Sebastian <sebastian.osterlund@intel.com>,
	Constable Scott D <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v15 1/7] kcfi: Introduce KCFI typeinfo mangling API
Message-ID: <202610050322.A4DE3B26@keescook>
References: <20260825235748.i.456-kees@kernel.org>
 <20260825235759.3379064-1-kees@kernel.org>
 <283975a8-ccf6-4a3a-9a9b-4bc450657bbf-jchrist@linux.ibm.com>
 <202609232054.5116AADA@keescook>
 <c45529ee-35bc-4c3f-a90b-aee6c6d91687-jchrist@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c45529ee-35bc-4c3f-a90b-aee6c6d91687-jchrist@linux.ibm.com>

On Thu, Sep 24, 2026 at 09:55:06AM +0200, Juergen Christ wrote:
> > On Wed, Sep 23, 2026 at 11:25:07AM +0200, Juergen Christ wrote:
> > > thanks for your work on this.  I will implement the s390x specific
> > > part once this series is accepted.
> > 
> > Great; thank you!
> > 
> > > I looked at this on s390x.  We actually change the mangling of long
> > > double if we are on a target where long double is 128bit IEEE to a
> > > "g".  This causes this self-test to fail.  I suggest to add this patch
> > > on top of our patch to fix this:
> > > 
> > > diff --git a/gcc/kcfi-typeinfo.cc b/gcc/kcfi-typeinfo.cc
> > > index b6723fac48da..fab06249ae16 100644
> > > --- a/gcc/kcfi-typeinfo.cc
> > > +++ b/gcc/kcfi-typeinfo.cc
> > > @@ -659,7 +659,14 @@ test_typeinfo_basic_types ()
> > >    ASSERT_STREQ ("y", kcfi_test_mangle (long_long_unsigned_type_node).c_str ());
> > >    ASSERT_STREQ ("f", kcfi_test_mangle (float_type_node).c_str ());
> > >    ASSERT_STREQ ("d", kcfi_test_mangle (double_type_node).c_str ());
> > > +#if defined (__s390x__)
> > > +  if (TARGET_LONG_DOUBLE_128)
> > > +    ASSERT_STREQ ("g", kcfi_test_mangle (long_double_type_node).c_str ());
> > > +  else
> > > +    ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ());
> > > +#else
> > >    ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ());
> > > +#endif
> > >  }
> > >  
> > >  /* Test mangling of pointer types.  */
> > 
> > So this portion is only needed once there is s390 support? I'm unclear
> > on patch ordering.
> 
> No, with your original patch applied, gcc for s390x cannot be built in
> checking mode anymore since it fails this self-test.

Ah, thanks, I had misunderstood.

Following Andrea's and Jakub's suggestions, I've changed this for v17
to make the self-test expect whatever targetm.mangle_type() returns for
long double, falling back to "e". That avoids the host #ifdef and handles
every target with a special long double mangling. The mangler itself
already consults the hook, so only the test expectation was wrong. The
builtin-typeinfo.c run test assumed "Ce" for _Complex long double;
it now builds its expectation from the mangling of plain long double.

-Kees

-- 
Kees Cook
