Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646C396D34
	for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480184; cv=none; b=qR6Qblq9CLINNI99bFuGQsNpf7K0HlDAZWkHu4mA09pmT2kT1eroI4PsR9m47P0VDV6eeUx5mqUzN3rSPA4+uslQBKmw9HmfV5ylLuS6aMCCxVFw+tD6cm1lWS5hEbN+Eta96MTcBjqvoEo2sYSlchqUJ3JCKgI0SSAKMXr5tq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480184; c=relaxed/simple;
	bh=vYsdvT7Esg+O4+yVXNphLK0YKxhLuEHhcRTW8Mb/9K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=docbcg4ta2Qa9/231+L5kLLqHd51v43aSfmfpiE9ZXqCRvgpvTjiIUW1xmc2we8o6eC85ACmWveKZYr7PvKOrE1l2dRZs/jsMDvarianfQBQpGy14qsRMAcLnW2dA2YLjxu20bHoVZaFC0W2CKbH66PNG3YC0YBEydXjnLUO9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YWoqPUwR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YWoqPUwR"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4801bbbdb4aso2459265e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 04:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768480181; x=1769084981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld+As4KXLNBvjLuNePKBkF4h3CZ3gGNkmAsVzP6KebE=;
        b=YWoqPUwRhFjDNetwPJSdKBHF/sh7S1EgP7tlt+wR//RGEkO9N4XmFTkKsELsXCN+Wh
         tAaa3ENOSjTUpPILgZg/y++6goGL+uSgamekIXw8LmEugXqkm+977/byxDPFL1eoqlch
         cGOXGBs3zphBNNZNyLq/ZN0EehjhFZAUYOQqw+DHgPeteIljG+U4TPt1rzkLOeMvmZ27
         1O7Yw5joixwU3lRrqJFdpDK0eX4HermI+x+n3JLmTrJSvtJqL+AZ+HvmrKi9QhTt/+v6
         TP50tRwd+Z2mmYQDTI3Bo6Q51iA8Biw9ePX1ylXoopdCQ6oTxMlph+beE7QlfFLDppB4
         0k0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768480181; x=1769084981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ld+As4KXLNBvjLuNePKBkF4h3CZ3gGNkmAsVzP6KebE=;
        b=bnGyq21mEuOmzeoJOdeG15b5FOUqoDsntkJDOydQW1ZkxkBXhWMUJ22N0cD0vtYUpY
         Vkl904s+7F3ZzwA7Ztnk/5bhT3/4bqJh7pGMklGHPg4YLluM2fLZmrazH60cwpqNO6he
         nKH5T5t0PDRMrKpQNdDwaSTgV3U7iPoqIcCPj9Hl+1CLxJx7M5YQribmfL/5VfYxyPbm
         N+lr3ef51qj1JOeI2f1ialtDVXlHiHiijOJZBOqb9LmKZoRuuf57DaEtbn/WNa1p3uxy
         v5nm2gaqbs9/mMSRtG6PwWzd4aMroDI731hW+fTl3ulkyyerfcF3vLAqcl0wSGkOMnAg
         VobQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7CpYFUlX634+I7MBvewlRrnZIv3WPiFUrinQmtYkwuT34AIB8bPaEZnSr+I128SRcD4nCbU/pHo062QNLst8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuvZHGVig0aUqOHliY+ozrVhLckzJ/TWbWwNZZEbLpf4kACMf4
	8dooFEMsHW2xxVHx6tIRvFOZuCV5xQVInmBizp30YI+Ig+8QvtAHID3k4JS8RhdLUX8=
X-Gm-Gg: AY/fxX4208VB4vya54iHw8qi2R15F7TrjGjuHXPwDY3GauEDXInfsSZZF+SyQIPznO8
	qOq2z/tS5cnRu5n2GLNIwlOSBiuHLviTBuVmlVN5IHc9yGEXD4VsO0QDjsLnVHl/Y3DdZ0Hze07
	dJo4yd+0KG+RSOWNYkymkssEQWT8HutSGG6gHnR0Dl9i+sYU5Ndy2RPiRYEuwiEsAT2fTvBEbgF
	Ln4etcxnOmJucwi+PUmg+HRqQOT7mXRavt41lLrLz2iGVcTvpPOs71pw1XJ8szaHuilcu0JadhY
	WQvSP/Kt9I6TccQWbDb3D2lr3Nzt7bc2kyjI6N64Nc99hNCk7DAxqj83kbZT3WEVPEczwe0108L
	Wo6vlU1lKaHBHlNetjNPui5m6F1r9wAgTWpWW9ipBbTRKc3z35TLMh3f9A146jEfr76OO+nfNy4
	Fehysq14Aybz9pRQ==
X-Received: by 2002:a05:6000:420a:b0:42f:f627:3a88 with SMTP id ffacd0b85a97d-434ce7324b4mr3823468f8f.4.1768480180633;
        Thu, 15 Jan 2026 04:29:40 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653576sm5965022f8f.17.2026.01.15.04.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:29:40 -0800 (PST)
Date: Thu, 15 Jan 2026 13:29:37 +0100
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
Subject: Re: [PATCH 14/19] drivers: hwtracing: stm: console.c: Migrate to
 register_console_force helper
Message-ID: <aWjdsbYev_5zfKEC@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:21, Marcos Paulo de Souza wrote:
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
