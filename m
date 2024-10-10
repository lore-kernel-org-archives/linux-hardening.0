Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6119EED2;
	Thu, 10 Oct 2024 05:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728537412; cv=none; b=VxXNsbiwG7uv1sZD9LpnH4boR0VMNHdwFCykuKhN5Nyjq6g3eaRq+EVsGk2pRcSSwGuR1ImcOJButBO6U+X7mPM92cWR947UoKlwNNpJyJPf94CbN2AUkbf+x1u2GUackTzoo5D7cnAW+uAE0cwJYMHw/KHo1pzgUG/ynzN8FVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728537412; c=relaxed/simple;
	bh=D70Tpo7J0ELsOQK1iTdNFGcuQuvS73KEkDWu/V0PAnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqLQmqqzN95z9q/lvLVlqL0dyI501dioXm6iEirNs7A0hVLLRvrMPdi/33qIg7UG8EhCeLc4TbBZ9WWoiKszpCNj6Ap29JGZ0ASiihCJFsNo1wJul/7gBFjQDIys0bQBo02t6sBcIWYnIVVjXQdMhoOGNYM1YGfMoQ74R+mw3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTLBtOAq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTLBtOAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5139C4CECD;
	Thu, 10 Oct 2024 05:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728537412;
	bh=D70Tpo7J0ELsOQK1iTdNFGcuQuvS73KEkDWu/V0PAnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTLBtOAq9at/hSE+ju6P4QsGJNViociNZEAtqRzwXeW4jIqk1ldrQRExatEsx+yRV
	 junTv8y0ZHgtpdeoQjElDKIt8gZ8ob15YCmUhKEumytg2PB7v+LdLqyUfl8Z/g+xas
	 n9CcjeBDIhMpFrg3pEmJ4kJyQH3BIJCbvZ/l+LOnJVBfltn2wv5BqP8+QBmH0hh5Sn
	 lpxbyR1bzGnQW8wjM9cBf57DmUeJMHF88OEG3M1EZdaykJAN6E7W7z77TFmeU6jgZb
	 p1g4UyYjr5iovjOoVb7VFIS6WhKImZfzACCm2k1RQ0V/ZfEEeUc21WJYCr7DfNNBhx
	 ufS4z+kLconPA==
Date: Wed, 9 Oct 2024 22:16:49 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	linux-hardening@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH] objtool: Deal with relative jump tables correctly
Message-ID: <20241010051649.wtarneasz7x7anaj@treble.attlocal.net>
References: <20241007224747.3973322-2-ardb+git@google.com>
 <20241008174201.b23zrrvqv26ihq4t@treble>
 <CAMj1kXHBccOwtLWuT9P1ozpVm7bTcfPfjfXTVzJnCzsCYm1RfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHBccOwtLWuT9P1ozpVm7bTcfPfjfXTVzJnCzsCYm1RfQ@mail.gmail.com>

[ Adding Jan and Jose for the jump table annotation discussion below ]

On Wed, Oct 09, 2024 at 05:18:36PM +0200, Ard Biesheuvel wrote:
> On Tue, 8 Oct 2024 at 19:42, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Tue, Oct 08, 2024 at 12:47:48AM +0200, Ard Biesheuvel wrote:
> > > -     /*
> > > -      * Use of RIP-relative switch jumps is quite rare, and
> > > -      * indicates a rare GCC quirk/bug which can leave dead
> > > -      * code behind.
> > > -      */
> > > -     if (reloc_type(text_reloc) == R_X86_64_PC32)
> > > -             file->ignore_unreachables = true;
> > > -
> >
> > I'm not sure if this bug still exists on current GCC versions.  If so,
> > it will start reporting "unreachable instruction" warnings again and
> > we'll have to figure out a way to resolve that.
> >
> 
> Ah, I mistook this for a check against the first entry in the table,
> but it is the reference *to* the table from the code.
> 
> So I'll just leave this alone.

But then with -fpie, unreachable instructions would always be ignored,
which is not ideal as those warnings are actually very useful and often
point to bigger problems.

> Thanks. I've added another tweak locally so validate_ibt_data_reloc()
> uses the corrected offset as well, or I end up with !ENDBR warnings.
> So with that in place, objtool can decipher the jump table if it
> manages to recognize it as one.
> 
> However, there are pathological cases (see one below) where the LEA
> that takes the address of the jump table is ridiculously far away from
> the indirect jump, resulting in a warning like
> 
> vmlinux.o: warning: objtool: fdt_pmu_probe_pmu_dev.isra.0+0x229:
> sibling call from callable instruction with modified stack frame
> 
> 
> This is with GCC 14 (it is the only warning introduced by PIC codegen
> in an allmodconfig build), and I suspect that this might happen with
> non-PIC codegen too, right?
> 
> So how important is jump table support now that it is turned off in
> most cases?

For x86 I believe -fjump-tables is still a possibility in some configs,
so it still needs to work.  That said we may be behind on keeping up
with all the latest warnings.  Jump table detection has always been
whack-a-mole hacks.

And we'd want to support it for other arches as well.

> And has there been any movement on compiler annotations?
> If this is worth while, it is something I could look into: Kees and I
> work very closely with both the GCC and the Clang folks, and have
> contributed other features that are specific to the kernel.

I spoke with several people about this at GNU Cauldron last month and
there is definitely interest in helping out.  If you and Kees also want
to help out, that would be awesome.

Jan proposed an idea to apply a R_*_NONE relocation at the indirect
branch instruction which references the jump table address.  And then
emit a sized ELF symbol for each jump table entry.  That would be all we
need.

-- 
Josh
