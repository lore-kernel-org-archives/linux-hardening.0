Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCCB306B3B
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151851; cv=none; b=TJXeheo2cBpbUohXFjaph+c0uDFUpxkiwQY4ZR7fBHpdkWFGyqU8k2dtDsaNfh02aRd3ww5slZsKadLCMmEtBeTU+QhrGC7TjFD/WJpkznDXvxfElbFFVNeFs60mJuRrRqEXKSmNjwrz3Kc8+dgFVP/VvNWHx6vii67QGLt+Ujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151851; c=relaxed/simple;
	bh=muy4ln8oosRMTLMN8Ir5RlGdNWkfxHNe7px5ZbQvV90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XLi9QFsVAdK3CfrFiT1aLcTQO09AFVNwhK5ggNlmzHZHMJDUsuulM7hHppYAXbBQilrTwTkIf4ALnb6ivcLeZ4yiazOcGZccSPebHAJES8yi6HwxwzSiUSk1m8lHYQlP3TFQC9LKMFOSrgg8krM3btRk9CCtW5I4t29ibas6wk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg6aOoCs; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg6aOoCs"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c801b30188dso260910a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 04:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151850; x=1778756650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmrgafWER5TklrlynvzNXexUVxLr7++bugjx6nPpFyQ=;
        b=lg6aOoCsQOoRdgaZ6Nb2ZcEFdGIAiz7gAVSladZLaak2XyA7i95gK9R1azMUrrRtub
         lDo+c0Na/EB+3lAnGUxtSKwxI1JSu8tFG7gva28yJHzkYtJyASBm+adtHFi8QFTquOPf
         wJfwY8hLRfywKCaIdKPdJkIDk91alavQDlu4A5JixVSbjP5QJaHPPhllQcJN9zJWXodQ
         6ahgX3GgJ1tPG1ldemGuPvpOrp6GWTdVZPJv9D0lVLuLHGzJpYAYXVUOKUU4lt7qDqX6
         oBsuDrT6kKItitC/jm8IcvEK37DhJxIvCIh4yu/muvPk8Zk3uMzUELHAppNjlic0Pzlu
         bFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151850; x=1778756650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmrgafWER5TklrlynvzNXexUVxLr7++bugjx6nPpFyQ=;
        b=dgJmDKVIYNKfnG6ayWp5XJB1MN0NFUC3ndJ22GV1PTT4KHeBX5z073J+WawIcQpZ7i
         cMACASjSGUZbkbF/KJN8x3xoWiygY/oaJBhvEqee7GOUbDbfHOmRxRohoE+JtqAMpmIO
         ygBg5PJ0iu484SO+SUI53BPcGDxB0oO5t0nlAJtYn4rYZymgnNwGxK9/PLtnizGBYtV0
         VwsulRmgD96p58VjPX9g+0qYbtvGec/k7ezgSuUMa7efCHX6kV1ll+1ZzmXw/1aVS6e/
         n/B0GOHz6Gxig9396+l0EhSlDlcVFtc7Z/Dgz40zB5COcAbVrFUSs3Rrd0rc8zNaw/BE
         8Gtw==
X-Forwarded-Encrypted: i=1; AFNElJ+6aBAfu+DNXzhNVaOUgdSO+6akG2yR1ptqhF9G3fEK2cL0iv+ONpm99qkCcct9VFZL5tAB0rYDqHwIQfKM3VY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb+V9YIH/BeHtPc7dGNPUcoktaybcCOqezf/XOyEmB6uL7MMaz
	v9w2YsU1pzr4FcBxDOo23zVEICLPNrXV7Ui/sFydsJd+ESRe0xq2Gy9H
X-Gm-Gg: AeBDieuY/ZhfMwItWRD/O0saZAOx5GMKCa2uxaw6pb6cQGqGEP7ez9pAlx/i8mtO6py
	tN29cGmZ8Ep6DuCFJ8GNBh29RJLLxUca/8cAlFJfsEfa5zMlPJaOYIf7YxtKCQJjmikRd9IhE35
	jXURhYgZxCWnbtCbekpoaNoAn58nb4a8zpU7ZN4l95ky8SdBVzMJOHXLRxTMlz6NcYp3SvBaeZZ
	AnLGmzcdkYNYwu59sWemSUA71iganUl+TGQhRI8vRe8DXWzoQQhLEhzqfJdrEZAf1Vk+BbL7r4U
	Y1p0bSHe/N2KLXS2xQGvSqQr2Ygfyis3fyw4+0zaonLW6SobGy9hBlg/tQgbMM9qnikupRj4R4I
	AdXYAqbsAHoJZY0jID7BaXKFXtSW0wt5SNUf4YwXbjmuKLzKe0W72y9ikcm9lkm5H+KsTkOKjFC
	IdjcOeTf7dkGV4P8CO49fKfn+WkaOQr/3eVR6LBm5x2IFcm2EGVk8=
X-Received: by 2002:a05:6a20:6a2c:b0:39f:24a5:3065 with SMTP id adf61e73a8af0-3aa5a72c4abmr8140964637.7.1778151849968;
        Thu, 07 May 2026 04:04:09 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8253b493c5sm1835163a12.28.2026.05.07.04.04.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2026 04:04:09 -0700 (PDT)
From: Jiazi Li <jqqlijiazi@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	linux-hardening@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v3 0/3] Add str_alloc_free() helper
Date: Thu,  7 May 2026 19:03:02 +0800
Message-ID: <cover.1778051552.git.jqqlijiazi@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently finds 4 locations:
./drivers/net/wireless/realtek/rtw89/fw.c:2557:7-12: opportunity for str_alloc_free(valid)
./drivers/net/wireless/realtek/rtw89/fw.c:2693:7-12: opportunity for str_alloc_free(valid)
./drivers/android/tests/binder_alloc_kunit.c:196:6-21: opportunity for str_alloc_free(alloc -> pages [ i ])
./mm/slub.c:1634:3-8: opportunity for str_alloc_free(alloc)

Patch 3 is based on
https://lore.kernel.org/linux-hardening/CAHp75VdHY814NRfyUfWeqRd4-DwYzHGh25OTsUB5EFpRKpVQLQ@mail.gmail.com/T/#t.

---
Changes in v3: Add first user for this helper

v2: https://lore.kernel.org/linux-hardening/CAHp75Vdvdr0TPzuDDPSoJ4Nixk-6qO_x6Or9iY9LNwSO1Q6mHg@mail.gmail.com/T/#mfb405519f7b3a06f4fcaa8e5a799da5299d9ee85

Jiazi Li (3):
  lib/string_choices: Add str_alloc_free() helper
  wifi: rtw89: Make use of str_alloc_free helper
  coccinelle: Add rules to find str_alloc_free() replacements

 drivers/net/wireless/realtek/rtw89/fw.c     |  4 +--
 include/linux/string_choices.h              |  6 ++++
 scripts/coccinelle/api/string_choices.cocci | 38 +++++++++++++++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.49.0

