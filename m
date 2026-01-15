Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B64F394493
	for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479285; cv=none; b=a1Io3HqpLvurlOIqNWdx11U/Lifk6TAMoYbLClQgxSwOdAQTZ530IUz64BlhVUvkSMf2G/Ax8pUmv+HL+ESWwXaRJmYpUtK1yj8woRkzgTzUAC2ms3wvkzbVrqsZL68sisTknjVDoBdzEz8NuB8SkP6PDPqlUjwDc/8SieZ2b2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479285; c=relaxed/simple;
	bh=BMtROxTlhcEjGTvjLejFDk2Vbg7ExK2i/Mb0lDmT8j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ6yYiIlLD4Oq/JMuDsZqB9qjUdln3WbVlO6Kl88P9DzIxHj5cEQsUW36KaQFnJuzFhcolZxMaf6UcIc8ebjz6sK7JciprWp8i1N8NvtFal5RoiLU0CtfHdgrCFXjVcEg86IqSIg0Ljf18pbVdb/lNynrnT4/G2ke5yqaIMnr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QC/gWSUS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QC/gWSUS"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so743670f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 04:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768479281; x=1769084081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zx4s5ogULMWiwAg3H50k8gmoVyZOh2DwfMGC+/dY5Co=;
        b=QC/gWSUSA0EAhwaYo46xYVQT8Y1ECjcpRFmmp8NFZI6gFeOCyv54QFoONL0zhD1tRb
         Wpjcalm58F07U7X6X3ElfdI2aMbZTcQHAaMqiDAUqfii1xPgbxHV2Rr+MHF/YquIzq19
         ugRBOmWQG091YmUU32AncGeAZWhNkTR6Mp48MmebVJnSiapVRAPhk0nmw029/JzlyLO2
         3wo7/niLOkIcJq11YHaoiZlxyk5NmQWmEdSgBJiPdg0jON0WU/DvEZu8cMJLNsZBeVtR
         QXw0tRC6Us8sGCxg174oOAPWPaE8M/fVUYQLmZ6JJA8mAowmTwqll4CNctmANwjapfcO
         OyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479281; x=1769084081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx4s5ogULMWiwAg3H50k8gmoVyZOh2DwfMGC+/dY5Co=;
        b=UH5xkIvuzzGgxyo3ozvdP0jFs7o2wTmrPirAl5cVn0PNeDUDbFkQawsg80UoPNabPS
         8y96KfGIuGxhHeW26TSzxiXTZEAwhw+OewLDtu7sFToWt0AI5z49NzsRDeQbM8SaFVT5
         l6hLxNmxMFhSHZ8aa8fORpegT7qFFJMmo7hLLRwKtNp2inrGvhNKqFS8FPGRbAmrW/fp
         iwBBO21bFnDEVWpdPCliNa1gHZnw1LKU7gJKlUOsYdxFOzSLpJeMHxcZBMpNiSVvgUDu
         Il1RM9Fj3T0OIErYdTPLDtWRcvMHHdsQ7Xe9WbUqf+MXtv0VqwCs5gzs+jUwk+3SGTO5
         Lf5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVh1WNauwk1LBtP8FK6ZLC7yzVdu4BsmLeRVvIgItHnQsS5dASMCzFgF6MAvB4TTjZzBlPdMwq3QngHBGC2rys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcPMPeY7LTtcB/2eZk++VNXPqUpStv2b7vEoTBWQNKnCsn265H
	9a5PtDywalsQKQMAcjo5RAz1dvhSe09CX97ulnJonKox/CXyS7ygOHiiq+PRuRi7N9U=
X-Gm-Gg: AY/fxX6ct/u/EIpYagCiviq+UwKVhkmoeMvsCIAr/qkq4QCedGZypIgmNHdFejdmng9
	zGJaP+0vQidoy/oTbXmg2lCoKUrQxlvZio/zCLvzg8Gs0+ErPC7Kp05mTMP0NJSnZSN67uf7aLw
	oYUSuEMK9DlEbM+WTNoOW0KXlk+By9uHpR30ng5o9+A5SZAR+iQTNr+zbplMWE9Os2XEC0aGXX+
	Yh7RxgvrCI91zO+BKrEK/RqnGGyY2N+Ru2falzyMjHSzJ6tkZweGbPjkn0zRA+PB4DWcrqBr1WM
	cdtayIcHqO1KXOBUVeVt4oo8XkonVaQsfUldqF2WlFisgleLG+DcUa0c6BGnl9jVXHKq5ZPXJ5n
	r3eafbZIStZ8nG0IQ9um/bEQ0U5FA3T1Tz+l7MgifQAeweUJJK+3/S2y9IQaLsELAWkSOIuZBIK
	itPgOdBjSQ+QaTFg==
X-Received: by 2002:a05:6000:3101:b0:431:abb:942f with SMTP id ffacd0b85a97d-4342c557b93mr7715812f8f.54.1768479281353;
        Thu, 15 Jan 2026 04:14:41 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a778sm5591185f8f.3.2026.01.15.04.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:14:40 -0800 (PST)
Date: Thu, 15 Jan 2026 13:14:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/19] sparc: kernel: btext: Migrate to
 register_console_force helper
Message-ID: <aWjaLhzRoTLalIrM@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-12-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-12-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:19, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

LGTM, nice cleanup!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
