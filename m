Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304641;
	b=RHr3OAuR6DMWSjD4kJQG4gBfRCj/3ANa4MC0jrcTJ4wPddUTrs1lbpJAUBu/JP9pIP85
	 tCza5V9wf86/rAUB07wj0p+hfFjM8qpcE6V7A0KH9rbLAewvXhEfc+tTQtRTifCe7vZHF
	 NOsuEKdLhbix6pizF+x8vVHPeKY3I5OQJiSnqzo36O1rR6gvBJ5nE1FrGIq6Px8aFObuV
	 Ta+Q1IUlksyaN+Y4mDoP0vo+/QxlUV1e99ZYYqrFCThUnCqcea+wsY8isSaaIg6c6iHeC
	 HS7tuVjy+U+Uwr6iop2iN3MU+UPnTIRXbyL/muQ0We0mbW7KqiH+l41kTVPVqufmcDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tTHR38mY11B/5icwsExskzuyoZfY2wPwkj1B1V6Dev0=;
	b=0aeal36Qzr/SduB1j0SqLTjWX8HJzZa850eHNQUoUIOd/hOM48sl+l7qrs8f8bhiqdP1
	 9uU1SNh0dJu0mxZv24Vyz/L4nNbSbISThwbmN1AElJaGaRl2e3950/l41hpE7qnxymXCt
	 drfa0R1weOBbQNvDol4b2vn4ldjJTcvuNWRz79qY92whpd9XT85pTQVHIo8o3+nqx1To1
	 dVMmZV/bPRrf6apPJPaMph+i7hxpKKSmJ9RExfd+gJJreWcD+xFQV6ynCUWONG4q44zxY
	 SbFh3tg2TT9qjyMDGvSTRNEWfFhFYdeHwSVsZCo8ub32v48EjMeHODnBxuuNzAQQw3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vFgJWNQR;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CDC606A901
	for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 09:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94CDC606A901
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vFgJWNQR
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e3b22e971so948539f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 01:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794304640; x=1794909440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tTHR38mY11B/5icwsExskzuyoZfY2wPwkj1B1V6Dev0=;
        b=vFgJWNQRpY00BTiiT2wohK496Dl7MoSkYIsP3zKGk4yjycuur59e6oLavf43ykes8u
         ToLxr0/upin1AoCisw5nZTRQ1xutanrTyJyY2sBbJvYCaBmf46He36lIDdz5sE8xmWxp
         Mi8KqptNWHLf82kxBk/xG75ofy8BvA+ZjjxUrpV4DGSPMKTyjVtJv6UI8ASO2Jag54Ok
         HEmjUIG25liwvNWd1/zC3wDgK5ViE2myFVFvkvHKg12U0wa+I2aCaQQboH1V8sXhlOUP
         eyVNvn8lqgsTM/4xmk+Alx3Xbhp3FdkDMaU9kixCSSCwLuGqyJ/wYcEFRNEo3i+tqvZb
         iEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794304640; x=1794909440;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tTHR38mY11B/5icwsExskzuyoZfY2wPwkj1B1V6Dev0=;
        b=OwiM9MLfNMBV2j+iXm5s8rMQr8zUePjQEmdbga+MPEstSqzsa5+yqr4HHXoi9j564d
         gw6m4dD1lBdEnhsfiYEN6Nt1rLNTnLEW2mI4FkHwTvmauoOkCDAwv3QmbRqhsFb5SKDm
         LtO9RccKCtSi5qoKU6YDXDiXM9JELfubpvFadeG2KORgL5kP3OnJLq8xn5wfVysysjCD
         2IoqUhRrNq3+yKUDhCeY5qsVbPM5MwOOkuXVzhuk2LPMu2YAudsH0Lw4faoVh1LMlnwT
         /VtsMxHGU9MnjLYfN0HFmgVJ4b8DzxqtIv2Kci5XHn+uTKuv3uGXwDBkKLateS4zoVfC
         tFww==
X-Forwarded-Encrypted: i=1; AL+hErFOzOoRQERmr2QEQ1EAlwtJlVyqYnIiVeVgNB9L0sdK4y+4ckjmzJwxX0gTVnc0QfUSkP2rwepUY5keDqNqXG4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nOrJHvrWKF3CYv0lkqZkFJq5I9FbaIXIN0cX5GCJuGOmk6j9P
	KuAn4f24im61DuaO0r2ECNePHqS2F9zwV6WBR8mOu+AsKK4lhNbwjk3U
X-Gm-Gg: AYBFou3PyNUghkSaTL/NeW2hArFzFUqoEF3/nCkTQDhy5Xf2dhYB/W1rPHDCzhFPxU+
	djb3ZEsk5gdhYWVL4JKK7E/NqTFGC06SS6r+lUFKZyGwwmK7ySgfplHeE/Sdu2qtSHYHDzD8nLA
	kxORmf/GzWPp3IMPg2qyfdRxyKPW8LlQDlzzEJqNsMFpitPERtZLTcOVEY1WKyPUrOoZ/s4baLR
	WMV2c77zAx1Vmlpun4wx7/K2bbJ86DSr2HzxvPiSeKFdzooJW32s4WDf8UBwNrAB/6KfdEbibpc
	V9MU3Qnwo9AkkAyRnuBioNwcPAsRrtkAl/gDnxbXmo+zlI6pDw6fBmjqG6FvR15NIfeZOOkHJlk
	3XR3HCUK9HbFTxV62lUJu7UoZPq2Ilv7GtvSMqIZKqoxGf55CBo/JEm9UyugKaegGQU/0Sm2A6D
	k2iUWGjqQxuo4mzcn0sph/uRfU2YA0kxjk7HIWEtSINymwvLoMf8++e6ODMFCFCBwop52j4C2sp
	harZMda7bIXASc5UGpWFXaOBTFDH5/iYWS6KKYH0zpUbXGW8rv58e+dZYXrYQTC9LERE9CKiGS0
	MkFVT+FPnkIxVr0qEx53cw7SOALrRSh9LJ3Fzvkz0zIA1waSlV+DJKwsujPmjg==
X-Received: by 2002:a05:6000:4b06:b0:495:5c83:51bc with SMTP id ffacd0b85a97d-4982d13022fmr3778167f8f.5.1794304639745;
        Tue, 10 Nov 2026 01:57:19 -0800 (PST)
Received: from localhost (ip-94-113-240-150.net.vodafone.cz. [94.113.240.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bc9asm3841475f8f.29.2026.11.10.01.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:57:19 -0800 (PST)
Date: Tue, 10 Nov 2026 10:57:18 +0100
From: Jan Remes <ciakval@gmail.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core: reset rtd->num_components after
 allocation
Message-ID: <avLqfsCe0eXV1hFe@mm-ntb-00805>
Mail-Followup-To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20261109102536.357134-1-ghidoliemanuele@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109102536.357134-1-ghidoliemanuele@gmail.com>

On Mon, 09 Nov 2026 11:25:20 +0100, Emanuele Ghidoli wrote:
> Reset num_components after the allocation.

The same regression hits Intel SOF/HDA: on a ThinkPad E16 Gen3 (Arrow
Lake, Core Ultra 7 255H, Conexant SN6140) no internal card is registered
on v7.4-rc2, with

  skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: Failed to add route ...
  Analog Playback and Capture: fail to add hda routes, ret -19

This also looks like the regression reported for Meteor Lake here:
https://lore.kernel.org/all/mAZY9HZuXAXUf7zv8tqXquMtquf7iW2CIZB7WhU-SnwWp-Rpr0e8yixTsb3lAeQsO64PwwWlOao8aMjQ4hTKOQ6grCiNmaWZmFRXMdPICD8=@proton.me/

With this patch on top of v7.4-rc2 the card is registered again: the
topology loads, and speaker, mics and HDMI outputs are back, with no
warnings in the log.

Tested-by: Jan Remes <ciakval@gmail.com>

Best regards,
  Jan
