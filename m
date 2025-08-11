Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9919518A6DF
	for <linux-hardening@vger.kernel.org>; Mon, 11 Aug 2025 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920093; cv=none; b=Hmx5v2yeKYmfcoJbWPuEDd46MY8GSY5K3kEE2+nlEoijR0Yqch2kDvceCg4FEkPBtZST4t4xEb7uJEGFFD5GaH2XlvnHW4sqyuG+ghh3osDM60uarrGeWrz1WbqOlhSveCO/5uy/FbgxrAlf1k1pltLllDAGPea6o6triYpmHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920093; c=relaxed/simple;
	bh=bVX0v89UAUdnlBPHEZSVVlNvOwpGXSx6cfiZ8LKvlF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5jf7sFRMuC9pG4p+ehmJWh3ruP1smcg8sncfCHeDuzWNDh6840suyGveqAlJQoYAFET4sVjcEmjQl55SAv0thk5ZAyrC3PT6LnFwoR/D32sdZidk0v+ZePqXDZsjl/J8WBjxao6OMQyh1kLighsD0tG5X+yyqzHphJnpTLkprk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1wmiJ1RT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1wmiJ1RT"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b7823559a5so2011474f8f.0
        for <linux-hardening@vger.kernel.org>; Mon, 11 Aug 2025 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754920090; x=1755524890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQbmbUuIO/FixqY/FscMGC9UsXtq4qbXi7Jq+h158Fk=;
        b=1wmiJ1RTPygsbLfiLHXj0okugYCiXJvQuzSQ69FEUWU62KQUvBSQZW+9OfnvHxPQXP
         lp6U7kp52F1tGp8ubS4thCJfvC2SGlfIwVjT914DBBhhCE9sqf789SYLzEQk74XqSJxO
         CR1senOhxEK3j4AIc11wWobL0aIZlYcwzTCUA6VZJBleBGfgna000lN4n2ezhcbv1XyP
         kiOzUauMBUSpKqJd2ZA1KKIOH2crRrXQDXbgPEJYol0SKZxVjGPeBupSu+f4jdBZ8Bs1
         SalRk7jwd95xdnWKYV6+HZjGF3GkPdGrTs+53lEkmTwnUUnpgYMIyxnVmFf7pe56VBHZ
         B90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920090; x=1755524890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQbmbUuIO/FixqY/FscMGC9UsXtq4qbXi7Jq+h158Fk=;
        b=pka813Nu8gH5ZRkGU9YnT0IX+LpGaBnY7rLKmVtAWaLnrR9mdhxEkuqdbzp0VonhGs
         KZ9LCoQqpKbUx5MVyGxMPYHuxjBils2C31bHK755vYIGCKaV4g4g/VOATgRyee1EheJX
         vGKI65YcywhwRpM548jzhxpMaauo0Mnish/qrpyx4HHQGp41APJARAmiTIwEkUha4xUZ
         EIDYDeiG0HTxOjBu8BCUNv99Uv+8NG54ct8Arzr3RcEvoxc6+kFtpV+ojXcp6AR/G1Hw
         3ReE019/Df9rapq9xXpmruPoJ5WWBJKQwUo4TVFbKBaq0NX42zzXNfumP0gxRxjdMtzq
         7Xzw==
X-Forwarded-Encrypted: i=1; AJvYcCWfnrNuGZFs+eb4LIui8jPP637fM8bIyC6lx2URjyfm10XvSbXVPWF1EK8Gwf+weUbRhi1yyPFQyMCE3JC0ysI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYw+tKPSjGxWtGEbvStaD7cxZSTcADekDANvTqT+R4KCaElm/q
	sxshRcm6Y63JZHROBVRDb04ucpUHpNW8+inArNxIWXOG781vY59Glt7CWyg8+lixqog=
X-Gm-Gg: ASbGncvghPVI8vwKb7j022SVSPdhfsp14W4PJlF7a718fkwSNbKST5mx3ebbeOqU9Sj
	dyctByMZqSAiZMVQcfoL4ksAIqJLg0Mtlq5zBZYQfRXluvGMJaxl+bLnLR04QyukSupWul/xIK7
	agXgCBnaOVwfF9qP6tsxFJaBgO2U1oRd2mJiwylfwPhT9+hKFVa4NffQ3dhgjkpls5/X6oF7nwR
	GUIbpcR9mxQsVVhiknu9m9Ai1tYXyihzDaxabm0kE57wbKP3zX7hlvGaXpZI5eywb5DHW56F5Qr
	HGMDQGVPntVB2l+kbDeSsU/pZA/yUUOeDJlb4ya7Dpc/OFJY/ULfYdO3T/O1joJaL72punTqAjk
	cit6YIV8mLsJxxHiIrF+YurCd
X-Google-Smtp-Source: AGHT+IEGLWnHTsgY+DQSPIbj10ccfo7+PIuZIGDyIiH0rtT1Xh+G6PRvNotxenNW93+TG3JyihzV1w==
X-Received: by 2002:a05:6000:22c8:b0:3b7:99d4:c967 with SMTP id ffacd0b85a97d-3b900b50d93mr11418569f8f.40.1754920089833;
        Mon, 11 Aug 2025 06:48:09 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6841:8926:4410:c880])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459d712c386sm339621115e9.23.2025.08.11.06.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:48:08 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Thomas Richard <thomas.richard@bootlin.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	DanieleCleri@aaeon.eu,
	GaryWang@aaeon.com.tw,
	linux-hardening@vger.kernel.org
Subject: Re: (subset) [PATCH v9 00/10] Add pinctrl support for the AAEON UP board FPGA
Date: Mon, 11 Aug 2025 15:48:05 +0200
Message-ID: <175492007083.69870.1998290411416656246.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250811-aaeon-up-board-pinctrl-support-v9-0-29f0cbbdfb30@bootlin.com>
References: <20250811-aaeon-up-board-pinctrl-support-v9-0-29f0cbbdfb30@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 11 Aug 2025 15:25:43 +0200, Thomas Richard wrote:
> This is the nineth version of this series. I rebased it on v6.17-rc1 (the
> only one conflict was in gpio-aggregator due to set() callback migration)
> and added AB from Linus.
> 
> Best Regards,
> 
> Thomas
> 
> [...]

Applied, thanks!

[01/10] gpiolib: add support to register sparse pin range
        https://git.kernel.org/brgl/linux/c/181fe022ecf8a8e85def0e94852c631c59a8b3f6
[02/10] gpio: aggregator: move GPIO forwarder allocation in a dedicated function
        https://git.kernel.org/brgl/linux/c/871c7cd54830c0bda15513238ea9d46fc1cae991
[03/10] gpio: aggregator: refactor the code to add GPIO desc in the forwarder
        https://git.kernel.org/brgl/linux/c/c44ce91b8ada680074aa976e61fcef5633e6f086
[04/10] gpio: aggregator: refactor the forwarder registration part
        https://git.kernel.org/brgl/linux/c/10d022efe2c4bb2020a07b2e4d94b658ce30aca4
[05/10] gpio: aggregator: update gpiochip_fwd_setup_delay_line() parameters
        https://git.kernel.org/brgl/linux/c/b94cf35db606453c64e5da13c56cc6f8cabc6a33
[06/10] gpio: aggregator: export symbols of the GPIO forwarder library
        https://git.kernel.org/brgl/linux/c/6e986f8852f56cf9214ea2ec02b4b432e201d02c
[07/10] gpio: aggregator: handle runtime registration of gpio_desc in gpiochip_fwd
        https://git.kernel.org/brgl/linux/c/b31c68fd851e74526ad963362ea205eb97b9a710
[08/10] gpio: aggregator: add possibility to attach data to the forwarder
        https://git.kernel.org/brgl/linux/c/60e92c1009c7c6abd4a9d0caf33a8cba5d09f67c
[09/10] lib/string_choices: Add str_input_output() helper
        https://git.kernel.org/brgl/linux/c/53ec9169db1345f04174febb90f88a871fc28d9e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
