Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50637E1;
	Sun, 22 Sep 2024 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727044678; cv=none; b=tov1T/Pg6HafLjwvvWd2RT8S84s7kTFBXwsrQUjFz5j1/m2iX0UVrmumOLD8ZOY/Umkbe4hoBJW42x4vIJzQPPJOvzDc+HCMng+9ZN4uhjDhUWFkoIDUQNH5l0Z4FH8PlqRicys0JAZuePxaDsSrto/d1BrCIqtT5aE2ewZl4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727044678; c=relaxed/simple;
	bh=4IWXfehvkd6g9rLG1j1cad/y+btEFVhO05pVNfTAi3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QV4WlNQMkVwTlhumDruQfukKak8YMdp6yNq4r9gMd9fuCNCibdB9p4RRJ5CTZiQsC5f9ovki86BcP7CJOc3qrOGh6pUL3Tx+E5E5BqzeJLH+mFmemWAbbD+7VCdyCqZGOetJQlaIiVPoahnK3vTuHaJM4sHg2HoJqaH10wAPyHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9qDGn0O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9qDGn0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274D4C4CEC3;
	Sun, 22 Sep 2024 22:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727044678;
	bh=4IWXfehvkd6g9rLG1j1cad/y+btEFVhO05pVNfTAi3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9qDGn0OfprDM5k76Ofdp1z2t4i5njPK0D01NvWyvex0YnTUKeYBDAyykOUVfJZUI
	 Hvg9yqiiTmUv7QQMBeYamO2QdFH0QFT5YVFTrNXO0H6BJaMxiAxGdwmX5wcrhZ12DE
	 bxtSp29u2x1+JVh/8qwEtwZWkxeryO1kIPUxoyUSP4WZT4xzpVf0UbKa6IP9MY72EG
	 OtCT01MGPn1iKCYwFwui6+Evm1xW7YHISOrr281UsTEUW2cdL6ZEHNR+0Znfju1FMM
	 YhDj7b1K8xcyjmc23tVmtwHzDyEQQKfIImhf56xWfnkkwEcL+Yj/97xzQdnV4UD3O2
	 Naz0TrQuZVI1g==
Date: Sun, 22 Sep 2024 15:37:57 -0700
From: Kees Cook <kees@kernel.org>
To: Jason Montleon <jmontleo@redhat.com>
Cc: linux-hardening@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-riscv@lists.infradead.org
Subject: Re: [REGRESSION][BISECTED] Cannot boot Lichee Pi 4A with
 FORTIFY_SOURCE enabled
Message-ID: <202409221511.9AF49BD@keescook>
References: <CAJD_bPJes4QhmXY5f63GHV9B9HFkSCoaZjk-qCT2NGS7Q9HODg@mail.gmail.com>
 <B2A62C7F-45BA-43E1-975F-5AF0197CD2C3@kernel.org>
 <CAJD_bP+43=XXD7p3fRfDxCbj=_YedgVLv38XO4iOAw94a+4PHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD_bP+43=XXD7p3fRfDxCbj=_YedgVLv38XO4iOAw94a+4PHg@mail.gmail.com>

On Sun, Sep 22, 2024 at 04:18:39PM -0400, Jason Montleon wrote:
> Thank you for the quick reply! I am using the Fedora 40 packaged
> version of gcc, gcc-14.1.1-1.fc40.riscv64.

Great! Thanks for the details.

> I originally noticed this while testing a build of the Fedora RISC-V
> .config on Fedora 40.
> http://fedora.riscv.rocks:3000/rpms/kernel/src/branch/main-riscv64/kernel-riscv64-fedora.config
> 
> When I noticed I could not boot this on the lpi4a I tried the
> defconfig(arch/riscv/configs/defconfig), which worked. After merging
> the configs a bit at a time I narrowed it down to FORTIFY_SOURCE=y

I'm trying to imagine how the boot would get stopped with 2003e483a81c
("fortify: Do not special-case 0-sized destinations") applied, since
that portion of the fortify checking is only supposed to warn (i.e. not
bug or panic) and then continue without blocking anything. I don't see
CONFIG_PANIC_ON_OOPS set in this config, so that's not it.

> To do the bisect I used the riscv defconfig, running make menuconfig
> to turn on FORTIFY_SOURCE, and saving.
> https://gist.github.com/jmontleon/9cdc778e9c9139296924d3f71b48067b
> 
> As far as logs, I am having a hard time gathering anything useful
> because the boot fails so early. Normally with FORTIFY_SOURCE turned
> on I get no output from the kernel at all.
> https://gist.github.com/jmontleon/42167a7b6d71bb4db8b7ca7114893b86
> 
> With a config closer to the Fedora debug kernel config I got a bit
> more, but it stopped booting here and doesn't seem much more useful.
> https://gist.github.com/jmontleon/00426b3bff2c85a68370ca1fb5f968c7

I don't see a panic_on_warn on the boot command line either:

  Kernel command line: console=ttyS0,115200 root=PARTUUID=c44914cf-1285-4aec-b5df-0224434d3e12 rootfstype=ext4 rw clk_ignore_unused earlycon=sbi loglevel=7 debug=console

> If you have suggestions for getting more meaningful output I am happy to try.

Can you try this patch? It should avoid using the "WARN" infrastructure
(if that is the source of blocking boot), but should still provide some
detail about what tripped it up (via the "regular" pr_*() logging). And
if it boots, can you look at the log to find what it reports for the
"Wanted to write ..." line(s)?

Thanks!

-Kees


diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 0d99bf11d260..469a3439959d 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -549,7 +549,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 					 const size_t q_size,
 					 const size_t p_size_field,
 					 const size_t q_size_field,
-					 const u8 func)
+					 const u8 func,
+					 const char *field)
 {
 	if (__builtin_constant_p(size)) {
 		/*
@@ -610,8 +611,13 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	 * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101832
 	 */
 	if (p_size_field != SIZE_MAX &&
-	    p_size != p_size_field && p_size_field < size)
-		return true;
+	    p_size != p_size_field && p_size_field < size) {
+		if (p_size_field == 0)
+			pr_warn("Wanted to write %zu to a 0-sized destination: %s\n",
+				size, field);
+		else
+			return true;
+	}
 
 	return false;
 }
@@ -625,7 +631,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	const size_t __q_size_field = (q_size_field);			\
 	fortify_warn_once(fortify_memcpy_chk(__fortify_size, __p_size,	\
 				     __q_size, __p_size_field,		\
-				     __q_size_field, FORTIFY_FUNC_ ##op), \
+				     __q_size_field, FORTIFY_FUNC_ ##op,\
+				     #p " at " FILE_LINE), \
 		  #op ": detected field-spanning write (size %zu) of single %s (size %zu)\n", \
 		  __fortify_size,					\
 		  "field \"" #p "\" at " FILE_LINE,			\


-- 
Kees Cook
