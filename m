Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694D53370E9
	for <linux-hardening@vger.kernel.org>; Wed, 29 Oct 2025 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736876; cv=none; b=uzlVrcpEGd88qHYX8fca2tdJTLt2qSVHuhgmBO0qe+yBrzXUxGQ8lkcs/hTOdFqH+RuV03AkNg7+E2O0pga3oFcaA2VsCE949MkPeDRPf8ZN9gyu16soSY6yWJwoOJoElGSOUm2icX1ZMoCiR0CdxPuI0T5MG1GhKnfC6htxLpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736876; c=relaxed/simple;
	bh=wXk+3crOirlJJ3BTqf/pNqQ/QmJIbx5e9hwDeEFKhJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RlNFwNOTF6fs/wpAqujJ/9OTWAM2W5kiFiA9GihhGdTxRdtrZ8QsmbaAej2SPGJwoxr8T6ln4emsmZi4B+m4Oqc1SVM7TtOtSZu/DcPtUm+h8L4wSfYk+fQ5bbRG9F4mM+jR6wUHzyIBpWXePS9ViHqdiJiG/hbl8XDf6dPZslc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1ffMZes1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1ffMZes1"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4270a3464caso3548524f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 29 Oct 2025 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761736872; x=1762341672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITkYH5qq6p2spjReXhvHRadCK4LlO30xMaO7HYP/79Y=;
        b=1ffMZes1mOU8fjR5o7wC+L01273unHdM0Mb+cyZsJ+3wUzEx+Ft3MEEL56PJxDOode
         /HuB0SR9xAgTzY5pJjKat0O+eT22V5ccFiXfhUqNLPCtE+dB2Gld/P102X3cMmGaTmVl
         y42s/dO1xeBhzqQ4PE3jS4rvuuVDMwwJy+R3esjwLF6maZ2pwXRfE2ZGBq9ET0kleItX
         28zh84HnXqYfv2N3oVQCo3FnrsH0MxNGd3kygdPOV2ylBKRfqsfBlG7erlq09KaEJsBF
         TG9YkhnZaPiwC7FYeMI3F5Dq0TVwqdPmrITyK8wzWZGkOyXgX7rcsX1sERKwsCAC4PJs
         g0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736872; x=1762341672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITkYH5qq6p2spjReXhvHRadCK4LlO30xMaO7HYP/79Y=;
        b=GkwZ0ALa9i0dLlQ/Z60Y3/cW1htYX0sUgAe5nMKcHsCbRX/XeoNnTB3ITvcbH0ebqY
         QrbUSWJ5+5ocZzKgJZ/iokGjOjzJVTLuZB6rt/hdVenqWgKwelUMzpXyx7qHD7bim2RC
         ktAwWr6rS9vXjATf/PSSfLRH3pSw9l0vM2R0LvG57VgY8ezEqGfCHOACcuG3q6INmaPA
         O4YA/MyZ5pr/7Oj9ce61TtvQX7wFXudHvFTorCXn/cfaFzM/yf8dFWEXRQYr/hrIPrnm
         FmaJCCDrV5uPXI6vmxlhCosbyHrlDxi7p9uhRwjOqlkWBD8RZBgaWVPuQpa2GM9xx1E8
         4k3w==
X-Gm-Message-State: AOJu0Yz3VlvgG994ZCMEEvYqJqLaDhbzUFfESH9uB+BAHOrEtwYt2ucI
	sFK+YBYgbEfT4yXiOHaaHgVWkfskX/fiRQ8cXkj7VXIXfEZqp7XmzrEOpJWbCTnZPQI=
X-Gm-Gg: ASbGncvuFAcEwP39ZFCAdBHEnLH7jitXN5pmI+0Y+h3n6DMANL2DYxL+IoQbEwMrhuM
	P46YWTaL/cnIXx8fL5NLPSq0Rh8HAc2RMtVlOPJv6xhfvC5ymZKYP/pvBoQLmS/PPjHFl5lge8V
	BNL/DrO+o7wgMb3In5XV6zbBnxazoh1BuJOXIkjwOI/xQ+6WQUhP9J453jr4zR1Gy/0Y0UI8b4z
	6R/QOxa4LkeNagtT76OTYUTtc3XwuTLLiL2mxYT+/b+1yB8x48Gr3gpwLX2FZsu1Wp5t/V1LdVK
	yKN5Iu694KRySGa0lE4Okh6xOKKbRijpqsyJqmS9mvS54p6dghaejt7c4qXtx+24bdL7m9sSJ7s
	GsXMOpcdrDrImS8U+NDdj/2tTKchbwu0C1ipX60BmTabjF5wdzsuBx1tRB4JOYEfSkcnMahaeWD
	SkkQew
X-Google-Smtp-Source: AGHT+IENSqWLO/JMNJLWEfyUHP3Mjq4W26Iv0qEKH3r8OB2YkTy+FUkLuZiv4z7uvfVY/XuiHdrcmg==
X-Received: by 2002:a05:6000:4021:b0:427:60d:c505 with SMTP id ffacd0b85a97d-429aef78e49mr2088157f8f.15.1761736871599;
        Wed, 29 Oct 2025 04:21:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df682sm25657486f8f.43.2025.10.29.04.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:21:10 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 12:20:44 +0100
Subject: [PATCH v3 08/10] ASoC: wsa881x: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
 flag from GPIO lookup
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-gpio-shared-v3-8-71c568acf47c@linaro.org>
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
In-Reply-To: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
To: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Alexey Klimov <alexey.klimov@linaro.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=iK0ZywBEmfSVw6xPFQX6Oke9nUVZV1pPcQC7Xb1WLtQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAfiXKnnAKknhcraojtkxn3HXQvIqfHbyL+bzN
 EXTvAFatICJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQH4lwAKCRARpy6gFHHX
 csiEEAC4y0Ps9nRfERWW+TIRHLw8qrds7gW3K+kxaWsNsBT38vOQRrALl8SNYm7GZ94LluEso9n
 SSL5AT5boIXTnkKpKhUsNmRhvoaLjsuUtlE1AA/iJvZ6//AC34+pn6a3lOlQZ/s8M5rvRUvNzCc
 /AUSqSkyyElorHQnZsVm23TiMb/h4chxqFQ1mzI1M2CaFDVugOHv3SZyOV5Yus7GI5c0uvt97Cy
 sWYE8PC4I3Io8+souZC+TdOkjA+DJuTjKURoijR4yUrYmiWAVyrz+0C9W9B7orM6U2G+o9DMJwi
 KQplI+8j/Hvq/9j7BdTbgEJmjhj6o3haaszRDVGGKcVhKQZT/hMfO5WOtpxcXUnGh0a9PXeCNvT
 ybgTvSQChRrkrZ/suBk7OAtLas9JNP/AV/ADIwkvT1Qg5YcFUQywjrBccQJaA9XrZ7dUQar+4NX
 plHV0zHPlCYaVSBIjTfUFKER/m41CuhFiKhU1CaIife+NIwemkfvoJNWoYcUDrMwT7Qx4H47jDL
 mUHV3+jE1kwsAHpCEE5EvjKnsgl43pw/R1IxgYaUrcDQxeyO3Bqy+8l0FvyCD9yINbpQNKIwPcc
 JtOZh2FqyA8AZW2dDandfZl9eVndB4tdKfVWQghb1jzvvn2MlVP5t04RU101IMPqdKH51lxIBFj
 yj8vFSO/EhCgneg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This driver is only used on Qualcomm platforms which now select
HAVE_SHARED_GPIOS so this flag can be dropped.

Reviewed-and-tested-by: Alexey Klimov <alexey.klimov@linaro.org> # RB3
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index e249de7f91d91f8c7f1e7020086cc65c71e64c5e..d7aca6567c2de1ec36e9f36aa82463bdbf3be27e 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1112,8 +1112,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	if (!wsa881x)
 		return -ENOMEM;
 
-	wsa881x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
-						GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+	wsa881x->sd_n = devm_gpiod_get_optional(dev, "powerdown", 0);
 	if (IS_ERR(wsa881x->sd_n))
 		return dev_err_probe(dev, PTR_ERR(wsa881x->sd_n),
 				     "Shutdown Control GPIO not found\n");

-- 
2.48.1

