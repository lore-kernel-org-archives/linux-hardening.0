Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB1138DC7C;
	Thu,  8 Oct 2026 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476251; cv=none; b=iLpON8jCc57fx9Mn8LCyPmLlvfu2gq4M4LkAEnHIEexlJVRwOXmZ6kUoUe4T1UN5/UG0Hrae8SmMKhfIiB6RAr73FwDVwi5ohT7uTPMaIfzZHES1gCQxT4p9BSnEJGAoD0SuRDrcN+Djd0Jf3ps9EbXGCzObV7ahBv1Suqel1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476251; c=relaxed/simple;
	bh=o1DTwXdejouNxpORyg+7GbxTObHoojCtnzLRyC9LShk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpdB0kD9jvCDnrPYRq0wJ6kfXTV9n67pCfacQoCPhxCog/8QCK2tiP2YbV4GwOVAGUblb3L70XVvYfNt1MzGGN2NE43yjzkie1aXLRLtfDR+JZ4iBVvpMtXqG16U8tu2MvAK27/9tSSEBXadEYbeuP4SszYsbo+k0bspzRduLyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n24Ja3Ng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n24Ja3Ng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355111F000FF;
	Thu,  8 Oct 2026 16:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791476250;
	bh=8mITTiI6BwQHLThdEabGz6B78/4agyYQ53mUoBTGAVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n24Ja3NgT9xdrfO62aZVVXWW29ykG0P7HwhsSgfLSp+tlw/SzHf/4K/ZdV0k4t/q1
	 7aIUPvjUukKJl7z3qlRYkE0ho8lYlWVAy6sNE49BypY8t43kFwN8Gx2gRO99py4qK3
	 bJywUp91paCWjsl5omEcE/1nNKaSqux10qgJK6mCDTlvhaakcdGNh57JTEzLyXlWTE
	 +ZXzh4kEFiUhGllaIBh7370/e4KZ1DDlll0dOMdCDxz501z+S1netVtT/+tzUIqXnb
	 ye3k+QMDD0YoUEHvEkw3+bMzGMMbdmBR5WThGcui3HR7lTUVoFFg//EAmckR0RfHGr
	 NcAuLBxGpIOLg==
Date: Thu, 8 Oct 2026 18:17:24 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Bill Wendling <morbo@google.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mark Brown <broonie@kernel.org>, Marco Elver <elver@google.com>,
	alan.maguire@oracle.com, namjain@linux.microsoft.com,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4] compiler_types: Allow opting out of __counted_by and
 __counted_by_ptr
Message-ID: <20261008161724.GA459@ax162>
References: <20261005102518.2400984-1-morbo@google.com>
 <20261006094358.2948476-1-morbo@google.com>
 <202610060642.7C4125F@keescook>
 <20261007090915.GA1504630@ax162>
 <CAGG=3QXPAa-i4r3Vv6-q25A6EvsxGb5RDLn02z1=a5zo7W-7Vw@mail.gmail.com>
 <20261007093641.GA1527653@ax162>
 <bc2e2ae7-02e7-4148-8ad2-ab3c1af3dd7a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc2e2ae7-02e7-4148-8ad2-ab3c1af3dd7a@app.fastmail.com>

On Thu, Oct 08, 2026 at 04:50:44PM +0200, Ard Biesheuvel wrote:
> On Wed, 7 Oct 2026, at 11:36, Nathan Chancellor wrote:
> > On Wed, Oct 07, 2026 at 02:32:45AM -0700, Bill Wendling wrote:
> >> Ard,
> >> 
> >> What's the reason why x86 doesn't need the KBUILD_CFLAGS flags? Is
> >> there something that breaks things?
> >
> > I think it is mostly historical. See Kees's series to address it:
> >
> >   https://lore.kernel.org/20261006204210.i.137-kees@kernel.org/
> >
> 
> I've queued that up now in the EFI tree.
> 
> Do we still need this patch then?

I don't think so, since the efistub should now get
'-fexperimental-late-parse-attributes' from the main KBUILD_CFLAGS,
which is what prompted this patch in the first place:

  https://lore.kernel.org/CAGG=3QWCmQ+LVvn2dtjEauj5WFwvx=pvg4Q6man_A2imdjRe7A@mail.gmail.com/

As I mentioned up thread and to Kees in person, we should still consider
adding '-fexperimental-late-parse-attributes' into CC_FLAGS_DIALECT to
cover other areas that may see __counted_by_ptr use but it is probably
not as high priority.

-- 
Cheers,
Nathan
