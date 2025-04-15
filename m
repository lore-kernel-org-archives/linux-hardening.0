Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98C2522B1
	for <linux-hardening@vger.kernel.org>; Tue, 15 Apr 2025 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744748798; cv=none; b=JROPow/x13QHgUaeISQGMWKeyaP3G48PnzZet24ReOGDcNAxG/YLDUeP+txH+0PAqF/2qX3EUG78Szh26bpntTaGdG6OJpHrS4TP+ReNDCOIOqNOjnhg9CX2J9JjDfREVVgEAHPOQ9Udh58hQ/f2EWOmctaZUSdrZDhXCdOpQ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744748798; c=relaxed/simple;
	bh=pvhdq1iT6xGsvgus+UKN3OsBlAAH0DtpK3RlifG8BJM=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=Jahe+u99colO4r99ntdP9YgMXepnvKNwkFUPvlAk8dukGmJlvfKjQJAkWO+zWx/5hAqf1ZCLXSwTzG5jOqi4V4w4IMqSpBFh6pioW5R4RnbAZoa8Iwjr4CNuVVNxsd0xk/ZWIEd8M2KxFmWFtnZSpt4L8WfR1f5AUdCjI7I6l0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=XLDo79tU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="XLDo79tU"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c336fcdaaso189725ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 15 Apr 2025 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1744748795; x=1745353595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75O+xckdYXwHr1AtIxgXc+6DXaHjIxC/DyVy3zDpIz0=;
        b=XLDo79tUWtsSyOg3xIXO22NF80KF+kIkz56BKthwC91b4eFF7bJO0jyzCHuTI262xE
         SGBooLKeSiFXReSSauJuw0Bqedg/QneFBy5IpgixbWcYzF/E4kgFlhshdVgaUe6aWUMi
         vJx+bgEA9kQ23l4FtxT9Z/PXaFZNURfI1kQW08KruJp1maHDt6x2fTyKZ7GYzc6okJvY
         kiP/IhTjuDDuQLS6lp+BxCYaoKxNQekkNdOVb+60IfUdRCZbFUOeKkMSWDKS0kB8bm32
         UGxMxfXzN3SSB++/LG2qlT6dyhle6Go0XLRAyz3IiiVWrjZh8LajjCztPmwhvlN8o0jb
         exIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744748795; x=1745353595;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75O+xckdYXwHr1AtIxgXc+6DXaHjIxC/DyVy3zDpIz0=;
        b=husSAlG2szmukpcGtjp80Qfw/F8PWhe0J4r+02Tyv3AYxnCWLQKiBcrEOyo9tXn1Hh
         fnK2Bn5/a+0sWVUwy8mZ6Ahh7Vl91YDR/xuxQiTrNjMAvqVMYMXx6edR70E5iIQqDBKU
         TA8T7ez/Nd/k0CoY5Qx+HjHQIrsUHdFZvKOn4KIGOSzAJIuUvL+43AMGI2KSNNQEAbIb
         vP+ZlKX7ltYJmNUTBDjfV+iUNSVYjoIC2e8jr1tHisMum4OdAYQMT+UlAAXqN6yTtkRJ
         xZlVPCo2VJgSf2l1BILkCb077CSBTFD19+WPvbgUbNWePtBMsW+wGYC+aEPivMUd+uXr
         On/g==
X-Forwarded-Encrypted: i=1; AJvYcCV1cve/3yCkwVjwWsWWTh/nb+/WPRdY6vdREHEvjDD4iyHYgyLgkLqLp7nO9y7fbpeapODuS2NILSG847cXF+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGlYC/Ms8zOOzlgLgywXeuiDEXEzXsbBPAZjrqtX+WdPRJU43U
	Ngg/66uKpd5QEJcKYgkG0Mn+9PxHnTLkQpjiJmTVy1GMt5RXJvmPbA6bVa1KKxk=
X-Gm-Gg: ASbGncubKayUgI2ruV6jgF8zSX3eFhrEM26eDMcI01vZ2Oubx/5FimBpBdCe9wt1XlV
	BCD9WQrSTLtmF0Fnr7D/q9zmx543fGeGeup0t0IQYvCDYGCjEW/ufdDR9sD5f5UgRI33HXRUpwp
	xkllQ7caIXsz0GOHX0H1jjWurKb0FOnAJy9OL17HVumswHPgw+r1+IoE+KL32grTXPItm+EtqkH
	lgef/rActbVnnnkwWUOlLQ5zDT4gJCh3KaO3DLCg9SIDDSiKjaw88bOsfyeYhbFs0+XnyLfXVRY
	cy6+WPWhZB+ZwDzhFNFjlKMhaIGazSYb8g==
X-Google-Smtp-Source: AGHT+IGZO5UAvPkrrKwYYPSXRVF2GgYYFWa7uULNbD4bFXFpfMPqMwk2vBYgwS4j3xl5itHBc4XrIg==
X-Received: by 2002:a17:902:cec9:b0:216:2bd7:1c2f with SMTP id d9443c01a7336-22c318bd3a5mr7320125ad.18.1744748794919;
        Tue, 15 Apr 2025 13:26:34 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c93ad2sm122460825ad.115.2025.04.15.13.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 13:26:34 -0700 (PDT)
Date: Tue, 15 Apr 2025 13:26:34 -0700 (PDT)
X-Google-Original-Date: Tue, 15 Apr 2025 13:26:31 PDT (-0700)
Subject:     Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
In-Reply-To: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>, kees@kernel.org, mic@digikod.net,
  gnoack@google.com, Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, broonie@kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: broonie@kernel.org
Message-ID: <mhng-812ee330-2f86-4561-8b88-cbb6a51f8515@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 07 Apr 2025 13:57:32 PDT (-0700), broonie@kernel.org wrote:
> In current mainline x86_64 allmodconfig builds done with tuxmake GCC 13
> and GCC 14 toolchains (which are Debian ones packaged up into containers)
> generate ICEs in landlock:
>
> Event                            | Plugins
> PLUGIN_FINISH_TYPE               | randomize_layout_plugin
> PLUGIN_FINISH_DECL               | randomize_layout_plugin
> PLUGIN_ATTRIBUTES                | latent_entropy_plugin randomize_layout_plugin
> PLUGIN_START_UNIT                | latent_entropy_plugin stackleak_plugin
> PLUGIN_ALL_IPA_PASSES_START      | randomize_layout_plugin
> /build/stage/linux/security/landlock/fs.c: In function ‘hook_file_ioctl_common’:
> /build/stage/linux/security/landlock/fs.c:1745:61: internal compiler error: in c
> ount_type_elements, at expr.cc:7075
>  1745 |                         .u.op = &(struct lsm_ioctlop_audit) {
>       |                                                             ^
>
> Arnd bisected this to c56f649646ec ("landlock: Log mount-related
> denials") but that commit is fairly obviously not really at fault here,
> most likely this is an issue in the plugin.  Given how disruptive having
> key configs like this failing let's disable the plugins for compile test
> builds until a fix is found.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  scripts/gcc-plugins/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> index e383cda05367..29b03c136165 100644
> --- a/scripts/gcc-plugins/Kconfig
> +++ b/scripts/gcc-plugins/Kconfig
> @@ -7,6 +7,7 @@ config HAVE_GCC_PLUGINS
>
>  menuconfig GCC_PLUGINS
>  	bool "GCC plugins"
> +	depends on !COMPILE_TEST
>  	depends on HAVE_GCC_PLUGINS
>  	depends on CC_IS_GCC
>  	depends on $(success,test -e $(shell,$(CC) -print-file-name=plugin)/include/plugin-version.h)
>
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250407-kbuild-disable-gcc-plugins-8701aa609cb3
>
> Best regards,

This one's been biting me too.  It manifests for me on gcc-12 and gcc-13 
(both locally built toolchains off the release branches, cross compiling 
for RISC-V).

Tested-by: Palmer Dabbelt <palmer@rivosinc.com>
