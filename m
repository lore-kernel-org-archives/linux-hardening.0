Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2901F2EDD5D
	for <linux-hardening@vger.kernel.org>; Tue, 25 Nov 2025 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066148; cv=none; b=FPABGwfV4x+IkI1C6lOZE/YmJj+ZWMehJX5h0DMdiEm+v6LE3vr/scDRUA74h7YV8xEB65szVp80EiQW+iYTXAhv89PWnsycvohlTtH1Ob1bcAiBEVKkM3J64iKFQpovNSpJ7DzDFslc+idKmZVRX3IuoxLxxyLqKsvZg5qJlRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066148; c=relaxed/simple;
	bh=WYwD1I+xdfArAC5RdudCuameleZN2fv2oJ0FCmMHm5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8AFaU1x+DPseJ0uj5TcPL2DiYjNqVL21n29vTCxPOlcFqNeeWkFiZpayz7ORyccBr4mrgPxfoG3mHbWJ+CzY67vUgOdIstw1zEIO0aurHgHDfMP3BqFCUKtlN3uuK6T2Md8pr74KWNLzOBe2hslO7w57lti0nezaqMLWBQc1fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qqyGD4Sa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qqyGD4Sa"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477632b0621so35682235e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 25 Nov 2025 02:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764066145; x=1764670945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eK8fZZDlsk0SRxfPZjyV+e1oHPKCOfUrPi2S56soEqU=;
        b=qqyGD4Sa2xa251p6Yz5C8m6VYeoqv5tF6HwyvtPtiuGO2vvP1fYYpJ86doVRt4PmAF
         8YGi5p5CBQrZrspb96XV61zGAxzQyL1Q5hsE6zaeTqPDG0uX0f4KxPJtsfOMsBl8FD+k
         yPb8mmjuBLEZ7ww4nMVG0a8TwDn3/3xQ4joqUcQ1zxW/YPQaVt1grVJTiofBSmqiUNr+
         TZCEinverTUJd8smxQRhb0P/EtxvYYmQ0uGAFBhIncfFmgDqmb+aw5Z10PG0OnT9CgSv
         pOs7jxb3MiyMaPb4WOBm6z09lz3FYxnV4q9lixiJtmZw0P0SXnKfvAjJ617oLZmUJ4QW
         osUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764066145; x=1764670945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eK8fZZDlsk0SRxfPZjyV+e1oHPKCOfUrPi2S56soEqU=;
        b=Dfh8sB4Ae692MEQ4K1QXru5Aek9GyQCAG6o7zkwT4tH+30dx4WVH5eM+XGcweAqrgU
         Wo/lUf79iFtcQpbQlVtsq/KqQYgPjbiP6MTFP+vuGzBWLCpfN/k6U/kfSy40RteTQd1D
         7TEjlw0G7jZrkTkeA0YuIX4kd5no3bcLki+PsvP+7v3veJzD9zfm+ljZjRaugdIk0Zwt
         +4sgSE1cdFIcGvXOHpdnI9DHP0rxHTOHu3WHSDlYabuBEv+FXRcsM1DKtvVca5UDqUC/
         WsKti/ex594t6uVgerdBcsx+94XP7srSYwMr05Kb0M6du8dOHfPuNxWI/Bs+f/1x7XCS
         B5bw==
X-Forwarded-Encrypted: i=1; AJvYcCXdBVE4jQsF3P3WCP5mfMpYyQ2H2dN8l8lOhy3/iKdPvOshbBN8a/8KtJo55ydf/LsPHp7WJxowcyyQ08Uceuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKPRFZEEF5EQr4WqMHz4g5PHNOTyvf8GgfWFGOBMIB+m4RJneF
	0DDEw0+6zkQbIkxw7C4kArI7dMSaugygigLKBrybVW63fuAFl4fhW3TrkgEaKnSEoNOoq1qtIHk
	tAdDuD/k=
X-Gm-Gg: ASbGncsmgV+ci4zkY6Bw1vVkKcfxU5QIrZuIqlKX+P3Ph37ZLOAcEfwrENatCfpYQJE
	7ROXpBD7gkzvCgVd6c48bWnRTWamztJXw1N/vuIG7Y9c4krtoSV9r5HIAwGpD1TT5stHvcNRSjZ
	QopOvIbVspuewJcYln4ekwMgiXMTTW7zrQ2WSIHPxvATKCfLTKoElAYkAahZgGusD7JXc4AD2Kh
	jMMfbHz0yAHsSsiJGB3utK1cpUYdlBWx+96ycdJnhnMaf/VAWxpEAuoTtyVj8CPMizjfzXQQza8
	1qwVI/oL6Rrt7Xpu35IM97qml3i4CWynIAxQG++ttNoB+UWcxweODtwnLJ+Fk067xtwenWg+TPx
	3/EFU0vanVdJ/on6Zg1/gDqoNVAGz9XMGiDmldj2ugTYQ64SRVFnqcnkdEatJMHQWq3OVpJA4e/
	2XiJNW
X-Google-Smtp-Source: AGHT+IHLfoiu0OhtOW4/WY9wle4h0TP4NKoRJzWPr32TM6uKFiPrEgDnqayuhMmT1+GeeLBi/xo0ow==
X-Received: by 2002:a05:600c:3ba4:b0:477:95a0:fe95 with SMTP id 5b1f17b1804b1-477c1123ae7mr216931285e9.24.1764066145393;
        Tue, 25 Nov 2025 02:22:25 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:df0c:79ae:5345:c3b0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1e868bsm235981445e9.4.2025.11.25.02.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:22:24 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: (subset) [PATCH 0/2] string: strends() follow-ups
Date: Tue, 25 Nov 2025 11:22:23 +0100
Message-ID: <176406614175.18009.7949064811846661509.b4-ty@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118-strends-follow-up-v1-0-d3f8ef750f59@linaro.org>
References: <20251118-strends-follow-up-v1-0-d3f8ef750f59@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 18 Nov 2025 11:04:02 +0100, Bartosz Golaszewski wrote:
> A couple follow-up changes to the new strends() string helper. This
> needs to go through the GPIO tree as this is where the strends()
> currently is.
> 
> 

Applied, thanks!

[2/2] string: use __attribute__((nonnull())) in strends()
      https://git.kernel.org/brgl/linux/c/194832dcb13b0d02fce0df887235b7e6d1ef0121

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
