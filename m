Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24895217F25
	for <linux-hardening@vger.kernel.org>; Thu,  5 Dec 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400650; cv=none; b=kULgcscytvH8EvLC4AxdTyqhOtiMQQ4cJGlKEl6G/HguMXv0Ohgsm2CF3hKXf1N4sspVj7+ijw4tSZ5PwyorFygFmSIq0ZCtshK7AlBU+k2Kzto6UeJJOeqs1jBkpnp2A2lgLfRMjvXrgvHlxxzzXqp50TL6+dAgXgU03NnEx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400650; c=relaxed/simple;
	bh=2EZLrM0ZLYYdbPxLmXbwElTcSDaUUFW0yoyYRrkj0Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOBKn1/evq8vJ1d0KGu5rXlQ6eAerK3nZ032NNlHmtaxRoY/MJL3Ut5ygiUmkNVWxinIc+MvP6pTP7GGfgAhjRQySVJcRyhg1a5703wwsfcJw4jUYJvgTUDbmqQs8Htv+3ZBhqDBn+tSuUPkRQBI/kQRoJuqpPN/T5HCvDDu9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OPtka1xb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OPtka1xb"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so8941255e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 05 Dec 2024 04:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733400647; x=1734005447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qt/CPBcS57R6kXLbkiRsszi+u13mNakGJLbglDYv4Qs=;
        b=OPtka1xbNSnLHImw/SXzmr+vThp69HlpLao6h8MAYbHaOsNc6dq0iCM+OMrR138uow
         HzqgCk8UDWKG/7KMWHtKMRJ1S8HiPD6x6uoC1Rmvy/PUrHCVRs0fINP0P0XPL4T0X9zq
         sDqPl2wN8D8rbTjt2txODLTHVW+k4IH6LjpBzCO3LdAdLdqYYCV5JW7AQ1knwZlG5WOu
         dBn+vF4/HHQHrAv05x1saKN9LvoMx2qAxI+wpacl/cqBstKNwf1+1vociSfl4oynozH6
         vD65XvWtgXMjVyR48tMMWawjtM5vsYkjZp3g+3hcrRgYwJZwHYGb5g0n/vYIavyAWYRQ
         8wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733400647; x=1734005447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qt/CPBcS57R6kXLbkiRsszi+u13mNakGJLbglDYv4Qs=;
        b=rmLnjw53pic/8dEp4pNQyt8uJUYVUt1KGnomI9QTCnoHdK1GSuXY93IParKtbb+vCX
         8u7bAa9t/UJkMVAMkGQlpuZCmNX/XepJa99PyXyFy8+KBEaRLh+Vp6ex4kJfzEBIDUi+
         teBICleaVkO8wsxGdI3jITWX6bnljcec9SWL5a0BNw3PJXExSWUDWN8Vv/JzxNFEIVa1
         yizARtw4mia++lI9YHS4A5rpUFFz7GkyRvwBq4BgFVKvWrixuQ+2PJneWiCO3SjZlKVw
         hzcJS92MEYq2YNpQX07kFVps6sTQpmqDZyxTX2edhscZgiFkWijV1earE7rpfYJQg7hy
         NABw==
X-Forwarded-Encrypted: i=1; AJvYcCXmpWMnKeeWLIZZa5vhRIu8nPKHw+UwBoPzmBF7+Da6GyvsFF11KkjO8ZKKWZW51xc71vqnGlB31Puh+z1ISmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMVWeteBQyQgcVKnDZlfVurXiDaCBaK5zE7eurkmyxmcugspwt
	SXbCxHNYsPo0yJX7ULb9TP58hknwLVREvFo4z3qug5uIOIkQFNcy5DIIkDn202A=
X-Gm-Gg: ASbGncu9Drc2TbMBbrM8nPB99pZ3lAYn2H1fSPMQtct0xWvDpH34F+rBGpw+OSBFRNI
	5z2BytmgB56kwkfUtX7baxj/g6ACl1iwFAmMF3q/I/Y8/dzAwkQ8ERu+lyMxS2IqFA6+K0NILvD
	ZRdgdr9nsl4cb81alDAtibfb+Dw18nNHeB92rITgtw4mTVFAB4fhx1xTFjmm1tF/HuuACzJh8GB
	ikUlFAC62vS74cRQKQfyZij9xlLCA+a+G8LOsqAfYDbLTek
X-Google-Smtp-Source: AGHT+IFfZ50+YagInJgFWXUcpmHfKY6JBPuy+JFDnVOzAD63Uh2CX35OZkA94Lrmw5g1ER5Pu8VJOQ==
X-Received: by 2002:a05:600c:3c9b:b0:434:a706:c0f0 with SMTP id 5b1f17b1804b1-434d09b5fbdmr91829905e9.14.1733400647235;
        Thu, 05 Dec 2024 04:10:47 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:c2c8:33f:e860])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0980ddsm22089655e9.0.2024.12.05.04.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:10:46 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Wentong Wu <wentong.wu@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Haoyu Li <lihaoyu499@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] drivers: gpio: gpio-ljca: Initialize num before accessing item in ljca_gpio_config
Date: Thu,  5 Dec 2024 13:10:45 +0100
Message-ID: <173340064220.41307.8479220444337077350.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203141451.342316-1-lihaoyu499@gmail.com>
References: <20241203141451.342316-1-lihaoyu499@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 03 Dec 2024 22:14:51 +0800, Haoyu Li wrote:
> With the new __counted_by annocation in ljca_gpio_packet, the "num"
> struct member must be set before accessing the "item" array. Failing to
> do so will trigger a runtime warning when enabling CONFIG_UBSAN_BOUNDS
> and CONFIG_FORTIFY_SOURCE.
> 
> Fixes: 1034cc423f1b ("gpio: update Intel LJCA USB GPIO driver")
> 
> [...]

Applied, thanks!

[1/1] drivers: gpio: gpio-ljca: Initialize num before accessing item in ljca_gpio_config
      commit: 963deccd17d4e538a8bafb1617803746efe910ef

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
