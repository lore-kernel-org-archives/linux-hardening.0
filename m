Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51928488;
	Fri, 20 Sep 2024 01:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726796914; cv=none; b=H/2QPMTK9bkwmjSShzyHBX6N3fiFG/O32KBdsd/0j2B4FkWoNMm5/1BQexYu94CZZbHlqWGX8wbdaykQLhEfPyVI3CXQtLeEq1mz4yIz4Qmbguy579FClAwRp4WheNKN8e08jjCIYdJd+8T/PYC4Wz3YAnMxkoAte/jCSiidg1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726796914; c=relaxed/simple;
	bh=jSoI39WMQGZkSUAZAR0rk3l2zuO1dUp3shRj2c5AfVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKouLeLkMCDcx+SynvgJMFvSlLk/gDBdyog5touqdkZcHkFk356/uRqSC84lyFULyweJ9ljoOSyhv3j6qKiyhiN6z0F71h4sccnkL8z8vLWpOzDhQGfqItmRFIOIjxUga7dUCXc10OhjF5gw9wpUAAc18uU8n/i0Z9nCkCZ05WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnYsxIYM; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnYsxIYM"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e039889ca0so894583b6e.3;
        Thu, 19 Sep 2024 18:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726796912; x=1727401712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jKNlb3VlWux/vWasCEWPPQSnn190v6VnOgHcSwdwxRE=;
        b=SnYsxIYMfSlY0+lPp7fUfBGiMBaRAMzITBtdwOpwiAtgl/+7Z3Wu+Uz/N9g+ciCTEQ
         p7fY9u1tXK5QTLBEBauUFO6lik/udhvi9y5ULKNm68diTZUbqurkRXS//szeP6YL6pQv
         WPMT48aYxo1FsGXOVRE+5EXmpvqK/6Oo0wZWIe3NoEmbtoJ/AHNFpJUXyY8FXuUDxYrN
         a46awcG5T3t9s5MwvRKp1jz9TYWN8RmScmDyvcZ3mE8p0MJLDxreyfgg2FRLSaGTLUlF
         NRAONbxMwd2BuPOnLlNdcbLwGbDFDA5ltXH+8+6xRzgqOF7nHeYam5pHQUYSs+kzozvQ
         L9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726796912; x=1727401712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKNlb3VlWux/vWasCEWPPQSnn190v6VnOgHcSwdwxRE=;
        b=PJe29tXD170m+iESCuHpqCmTzMVDBUt+lPqXu4BS2pXp5Am2wxiFWx0MSsR03OwX11
         NQqUP94UrKARXWW+Lq5rpiaVqxQk9wLdkQsnf7Eo8ph0I4S2yP4Yjva+C6xosvL+QYQ+
         uxzefi9hJIS9XAbM9SmGpiJWoXSGeaJ8xj21TiehIfSXLGpcfcDYur8JNAnDQha2rhUK
         XX70tMcd40r9bPc5+d5ituXKkVomEe9+yd9N6rnDM6fl9RRRnR5tXoaQVR6Afym2izCI
         VZCTJyLHWFw+OQmTdnEsxxm6XLPbH1n5sXR8lzSrNsNcSjN5jsYSB8LQNUKJSoCNgE7q
         qQxg==
X-Forwarded-Encrypted: i=1; AJvYcCUiVJusJgY97hf737DQcw3rDvUaknqVZVxPXzC5eDGCyMcKuoZU1C6zzsTZ2eWHCZXdNQwrb40zKoBRH/D5@vger.kernel.org, AJvYcCWDfRy6ShN7xlyFPD2sg78ZCSOn80URO6hUM8VlSzqxvlJR4KS2jU9enlWDc9KbfuGycWGbxnn7oxh2RTQq6I4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5MiAFu2NmHMgcLUAbETUOYyNWa3ExBaWCfAjWc9bn8+zok9Nd
	3PAnuhRlwxBliPjOjcRuNdlxtAaCHkOuhVf6K33/lvee2DtIvWI1jgV99osVd5JGQ7qCGoao8sD
	DxpU8dGygL8HWhuxqXMh7Dl9SbRs=
X-Google-Smtp-Source: AGHT+IH/bQD7pgqHd1p6BRYd2PjIwYfPHHcdz9+dZMvw+3O5NpkNnyTG84+1ayDrl+AHsJp4HGgY8zrYG0ki0tieyAs=
X-Received: by 2002:a05:6808:2005:b0:3da:ab86:bfd7 with SMTP id
 5614622812f47-3e271b5f520mr1475181b6e.3.1726796911989; Thu, 19 Sep 2024
 18:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYSPR04MB70840448562705C21BA8DCCF8A632@TYSPR04MB7084.apcprd04.prod.outlook.com>
 <6a689c83-24de-4d3c-afc1-107439f66130@linux.alibaba.com>
In-Reply-To: <6a689c83-24de-4d3c-afc1-107439f66130@linux.alibaba.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Fri, 20 Sep 2024 09:47:56 +0800
Message-ID: <CAAfSe-sbz2na_yZ8XgLOaLrY=NOR8RSeQ_+f20qk3jEFxdsKMg@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/timer-sprd: Select driver on ARM and ARM64
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Enlin Mu <enlin.mu@outlook.com>, daniel.lezcano@linaro.org, tglx@linutronix.de, 
	orsonzhai@gmail.com, linux-kernel@vger.kernel.org, enlin.mu@unisoc.com, 
	enlinmu@gmail.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 15:51, Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/9/19 15:25, Enlin Mu wrote:
> > From: Enlin Mu <enlin.mu@unisoc.com>
> >
> > sprd timer is currently available on ARM and ARM64 based devices.
> > Thus select it for ARM and ARM64
> >
> > Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
> > ---
> >   drivers/clocksource/Kconfig | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 95dd4660b5b6..296c5f664583 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -494,8 +494,8 @@ config MTK_CPUX_TIMER
> >   config SPRD_TIMER
> >       bool "Spreadtrum timer driver" if EXPERT
> >       depends on HAS_IOMEM
> > -     depends on (ARCH_SPRD || COMPILE_TEST)
> > -     default ARCH_SPRD
> > +     depends on (ARM || ARM64 || COMPILE_TEST)
>
> I don't understand, if this driver is available on ARM, why ARCH_SPRD is
> not enabled on ARM architecture?

It is probably because GKI doesn't select ARCH_SPRD.


>
> > +     default y
> >       select TIMER_OF
> >       help
> >         Enables support for the Spreadtrum timer driver.
