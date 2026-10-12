Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B849B21B
	for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818656; cv=none; b=G+X+MYfUcPDdodI8pXnku/+63HJ2tKmpln8pEJA0HL6voQRPImASxTC0j/G8DTt7+LRlZBUgSDZy4NjVodtbjTHJtXUP0cQ2IDbX0JUGyD7CmJlhoKvmu+U4SEhMeGH8CD30T6ciGMRMPQnHwZpOM87baiztU+hR2pIb6zga3to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818656; c=relaxed/simple;
	bh=BPhVdVn3lLt61EeSVOe16izIdtSs7qr03SzF+WwtHCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b1mZzkbAtsFp1syhTwIRtZICRfbgMPSlg4s9i8WZC0gEgxF81oYKyV0oms88pEA65lsUHMCaLIWzipLsMe0aJ8fa+Xq/Y+PfkRxMiHe0iUKgJc+wYeMkOoydZLryx3XBdiVHjP9drOklmHdt5MdFUJT8VZy6RJO/3u7hFb7EJjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=F+SzHLge; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="F+SzHLge"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-9144e8021d3so30078026d6.3
        for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791818652; x=1792423452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N6I52eyh3zXooRwST5ZWSSAFFlPV3h5qGgt5QWGPanM=;
        b=F+SzHLgeYzLnrBR2QMqeSqprXiyECG8R7zUelPJqND5n2lORKaWtTLzU1hIQz9cYwz
         Ekrx5p3BpfVa8ATm3kcElT+2iUTiC3xAliv4LLiBL05ZUG83Ps6hv72lm6hjjvaZI1Jq
         HK1Kr/Rlew1qrQ6Fh2UB4/QYP8JhYdPonZeHAASYP744X5RFysQrVEgZ0jJchbqD4IL1
         pHOQGhX1t924d2pSfOKuG4821OA6toV0moKmDJhYNPvEF2fuHEqR9I8uNHnJfR+5tLk1
         hy7601/fZ7qnJKtNqG17D2Hkvcs11SquoeQaU0XkQnrEiFOIuR11dcDWayrap9i/4eMA
         rE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818652; x=1792423452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N6I52eyh3zXooRwST5ZWSSAFFlPV3h5qGgt5QWGPanM=;
        b=M68z+EGwCOftIdHBjhOiTOI+5SpJ4hz+yeuGP6bW5SZIiohWqpGPor22mLKKLtgZZr
         M3Q4FrmMZF2Xgyibneqsq4WWom1D8626w9JaQz/a1LDpTNhZNl8VsmfWSRSKsgsh/GBy
         jN2mnUPlQP0iW3xGMg5VL0vBNiWK9Ixb6OIiwbGiqa55Ors/KciPoOd3FTfq5VFWr2RT
         zOmQXeAi9DR78H43poSet2frolP1ZyCD/ThTwOAl8cFFnr+4tqMpe4GokW55ft5zqlZQ
         +0aDZY59e5qr0CuDd+/HZLndGZ6lEuP4i2xjuOTqePJ5g6ZnpcspC3tqOOA2/+1Vrtah
         /p9w==
X-Forwarded-Encrypted: i=1; AKwUvBzvpaySVOo+OA1hOjjcIDJUk9tfFHI6n/alukqqZnRHyzS2+mIRTQpEf18g2Mi5+XbU4oV5/BigccvWzNjm0gc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHS9G/fAgerCD8/HkSM1P9dsiFzMW6eT1kYUMiNJjNrurUExfX
	YTgOU2gD5lLNHuFGWgH0mJ9YaIX+edMDSUnSepA4p9ex7n/Q4e5wltGeH4t3b3oqPA4=
X-Gm-Gg: AYBFou0V5OV0gFxFbzVWON1lmAaCyFiv7MlKkATLuLqyWaq3YJjY3Tmfbwpwsb8Izu3
	THF0zU5KK6oBhpv4acxyy2dpZ0aJsUslAyLYTh5lWps1S6oGDCIqOMZZtvGWPPpiBA8iTHfq/Ju
	33MHsSqIF5gDkhD5CouKsTmnYmVmQLoSlcrKogPe7TliIbXcGN8WsMqMhMLh6e9kWref5w8zaJ1
	u9revBcqEz3QANwQp7or2GFzzxy3VaY4N7m91TAgGOaHXEaPhaRLDMo67AHMrh4yGHeu5fF5DZG
	6XOusSbCxn0aw+PTvSMdhZyv6ahabl8GFzoQaI+e+YXUYhGwRtqB0ejWQZlQlOJTO86VhyjTpDj
	QJWbpf2WiFYD9Ch8zUE3p4HB9fu/eOMTjJm+h2Il7bICVOU821Sr3vwQMgE6J0f/pWWG53Vk38E
	rAJf7XhOF87dt1VyZBnNxUGtAke61yTcl+hGBoSgIRkTU1QBzu+DikXlpzqYMrPLez1+1NgvAVQ
	JR9ZIoRE9bi9g==
X-Received: by 2002:a05:6214:2b8e:b0:91b:8d97:122 with SMTP id 6a1803df08f44-91b8d97039cmr23749566d6.51.1791818651854;
        Mon, 12 Oct 2026 08:24:11 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97178de2sm659086d6.0.2026.10.12.08.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:24:11 -0700 (PDT)
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
Subject: [PATCH v3 0/4] clk: introduce TC9564 clock support
Date: Mon, 12 Oct 2026 10:24:03 -0500
Message-ID: <20261012152408.3729237-1-elder@riscstar.com>
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

Both TC9564 PCI functions can provide PCI endpoint buses via
devicetree.  Each PCI endpoint bus provides access to one of the
function's BARs.  Subordinate devices (like the clock controller)
can then be defined as nodes accessible on the endpoint bus.

Only one of the two PCI functions is permitted to define the clock
device node.

					-Alex

NOTE:
    This series is built upon linux-next, with this patch applied:
      https://lore.kernel.org/lkml/20261002181849.790275-1-elder@riscstar.com/
    The series (with that patch) is available in this git branch:
      https://github.com/alexelder/linux/tree/outgoing/clock-v3

Between version 2 and version 3:
- What was formerly described as a "clock" node is now "clock-controller"
- The clock-controller DTS node, which dropped its reg property in v2, is
  now a sub-device of the config syscon
- The config syscon is now (also) compatible with "simple-mfd"
- The clock-controller DTS node no longer defines a toshiba,config-syscon
  property, and the config syscon no longer requires a label
- The clock-controller now requires a (parent) clock property
- The header file is no longer included in the binding example
- The binding example now includes the definition of fixed 25 MHz clock

- The clock driver now gets its regmap by calling syscon_node_to_regmap()
  on its device parent's devicetree node
- The clock driver now must its parent clock from devicetree
- Added Brian's Reviewed-by tag to the second patch

- A new 25 MHz fixed clock is defined in a new patch, and is later used
  by the clock controller


Version 2 is available here:
  https://lore.kernel.org/lkml/20261005230927.2000398-1-elder@riscstar.com/

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

Alex Elder (4):
  dt-bindings: clock: introduce toshiba,tc9564-clock.yaml
  clk: toshiba: introduce a TC9564 SoC clock driver
  arm64: dts: qcom: define a fixed 25 MHz clock
  arm64: dts: qcom: qcs6490-rb3gen2: add the clock controller

 .../bindings/clock/toshiba,tc9564-clock.yaml  |  65 +++++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |  22 +-
 drivers/clk/Kconfig                           |  12 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-tc9564.c                      | 268 ++++++++++++++++++
 include/dt-bindings/clock/toshiba,tc9564.h    |  34 +++
 7 files changed, 409 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tc9564-clock.yaml
 create mode 100644 drivers/clk/clk-tc9564.c
 create mode 100644 include/dt-bindings/clock/toshiba,tc9564.h


base-commit: dc44eb73f8da11f478815bc29b6509a6a4c5c35f
-- 
2.53.0

