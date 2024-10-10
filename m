Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3331CCB49;
	Thu, 10 Oct 2024 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574357; cv=none; b=lJtrh8wtLDcP9yE4DQHLMMczLUTXfLcHKob23FZi8LBO1Q8N4ZtmHillVyvhnKeoeK+35PvjtrUP3EmYk8e1l6lHLzeG6Ezf6CXuGJhCKD/joJSgb/hrAm3aDVUUVfoO857cPvjZv7IJckXdVdLQJw5VyU7q/Fy0hfXG/ArPZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574357; c=relaxed/simple;
	bh=vRYCLDUt3fbfr8Wex+GsOxts4nMwV0QgXj5YSyO5tFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftU1syqvvCpGYW9dA8jqZUs3YP6RC+Y3fyBezZo/KZ03ZmkFna1sGq+hInqOv0gNGDZvUfWh4K2xRzobWb0BaHIjAmSL75kbUYXjmdhFnE010u/cfXRxMS8zdeoUzOre5Wyj/XhVQ8AxjfgD0rjrLflAn5OmdnqbUOZKlml2qX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1HtouqW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1HtouqW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464FFC4CEC5;
	Thu, 10 Oct 2024 15:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728574356;
	bh=vRYCLDUt3fbfr8Wex+GsOxts4nMwV0QgXj5YSyO5tFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1HtouqWok067LX1rL2gOxi64ae5k3JjMp6Qk0rRs7MIPDRGjL9zipOfdFw1zLnbh
	 3Hn8D3P7/TZf1/h5zF9mEj7hQ0g9CPzHwwE6fa9Or+eYjoO5YS5mnexEo3Dno0No7u
	 Y/J3cmPngv6/iWIU++ns+zhbwaM3tXk36H63HzjR+xumVxz1FTa0FNRda763jgAGPj
	 zUW1CwsoiiOeyhTRuZh1TZflOR6in1r3XrIMPl0EFDsJch+FQSArnyMr0O7u7199xi
	 E7BrAwvY61SJilWCOdoEcNtUY2hrjHkFtCayi5b7dtSL2X4fbHHwMz9NBmvKn9dnCx
	 zFLeg7Ppiz3Jg==
Date: Thu, 10 Oct 2024 08:32:34 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	keescook@chromium.org, linux-hardening@vger.kernel.org,
	nathan@kernel.org, Jan Beulich <jbeulich@suse.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 1/5] objtool: Deal with relative jump tables correctly
Message-ID: <20241010153234.646lb24sp5uy27hn@treble.attlocal.net>
References: <20241010122801.1321976-7-ardb+git@google.com>
 <20241010122801.1321976-8-ardb+git@google.com>
 <20241010132623.GI17263@noisy.programming.kicks-ass.net>
 <CAMj1kXFg+JWMrfw40y2=0f9jr-3ebUxsFPprAK5diK4GQke_4A@mail.gmail.com>
 <20241010140745.GK17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010140745.GK17263@noisy.programming.kicks-ass.net>

On Thu, Oct 10, 2024 at 04:07:45PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 10, 2024 at 03:59:43PM +0200, Ard Biesheuvel wrote:
> > On Thu, 10 Oct 2024 at 15:26, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Oct 10, 2024 at 02:28:03PM +0200, Ard Biesheuvel wrote:
> > > > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > > > index 3cb3e9b5ad0b..7f7981a93535 100644
> > > > --- a/tools/objtool/check.c
> > > > +++ b/tools/objtool/check.c
> > > > @@ -2101,6 +2101,8 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
> > > >  {
> > > >       struct symbol *pfunc = insn_func(insn)->pfunc;
> > > >       struct reloc *table = insn_jump_table(insn);
> > > > +     unsigned int rtype = reloc_type(table);
> > > > +     bool pcrel = rtype == R_X86_64_PC32;
> > >
> > > R_DATA32 or R_TEXT32 please, the budding cross arch stuff has their own
> > > names for all that.
> > >
> > 
> > #define R_DATA32        R_X86_64_PC32
> > #define R_DATA64        R_X86_64_PC32
> > #define R_TEXT32        R_X86_64_PC32
> > #define R_TEXT64        R_X86_64_PC32
> > 
> > Clear as mud.

Yep... :-/

> > 
> > I'd guess we need the '64' variant here, but I'm not sure which one to
> > use for a .rodata relocation pointing to .text. Any hints?

This should be R_TEXT64.

> Josh? do R_{DATA,TEXT}64 want to be _PC64 ?

Actually, R_{DATA,TEXT}32 should be R_386_PC32.

-- 
Josh
