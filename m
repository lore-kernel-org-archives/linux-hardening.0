Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B7F482DF
	for <linux-hardening@vger.kernel.org>; Mon,  4 Mar 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568417; cv=none; b=cyQAmx6Hz41s406i/gL0ziMGbKmaDX7i21+bMg7KwCBLvVKhzAlURxQ0RUmi2cExMmbOjFshdOoPU040R/HHyhzSocOx07GJxZrK906CFud8Jf7C+Ud0wZoTy9NQB0zowiZFs/ztJ/5kdEeCh5piu7P707Ovu2WkzzuZN2Vav3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568417; c=relaxed/simple;
	bh=plzGzd4ql4UkHxCqU2wX/tIOWDt5L2wXbFIVFHz/b7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qrLX7sZFJABxJXmnDJpDDzmDHFA4eTgb4BvEodyZCjN1+DqPaN/wAGZ+adE6rcauGajvNgku/uzUhO5OM0T8kcig3I9D51kAWSqXWwaxtTaRNSEgP0Z/f1HRkJInaZvFZVPA4OYrh6wvh7OCZ+CLXAgfzJlaoUd8Y5rRecORuCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2c44+gtB; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2c44+gtB"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-21e45ece781so3481449fac.0
        for <linux-hardening@vger.kernel.org>; Mon, 04 Mar 2024 08:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709568413; x=1710173213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSnLoEFc3zi8rA7WG8Da+BT83RJ1sRrxJIuPYNavbyo=;
        b=2c44+gtBLcNVdr1YFO7BuvfKiPMrE1YmbMK8ll3s0Tg/hV6t5Mt5nphH7iW7K9lneH
         kGF30bpqf8X2/UnXRdMAC+vf2WsSoP2Uvm6cbpZVmLEPwxzmMpxr0n7csYim4cKPKXWe
         klN7QAPXPLe4qvsGKLhVm/KRq1LJK3hc/Qy4F4f0MWTTyw1bf2bSNIcosRuhyGc7c2Gn
         WEUSbu06pgsQd9iZOV9CaNiErTp5soW75SwpRkWfuj8WMW1E4czWJKiTnRY9vHCSbiZw
         +DFQEpKOQ27g19DCcuOLkfGCeOhcfsL3c2JKRUHagCRYiUyTz3vD9K1AXNf5xr0ABsS8
         BOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709568413; x=1710173213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSnLoEFc3zi8rA7WG8Da+BT83RJ1sRrxJIuPYNavbyo=;
        b=MkW4ycuXXr2VkPqSf/gA+XBSOa3DpVc7AXSfEZjLm//CmXBILUDgJHzP37NQiL0E9J
         cvuv6imE6GAznb4533PQz4DpfkIjlofAbeVPStKSHt5qs4BZMMMkvY6+E/uhCcDvFGV1
         zHSGsyvjV96vtKkYzqYTlwBQbaAC+G9mrMLjjpNDTUw9/uZAMtZ0npTxLquujWJkQE56
         QTFsYS4DP0rU5phvPDZyW/18fd4rl7D1pfbo7xsKd6iE3mHDeNdt6Ir2H0E+HVCnYfPc
         WHCSYh/1S1lnYIMZ+PUw3zTqDtxwNQFZHLtIQcPJ9CvOZ4ogrpy3IjIlG4YWS/wD0Udl
         LXDw==
X-Forwarded-Encrypted: i=1; AJvYcCVYaVlketS/rC5bJEkE/hbgh8jpYLnWUsIS9Lmwiux9Z/lihI3X0Quev5phHjNmaF+JVp8xiKCHDJ04CmbizBjTKVwhtgoLJoGt1nK2JHHX
X-Gm-Message-State: AOJu0YxwbHSQc9aeteG4Svy38uQTuGS1Es4gwlqPYikkFpwsUmtGo1LR
	mkGhO384n8DG9mf8fwtUGl/IbYDBOszP5kvLGk9/8wSRxQQ2m0tsIvlS5mO7hmw=
X-Google-Smtp-Source: AGHT+IHXOFOEU8sb536X5lP+Lr6j5C3vnrJ4Q/x5YmVWctjjbF4G2PE1tSGomkUTlXXMEwivjXRpDA==
X-Received: by 2002:a05:6870:e98b:b0:21f:9c60:dba8 with SMTP id r11-20020a056870e98b00b0021f9c60dba8mr10760372oao.4.1709568413352;
        Mon, 04 Mar 2024 08:06:53 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id lu6-20020a056871314600b00221287ebd03sm83392oac.4.2024.03.04.08.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:06:52 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 0/3] spi: axi-spi-engine: small cleanups
Date: Mon,  4 Mar 2024 10:04:22 -0600
Message-ID: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This series contains a few small cleanups to the axi-spi-engine driver,
mostly suggested from previous reviews.

---
Changes in v2:
- Picked up the Reviewed-by trailers.
- Modified second patch to reorder assignment of the length field.
- Link to v1: https://lore.kernel.org/r/20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com

---
David Lechner (3):
      spi: axi-spi-engine: remove p from struct spi_engine_message_state
      spi: axi-spi-engine: use __counted_by() attribute
      spi: axi-spi-engine: use struct_size() macro

 drivers/spi/spi-axi-spi-engine.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)
---
base-commit: bf790d87088a04d5f3a4659e04ff2a5a16eca294
change-id: 20240301-mainline-axi-spi-engine-small-cleanups-cd08b51cb6d4

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

