Received: from mail-qv2-f31.google.com (mail-qv2-f31.google.com [74.125.230.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C68443E2F
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241774; cv=none; b=WtomlsOvNsOj97Y5T8KZmrnRKhKopdwaOWMnL9E34kslvKV3PoKNL0PWgdWQFmeZlOrNxrXDxfxLst6cs7qF5g404fxvGRKIt8aG8U0nbsAyMRZT0Cp0Q3pQVkNSrkvvoEB7w+tVHqCMX33Q5fuqseD/8108XxhtLhRjJs0LIPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241774; c=relaxed/simple;
	bh=b0bEVA86VyyHz5nQ+2UxZSzWxBoAP+zyISUZ3T8VRko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AxMnOSLuHq2RwfBnn4HQ1NOKlubp52G9vUuxQfrx9uZOn7sLY2o92hkhKxJykfL6bYmkSNtImcUPDe9NClJTM6yXrquDYLbU1Zx4GihJPMyKSzjg6ipsSCAbBXqwXHkK5Tjz8pvGTNjaWeXVposawLAUj7hdSchllc25U/ywOTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=jhoHViT8; arc=none smtp.client-ip=74.125.230.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="jhoHViT8"
Received: by mail-qv2-f31.google.com with SMTP id 6a1803df08f44-91219376dd6so32892196d6.2
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2026 16:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791241771; x=1791846571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MQV3ii+qSfSea4Cw0bZn9/qaZsDG0gsTwXp5wwzAElo=;
        b=jhoHViT8B2A6av+l5LAX4BiDRkFbZgEUcVsOG2/zZ8Rfjs3RNTus0wwShhyCaf8pN9
         K9i1UbO/et/V/uCXrmhT3wIBxY563u1WJ9CUWx4uohNF5fmHBGjrVovOLm5w6AvvfM/q
         A0pDAavZ6Wl75qA24G9bB7z5fyz/BtSz+RTPgYGfEU4fDx/slaXoH1jN5UBmv1Wtrmzg
         L/GYuaLhCxkWykNSO+8NwRpqTBm/pP/p6KM/c+eyx5j/pXXwn1URHKKuZqlaM2U8yFIG
         3pWfLaJIOET+boIZFFWVaUtVbH1AEisNNPVu6lBa2zuPTm0LCNoq6p6Mw3aoEKFzfmrj
         KsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791241771; x=1791846571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MQV3ii+qSfSea4Cw0bZn9/qaZsDG0gsTwXp5wwzAElo=;
        b=hD6Ghb6/k1LQ2k85l2wEU3BHXZufuSb8YybBjvdd9xfHnQ+QP4AshqtYt0QbCju6LG
         L1IxUZURJ8dRbZkMHcaOpPL7K0CNWu+R/OuD4Q2cXC1zQpw9p7n1QxbEaLOnPikUAal1
         91NkQEzQe+qVN9PFiGv/Qb2qMj+cKdX1L7s8/PaW4J3g7+2mxOZdRIYByPGvpI3I4kRu
         3hvfX/+z8vnwuWyihO5hUdMyEJnlMYHQtRv+7oLDpg4gWUTecNzfjpmMkQ2RHwEHpa/+
         WmvffLf7g9ijEOxlop4NdUfDHje/Lv1c2bv44y5mNcQuTbmFLcT4v9UMfywqIszjL5kU
         Xm5Q==
X-Forwarded-Encrypted: i=1; AKwUvBySwUMLsTNLI2AYQ3irI40cfYIhKKQZadp967KiORaEjwZOtCefPQye1N8z3z9xo6acy4GHmPVxWvz2bBh/zfE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOWRjkQ2TScuNLpad1nEA436eZJPd5o9qgnI39Sv68kedsZA7O
	YdY/jS+TRObXUb4b4Jt7rI2n4Tmn+sZu2UCbWcWm0mbc6RkRNvreKFw/sWGrznTYiiI=
X-Gm-Gg: AYBFou1ivzizejQqbP+Os5Bx5Y76PmoIg3FGHB/ET7qwtVqjXLpFufyYvTkcl+31CyN
	PAko77onstOpIn7yi5GBHMeXMlzlEHaCLcmNhuuDNd9MJWyzSJ284EN9q8WTxTMivzVAHfSm+iK
	LYIykj9ODlAQz1mEkSHwtPfa6g2U58d5JBT0I2y8PK+CfdUGmCev2VyQVuTeILitaJdZ3hu9Yzj
	yP9YtyHGlmycAGdr4bpd49aNoqCfSuFljiymKjb3AwxBFggFzQDJQ3p2BWgd+wytslyR1jnVsGu
	lSN8IyI1jTmg6sB8pGbUvC9rt3hoAUqKgiL/ZdIddVAg17ovxJOkueDV23SyAm6SyYC4B3LgNCU
	Z+YH9EOAbrk+lJbkxfdK/JVY8bw7MdfTKyng8849+mYay+7zYc06MbxiypHan7yHttJVLO85x7u
	+DmLCVX4IDA5IsDKBeLwIbXJoL11944rFWKWjYhbn6C4ZjB5+vt0t/zl4lwdTjEPdv15zrhkBXR
	D5xrYGq+9wifA==
X-Received: by 2002:a05:6214:598b:b0:917:9f83:6540 with SMTP id 6a1803df08f44-917bff42ff8mr244696676d6.5.1791241771486;
        Mon, 05 Oct 2026 16:09:31 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-919442ce1c4sm89892116d6.3.2026.10.05.16.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 16:09:31 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org
Cc: abelvesa@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	danielt@kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] clk: introduce TC9564 clock support
Date: Mon,  5 Oct 2026 18:09:23 -0500
Message-ID: <20261005230927.2000398-1-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the clock controller present within
the Toshiba TC9564 SoC.

This SoC attaches to a host system via PCIe.  It includes a PCIe
switch with three downstream ports.  To one of these ports an
embedded PCIe endpoint is attached, and it implements two PCI
functions.  BAR 4 for both PCI functions provides access to the
registers that enable or disable a set of clocks.

Both TC9564 PCI functions provide PCI endpoint buses via devicetree.
Each PCI endpoint bus provides access to one of the function's BARs.
Subordinate devices (like the clock controller) can then be defined
as nodes accessible on the endpoint bus.

Only one of the two PCI functions is permitted to define the clock
device node.

					-Alex

NOTE:
    This series is built upon linux-next, with this patch applied:
      https://lore.kernel.org/lkml/20261002181849.790275-1-elder@riscstar.com/
    It is available in this git branch:
      https://github.com/alexelder/linux/tree/outgoing/clock-v2

Between version 1 and version 2:
  - Previously, this driver also included reset functionality.  That
    is now in a separate reset (only) driver, which will be sent for
    review separately
  - Dropped the "config syscon" devicetree binding
  - Reworded the clock binding description to focus on hardware only
  - Clock IDs are now consecutive (no more commented-out values)
  - Get the definition of of_device_id from <linux/device_id/of.h>
    rather than <linux/platform_device.h>
  - Dropped a comma that followed a ternminating empty array entry
  - Config option COMMON_CLK_TC9564 now selects MFD_SYSCON
  - Clarified in config help text that the reset and stmmac drivers
    are the "others" that use the config syscon
  - Moved the clock devicetree node to be a peer (rather than a child) of
    the syscon node.

Version 1 is available here:
  https://lore.kernel.org/lkml/20260918165234.687224-1-elder@riscstar.com/

Alex Elder (3):
  dt-bindings: clock: introduce toshiba,tc9564-clock.yaml
  clk: toshiba: introduce a TC9564 SoC clock driver
  arm64: dts: qcom: qcs6490-rb3gen2: add the clock controller

 .../bindings/clock/toshiba,tc9564-clock.yaml  |  54 ++++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |  16 +-
 drivers/clk/Kconfig                           |  12 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-tc9564.c                      | 262 ++++++++++++++++++
 include/dt-bindings/clock/toshiba,tc9564.h    |  34 +++
 7 files changed, 386 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
 create mode 100644 drivers/clk/clk-tc9564.c
 create mode 100644 include/dt-bindings/clock/toshiba,tc9564.h


base-commit: e8e67c48ac5cd9b0e7ba4ba2cef9decfa7327833
-- 
2.53.0

