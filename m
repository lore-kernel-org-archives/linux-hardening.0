Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CED21CA1E
	for <linux-hardening@vger.kernel.org>; Thu,  1 May 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746100014; cv=none; b=Ze3vABX0r4O9xL7vScGVeEd7satBJzXRYM15IP47q/l2/+gIwMV+s3LWGgd9M/y4qMFP9T6z8TK5r7nzXPLC4Uy/Vsc9oxrIdcoVUFjMU1y7PtSABHUMeK++MCe24nSUqMKm2lE6oXLor+JYjNzxgH9wG1CUGMmQJ8NN9mCvTKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746100014; c=relaxed/simple;
	bh=gA/dP/1fe3IU6fqje0YYjQwYu/yCBUq82rjIqFksv9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=diDEs5WjJ6i5FqxYn8AB/SqTdxeqngEkvgqHG9LQFdQ4v3Jf/R042s8SHgZ0ddSNJtW2Y18nAIkAXBSr39QZLMZLsPtaIZYg2+WpAZNZLWa1BhKw17HQ9HHbBkcakr+uXPftNdDoGF7fkCyWbALAbbDI7jiPUjBM8bL/dezYMCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bQQ6DbDQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQQ6DbDQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-440668acbf3so1225835e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 01 May 2025 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746100010; x=1746704810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgwakmqHlp3M4BuHJh0II3nl/7c5y+mQeic4clcaFRg=;
        b=bQQ6DbDQf+nsD5kltspnf1v29oQwmfh3U606Il9WwhmAfMzmcpKWXzAW8Z9oQ7LHts
         FL7mzFrdMXtivjcIxaEoP32ZAjFt5HHIb5Wg0m/z9phKyFjJKQ/pCUWmIl5FZXQI7vFp
         uBk9pqZKOIys7MhftQ1EHMqs2+NG+SIHFyCHXVOy3R9LnxV9oNg2vrh2N4IlEtL+dLh3
         aJEw3m9lBzbtXJ3TKxSAOLRJ0vE+lbCQJH2uWdpvg/0tXLRbPEWjc5VA0vkwfzyS7x0c
         8H+G1xbCD8brcwrs4SdYUdn0KeLzy3RoAH5jT3T81G8fScytc2/VSpnn4gLhqHut/or/
         ajgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746100010; x=1746704810;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgwakmqHlp3M4BuHJh0II3nl/7c5y+mQeic4clcaFRg=;
        b=fxHS3VBkseeE1mGn3L+Clo21qASZQiElnLMFpVPv7LR3qI+Z6zq1GPfIESy7zerjWo
         W80lYiNi1wmOx+8T7oPegolTVAYmD+1gma7AgHevPoaqueJpdkF5fLBuMyklU4A4Ajt5
         hBvUFj0RMO7tRtoYiqYb9Pr5RmMp4TJxbOCsd6537Obsn2XU21tEolTpRDjwML2d9zIj
         wSd7oz0wqeQ6XUI9zGCXWEK7pD4McaaMK9Vw3H/np3f4v492Trd49W9RTrwUPh+uOp60
         qQbdwy542o3UpKCzp+XBoYuOouRwRrusVglc7aihusyZ7svuzSrytuRXF+N1W0jmt4qO
         FmaA==
X-Forwarded-Encrypted: i=1; AJvYcCU0z+Svnxg4uAEmqR4wWAcFyl+x6F/TpTapiuVqdHG3BMDPfT+60LbudYYDe7h/Fj3q3l6+KcU9SqMaBMYxvVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylnLzwF3f3dcK0TI5GJ7rulnO5gwecHirO3BVqoEGV4Lxv/Taz
	zAqR/y8/z4U0tK+DeWoNu66wg10qREJ/nfzUlY1b2mdC7IUM+Ld7bIrGNCErBpQ=
X-Gm-Gg: ASbGncspAjw2kNveMKx1b2qqnfQve8KoTK32Wg1FIp6aujtEvPP1DkCfSieYFS/7QYu
	+c/bNw+YjzfoRW2Ec2Qy1jKg8uQvBAtHvJPpFxb1eKWrEpVbLqpENB9CNIESfAgddl8HlqrjoyM
	sawXf7K27iT41VlZVPAGC+tsenGsNdovHLnVeqOLxaQ4OLhw8lKVsRyrrptqUXYUJs35JHt1i2d
	gWqtPkujExYHPHP7vucLA0D0wBp+RpxHS2kvjjFrYLSDTCYvFZPti7/vsbNZ+IzqozNSXMXxbp1
	hwvo3EAmlqqVG6mfcmtlI91waxgCkAxsaDSPXokKobLzRqZNC5qdJxx0qp0=
X-Google-Smtp-Source: AGHT+IE19/IV2sTGx5RIWEjQEneEcVM1DQ6fXDyvBd3U1JlBxsPULPZVr3GiI+mJAGk12V9wXMS3lA==
X-Received: by 2002:a05:600c:a281:b0:43d:fa5d:2675 with SMTP id 5b1f17b1804b1-441b76d51f5mr4498065e9.9.1746100010177;
        Thu, 01 May 2025 04:46:50 -0700 (PDT)
Received: from [192.168.1.28] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af306bsm56097115e9.21.2025.05.01.04.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 04:46:49 -0700 (PDT)
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
In-Reply-To: <20250501-exynos7870-v7-0-bb579a27e5eb@disroot.org>
References: <20250501-exynos7870-v7-0-bb579a27e5eb@disroot.org>
Subject: Re: [PATCH v7 0/5] Add support for the Exynos7870 SoC, along with
 three devices
Message-Id: <174610000860.28558.16541132218843175138.b4-ty@linaro.org>
Date: Thu, 01 May 2025 13:46:48 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 01 May 2025 17:02:56 +0530, Kaustabh Chakraborty wrote:
> Samsung Exynos 7870 (codename: Joshua) is an ARM-v8 system-on-chip that was
> announced in 2016. The chipset was found in several popular mid-range to
> low-end Samsung phones, released within 2016 to 2019.
> 
> This patch series aims to add support for Exynos 7870, starting with the
> most basic yet essential components such as CPU, GPU, clock controllers,
> PMIC, pin controllers, etc.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: arm: samsung: add compatibles for exynos7870 devices
      https://git.kernel.org/krzk/linux/c/004bd8536cb9d56cfe2a13a6e05a4a1998455b71
[2/5] arm64: dts: exynos: add initial devicetree support for exynos7870
      https://git.kernel.org/krzk/linux/c/d6f3a7f91fdb84f286d943d89cf082f43fab239e
[3/5] arm64: dts: exynos: add initial support for Samsung Galaxy J7 Prime
      https://git.kernel.org/krzk/linux/c/61296c6b604df4409834eec0bd1115ddbaecb921
[4/5] arm64: dts: exynos: add initial support for Samsung Galaxy A2 Core
      https://git.kernel.org/krzk/linux/c/d5cbf26a5c8f57536fcb782c8985a83ca16dfc7d
[5/5] arm64: dts: exynos: add initial support for Samsung Galaxy J6
      https://git.kernel.org/krzk/linux/c/fc581fae50a2d9777a4056c07a62e5f0470b640f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

