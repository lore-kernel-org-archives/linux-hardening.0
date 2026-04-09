Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE442F84F;
	Thu,  9 Apr 2026 03:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704039; cv=none; b=TWG3yjli5RXlaMjuM6ndAxYy5VFwJEjaXMUiSFFBmsAcXu1eGSeokWV5bSWknZumuz00W2v06pgtSzetSE2FFv7IXXx9/YUO1xK2AqjNTG5vtsAhAT1gIE1BdNNTioSVtyeB1gjiy5dGtNSpo0hqz5QyXQrTrH9y5q3NZXaGMl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704039; c=relaxed/simple;
	bh=LjEFGbpZ1i+DF1H1TB3qV7PQGb/Dy2zmEfpM1P0MEJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyVRy53kcZPv1d4l19phirKiVzjMCwPT0eMJ4C9SgYUc2kTi6oExXbNQeoZTIIqLI5VngMPNLVkUGLdLKOnmE3bZuneSkbucK0J4QnzdW41Ooh+zdfV7V3+/Mg14q5csENJYoR2fn3ZgmaMdQlmociq8iS6RJaBdn1rxjpLBZ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpiPoESf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpiPoESf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B38C19421;
	Thu,  9 Apr 2026 03:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775704039;
	bh=LjEFGbpZ1i+DF1H1TB3qV7PQGb/Dy2zmEfpM1P0MEJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpiPoESfxrYb95SDvk5mUQCWcfARXYqFe0KA9CsaVNHhFI8Vuqj2RsFNQMNRgmA7f
	 AfEnkXhzKQ96tqEd70bF9PzBVxtXDTeEOKP1eu/SV7PKCv+NjhzsN9nlQ/j5UWrnVX
	 lC+ECxUUIwM++4VM9ktTMa+FpAbXQ0gcveH7a2Z8B8tRW4t7P909+Mc/Z1sqGuSTzy
	 CoeZkyhvP5aTtGy8F1aJCxF9Olxw17nLEZbiWohx/W9bhmIDWpqd+3g07ju5gU0u2p
	 801A6r+eAsWC1dtNKz71d6ylkdUv54rBCu+If75hQ+lw2lFoIQc09Y1tbM1Och+PO4
	 DQOdjOigsMe7Q==
Date: Wed, 8 Apr 2026 20:07:18 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>,
	kernel test robot <lkp@intel.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] gcov: Disable GCOV_PROFILE_ALL on 32-bit UML with
 Clang 20/21
Message-ID: <202604082006.FF907B56F6@keescook>
References: <20260408162607.it.347-kees@kernel.org>
 <20260408220334.GA3962465@ax162>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408220334.GA3962465@ax162>

On Wed, Apr 08, 2026 at 03:03:34PM -0700, Nathan Chancellor wrote:
> On Wed, Apr 08, 2026 at 09:26:12AM -0700, Kees Cook wrote:
> > Clang 20 and 21 miscompute __builtin_object_size() when -fprofile-arcs
> > is active on 32-bit UML targets, which passes incorrect object size
> > calculations for local variables through always_inline copy_to_user()
> > and check_copy_size(), causing spurious compile-time errors:
> > 
> >   include/linux/ucopysize.h:52:4: error: call to '__bad_copy_from' declared with 'error' attribute: copy source size is too small
> > 
> > The regression was introduced in LLVM commit 02b8ee281947 ("[llvm]
> > Improve llvm.objectsize computation by computing GEP, alloca and malloc
> > parameters bound"), which shipped in Clang 20. It was fixed in LLVM
> > by commit 45b697e610fd ("[MemoryBuiltins] Consider index type size
> > when aggregating gep offsets"), which was backported to the LLVM 22.x
> > release branch.
> > 
> > The bug requires 32-bit UML + GCOV_PROFILE_ALL (which uses -fprofile-arcs),
> > though the exact trigger depends on optimizer decisions influenced by other
> > enabled configs.
> > 
> > Prevent the broken combination by disabling GCOV_PROFILE_ALL on 32-bit
> > UML when using Clang 20.x or 21.x.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202604030531.O6FveVgn-lkp@intel.com/
> > Assisted-by: Claude:claude-opus-4-6[1m]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >  v2: fixed typo in version comparison: needed < not <= (Sashiko)
> >  v1: https://lore.kernel.org/lkml/20260408005958.work.271-kees@kernel.org/
> > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
> > Cc: Bill Wendling <morbo@google.com>
> > Cc: Justin Stitt <justinstitt@google.com>
> > Cc: <llvm@lists.linux.dev>
> > ---
> >  kernel/gcov/Kconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> > index 04f4ebdc3cf5..56abff785654 100644
> > --- a/kernel/gcov/Kconfig
> > +++ b/kernel/gcov/Kconfi
> > @@ -42,6 +42,9 @@ config GCOV_PROFILE_ALL
> >  	depends on !COMPILE_TEST
> >  	depends on GCOV_KERNEL
> >  	depends on ARCH_HAS_GCOV_PROFILE_ALL
> 
> Would it be better to avoid selecting this symbol in arch/um/Kconfig
> when we have this condition?
> 
> > +	# Clang 20 & 21 miscompute __builtin_object_size() under -fprofile-arcs
> > +	# on 32-bit UML, causing spurious compile-time errors in check_copy_size().
> > +	depends on !(UML && !64BIT && CC_IS_CLANG && CLANG_VERSION >= 200000 && CLANG_VERSION < 220100)
> 
> Given that you have an inclusive range above 0, you could drop the CC_IS_CLANG.
> 
> With the suggestion above it would just become:
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 098cda44db22..d9541d13d9eb 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -11,7 +11,9 @@ config UML
>  	select ARCH_HAS_CACHE_LINE_SIZE
>  	select ARCH_HAS_CPU_FINALIZE_INIT
>  	select ARCH_HAS_FORTIFY_SOURCE
> -	select ARCH_HAS_GCOV_PROFILE_ALL
> +	# Clang 20 & 21 miscompute __builtin_object_size() under -fprofile-arcs
> +	# on 32-bit, causing spurious compile-time errors in check_copy_size().
> +	select ARCH_HAS_GCOV_PROFILE_ALL if !(!64BIT && CLANG_VERSION >= 200000 && CLANG_VERSION < 220100)
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_STRNCPY_FROM_USER
>  	select ARCH_HAS_STRNLEN_USER

That is a lot nicer; yeah. I will use this and send a v3.

-- 
Kees Cook
