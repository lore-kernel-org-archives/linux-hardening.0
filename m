Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57CF3403E3
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 01:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116277; cv=none; b=OMLMR08UyuqTT8OIuBUhzQsSE0cgWGe0xoXm3YTjornjSt/GhsTHsUIAGQQF6HG9J31yCcOJuzaYSSKoxgkRMXfQVK7l+McVH4TkEx1AYUg2qT53NODSzrk8MyQFtMwglLbyp44MBwbvfijCBZfiEP2TUVAo8R5YYzS5tqGobyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116277; c=relaxed/simple;
	bh=4Du12IrYdFkkEnXL/yNSCK5B4x+jmIWWPczOqwUqqTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAS8e9XC45AUGTOHOAKSx3SV1YYzJW+GNpS1y69E+0sxi5hC4tfQd7RwNRcng7Qz753OcfXYJJEf1yY2GVvJDae9qEKxc7ndw0I7ruJeXFp9edJ4b2YElnOwQiysds4giRCP6rF4WmQu66rGjGIGDuusVxLlDpveeIfMWOOzS6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVb81v2Y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVb81v2Y"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f633e6058so1875635f8f.0
        for <linux-hardening@vger.kernel.org>; Sun, 26 Jul 2026 18:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785116269; x=1785721069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X5WxXKv3tM/juHDs7F+fi+T5krsvThiBbf/3eNS3EFY=;
        b=UVb81v2Y8FCOH/qo3DTSqFxRn4rsBbfjtSwcCH2VSvTiWYpIP/lASAWBpTGTrClXiJ
         gJgaIAlYBdLjUNixlrlM3Y33jSEsYRquVFMIt2nNBSyVDE4FS/R64uBKbq4mdWVql+H2
         qcNUBaQ1nFHrP1pzLyUDuMQOHdljGC3CY3jUj6byItX3Hodx3wR+WgIWtQYUaFGF9ZMw
         we89yPBxdQk2VDKyDcQfQGuY45aJq2dg8DtFKuNLg51I8JcOorkCHHO60SGk8nNjLiSl
         XSzMCjECgkaQvaC5nEeBl+STbDnhNTHPTWUNLZyqRbKXUsMK3chUk+LijSmVhyazVgd9
         W2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785116269; x=1785721069;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X5WxXKv3tM/juHDs7F+fi+T5krsvThiBbf/3eNS3EFY=;
        b=EvL2fNQtzgCq+4p11vlbTqMn7WcG3uzaGSUKKdxLQRd77QqzC0WQReda2CJC4LMX7G
         MK9fiYM919Q4HK8gzRyOeZIjAIoAAE/IuV1qJW+Nh6k/lfHyU0AtAisXf1Y6Gqx5FG53
         it+MYlv8V7DatDOMcLnADyHploylG8IxA7z7/5Vm/aYjMTD3ZQwoa2Vplx/xOQQ1iTdR
         fT+jz524BHSbGKRpdo7d7UKidi8EBWyKS7985AwYEUubgl1KE9tyWpL1DIrYJUbDVBsr
         yf+QXQDlO5OzkRddnvbOSRIobYVzx5FvZN8nG+0s7Mv1/ytfdVgHvsmM0vryINQ+sgYy
         lLTA==
X-Forwarded-Encrypted: i=1; AHgh+Ro/SIfDwbNohMEvCfM9EkwMZu33Foc+CWvnR/mwHirq47aqfd0VjkodnEOuqlaGUoG1kR7dXCQCqstbTsQXqng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJn6pT99aCDeaX/x7VdOZsq+yyg+u+a2uEIQQm0qEeMwO48ajd
	t7gKWG778YFto9trb96xE+NQPppzGiCg9KGRM+DBU3Wi/b5W9GI4UiEj
X-Gm-Gg: AR+sD13B5xuD+Rqb7P+a+Elrcy76rRFEp4Wizr0uUXZij2F+okK69wsEOgUt8ToegIZ
	ghw4xiJdcmp0qyYqm8RwufvN52S3ZTgLlc3HyRuaxk4O76HsTe9X6aXR3se3ofR1n2Yw5ldjFKj
	wylY1yWPJcfIivAZONPHmWS0I0DB/o1qafbi051xHZhPrL8GpueZhOQmkjjDtELDSjEE7qKgb+c
	ufj7pwR1Kh7ICLEOgoEmoJ38izlEffeKu+V/RJ9RIWZI/LPduRffkGqp6TbMLKzFvj8ur8YzI0J
	w1x1g11howii5+7MC022o4GPx5ur56a5aUQUtnqRQpl9SIvrq2+KOU3d4nNulzPT6FpXEXKIaKQ
	I5aJ20yoGSqFyCTTOKEIjpXPw9LQmxwQGx2kXFATbGh99KZ46hlsmSh05EgahgU9N9qA4FkmzdL
	HidA2oyblG14HfflMhmGKSJFSrGddGOOsdGg61zAGV3sERsvse+7wbEQ3TM8n6BnZu1Oye0/gKH
	I9MZu7ZKdZ10KOulWR8CfXrypMdM3qUABcWdIwgssY=
X-Received: by 2002:a05:6000:2512:b0:47f:4fa9:ae42 with SMTP id ffacd0b85a97d-47f9fc8c4dbmr8796069f8f.11.1785116268631;
        Sun, 26 Jul 2026 18:37:48 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-095-114-116-215.95.114.pool.telefonica.de. [95.114.116.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm45492653f8f.11.2026.07.26.18.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 18:37:48 -0700 (PDT)
Date: Mon, 27 Jul 2026 03:37:16 +0200
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
Message-ID: <ama1UiT1Jxy-PvVN@gmail.com>
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
> +			/* Check for EOR/EORS immediate: cccc 0010 0x1n Rn Rd immediate */
> +			if ((instr_prev & 0x0fe00000) == 0x02200000) {
> +				/* Extract EOR immediate value and XOR to reconstruct type */
> +				u32 rotate = (instr_prev >> 8) & 0xf;
> +				u32 imm8 = instr_prev & 0xff;
> +				u32 imm32 = (imm8 >> (rotate * 2)) | (imm8 << (32 - rotate * 2));

With CONFIG_UBSAN_SHIFT=y, I reproduced the following in QEMU with GCC
v14 KCFI and LKDTM CFI_FORWARD_PROTO:

  UBSAN: shift-out-of-bounds in arch/arm/kernel/traps.c:555:48
  shift exponent 32 is too large for 32-bit type 'unsigned int'

Could this use ror32() from <linux/bitops.h> instead?

Thanks,
Karl
