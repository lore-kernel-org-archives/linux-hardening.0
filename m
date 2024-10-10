Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147951CB32F;
	Thu, 10 Oct 2024 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569271; cv=none; b=W4M0l1NJs24sSldYQeHTsSoN4ZW0pk9GdD8JDdCcxU5i7OyjswiAigY13acb61wauCnTbvAvgtvmXvwJoPu32pqoaxpkdDkCFGVg3P7KJacpSXNIOEGETagLVLaRE6gtKq/iAfNYbnNpCZCscbQVhytDBMybvu55STMDHdP+QWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569271; c=relaxed/simple;
	bh=rmM/AWDxoVG1QMUNHd6R8VhVr7+0gOvrFbuFhF7sQm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixdqCwat1dcRoDnvW2X/m/YXVlydqHJl/6f38WtJENQyTxoBrsmjQQjU3AEMH9of506Jb1KScTThZZMKoKm4ajd8XMPc9dFxObehVui4N9g7uiy4WBBB+OGosa8DTkcZ7NSi58yqAsszXw1i/Kf2E6sr/yPDmB5Op6EgPTxhdRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LXI/9HI8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LXI/9HI8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/YWjnn5358vBZPgqLyx9cvMGPoYL6LKYQX7ZVmmyDJU=; b=LXI/9HI8VJxm8koOCRi6gi+O0c
	iefV4K9uhYXbeNOdtok5aK8epMBK7Veh8S83uyuhpVkE+aycoR+XEbEmfKDcFS7wKha4kzom+MWzX
	8aVXtotyOCitzmwsxe4pIbyQYFilY+iRS4Lcnof2x1O8JyIEktH7zitBOUQ2y5cdrnwqTrW2FfwZQ
	fiqpi7L6S36Ri5iMJnOtSNlCwxm2KAv2JoNEqO6O2jPKHfXNkaClQVZLxXxtuatC9eKbLpG7wNCfX
	QS/XG8bMbcxJ6jAZkQGU0BPCdlyCyppYTsD4YtFM6dmmd9uRwPKI46qi7eH27C8vaW4f4zVnODO9x
	+lvHzWLA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sytpR-00000007mcu-1P8R;
	Thu, 10 Oct 2024 14:07:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F84230088D; Thu, 10 Oct 2024 16:07:45 +0200 (CEST)
Date: Thu, 10 Oct 2024 16:07:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, keescook@chromium.org,
	linux-hardening@vger.kernel.org, nathan@kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jan Beulich <jbeulich@suse.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 1/5] objtool: Deal with relative jump tables correctly
Message-ID: <20241010140745.GK17263@noisy.programming.kicks-ass.net>
References: <20241010122801.1321976-7-ardb+git@google.com>
 <20241010122801.1321976-8-ardb+git@google.com>
 <20241010132623.GI17263@noisy.programming.kicks-ass.net>
 <CAMj1kXFg+JWMrfw40y2=0f9jr-3ebUxsFPprAK5diK4GQke_4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFg+JWMrfw40y2=0f9jr-3ebUxsFPprAK5diK4GQke_4A@mail.gmail.com>

On Thu, Oct 10, 2024 at 03:59:43PM +0200, Ard Biesheuvel wrote:
> On Thu, 10 Oct 2024 at 15:26, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Oct 10, 2024 at 02:28:03PM +0200, Ard Biesheuvel wrote:
> > > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > > index 3cb3e9b5ad0b..7f7981a93535 100644
> > > --- a/tools/objtool/check.c
> > > +++ b/tools/objtool/check.c
> > > @@ -2101,6 +2101,8 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
> > >  {
> > >       struct symbol *pfunc = insn_func(insn)->pfunc;
> > >       struct reloc *table = insn_jump_table(insn);
> > > +     unsigned int rtype = reloc_type(table);
> > > +     bool pcrel = rtype == R_X86_64_PC32;
> >
> > R_DATA32 or R_TEXT32 please, the budding cross arch stuff has their own
> > names for all that.
> >
> 
> #define R_DATA32        R_X86_64_PC32
> #define R_DATA64        R_X86_64_PC32
> #define R_TEXT32        R_X86_64_PC32
> #define R_TEXT64        R_X86_64_PC32
> 
> Clear as mud.
> 
> I'd guess we need the '64' variant here, but I'm not sure which one to
> use for a .rodata relocation pointing to .text. Any hints?

Josh? do R_{DATA,TEXT}64 want to be _PC64 ?
