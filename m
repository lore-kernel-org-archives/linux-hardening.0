Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E12F6924
	for <linux-hardening@vger.kernel.org>; Thu, 20 Nov 2025 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645350; cv=none; b=cQo1STP4/fiStkDAyrs35+G0tKKtHk24xZjPrHedxAB/4ztdhL+zuF7ZsOwpoRcdLFwQfuCC1uYRIj/fhKxOsfFatgD3P8opRx3qbPiZKDNTxmOyIVMP3avy1zIH5KoZlyWHzUsxvhcImM/HXzg0WtJTICumrt4SBT0E4BszCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645350; c=relaxed/simple;
	bh=SN7uq0k34glIRrAKT2+U3VbGa7fDeHa20jG2LCCXgF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=leOHC62U06ZEwW9TUeDZDcEK88/txaETcicUxvKSEbuf/NNpumc8QRvQzLzIXOXsDizOB4nYCndfUjLYJMGAtI2dfwl0kPYWJaFLdEMecO4EN91e0qjMzXen8sJielvI8Vf5S0cqxS2fRB+5BUQYU/r43CIBU3P3p2JQwDE7/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jxeK9uys; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jxeK9uys"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so5415615e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 20 Nov 2025 05:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763645346; x=1764250146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfxBIlU8bdjwS+AFQgoVox7qmz6MOKxlX/ZrAJzGib8=;
        b=jxeK9uysLQBRlnFAd3VzoxzNUtzBDmcL0ttuQqTG+142jYz4Em3DJFz8HdTFaX1ZmY
         6k02lDjDWMXW8pAuoUuDoyCy3zM9XCpeFfLpHYFNnAoqPSZqPBdr/WnWvKQu4vKWxiKS
         MoIkijujgWctcZOFDn/BG8p9IFj7/ks/t2UtBDTnA48RduoiDlXcJbWBm+WEJLimiEwK
         ayM54lov7hE0OJ1TC2YJ1aLehMBUW/yXKA+ad4Lqq0tmj4cEyWH8Pi2A/fHvxK7si+Or
         UbuJtd4W64KjF5xwLINFS9ZSetQoLmHPPSgTs9fZcQXu/wzo4111DVgrOfHTbTdHmoOf
         5OQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763645346; x=1764250146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EfxBIlU8bdjwS+AFQgoVox7qmz6MOKxlX/ZrAJzGib8=;
        b=wQT1tgViOV8wsV3xXv8oZZMtBhjP96QWP6T9/alhboCqGOBN8xCvV8RKWPRFwZfm0W
         crPrgL5Cyc80yKFhht00RX06vTETRYkKIG2mSnBBxzBsXoVKwwa69AADukKP+trNl2O2
         zhV0PnwLK11hYk8Hrp5sFArx8IzA7gYh7O1VhH1ko2/z686YfpKRcMLVAjwSruOIsLfB
         RqLJuoUbiWYIOSPN26aEN+pjKIeyY0KDYCK843ssw1ivivoJnM3EHBH7QY2dwdxNW+6r
         QJhj4668jRHBQnOG1t4bNw2Ad67S35mNMnF+XzSq5ywrah9oClVP9kAhzMA6+iXVqdT8
         W3gg==
X-Forwarded-Encrypted: i=1; AJvYcCUOopK2Qy4h4t+yKPpsUZt95e3mkAwZMB6N0fIz4bQNmjpXqAjO8W8cUJpOV49PXmRWJl5qLh5zNdjl18Ey6K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXKYOYE2NFfEvOLCFvIDVIZ2VLn0Qpp4oxzT3Q+7E5aUh8AECX
	HOWrujWSy/yUywcIW7gW0bzJ9LxhDC1Ho0mcw17HiaP6Q2WSLWJQT1ekR8PNS7Rk1XM=
X-Gm-Gg: ASbGncv+m+0DErELUkYFV1TnAWCBn4SMWbyNrLZzy10R+eAsF9BKbtpBwyKsr0z2YiA
	pHxMltyUtFEhy3WaAy/oG977qwZf0qfAFiawql8ulHc/qOq0ck7YHRrHZOi9TP8ezP1bdmNczK+
	ST5oA4DuKOY7OCiy7pihEAW8qxccHT0VWnHq1GWEJBOIycEIXUzbkyliXodpfcuVRP148bnWa0D
	lB7ZD/k7sEkTSAEJw340eQ2FoSLYBvWxE2OjUUGePa6GM5r5KVnTxr5J5XevDeCB/NrUxV2XpWc
	JSlc9jiD145XfOWdOiI2zNeZUb9LPDrgB9Vwa4YOosjb4fMNE36zPFBwP1qRAS2IWUN1QhFYtiN
	pPBL5fRXxDBbz7gZse2iPbl8KKGtAH/yNqvsHo07sduKm04OaaTqqipmfELrN44QI+N+iA5fILL
	rOw0tt5X0mbhkG+JE=
X-Google-Smtp-Source: AGHT+IEZ4dJp89sRfUEbMEqx7SlPWA1KyD2vLcQzdk+DJs3uQ5K4nAW6e8v8RUcTQAioTqgzbfmi+A==
X-Received: by 2002:a05:600c:4ec6:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-477babc1fcfmr22679845e9.7.1763645346170;
        Thu, 20 Nov 2025 05:29:06 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:37af:6c1f:28a:47d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b102bc9csm108574055e9.8.2025.11.20.05.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:29:04 -0800 (PST)
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
Date: Thu, 20 Nov 2025 14:29:03 +0100
Message-ID: <176364532053.31751.7963392559783583346.b4-ty@linaro.org>
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

Queuing this one to fix a warning in next. The other one can wait
for reviews.

[1/2] string: fix kerneldoc formatting in strends()
      https://git.kernel.org/brgl/linux/c/6f87b41303d3c4280a57b4f7360022a0951b43dd

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
