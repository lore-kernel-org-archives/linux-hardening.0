Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133A9143756
	for <linux-hardening@vger.kernel.org>; Fri,  5 Sep 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092534; cv=none; b=YvgsO2su8QfPMKihfVbAk2bkBzcbWbQ8ZNIvKxOyLkcDnhTjwnwVQgualSBiyOUdbDQmo71/KpMoQY9yqpSjzounL7Kf/eOSrPMHXJVrL2Sa4kjbptWpgn5bigIps/zhHIsm8QT5tLuqjhU+aXE8vKrT2FPWhMUpWf+EEo1N62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092534; c=relaxed/simple;
	bh=FyALXuaJqAwhA4Ic3W5ABw6sQQDQJojhS843VbsAAyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTphS+U6anik7Dlh62u8ZFjEKIjxrDWF/LV9rEOAItPiGrzycfLjToIWV03Tu4xZrBuIp7dwkKTHhvArQOofgUnkqCNHn2DjxcF7jYuFeMDx7PiW7f+60ElnBYnicm7o8xD8KNPQzonvzFkmvEKQATgIv9Moky7Ev1c32o6JCC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYLLqJOQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYLLqJOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE6CC4CEF1;
	Fri,  5 Sep 2025 17:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757092533;
	bh=FyALXuaJqAwhA4Ic3W5ABw6sQQDQJojhS843VbsAAyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TYLLqJOQS1KN6pIxkngxtpyEBl4/S29pAZafwi17NNbcnYWZ7e81RcuhE6SZ2w+tO
	 P96PKHCbyhu0vwixYGjxdf08kkaH7m5GrZe0YkgGUxuBfd44BM3TnGxiTx/GC2tDMD
	 XaE/4CNEjRhR965Lqrf4rP6gVQAsJOCfxsvBo1C4cUXd8R/CfWRUQbuFUyQIToHYlj
	 3pdXLCSsNpIwzK4SZx3xriKC8gk4Wtw5wNu1QdtJX6/PnPGcgY9a7aravKvF6hnHLc
	 8yvOLmMPTC3CW6wnJ+mRZCye7IQRw3qdytwOUPe+42vArd4caPDzL8AtsXEu3FnGcq
	 xUBb2FD+GueXA==
Date: Fri, 5 Sep 2025 10:15:33 -0700
From: Kees Cook <kees@kernel.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Andrew Pinski <pinskia@gmail.com>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 7/7] kcfi: Add regression test suite
Message-ID: <202509050950.8D39B0D@keescook>
References: <20250905001157.it.269-kees@kernel.org>
 <20250905002418.464643-7-kees@kernel.org>
 <aLqMAWTwDh5eXgUJ@tucnak>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLqMAWTwDh5eXgUJ@tucnak>

On Fri, Sep 05, 2025 at 09:06:41AM +0200, Jakub Jelinek wrote:
> On Thu, Sep 04, 2025 at 05:24:15PM -0700, Kees Cook wrote:
> > --- /dev/null
> > +++ b/gcc/testsuite/gcc.dg/kcfi/kcfi-adjacency.c
> > @@ -0,0 +1,73 @@
> > +/* Test KCFI check/transfer adjacency - regression test for instruction
> > +   insertion.  */
> > +/* { dg-do compile } */
> > +/* { dg-options "-fsanitize=kcfi -O2" } */
> > +/* { dg-options "-fsanitize=kcfi -O2 -march=armv7-a -mfloat-abi=soft" { target arm32 } } */
> 
> For stuff like this you should be using dg-additional-options.
> /* { dg-options "-fsanitize=kcfi -O2" } */
> /* { dg-additional-options "-march=armv7-a -mfloat-abi=soft" { target arm32 } } */
> (in various other tests too).

Ah, perfect; thanks!

> > +/* Should have KCFI instrumentation for all indirect calls.  */
> > +
> > +/* x86_64: Complete KCFI check sequence should be present.  */
> > +/* { dg-final { scan-assembler {movl\t\$-?[0-9]+, %r1[01]d\n\taddl\t[^,]+, %r1[01]d\n\tje\t\.Lkcfi_call[0-9]+\n\.Lkcfi_trap[0-9]+:\n\tud2} { target x86_64-*-* } } } */
> 
> This at least needs
> /* { dg-additional-options "-masm=att" { target x86_64-*-* } } */
> because Intel syntax wouldn't match.

Ah, okay. Is the test suite ever run with -masm != att?

> Does this match with all possible -march/-mtune settings?

I was just running this with "default" state. I didn't think there was
value is testing all the combinations -- all the sequence tests are
basically validating that nothing surprising happened during emission,
etc. What's the best practice for this? Should I add specific
-march/-mtune options for each arch?

> Peope very often do test
> make check RUNTESTFLAGS='--target_board=unix/-march=skylake-avx512'
> etc. so if the test depends on a particular ISA or tuning, better
> add it explicitly to dg-options.

How does that end up meshing? i.e. if I have -mtune=generic in
dg-options, but someone runs with a different -mtune, what happens?

> Also, we try not to use triplets like x86_64-*-* but instead
> { i?86-*-* x86_64-*-* } && lp64
> or
> { i?86-*-* x86_64-*-* } && { ! ia32 }
> depending on whether it is only for -m64, or for both -m64 and -mx32,
> because on some targets the multilib compiler is i?86-*-* defaulting
> to -m32, on most obviously x86_64-*-* defaulting to -m64.

Okay, sounds good. I'll update all of these (for this we only care about
64-bit x86). Out of curiosity what triple matches i?86-*-* and lp64? I
thought x86_64 was sufficient here.

(Though I suddenly realize I think I have nothing in the KCFI patches
can that rejects working under -m32 ... I only do careful target checks
under arm.)

> > +/* x86_64: Should have 0 entry NOPs - function starts immediately with
> > +   pushq.  */
> > +/* { dg-final { scan-assembler {test_function:\n\.LFB[0-9]+:\n\t*\.cfi_startproc\n\t*pushq\t*%rbp} { target x86_64-*-* } } } */
> > +/* { dg-final { scan-assembler-not {\t*\.weak\t*__kcfi_typeid_test_function\n} { target x86_64-*-* } } } */
> 
> .weak is ELF specific, not all targets have it, are the tests restricted to
> targets that do support it and in this syntax?  We have
> /* { dg-require-weak "" } */
> but that doesn't imply a particular function.

Oh, er, this is just for ELF targets. Is there a way to globally
restrict all of these tests to just the 4 arch combos? I'm suspecting
now that these tests will all universally fail for the archs that don't
support -fsanitize=kcfi. I thought dg-options was handling filtering
this, but maybe I've misunderstood?

I'm guessing I need to declare an alias like "lp64" or what I think I
saw asan doing for this feature?

> Also, not all configurations will support .cfi_* directives, that depends
> both on command line parameters and on whether assembler supports those.
> If you expect them in all tests, perhaps you should test for those in
> kcfi.exp and not run the tests at all if the directives aren't supported
> (or if weak isn't supported etc.).

Yeah, this sounds like the place I need to limit the tests from?
Everything I know about dg I've learned in the last month. :P

Studying this some more, it looks like some .exp files use "istarget". I
found, e.g.:

if { [istarget nvptx-*-*] } {
    return
}

So maybe I need that as a top-level filter in kcfi.exp:

if { ![istarget arm*-*-*] && ![istarget x86_64-*-*] && ... } {
    unsupported "KCFI tests not supported on this target"
    return
}

?

I will build some 5th target and see what happens when I run these
tests. :P

> Also, there are targets with different line endings, so usually one scans
> for [\n\r]* instead of just \n.

Okay -- I'm expecting this will go away once I limit to just the 4 targets
I want, or do you want me to universally update the \n patterns to
[\n\r]*?

> No idea why you're using \t*, the compiler emits just one tab.

Ah, I'm not sure where that came from (I will fix it). There has been
a lot of automation on my end to get all these patterns converted from
.s output into dg patterns.

Thanks for looking this over!

-Kees

-- 
Kees Cook
