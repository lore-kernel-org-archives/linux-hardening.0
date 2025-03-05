Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94D5253326
	for <linux-hardening@vger.kernel.org>; Wed,  5 Mar 2025 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201558; cv=none; b=XR8PgTfqIPuZK7t63xKDftYI8whNwh1gMGMgzmOudIvHzPHL+TVvnKjeBwxIrlN/Ee1GrydyG5lI4DMuMRdHkgskHq8m/A3/SOd/GQLtSCycFJeilFlWy1nHKKUg/j/R1mIoFI+rRny/KOYTP4zpWPGBKqfFctsPwHNbNjE062U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201558; c=relaxed/simple;
	bh=k657FxCWzDpdSCjqG1OpdeS9FGRaWIIzPSLgP8iEB8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nZZdPkOCC7M4tV4OklJK0D58TooybnWTMkxLf6X6A8/5LxbktPdsNeh9Ei8yQO2oUaJICSj0MeUpSUy6TvqhAz1k88TaQ1zHIHRXecq766gRUluetCG7o69o141T0LCsqwOYAwCPP8n2Ld4FQuxrYuOq15UbH8vK0wpfuY3zGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RQVgtHsZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQVgtHsZ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394944f161so8748415e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 05 Mar 2025 11:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741201555; x=1741806355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXwlkhSlbVtwXogPWWcb08IskVMbUMqFwrxRMdg6+Ow=;
        b=RQVgtHsZDjG8c4C/5yd7aPX+D5oNCtBX3uN7//eE6rIs4/3W6U+inhwcriB7y+x9X3
         pHfw56hvP1FHgzRLyHBJ6VaxEL31PheSI34E3wVkg8qfU7xDpbg1kbNCPHi6ZZbMgsCK
         nlfz7S4D7FJSp856HeiKI5S8lF3yAWRxIQKhvKhP1Uhi+0sQXSKRgWptRlRUzXd6z6t0
         sUJyI8PKtF8g4kDdG2Bfl8EYzeN2sOzFpkHH0DUzc/9HlU9fxYb4fv2DolHvkmdkKX9V
         Bzsl4Efqh24PCYORYaMM6KP2HtM9bmgMLxYwjc/JeYQTvOnMaMzSsyGwaI8j0bpjaEjg
         bwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741201555; x=1741806355;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXwlkhSlbVtwXogPWWcb08IskVMbUMqFwrxRMdg6+Ow=;
        b=JQWKMZehKDqCFXsudvZgVbgbvC4XAzmInGsStyIxfUXzACLIMM5FqR4t0sI6fOz5C5
         P1y3KwfGDKQqsYI93IEEcAIXDZZ3+V0S7EGggZMPXJGSQjpOZj2DJmFhWxkCWs2qBKBE
         yXyRkHwH7CmQZkh3a5VlCD2mzM5lPV+D6Jwl09jIJcxEKo9gzjKeVrX0pPObKoqRyQFF
         TQmWdFAj12GbartRCS9POXpTPivfk85ZR9oh3NUaZO5IwKH47P39cqiYRDcXRu9A67vI
         XzrhOpFIcPu9xg21wHbd9jsG9ujyOCX2V7MX+wu7IBQcEiJfDDiKYXmprccK+osvhNTP
         2cHw==
X-Forwarded-Encrypted: i=1; AJvYcCX9hyYXq6bPFBAf1TNXbPkDQhJCy8ci7Y8DLn2qDrpLPS7JDifKwnKxbWoYtn4RtKY0Anbp5ciGEzUuGRj0De8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkSNIcfyu+8C6WBxJdRlsf7QKe5US0kqCiENEn3pZxqNYWvgi5
	hf3mAKeMgpj1x/xst4HCvNcR3M5u2yD8qKPOBuKGpbbU8A2trbRt0SwjjWTctDc=
X-Gm-Gg: ASbGnctcJIh3MaoT0CTNmNMswyy7MmF8pOjGJgn3ET3IwRAZGOlHmhnZLYtzkEQBoNj
	Yc0B1TL13A74uUoCupN0hRj/it+TlPefsOhtrmrgSX+k5rJyaIl3BKV90BFK1WkKKvC00M+ADuQ
	llNVgemCitAYyBgRVewHCyYrcIpXFF5TuFurWCEH2ibJIrK0eIMOI2qeO4KWdF4IRr9AiE6tybc
	tA3oO81+JwpOLqnEXgkE7K1mvp49P0Yic/32Mr5rTg50Qhh6xeU6KGVdrFCLl2VwjunfRzeRS0c
	Hklcz9OMkqyZ7Be5YNRlauW1YM6Xb/KXVAHwa3lICXlW14mMK9rodVU0kLTP
X-Google-Smtp-Source: AGHT+IE3IjJeSMhwhYFQVkJODS8A0V92GzgNUXihhvb00RZvzc5AMKy+de2oOq6U0u17cQDNCmp+YA==
X-Received: by 2002:a5d:5391:0:b0:391:2886:d9bd with SMTP id ffacd0b85a97d-3912886dbaamr319116f8f.3.1741201553557;
        Wed, 05 Mar 2025 11:05:53 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47965e8sm21491662f8f.1.2025.03.05.11.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:05:53 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20250301-exynos7870-v4-1-2925537f9b2a@disroot.org>
References: <20250301-exynos7870-v4-0-2925537f9b2a@disroot.org>
 <20250301-exynos7870-v4-1-2925537f9b2a@disroot.org>
Subject: Re: (subset) [PATCH v4 1/7] dt-bindings: soc: samsung: exynos-pmu:
 add exynos7870-pmu compatible
Message-Id: <174120155027.74217.562001377328469243.b4-ty@linaro.org>
Date: Wed, 05 Mar 2025 20:05:50 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 01 Mar 2025 01:16:49 +0530, Kaustabh Chakraborty wrote:
> Document the compatible string for the Exynos7870 PMU. It's compatible
> with the Exynos7 PMU design. It handles syscon reboot, syscon reboot mode,
> as well as other system control registers (i.e registers for the USB PHY).
> 
> 

Applied, thanks!

[1/7] dt-bindings: soc: samsung: exynos-pmu: add exynos7870-pmu compatible
      https://git.kernel.org/krzk/linux/c/bf869ecfb8d3d0fef07ed2752df93c977cc257b6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

