Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A032931CC
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 01:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785115726; cv=none; b=q0AMFVBnX4lI9DHrxHknt5Ly5mVHx7WWoq4mcw0s1XWbV+bp99GAqKXp5rLA4XYxAGFQXbLJKckPq3nTf3MpFLuEyqKvPWu1bq+4/BQEBnCgtaEpSEJT+Zt9PNVRbaxCBhzK22c0JaQIg6ZRaXIC8sWhuXikdNm9m+tqv3PTFmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785115726; c=relaxed/simple;
	bh=LsdNLXzG+2oi8st6LkBT/jm25MgJi7X7MpYpwrwfa08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCJ6/JqvKZ3ky4E3CMk7QUK5uvzukNGeq9Jih2DgW+cc8wKVFuIvphMZMsQeDzTVLNE2AG9EifZbyJgSv2n6qowSWM5jL9LBMuyXMEf8iccg1y6QLKAq4vLk7JbJlx1MnjEnQLh205w1VulaA8PoGufMzHWbPb0Vexk3VqT+W9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMgDvFKZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMgDvFKZ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47de008b020so1164052f8f.1
        for <linux-hardening@vger.kernel.org>; Sun, 26 Jul 2026 18:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785115723; x=1785720523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J+YAafdUWyy4iyACMaMYl4fxl/7MRA/3Ye5L0fqVOqU=;
        b=SMgDvFKZduaTyByBhaNPwLlxCBFKu1KYarmS3x2s87AbwgVoy7i9MErrxFBmc/aoEk
         mmUuqVWO1ojn1ank6I8xFFeWcaydnrLs0rwTmblilYMBVCoVGEZQCOq5ibi8EdPekI0w
         KPJFyK/xuPaGt6OfFBaKixBj38f367VIVkGG1g7ryko4M+6Y0DZEJBRb5cF3+zpyuGXv
         Rnr5VdEZ6VUFs8pYNkGlpMHw8VBDqn7Z6Cby/WLEpXlbkZobXSg1BDX2uYXX9ghedWtl
         4iYzlt+hFQZU+cTF63W2D+FkwUnnbS4kabOlNrDoG/fGs/9Z9yyBKzTfRWfVmCGKqZs1
         kyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785115723; x=1785720523;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J+YAafdUWyy4iyACMaMYl4fxl/7MRA/3Ye5L0fqVOqU=;
        b=WlG4RVJV45Pg35Uwl17S4a7UkWCQ8fjFohSts5daLZcZw7SlI8cJ3p/1Qy8itpXK7k
         CCVkuG1J8zmx6fbXO6WHUqX/9GzFkWTo5CQ/2Euava9NhQk9/U18cuNqZoreNsox1DPq
         wc9Elffj5vzSssRRZd+vKv9A6we7vUUWnUtAdk2gL8Za88rO38ev6uK7/LG4WNPehiKb
         GUclw5NEq0rPt534xsDQ7Vzm1EJdUvirT4c///qed8sLazumb3ZZyMEf+2ypUOU8op0/
         Sbd1Tz6cPOtDKb439Do8kZgVEs0OeejdKq95m8pxroXoPaSK1qZP0Ev/YqmCYIQEAj5n
         c7hQ==
X-Forwarded-Encrypted: i=1; AHgh+RrFmtWgPsDEpZNuPeIEHVr5rXk/4Len5HSUynEekRZOih2aPRnGKFurN5JODQcegqCKgsMCtxZ/Tfw674Dgtus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtEVy7Xhzw0Q0XTJ8cGHCfA1vYHnSytiCt/zRFM6OmUd5ZSBmA
	DYhaPj93/Q9ORMDUPjEbsGdwLsAztsth5/vPyCsbyDnET1yk1tkCNMa4
X-Gm-Gg: AR+sD13cB/v/szWkxOqWSYXGc4FQJR+Dl7CMDH9WhKIOcVRpVu5WRiaoll41bwtGFmP
	3Gn2Ipx0n+h0GEjpeALKFvOK6aJ2VYpESQuzNJlcPMM+ZpAT7Q/aBKqGPCD9WgXywwHMYweme5y
	Fbioo4ysGBCibPfuUa9nlh7n09j4m4wxPjcswBe6UK4AlcQPvkVHYHpKoCxUcfPz9E3dDv8MvqB
	qvdxRzz1NdGuZ+KNCOM4s0Ki/w/vCYvda1sY2uImDdvmDvZ7NqIxPHW4Yq24faRPjNHCIZj3Ipm
	/1jjtzY/gnnaTxgJMauhB6+6GiAZ+mvLfWwlw27Jz8FgGHsZyi4s4PxvIDPekpd5R58KDkVFA24
	g85TDZSC8RBsVEMFZApGMLpz9RUe4d9i6nSLWXh47+vjfCrLqleI/QIZBindaLBYlJIi6qR85Cm
	/S66nRh2htOJsbXnqbWXosqBMSS7AmcSOIY0aP1x6e4q8wwPdRZZiZp0LPs31LYxa1/6p8a5MG8
	/aA9i2g/y3wBM6Dj0xRh6qxnI/XBQyV+cS0GKzDMPg=
X-Received: by 2002:a05:6000:2903:b0:45a:5392:3a19 with SMTP id ffacd0b85a97d-47f9cdff8abmr11557115f8f.16.1785115723100;
        Sun, 26 Jul 2026 18:28:43 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-095-114-116-215.95.114.pool.telefonica.de. [95.114.116.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f96d4656bsm27341954f8f.21.2026.07.26.18.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 18:28:41 -0700 (PDT)
Date: Mon, 27 Jul 2026 03:28:09 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Linus Walleij <linusw@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] ARM: traps: Implement KCFI trap handler for ARM32
Message-ID: <amazbT2M9PQgb_Vq@gmail.com>
References: <20260715175223.make.153-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715175223.make.153-kees@kernel.org>

On Wed, Jul 15, 2026 at 10:52:27AM +0100, Kees Cook wrote:
> +/* UDF base pattern with KCFI bit: cond=0xe, 0x7f, xxxx, 1xxx, 0xf, xxxx */
> +#define CFI_UDF_IMM_BASE    0xe7f008f0
> +#define CFI_UDF_IMM_MASK    0xfff008f0	/* Mask for UDF + KCFI bit matching */

With this patch applied, KGDB and CONFIG_CFI cannot be used together. 
Setting a breakpoint causes Oops as CFI failure.

This patch on top of "ARM: breakpoint: CFI breakpoints only on demand",
multi_v7_defconfig + CONFIG_CFI=y + KGDB/KGDB_KDB/MAGIC_SYSRQ, THUMB2_KERNEL=n,
clang 22.1.8 LLVM=1, qemu-system-arm -M virt -cpu cortex-a15, booted with
kgdboc=ttyAMA0. 

Then "echo g > /proc/sysrq-trigger":

  sysrq: DEBUG
  CFI failure at kgdb_breakpoint+0x2c/0x58 (target: kgdb_breakpoint+0x2c/0x58; expected type: 0xc0472d70)
  Internal error: Oops - CFI: 0 [#1] SMP ARM
  Modules linked in:
  CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 7.2.0-rc3-00278-g38436106b2f5-dirty #1 VOLUNTARY
  Hardware name: Generic DT based system
  PC is at kgdb_breakpoint+0x2c/0x58
  LR is at kgdb_breakpoint+0x2c/0x58
  pc : [<c0472d70>]    lr : [<c0472d70>]    psr: 60000013
  sp : e080dea8  ip : 00000000  fp : 0021a1c0
  r10: 00000000  r9 : 00000000  r8 : c2004048
  r7 : c2205d9c  r6 : 00000000  r5 : c1609558  r4 : c22bb994
  r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000000
  Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
  ...
   kgdb_breakpoint from __handle_sysrq+0x150/0x158


Thanks,
Karl
