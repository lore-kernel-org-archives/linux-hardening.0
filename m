Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE166382373;
	Fri,  9 Oct 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561081; cv=none; b=nWvoeILIKUrAMvx5mJMrxpZSt9APYfQT+9uHg6l6TFNUTCsQXhs16x6QfTni9TucikpJRj13gmy0rwd0ZMCPLUx8D7y7VXkND1Ikt9EGNkTjXWB6tZJGkiqBWMg/i0t9xEB1cAfOUpUZMaRc2sF/O8lt6m6LB6gGpYvYT6TRO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561081; c=relaxed/simple;
	bh=6I/E3ls6R65hg7gXxWt0LfIc1SzseqQ7dHBDy1GDox0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMv56a0TC5CdmqJuOo1BvyTu3TpI68ms7qTJr2AQblP+p4kvzXtBMXEYqPmPeI86Fy8oZtD/fiCswjVJOvTvCWC+KhPA2dCvtF80Jk+HJVTfb/2Cn9PSibKZZWkF0OlvXDjd3C7xyWbNNnohaIUU2MwjaZN93uNl/xhTcPXB0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD6VrvTA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD6VrvTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495511F000FF;
	Fri,  9 Oct 2026 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791561079;
	bh=1JTJsG9iHy7cnxkMGpPJjEaV21cpLxYzGB1ulrApZoo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=PD6VrvTAd3jYgu30Iis+oILhqIvALacy7lyzxwIB3ceb/lxkvncsyvcMOsH6BAmS+
	 v8iWpnVwO/Kx4gAeEVqgsUgtti9EvvqpuPpAIJHIw1aEjUDumbyNWfZekmLlQmntOH
	 ARSAjIO+XpvP8AbNExXCn52gZOPVV+RJGRwdYtmCMco7uOd/lEImcOjAo7HI7dxi0x
	 klG+LplHs/9YkVYkmDHzjqdT1Onw9kSpQAKhpzxH1yMP0WUPNyXGdvi0Ol4Y2Y/R1K
	 9CjfnPLjA6BekC99vLugXBplJr0VBt1uZeDHQPkmnlcQ1790EAE1iAMGmPUrwE2nll
	 yQLSzFcIG/ciQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 056E2CE0B28; Fri,  9 Oct 2026 08:51:19 -0700 (PDT)
Date: Fri, 9 Oct 2026 08:51:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/2] kbuild: Mark the kernel image gzip recipes as
 recursive
Message-ID: <7fa8e996-d015-4f8d-a197-3f8901e0b31a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261009062722.i.253-kees@kernel.org>
 <20261009062733.3119731-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009062733.3119731-1-kees@kernel.org>

On Thu, Oct 08, 2026 at 11:27:30PM -0700, Kees Cook wrote:
> Since commit 48ebe1cbbeb51 ("kbuild: compress the kernel with pigz if
> available"), cmd_gzip runs pigz through scripts/jobserver-exec, which
> takes the job slots make has free. GNU Make passes the jobserver pipe
> only to recipes it treats as recursive, but leaves --jobserver-auth in
> MAKEFLAGS for all of them. The make 4.3 in CentOS Stream 9 also hides
> the pipe in sub-makes (a backport of the fix for GNU Make bug 58232), so
> jobserver-exec cannot open it, runs pigz on one thread, and prints:
> 
>   WARNING: Unable to reopen jobserver read-side pipe: FileNotFoundError(2, 'No such file or directory')
> 
> Mark the gzip recipes as recursive with "+", as commit ecab4115c44cc
> ("kbuild: mark `rustc` (and others) invocations as recursive") did for
> rustc. As with those, "make -n" now runs them.
> 
> Tested ARCH=x86_64 and ARCH=arm64 defconfig with GNU Make 4.3 plus
> CentOS Stream 9's make-4.3-cloexec.patch, GCC 16.2.0, and -j64: without
> this change the warning appears and pigz runs with "-p 1"; with it there
> is no warning, and pigz runs with "-p 54" and "-p 64".

Thank you, Kees!

My initial test of this patch (using rcutorture) still showed the failure.
I am running GCC 11.5.0 and without any patches to "make".  I take it
that I need to find and apply CentOS Stream 9's make-4.3-cloexec.patch?

But if I use "make -j" instead of rcutorture, this patch does work fine.
Even with "make -j632".

I put rcutorture in the background using nohup and full redirection,
but "nohup make -j632 > /tmp/Make.out 2>&1 < /dev/null &" works just
fine.  And running rcutorture in the foreground still fails.

Very strange.

So I guess I could give a Tested-by for builds using straight-up make,
but not from rcutorture.  ;-)

							Thanx, Paul

> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Closes: https://lore.kernel.org/all/0ddb5e5e-f801-444c-aa98-0cfe814a3026@paulmck-laptop/
> Fixes: 48ebe1cbbeb51 ("kbuild: compress the kernel with pigz if available")
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  arch/alpha/boot/Makefile             | 4 ++--
>  arch/arc/boot/Makefile               | 2 +-
>  arch/arm64/boot/Makefile             | 2 +-
>  arch/microblaze/boot/Makefile        | 2 +-
>  arch/mips/boot/Makefile              | 2 +-
>  arch/nios2/boot/Makefile             | 2 +-
>  arch/parisc/boot/compressed/Makefile | 2 +-
>  arch/riscv/boot/Makefile             | 2 +-
>  arch/s390/boot/Makefile              | 2 +-
>  arch/sh/boot/Makefile                | 2 +-
>  arch/sh/boot/compressed/Makefile     | 2 +-
>  arch/sparc/boot/Makefile             | 4 ++--
>  arch/x86/boot/compressed/Makefile    | 2 +-
>  arch/xtensa/boot/Makefile            | 2 +-
>  14 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/alpha/boot/Makefile b/arch/alpha/boot/Makefile
> index d8dba85e606c..b050753e9015 100644
> --- a/arch/alpha/boot/Makefile
> +++ b/arch/alpha/boot/Makefile
> @@ -40,7 +40,7 @@ endif
>  
>  # Compressed kernel image
>  $(obj)/vmlinux.gz: $(obj)/vmlinux FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  	@echo '  Kernel $@ is ready'
>  
>  $(obj)/main.o: $(obj)/ksize.h
> @@ -85,7 +85,7 @@ $(obj)/vmlinux.nh: vmlinux $(OBJSTRIP) FORCE
>  	$(call if_changed,objstrip)
>  
>  $(obj)/vmlinux.nh.gz: $(obj)/vmlinux.nh FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  
>  $(obj)/tools/lxboot: $(obj)/bootloader $(OBJSTRIP) FORCE
>  	$(call if_changed,objstrip)
> diff --git a/arch/arc/boot/Makefile b/arch/arc/boot/Makefile
> index 5a8550124b73..8a44c3e7ff3e 100644
> --- a/arch/arc/boot/Makefile
> +++ b/arch/arc/boot/Makefile
> @@ -23,7 +23,7 @@ $(obj)/vmlinux.bin: vmlinux FORCE
>  	$(call if_changed,objcopy)
>  
>  $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  
>  $(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,lzma)
> diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> index b5a08333bc57..d42d07667822 100644
> --- a/arch/arm64/boot/Makefile
> +++ b/arch/arm64/boot/Makefile
> @@ -26,7 +26,7 @@ $(obj)/Image.bz2: $(obj)/Image FORCE
>  	$(call if_changed,bzip2)
>  
>  $(obj)/Image.gz: $(obj)/Image FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  
>  $(obj)/Image.lz4: $(obj)/Image FORCE
>  	$(call if_changed,lz4)
> diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
> index 2b42c370d574..e3df3a64808a 100644
> --- a/arch/microblaze/boot/Makefile
> +++ b/arch/microblaze/boot/Makefile
> @@ -14,7 +14,7 @@ $(obj)/linux.bin.ub: $(obj)/linux.bin FORCE
>  	$(call if_changed,uimage)
>  
>  $(obj)/linux.bin.gz: $(obj)/linux.bin FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  
>  quiet_cmd_strip = STRIP   $< $@$2
>  	cmd_strip = $(STRIP) -K microblaze_start -K _end -K __log_buf \
> diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
> index 8473c4671702..996bf41b78de 100644
> --- a/arch/mips/boot/Makefile
> +++ b/arch/mips/boot/Makefile
> @@ -63,7 +63,7 @@ $(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,bzip2)
>  
>  $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  
>  $(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,lzma)
> diff --git a/arch/nios2/boot/Makefile b/arch/nios2/boot/Makefile
> index 29c11a06b750..1381e6e428a8 100644
> --- a/arch/nios2/boot/Makefile
> +++ b/arch/nios2/boot/Makefile
> @@ -18,7 +18,7 @@ $(obj)/vmlinux.bin: vmlinux FORCE
>  	$(call if_changed,objcopy)
>  
>  $(obj)/vmlinux.gz: $(obj)/vmlinux.bin FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  
>  $(obj)/vmImage: $(obj)/vmlinux.gz FORCE
>  	$(call if_changed,uimage)
> diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
> index 14eefb5ed5d1..a7fc7d424c00 100644
> --- a/arch/parisc/boot/compressed/Makefile
> +++ b/arch/parisc/boot/compressed/Makefile
> @@ -55,7 +55,7 @@ suffix-$(CONFIG_KERNEL_LZO)  := lzo
>  suffix-$(CONFIG_KERNEL_XZ)  := xz
>  
>  $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  $(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,bzip2_with_size)
>  $(obj)/vmlinux.bin.lz4: $(obj)/vmlinux.bin FORCE
> diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
> index 4a2d75b7e42d..b80a077a8e8f 100644
> --- a/arch/riscv/boot/Makefile
> +++ b/arch/riscv/boot/Makefile
> @@ -23,7 +23,7 @@ $(obj)/Image: vmlinux FORCE
>  	$(call if_changed,objcopy)
>  
>  $(obj)/Image.gz: $(obj)/Image FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  
>  $(obj)/loader.o: $(src)/loader.S $(obj)/Image
>  
> diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
> index 10b75e053a6f..e8e43ae80dd5 100644
> --- a/arch/s390/boot/Makefile
> +++ b/arch/s390/boot/Makefile
> @@ -117,7 +117,7 @@ suffix-$(CONFIG_KERNEL_XZ)  := .xz
>  suffix-$(CONFIG_KERNEL_ZSTD)  := .zst
>  
>  $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  $(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,bzip2_with_size)
>  $(obj)/vmlinux.bin.lz4: $(obj)/vmlinux.bin FORCE
> diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
> index 1f5d2df3c7e0..cf63e319b786 100644
> --- a/arch/sh/boot/Makefile
> +++ b/arch/sh/boot/Makefile
> @@ -66,7 +66,7 @@ $(obj)/vmlinux.bin: vmlinux FORCE
>  	$(call if_changed,objcopy)
>  
>  $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  
>  $(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,bzip2)
> diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
> index 58df491778b2..b85aa5f0d616 100644
> --- a/arch/sh/boot/compressed/Makefile
> +++ b/arch/sh/boot/compressed/Makefile
> @@ -39,7 +39,7 @@ $(obj)/vmlinux.bin: vmlinux FORCE
>  	$(call if_changed,objcopy)
>  
>  $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  $(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
>  	$(call if_changed,bzip2_with_size)
>  $(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
> diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
> index 339c42d35089..b53cf596611e 100644
> --- a/arch/sparc/boot/Makefile
> +++ b/arch/sparc/boot/Makefile
> @@ -23,7 +23,7 @@ ifeq ($(CONFIG_SPARC64),y)
>  # Actual linking
>  
>  $(obj)/zImage: $(obj)/image FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  	@$(kecho) 'Kernel: $@ is ready' '(#'$(or $(KBUILD_BUILD_VERSION),`cat .version`)')'
>  
>  $(obj)/vmlinux.aout: vmlinux FORCE
> @@ -45,7 +45,7 @@ $(obj)/image.bin: $(obj)/image FORCE
>  	$(call if_changed,objcopy)
>  
>  $(obj)/image.gz: $(obj)/image.bin FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  
>  UIMAGE_LOADADDR = $(CONFIG_UBOOT_LOAD_ADDR)
>  UIMAGE_ENTRYADDR = $(CONFIG_UBOOT_ENTRY_ADDR)
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 6ec5e031db1d..680ad803cba7 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -133,7 +133,7 @@ vmlinux.bin.all-y := $(obj)/vmlinux.bin
>  vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += $(obj)/vmlinux.relocs
>  
>  $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  $(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
>  	$(call if_changed,bzip2_with_size)
>  $(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
> diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
> index d8b0fadf429a..934f9015b15f 100644
> --- a/arch/xtensa/boot/Makefile
> +++ b/arch/xtensa/boot/Makefile
> @@ -36,7 +36,7 @@ $(obj)/vmlinux.bin: vmlinux FORCE
>  	$(call if_changed,objcopy)
>  
>  $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
> -	$(call if_changed,gzip)
> +	+$(call if_changed,gzip)
>  
>  boot-elf: $(obj)/vmlinux.bin
>  boot-redboot: $(obj)/vmlinux.bin.gz
> -- 
> 2.55.0
> 
