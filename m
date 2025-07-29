Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079E192D6B;
	Tue, 29 Jul 2025 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753832775; cv=none; b=KnGw51GifLYaaootFiiGCKrCXuWJrIGPVE2Nng3FZJbe4EiZLVPensevsTVBd0VznB3cVlXy6u8iwGTOcEhBhYGRSopFNis5O10mn+GWtbNhOcpxCYgKNpFxncZ18WvhfExxH7u6fXJ55XYDOuvPr42R3lb5JQahGqIO9vtAKt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753832775; c=relaxed/simple;
	bh=X8zTb6ma+/1bkB6kEJKpLetsS0VgLj3oM0Tgo3i/a8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQ2GYB8p411GvIcyRDBFUkjZYLHhjtECt74xfkwpp3uYFGcMc49ARe4+kZyc/IExIErm8f7THzCQQ12Sp34N6F2V72jIFLTX2C9XWJmcfwddLZDlTz3qxaZrKNlp2sR9R21JbhNLu8JrD85VNJf/SiPfP4Qu0PcC9DWIWao6rG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piV4HtIc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piV4HtIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BC0C4CEEF;
	Tue, 29 Jul 2025 23:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753832773;
	bh=X8zTb6ma+/1bkB6kEJKpLetsS0VgLj3oM0Tgo3i/a8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=piV4HtIc5sBg/TMQNSBoRVYMKqvc2FcVPHpVK3RU+6JkeHXEY6pH1cyKPmNIgM7LP
	 2vfdsUJ4Z8xS2LGsO+1D6BK1ZKjo/1fNPESuwTAOPTC218M2VLobPzRIOaLFY7k1OG
	 Ix26l88KnXhFL080Qu2iatoDVx6iIc4prUgg0SiRW10ilowssvsiolYDGHxWXK1e2V
	 VfJDlcxMGVtZNIq//3GwC/rKpNK2zzKmzRr9E6vmZG0xsDIUD77YU/ee/8WpYp31c/
	 uuVP+dxrxzGoBOvn75VjCLw5258zfiKnw0zFlxaHgDrarJ+qU2EIRKrUNKioLBQSRO
	 8NYSkfXxSPVlw==
Date: Tue, 29 Jul 2025 16:46:04 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
	kernel test robot <lkp@intel.com>,
	syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	Marco Elver <elver@google.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	"Kirill A . Shutemov" <kas@kernel.org>,
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
	Jan Hendrik Farr <kernel@jfarr.cc>, Uros Bizjak <ubizjak@gmail.com>,
	Marc Herbert <Marc.Herbert@linux.intel.com>,
	Yafang Shao <laoar.shao@gmail.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] compiler_types: Provide __no_kstack_erase to disable
 coverage only on Clang
Message-ID: <20250729234604.GA921387@ax162>
References: <20250729234055.it.233-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729234055.it.233-kees@kernel.org>

On Tue, Jul 29, 2025 at 04:41:00PM -0700, Kees Cook wrote:
> In order to support Clang's stack depth tracking (for Linux's kstack_erase
> feature), the coverage sanitizer needed to be disabled for __init (and
> __head) section code. Doing this universally (i.e. for GCC too) created
> a number of unexpected problems, ranging from changes to inlining logic
> to failures to DCE code on earlier GCC versions.
> 
> Since this change is only needed for Clang, specialize it so that GCC
> doesn't see the change as it isn't needed there (the GCC implementation
> of kstack_erase uses a GCC plugin that removes stack depth tracking
> instrumentation from __init sections during a late pass in the IR).
> 
> Successfully build and boot tested with GCC 12 and Clang 22.
> 
> Fixes: 381a38ea53d2 ("init.h: Disable sanitizer coverage for __init and __head")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507270258.neWuiXLd-lkp@intel.com/
> Reported-by: syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6888d004.a00a0220.26d0e1.0004.GAE@google.com/
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/x86/include/asm/init.h    | 2 +-
>  include/linux/compiler-clang.h | 3 +++
>  include/linux/compiler_types.h | 4 ++++
>  include/linux/init.h           | 2 +-
>  4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> index 6bfdaeddbae8..5a68e9db6518 100644
> --- a/arch/x86/include/asm/init.h
> +++ b/arch/x86/include/asm/init.h
> @@ -5,7 +5,7 @@
>  #if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
>  #define __head	__section(".head.text") __no_sanitize_undefined __no_stack_protector
>  #else
> -#define __head	__section(".head.text") __no_sanitize_undefined __no_sanitize_coverage
> +#define __head	__section(".head.text") __no_sanitize_undefined __no_kstack_erase
>  #endif
>  
>  struct x86_mapping_info {
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 4fc8e26914ad..fa4ffe037bc7 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -89,6 +89,9 @@
>  #define __no_sanitize_coverage
>  #endif
>  
> +/* Only Clang needs to disable the coverage sanitizer for kstack_erase. */

IMO, this comment does not add much now that this is separated from the
dummy definition of __no_kstack_erase but it's probably not worth
changing in a new revision if Linus wants to take this directly.

> +#define __no_kstack_erase	__no_sanitize_coverage
> +
>  #if __has_feature(shadow_call_stack)
>  # define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
>  #endif
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 2b77d12e07b2..16755431fc11 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -424,6 +424,10 @@ struct ftrace_likely_data {
>  # define randomized_struct_fields_end
>  #endif
>  
> +#ifndef __no_kstack_erase
> +# define __no_kstack_erase
> +#endif
> +
>  #ifndef __noscs
>  # define __noscs
>  #endif
> diff --git a/include/linux/init.h b/include/linux/init.h
> index c65a050d52a7..a60d32d227ee 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -51,7 +51,7 @@
>     discard it in modules) */
>  #define __init		__section(".init.text") __cold __latent_entropy	\
>  						__noinitretpoline	\
> -						__no_sanitize_coverage
> +						__no_kstack_erase
>  #define __initdata	__section(".init.data")
>  #define __initconst	__section(".init.rodata")
>  #define __exitdata	__section(".exit.data")
> -- 
> 2.34.1
> 
