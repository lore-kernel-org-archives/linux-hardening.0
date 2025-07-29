Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0963111A8;
	Tue, 29 Jul 2025 23:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831162; cv=none; b=oj8bCS1fTu1fnbKDkgCvbi9Uj5+Xz85bMs9GXqleZ9AZbyw5HLyy43Z18ZAzqAxDNmDBsofySUYEzjpSIbgiB+PY29eflIi+NNFm+NvDhWdt+xNconxDLiRQXfqk4WqgB+n+r0xeSzlyTOY9YbUvnQG+a1doAQkVua5mnGzge/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831162; c=relaxed/simple;
	bh=6wOezsch67WwQVNo5tzv6Hbsz/dH8RKG8/l141P3N0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4Is1yhjirkUPX1w/04tU1VviKTG3Jw0O3yUs1Lx721K69sYUdfRReGTJLb2qhtflyvp0957S0UGy5L/OIcMHGL40LguAYmQkX9sVnR6Jl5G/2rR39pVe7n5V5SBB4v9cU3FDcJXO1a2SaIS5xczeR1k4CZUwokgi8bYAOm9dGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbHBejxl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbHBejxl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D628C4CEEF;
	Tue, 29 Jul 2025 23:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753831160;
	bh=6wOezsch67WwQVNo5tzv6Hbsz/dH8RKG8/l141P3N0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lbHBejxlHeq5firbzsiMgx5MLnMxXrDyNQxM07GuE9/ZGMLcFqnh+Z+XAeNSPtm0q
	 8QmJsncEDQnBOmRqFiXzYZkDYLh/Ja7F0HZ6tAXpShAD/XN+5dP+bKIiKTcXnICqJx
	 j2D0/tpxlylHe/3m2Cox9AtecdBCVVOrbDRh91Qypvjx575Twu3SZFB/vYHhtMVPaC
	 pUsKLpA+L7JcSQwqcnnxMY8cenK/jWmpKSp24PnPiQsDVDFqHuRibrGEUxnLnod//4
	 whSxK1jHf1CIamTSZt+oW6UZ2HPlJPe/sSyQRR5fTrm4ZPup4F2BbV/A8/GJK/fR8b
	 ihYwaOgv4Rcfg==
Date: Tue, 29 Jul 2025 16:19:20 -0700
From: Kees Cook <kees@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
	kernel test robot <lkp@intel.com>,
	syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	"Kirill A . Shutemov" <kas@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Yafang Shao <laoar.shao@gmail.com>, Uros Bizjak <ubizjak@gmail.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] compiler_types: Provide __no_kstack_erase to disable
 coverage only on Clang
Message-ID: <202507291618.8B04B08@keescook>
References: <20250729224325.work.019-kees@kernel.org>
 <CANpmjNNkYE9dvyR-YH3U18+g4bG4tpgD1pv99xG6xhdRuQYUQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNkYE9dvyR-YH3U18+g4bG4tpgD1pv99xG6xhdRuQYUQA@mail.gmail.com>

On Wed, Jul 30, 2025 at 01:00:39AM +0200, Marco Elver wrote:
> On Wed, 30 Jul 2025 at 00:43, Kees Cook <kees@kernel.org> wrote:
> >
> > In order to support Clang's stack depth tracking (for Linux's kstack_erase
> > feature), the coverage sanitizer needed to be disabled for __init (and
> > __head) section code. Doing this universally (i.e. for GCC too), created
> > a number of unexpected problems, ranging from changes to inlining logic
> > to failures to DCE code on earlier GCC versions.
> >
> > Since this change is only needed for Clang, specialize it so that GCC
> > doesn't see the change as it isn't needed there (the GCC implementation
> > of kstack_erase uses a GCC plugin that removes stack depth tracking
> > instrumentation from __init sections during a late pass in the IR).
> >
> > Successful build and boot tested with GCC 12 and Clang 22.
> >
> > Fixes: 381a38ea53d2 ("init.h: Disable sanitizer coverage for __init and __head")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202507270258.neWuiXLd-lkp@intel.com/
> > Reported-by: syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/6888d004.a00a0220.26d0e1.0004.GAE@google.com/
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Linus Torvalds <torvalds@linuxfoundation.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: <x86@kernel.org>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>
> > Cc: Kirill A. Shutemov <kas@kernel.org>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Wei Yang <richard.weiyang@gmail.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > ---
> >  arch/x86/include/asm/init.h    | 2 +-
> >  include/linux/compiler_types.h | 7 +++++++
> >  include/linux/init.h           | 2 +-
> >  3 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> > index 6bfdaeddbae8..5a68e9db6518 100644
> > --- a/arch/x86/include/asm/init.h
> > +++ b/arch/x86/include/asm/init.h
> > @@ -5,7 +5,7 @@
> >  #if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
> >  #define __head __section(".head.text") __no_sanitize_undefined __no_stack_protector
> >  #else
> > -#define __head __section(".head.text") __no_sanitize_undefined __no_sanitize_coverage
> > +#define __head __section(".head.text") __no_sanitize_undefined __no_kstack_erase
> >  #endif
> >
> >  struct x86_mapping_info {
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index 2b77d12e07b2..89e2c01fc8b1 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -378,6 +378,13 @@ struct ftrace_likely_data {
> >  # define __signed_wrap
> >  #endif
> >
> > +/* GCC does not like splitting sanitizer coverage across section inlines */
> > +#ifdef CC_IS_CLANG
> > +#define __no_kstack_erase      __no_sanitize_coverage
> > +#else
> > +#define __no_kstack_erase
> > +#endif
> 
> I think this belongs into compiler-clang.h, we've typically refrained
> from ifdef CC_IS_CLANG/GCC in the generic headers.
> See __nocfi for an example, where compiler_types.h provides a default
> empty definition, and compiler-clang.h provides a non-empty
> definition.

Oh, good point. I will rearrange this to use the #ifndef style handling!

-- 
Kees Cook
