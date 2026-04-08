Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442392153EA;
	Wed,  8 Apr 2026 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685819; cv=none; b=mTZMKtppChVZwWALpTV+okwdb+aDmCQuXDSzqhx+q4X5JGWTjxJ4lfmZ4WZ2WXBZSOQwINVbCn/vvtJeCxTAtOY2ANjnB0bF/FEa70D+jzszYhW3iZW6jPqtsmqT38g1/aW/gl1mxbO5ewUNLSqWoq891DjTuP6VMNZ4OcKk5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685819; c=relaxed/simple;
	bh=Yjer5woEh3mw3RtpKNVTvZ9uyG6f8sJECUD6FN73R+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIOWb1I8ZdvOmigIaVOpPQGZ+UQBYk8gwuEHoNxCCsLcDIgMZcIP6t1scZ0cWZXHW++9QOiUB4qQCcjRvVAUW6pjZ7HoA5l/qOtW+dbTsH9GnpCgfLzVXi6sSZKAJPPLpdnipPTMUbT8HhXcQjHjMw4NHukes9lqFuAyzen5rgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp5wLYIt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp5wLYIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005AEC19421;
	Wed,  8 Apr 2026 22:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775685818;
	bh=Yjer5woEh3mw3RtpKNVTvZ9uyG6f8sJECUD6FN73R+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pp5wLYIt1R7KEOiJQQnXW6ZhJEmjf9UvC06DcsgIrDzefnDIeilwMVXldNCwWtFt4
	 uNVmQ0+glAJB5Db5wzHoDlmnmC3M8IdK9/qXJEtnwQsntoI2MBPp1TfmeM/BUo95fR
	 KDqeF6riY5+LsrJ1r+DJeNZ890kQRurbE1c7I163hs/oNGExGQVy5mb7Kxqt9HSb90
	 3rz3Q+F3lmb2gxwpP1FDt+wioHBLLtRdyhANIn2ZUARYPWvglVD2owgocjtsmbIleD
	 hVHwwiktZDlsAmEMCfdnc9IBDHHOaujHTpShcIdyn7QDDdLTLmQd8eUfkSqIyO+MA/
	 yhlcfB71P7Oyg==
Date: Wed, 8 Apr 2026 15:03:34 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>,
	kernel test robot <lkp@intel.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] gcov: Disable GCOV_PROFILE_ALL on 32-bit UML with
 Clang 20/21
Message-ID: <20260408220334.GA3962465@ax162>
References: <20260408162607.it.347-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408162607.it.347-kees@kernel.org>

On Wed, Apr 08, 2026 at 09:26:12AM -0700, Kees Cook wrote:
> Clang 20 and 21 miscompute __builtin_object_size() when -fprofile-arcs
> is active on 32-bit UML targets, which passes incorrect object size
> calculations for local variables through always_inline copy_to_user()
> and check_copy_size(), causing spurious compile-time errors:
> 
>   include/linux/ucopysize.h:52:4: error: call to '__bad_copy_from' declared with 'error' attribute: copy source size is too small
> 
> The regression was introduced in LLVM commit 02b8ee281947 ("[llvm]
> Improve llvm.objectsize computation by computing GEP, alloca and malloc
> parameters bound"), which shipped in Clang 20. It was fixed in LLVM
> by commit 45b697e610fd ("[MemoryBuiltins] Consider index type size
> when aggregating gep offsets"), which was backported to the LLVM 22.x
> release branch.
> 
> The bug requires 32-bit UML + GCOV_PROFILE_ALL (which uses -fprofile-arcs),
> though the exact trigger depends on optimizer decisions influenced by other
> enabled configs.
> 
> Prevent the broken combination by disabling GCOV_PROFILE_ALL on 32-bit
> UML when using Clang 20.x or 21.x.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604030531.O6FveVgn-lkp@intel.com/
> Assisted-by: Claude:claude-opus-4-6[1m]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v2: fixed typo in version comparison: needed < not <= (Sashiko)
>  v1: https://lore.kernel.org/lkml/20260408005958.work.271-kees@kernel.org/
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: <llvm@lists.linux.dev>
> ---
>  kernel/gcov/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index 04f4ebdc3cf5..56abff785654 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfi
> @@ -42,6 +42,9 @@ config GCOV_PROFILE_ALL
>  	depends on !COMPILE_TEST
>  	depends on GCOV_KERNEL
>  	depends on ARCH_HAS_GCOV_PROFILE_ALL

Would it be better to avoid selecting this symbol in arch/um/Kconfig
when we have this condition?

> +	# Clang 20 & 21 miscompute __builtin_object_size() under -fprofile-arcs
> +	# on 32-bit UML, causing spurious compile-time errors in check_copy_size().
> +	depends on !(UML && !64BIT && CC_IS_CLANG && CLANG_VERSION >= 200000 && CLANG_VERSION < 220100)

Given that you have an inclusive range above 0, you could drop the CC_IS_CLANG.

With the suggestion above it would just become:

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 098cda44db22..d9541d13d9eb 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -11,7 +11,9 @@ config UML
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
-	select ARCH_HAS_GCOV_PROFILE_ALL
+	# Clang 20 & 21 miscompute __builtin_object_size() under -fprofile-arcs
+	# on 32-bit, causing spurious compile-time errors in check_copy_size().
+	select ARCH_HAS_GCOV_PROFILE_ALL if !(!64BIT && CLANG_VERSION >= 200000 && CLANG_VERSION < 220100)
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
--

Cheers,
Nathan
