Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655C21A454;
	Sun, 27 Jul 2025 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753631475; cv=none; b=BwJuVIHhavsT3430G93NnrC8S84Yvs96lvDDAtRaFwskt0PYYqjYLzxlcXKMi91wk8fvo5EG+UPzj+1YitaLzuNWq8KTMGsUUMuqW4877nVTVNbrb2P8ogz2YH+2v3qPDFq7F6KyuTibZjbVfC5HTuBVX5Q5a2bUL0WUr9EHglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753631475; c=relaxed/simple;
	bh=msHKRjFFx7+1sMmbL9h5O1PqaONUz5+/Ve6TzuVMpFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCjieMR1W5D2cmRNlMblwuv+HUeU7rUfxRdWa0kb/OhU9tgFRwc/E/YTdHqjacY0SJwAChxlatdM5FgxwGxjqCrMVmUpIbaNDGzoCRd4izSJ2Z6Yc7ncniVr9rRDesioUv8GiGEagfO3DcZsBgsrhBeuOi1FeP8blaNGCDU667w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SggHjkCN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SggHjkCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF01C4CEEB;
	Sun, 27 Jul 2025 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753631474;
	bh=msHKRjFFx7+1sMmbL9h5O1PqaONUz5+/Ve6TzuVMpFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SggHjkCN2gee0RrJrwYNHW5YZL77lrZPPkE85UrooA0dTj7FBJAjmA89sMOzQargE
	 /hN8iHMBMwgPIiQOj5yNj3jF/L3yEZXiCLVacfaMz9qUoZai63DddxjcTuiUm+KQ04
	 BvOqallc/z1SnjS/Hx8fr0OiVDzqFcJLSH1m6RndjCIN5dAxE9VU+DupmFd+ukGW8e
	 Igd6UAtreNYPTe1yhy1WJn6bPjOn59VPVJN+diYf7vQa4HMGfuTslEnxmPIhJVoYVy
	 5kMLBEuN1KFuWqGVuUHQN+YLVPsb9rVL3CkWbFgpWUfWx0hxw9ljtziTmPM90amC1a
	 ZgryXUrgTF0dg==
Date: Sun, 27 Jul 2025 08:51:08 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Coiby Xu <coxu@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kstack_erase: Add -mgeneral-regs-only to silence Clang
 warnings
Message-ID: <20250727155108.GB1183915@ax162>
References: <20250726212615.work.800-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726212615.work.800-kees@kernel.org>

On Sat, Jul 26, 2025 at 02:26:19PM -0700, Kees Cook wrote:
> Once CONFIG_KSTACK_ERASE is enabled with Clang on i386, the build warns:
> 
>   kernel/kstack_erase.c:168:2: warning: function with attribute 'no_caller_saved_registers' should only call a function with attribute 'no_caller_saved_registers' or be compiled with '-mgeneral-regs-only' [-Wexcessive-regsave]
> 
> Add -mgeneral-regs-only for the kstack_erase handler, to make Clang feel
> better (it is effectively a no-op flag for the kernel). No binary
> changes encountered.
> 
> Build & boot tested with Clang 21 on x86_64, and i386.
> Build tested with GCC 14.2.0 on x86_64, i386, arm64, and arm.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20250726004313.GA3650901@ax162
> Signed-off-by: Kees Cook <kees@kernel.org>

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  kernel/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/Makefile b/kernel/Makefile
> index e4f01f1d4d0c..0ee9afd8b7cf 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -140,6 +140,7 @@ obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
>  obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
>  
>  CFLAGS_kstack_erase.o += $(DISABLE_KSTACK_ERASE)
> +CFLAGS_kstack_erase.o += $(call cc-option,-mgeneral-regs-only)
>  obj-$(CONFIG_KSTACK_ERASE) += kstack_erase.o
>  KASAN_SANITIZE_kstack_erase.o := n
>  KCSAN_SANITIZE_kstack_erase.o := n
> -- 
> 2.34.1
> 
