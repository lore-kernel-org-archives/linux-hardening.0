Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF634846A
	for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479190; cv=none; b=pHpmLem9qLW1hqL+kbogY62DMiV9bXboKYlxBq643meHSZ7NCU2ZY0lNIIZukuXcHjw0QEue69NO2LjYrvezVufBWZgvfMs8AFJN7/DU10GxmSyDf0Xz0o4bjNCq6+PjutRRXSRlC8W2M3snhaU4hUB1TETTMeSBjx6s9oVYUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479190; c=relaxed/simple;
	bh=WgWNQzN1HCbfxhvYic4vy3EiJadotNmJsmSAKb79EIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js8TOOiR5NzKXuXdoHBu4AhgIFjnCdp5U7yXUK9TUufgAMZii5e8B8fT1AtPjscXezIIP5seI+22Yuhz0Q+ZiE/w9E/OBer6HYqZ2tPSL/REdbSSm1lhryDw0X0WB3M4TeWsbNUiE3sSJnjSXFzqHtx7CKpvDrTfn+WTSF9BaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BfTHUrZ3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BfTHUrZ3"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so10476875e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 04:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768479186; x=1769083986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tARhp8b6WpUCQdTEvi4pG8l7ncFl190/VBWtO1OWxSE=;
        b=BfTHUrZ3u5ApH8EMCkFS7NjojsplUSRc4DXcm4dai1QX+UpQAxW6Lfy8zd1RnxLsIZ
         W6M14mRS7L5U6AW17JqpChgweZ2bcLX45gBaMp2WfX0ratjmrgOz3cuZjOrvLPRigfVF
         AXb8vp4TdJpOEfHcwONsQKtadDQ1g+FQQI8vCbQKoRVywWEtW4uh2GNwSGWQVTbvYGLn
         7hrpzdn1bVFQsL1C8x5ZyoAu8bgCLO9wmlcaujAh+qLtYBvNDQVUvIPgTFL4vJgrLRzA
         OzvmDq8oiNhBno1p6gWZWEW5/gDsq2mQl7a+Q5ac6Y4uqg35suO36FhIdGnoZGK1v+L8
         BIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479186; x=1769083986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tARhp8b6WpUCQdTEvi4pG8l7ncFl190/VBWtO1OWxSE=;
        b=l1mkufUH0dsnHCiFKlrKCTDNW+yrHEDEQUArtsMLSAMBbFXF4ULp/TMP3s9jxu5o1z
         mF1CjrzOO336y704pGCTRKa+DQizvKPD252avhGzhkHSWB8KK8njZOoMYohns3cI3Zj6
         IM+HgGN38D1O/XGPCywRN/qsJy6DW/nIwv1SImbDZCAD3zUv4tMM4s4KqS2vEZWJTxoJ
         +PXYtiw3is3qUm9VUJdxf4XeScXSIbsEZAsS8a7UY8Hw/TdABojG+MnioOYOtJo4KakU
         syNBAB83iXz8PCt1nUal7EIatKqzhDk9B2JjYTbznm8/HZWWTJs3tplMmLoA7+2CHQPL
         EDuA==
X-Forwarded-Encrypted: i=1; AJvYcCVDrn3HTdBYry6DV9CMxf2MqBawxkQQ8DU2MXlT86gpktyOsJfMG2R+OVBhFZaH07oeN+P3Vgs3HH/oBbXzDkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/ncu3zp14kCg7JQHUKbA1HqdK2lhLas4/PTwHBODyeFvvY6w
	pP5WNeBCyzGnFPrpUVZSEGqOsUjGLtAVMWyv8ErqcC8W/Roe3TImL1FCeTzZz1O9oMw=
X-Gm-Gg: AY/fxX6d+kbla5ruT+2Ay2EQEojlonUbwOFZugxvhj/+DAJPCZRGnMIDquILv7Otb7k
	TFuork7uqwaifnjanfasSDsULPAryRQj364qVsyY1QC7kEGQ6z5xOkjXWJ7deRlpa/XlENMceW/
	JfzJJMh/OM0+BFzrpk5q2td+t/jej1Io7mpOS9l9IgtgevAkS2W3a8ZThV9o8q+AXFKCtsN1wxx
	qDhdilETAmOQzxAzZZ9BrQDeYsJ4GjdQuaVepeLu6fwdFn0AsTs95MEBGdD9lURubteXxy//J1H
	68abQfgdLv7uxRESL8XRTJ15hgnMfbiNE/FFSgIL1sqQIU2I79h2D7yri2UicEcI0OEP8wIKThq
	a1NdHUFbCoxFR8D45dObWW6hdaRgBNXvAI6Edvw7EK+hbmSTtZxZpiHbmK8Y6leSfNFtWGsLOYo
	D+VNDXcc46AyU8gA==
X-Received: by 2002:a05:600c:1c20:b0:47e:e712:aa88 with SMTP id 5b1f17b1804b1-47ee712ac96mr42613125e9.31.1768479186231;
        Thu, 15 Jan 2026 04:13:06 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801bc3e57fsm22590935e9.5.2026.01.15.04.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:13:05 -0800 (PST)
Date: Thu, 15 Jan 2026 13:13:02 +0100
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
Subject: Re: [PATCH 11/19] powerpc: kernel: udbg: Migrate to
 register_console_force helper
Message-ID: <aWjZzuY31bg95jiy@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-11-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-11-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:18, Marcos Paulo de Souza wrote:
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
