Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B627781B
	for <linux-hardening@vger.kernel.org>; Tue,  1 Jul 2025 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383474; cv=none; b=BgxbHWHVWIJO6z95OOuh9546VwrrgFQQhWSxgvJqzATR5HqhQL6GpEv7VKWylWOfGrcnEHFXpd8Scey2586YZ7ZmbJV6gfHM/rpRkzpN3gagMFhO4a5tuC7XIp/1Am38ouQ2AP85dKP/rKGfnoefyZUtW9WsdyZjcmE78dxzYk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383474; c=relaxed/simple;
	bh=gzy0HYW1aiyamvIuwFD3xssIx7Of7faKEIvouPwowlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noYbXpdn5kIENSUYc9NXq4Qb3vtW4EUKymD63Gt5//VjUFh+ftFyu3YVOZo8tQ9W2aPDa988HStx3K9u2cq55rx3kzERPjw1cL6REHwQdA0iBoJNiBD1YVvOLT/eyny1hfrguFKHMh98Vmfz7bbogicnEw+6G5vqtxSMGSp1Eo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G4dzMgaG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G4dzMgaG"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a5123c1533so1957953f8f.2
        for <linux-hardening@vger.kernel.org>; Tue, 01 Jul 2025 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751383471; x=1751988271; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TWTUS4XDaGfHhbLK/yKE5holBOESHiUAlAPrvZOBErY=;
        b=G4dzMgaGk4piVorXG+wr3/IA0UAi7rIqRfmN3WJ4Xk1jJS7Bthw50C7nT5sSR4WxmW
         dRyGY3aqh1+yUVK+ETYEZxODBsGqXN50HPo3hh433DkE6qMhyEjBEL1aBBHlH7X4SeVi
         d0BgXpP/pDw0CwekZeju+iVpItG2h44Q3ZzlJ91oOrg4SRS94/5rRDTtc8Ppxaxi2XYA
         vdgQag/2fSK1/dR6ueSQw1scOV+weqTb3bx90Z+cp3ff5+OTvpjEu9IMZz/NjrpPCia1
         HFLGwm+p2h0wO+0BNPEs9h2D2erYTAhqvZ+pnmNUZhusUmB78pjPBKvOq0QeEgXRYIRr
         zmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751383471; x=1751988271;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWTUS4XDaGfHhbLK/yKE5holBOESHiUAlAPrvZOBErY=;
        b=YIXsv5mMmQ2+2gHNGPmm2XM9TNlLOC2TTNtd+FZEu9DXrrI9Q5cTtTuL8hyQvUHNBz
         T7BpqUZCZ4WZPGqMZiftaKhS5Murer1bv39Xk+4a8HkFZjhTt9P8+wbtQ3K44VaT5xvc
         kesuEwXvNhkDgpkHgUwP7b7KdI1kQEpyE3MpC2ooGxW16Y65clPW82/Mmw1KEd1Xxoch
         4bsToOn1kPd+EZRVUvW3UcpIyy/l3ZJZuIYpvkQm+pLrZh2Rtyqew5e5sdlU/+Usz60n
         L3SPk4TQTFF+9DjD5bAUjA222v24oOEJCMzGuPOZPoDix7++uwALDhRI3r+6gDprKU3k
         dQgw==
X-Forwarded-Encrypted: i=1; AJvYcCXHbskJWMnAm8Cqyxxcsxuey0b36SdrkajwBkHavBxKltxHdtFFV5ATTeE6ytIzaUx+2a9GNFiAcL720aOXjBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGx7hxJs+/Vm5NX5RLEM7WWDbyXMQa4RrbUloy3k15MQ93ECz9
	ES/PsHFz07ueEd9171KCpL8F+XivSAfnNu4IVXhF5uAaum2BsPMNwuag+71My7bl0QOUqFCxIxB
	UbWRy
X-Gm-Gg: ASbGncuRMBmFQJdtNZOlq2jUUV7p2RPQ67f6LLO664jkVsLobO/IZfmhRlxWmru3G9j
	yYLyocA8ZkL2X5VpfXLAPO4my3AUzYl58UA/OJ3oQ9clF3XFxrDYRsufBHxDJmtfM1A1oGmv0Vt
	1UvhBgE9mXcUsp2sB8HuMdbHQQT+BwYQ7xlFQJI73h6Fd6auIBdp/njTadWCeixpuB3DppSELOO
	9FSng6oy2xf+ujau+EJ27twxkjAx9Oojt/smBwPVNlxrraH9/S+FTd8QMkL6zoEJvlKnTGLQGls
	EHVzXTkSsYMxShhHNFQ44bYrt/6CqqAuu7cTKU1XcvTA+/bUcCKT+N2mQbaK5Fma
X-Google-Smtp-Source: AGHT+IF8wfGH2gABidn97K6pcyx6hogp9QScuA+QUd2PL6iDQ+isNSIi1grDYA07z8SPbV8FgoUiJw==
X-Received: by 2002:a05:6000:25e2:b0:3a5:88e9:a54f with SMTP id ffacd0b85a97d-3a8f435ed20mr13353032f8f.1.1751383471106;
        Tue, 01 Jul 2025 08:24:31 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f542661asm16082565a91.26.2025.07.01.08.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:24:30 -0700 (PDT)
Date: Tue, 1 Jul 2025 17:24:18 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Ogness <jogness@linutronix.de>,
	David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] printk: ringbuffer: Add KUnit test
Message-ID: <aGP9ouAP5UFQQn0z@pathway.suse.cz>
References: <20250620-printk-ringbuffer-test-v4-1-8df873f1f3e0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250620-printk-ringbuffer-test-v4-1-8df873f1f3e0@linutronix.de>

On Fri 2025-06-20 12:26:09, Thomas Weiﬂschuh wrote:
> The KUnit test validates the correct operation of the ringbuffer.
> A separate dedicated ringbuffer is used so that the global printk
> ringbuffer is not touched.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
> ---
> Changes in v4:
> - Add comment about possible prb_reserve() failures
> - Pick up tags from Petr
> - Link to v3: https://lore.kernel.org/r/20250612-printk-ringbuffer-test-v3-1-550c088ee368@linutronix.de

I have already pushed v3. And I would prefer to avoid a rebase.
I am going to send a patch which will add the comment.

Best  Regards,
Petr
