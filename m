Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D936DA1C
	for <linux-hardening@vger.kernel.org>; Thu, 23 Apr 2026 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957792; cv=none; b=Zf0KuWE1K0pMVsnLRm5lJUROuXU1r+O4blRRj6GqTd9kGzkGQyfAj2BSDyEWKQouRbeqq++1qxXKsiLoRjz5Z8ADqn9Wnusi6O1oESFWWKP5UEK7PGne/zj2Odr0cQpb1LFvq5jzL/KOdXM5m0kKsFcIriGymixjyeugP2kNTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957792; c=relaxed/simple;
	bh=FWU5VNsYMZRRVGYIioWPuaaPLaZNzDvKQUDpPiPlMQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AzpbIlRKDaMGOBPaxS9VK3TdvoUmafOD303YuR3pYb1N3ns1+PWTQ0iI5YymVhAxXDZ4aVGm30ERkhQpuPw7svjJAZ4eVhnEUiVr7fwYFAqc9CLGG7lw+l30wDX8BKQG3NOJdpBxYn7F1hzVMoLGp442HAeD3Uldb2/4UT88AF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GCAAZbYY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCAAZbYY"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4890098abbaso50524745e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 23 Apr 2026 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776957785; x=1777562585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2rw/F+vOuT6UFAdYwCBkXsXOmQ9+TggXzaKDVp2DDM=;
        b=GCAAZbYYy/w0aeRmk5QZsvV5wURYbYWtVTwOAMINonLeq5HBbGn/Av0cd+ba/u4LTM
         SN2iOemM1vnNT9JwCPtIvNL9WlrC1X4pRpJqEgZT0VAnHRq7podSz3q+QPuMHrVOSDLH
         TWEEuBPfpz/3d4HqBZ2yz2Vo6tvlOX3U81by3UcDU1jcJGjqh88gaEaetY1CAtWsQOUU
         2cN+TAJVM8/Wimal812AvM7qIoDyuQAe7/YqY4bG6Wb99um1MFIEJI6HqxrQjG2+F7dh
         6dsR0bOh95tRe2qA39DhAiheNmE/SP+0RPwHLfGMJuCUrP/jbtZz9KhmUW+5LafOkxh1
         iXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957785; x=1777562585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/2rw/F+vOuT6UFAdYwCBkXsXOmQ9+TggXzaKDVp2DDM=;
        b=IS7c5WD1CpX7NUs3x3oq5W25urBGM3/jO2N/D+5+b8E4kqVz/NFepmNeQe6cryvZyE
         0CjQnMd0VLyE+Sc3zlw1yvolfYlvFfSXweOhB5y0tL4gnlYUj7gumCQPJFHC39WbX+E7
         Fr5pIH72zI9NKeJAAc/HquEvkUWYY62kt/qbFCubw931JZiW77hPB5T9oHxEx7XU6DAY
         c8RGoEjqwfJRCq+NIucXcwDkLYONgmVXBgJ+UPFm859ey7zNkr20l9zkyPO7DgRanL83
         LUU/z4+r6cCeQw/gzS4nLyzAWFUwFcrPi/w+Z4kK2VV+uU+uNft/2ZVPMV3+zq7OWyIx
         qhbA==
X-Forwarded-Encrypted: i=1; AFNElJ84djesz8lc2T8Nl5d1CjvJAlrcx18djLEwA8XaejY8QVEuCsmtQYCB0ICrnVVyDzAbcFUa5BQ5UT18NT7RWwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCY3PpD7+9AxN74afDZU7sRuKT0qO7L+Eo9Sybm8DxLFf0apRD
	77VCj6uJN3/EQMjWPKp6DQmDY4JH2Y4Ec8GjCFDPwPQ0uluyeAV61xiIZo62RCIEreU=
X-Gm-Gg: AeBDiesrQrzGRKHp0FXFTINkOpiYXloUjzNfeK5sDs9DWLe/QzfCo92mWiEEwpA8S0o
	8LoNj8Z7Y5kylCy9/xCJTFkhS/8K78EJNGfBJm48//9HEBoNT/4U1LXzmwHFpdbtbF/b4A6Bohq
	eDMsvHER/8K7pdQn2NGXPGJGeer2YfePrfVohb6RIb9ktjf0i7I59aKWYxQxeP/fBw7eS9X5/ZK
	VzHNkZhLvfAZNgdVqy/wP9H0ljEQtojvJIr3braLLWdIV7bOjeE/2MOMR7MkjZQurpQOpYA/PLc
	WLziPXQhKRK0b1zroq1bQ0uBLkE1q51TH8DHxtk1Yywd0tMRlQIMGHwbCUajjsOxZNro3DrQ1Vh
	ra3tGDBWnnsOLnBpjT1GFxArO6aJsnEFvNAl2TW3WNxbMKIf5Wq40Ja0w2yQRl1tynB2j601Hjh
	Xlgc8Q88JgHpaHfTaNV+qEeaAd5LI+0tfajOXmsdDdBV1oVR7G0jADgdkvXNIybeApKu3XB+ZOH
	oBl/+d54QDs+P9/2g==
X-Received: by 2002:a05:600c:4fd1:b0:488:78f2:6b0 with SMTP id 5b1f17b1804b1-488fb78ede0mr397227715e9.29.1776957785364;
        Thu, 23 Apr 2026 08:23:05 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f98728dsm90550755e9.23.2026.04.23.08.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:23:05 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 23 Apr 2026 15:22:57 +0000
Subject: [PATCH v4 09/11] MAINTAINERS: Add entry for Samsung Exynos ACPM
 thermal driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-acpm-tmu-v4-9-8b59f8548634@linaro.org>
References: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
In-Reply-To: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 linux-clk@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776957778; l=988;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=FWU5VNsYMZRRVGYIioWPuaaPLaZNzDvKQUDpPiPlMQk=;
 b=oGan3n0YDDTqNrNPvT5e5tY9UzUuAumcLznabKnHsbyyIVFfufKds/6MUWf1Xq0V0ycSAXT3/
 KZjDYxlqCdNAPXdbDR3RyrFMLbqE0LrVkmWv13ndxJQsDwP/6anSJj2
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add a MAINTAINERS entry for the Samsung Exynos ACPM thermal driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9b7b6f9828e..759c05bd0004 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23693,6 +23693,14 @@ F:	drivers/clk/samsung/clk-acpm.c
 F:	drivers/firmware/samsung/exynos-acpm*
 F:	include/linux/firmware/samsung/exynos-acpm-protocol.h
 
+SAMSUNG EXYNOS ACPM THERMAL DRIVER
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
+F:	drivers/thermal/samsung/acpm-tmu.c
+
 SAMSUNG EXYNOS MAILBOX DRIVER
 M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-kernel@vger.kernel.org

-- 
2.54.0.545.g6539524ca2-goog

