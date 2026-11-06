Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793949195;
	b=pG4qePk2d4nw+L4NlMBa7S0nkHvR8EcW+UF4veEJbDn+foKHdppD9zxqeekZ5ibzzDQc
	 lJSSjo+mHT4IXu9MwOeocdVI872Qh21r2i3oYy9VFNbq5mLQMAQ3YPhp/Y0T+qcYX6fCm
	 xocGPJGeQluX4yNrp9xtGJdSghvVjvfBGULLG2qWfHF02swFzGC1XCs+HXAQ2gQ3eEuoy
	 54Df2lGzwuZ+1snwQ4hjKx49pHRuJmDuEM37/pWdu8a4NB8VVHSorD3dzbXA+rJVPj74q
	 pOkoNgy4bWXwjMxzkpAC8/gT9J3NxKWxmpeXURzPOBYJi+XMs5r5o3a/51VXVo96ybA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949195;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=kh71zvMMt1zTzgPdpRNPd5BIRCWG59enIN8zrZyqd3A=;
	b=XIfgwAAj6D9EEIsXQd3UgUxAepeJvLFTN8nM0b5zK9h4p/dWwQNAyubb0jSuag8l0W7I
	 y6Lwf/WlFvEJ8biuopD9bgZbmnbqCw8mgokUAbpBM6FoslcE4+Cvhe2FpFarbdN/LRSbT
	 LKyH3nJdcdR2hrMRpRNlyEQWzyHpjGxdZA1ih1yi+zsI4MxzUY8cLwWhuazsNkhkSGFQl
	 Rlzyh9F3V38wR+RtX1ENYQTVwQoX0Blx3+l6OYtm05bZ0TdXEUJ9FIz3k+4pcuIXH4hzo
	 f+4wCm/WwiXR/0xQtM+kTnpeFhssbzo5aVyNLKeyVkL/VLZd8SD4wSLhZR6Q5y9NfiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqEc0Xpw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243FA606A326;
	Fri,  6 Nov 2026 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqEc0Xpw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793949195;
	b=Qx49vOjM1+M8AuhSNnO2B5L08/6LhSeu5WoPyZi3rzbrkiVaoLaIVDm0zoi3VSbTIkxh
	 oMzssb4+dIfueSg3OMZGdDAypZ+CBIbfe1fvK2t3Fpu1zK0+xHDMPZ3cydNv340+NlxB3
	 +D2GN1L1ROMo5p2T3A7cEDfBdgkWOxyM9dx/ew8EyRenSvjvRv+f8Z1YBzUU6n2HJ5Vdl
	 kEBDccwVAkyZN35cxybWHDSMvukSDdVk+8pvolM+dYqHHjM4lJ6CgVtDP4yjv1HEULz3L
	 Dk70qLelWKqTV2nT2cMOhmQPnYEyVrlqg/yVwfgorC8iWeVmZDjTnJnX+jJfmODaV3Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793949195;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=kh71zvMMt1zTzgPdpRNPd5BIRCWG59enIN8zrZyqd3A=;
	b=FQAjU8cOxj892vAhrPbgNZOcZDD47aWXnVAiQ5mxXmNIjuuNzQuzxG+J789ZjU1dSZj0
	 6g1YNMnGuAb7hjyF+CPurboW3GNlVj2pCuLpWI9WjjFlhHzM4W+7ySWL62Y/F6Kpu/+5c
	 x8BndrSgVMfMw+ehYtrTEFT3K6PDiWGsrRVKFkix8J12khqcx56wB+w5Gs4dr6CzKmRo3
	 XJUJWuLoyfO/NTWy7ohucEPf53VMXeVmfO21eL2R56KHpc1CB1I9qChbLLn8tdMpZiM1M
	 DkKgcV5wZVEulTp+EpQefbMElkP3i6WG/+fTlWsiYvWrJKuw9AJp4TSE13MecDw7kyw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 659411F0089F;
	Fri,  6 Nov 2026 07:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949194;
	bh=kh71zvMMt1zTzgPdpRNPd5BIRCWG59enIN8zrZyqd3A=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=hqEc0XpwnO+0eRD3xFa9MtqV9q+3fwmOsNGgEmoR+/sZjr15fQNFIbogFrbpAWEQ5
	 zroK5844wff9yEV6HRRItBkvL+FwGtGM0fnXdaEB1Acy1mOfV73j977vURI9MQ38/6
	 BYhjoRIcYyZmP6dBBSY295ZPo411ZonlZyNuL/nGngC4eEDoQWE68NLlvEkCd9ItSe
	 pdhROBlGxun3qCoQaY5v88Ec0+L/9cfpMbN4W6d5f5gZ9lvGsdzAEPnZdfWfaduwuW
	 J2TjINFitvf7GJnZu2QxRg1W6uXt95exBU1sOmzibj2O8QnGGxX/Ptjg+3RCge6v0x
	 7dDiK1NcDJjIA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E5C4D45C30;
	Fri,  6 Nov 2026 07:13:13 +0000 (UTC)
From: Junyi Zhao via B4 Relay <devnull+junyi.zhao.amlogic.com@kernel.org>
Subject: [PATCH v3 0/2] Add Amlogic A9 I3C support
Date: Fri, 06 Nov 2026 15:13:07 +0800
Message-Id: <20261106-a9_i3c-v3-0-804b69b9095b@amlogic.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAN+7WoC/1WN0Q6CIBhGX6VxHQ0QTbrqPVpr+ANKS2lgrOZ89
 8Bmrcuzfed8EwraWx3QYTMhr6MN1g0Jiu0GQSeHVmOrEiNGWEUJJViKiy0AC1UyXioiONQoje9
 eG/tcQqfzh8OjuWoYs50XnQ2j86/lKdK8W6NijUaKCS6YUDUVqmLUHGV/c62FHbge5WxkP5ES9
 hVZEgnwPW8MgDHyX5zn+Q1h54OM6QAAAA==
X-Change-ID: 20261010-a9_i3c-9d5245d094c8
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, imx@lists.linux.dev, 
 linux-hardening@vger.kernel.org, xianwei.zhao@amlogic.com, 
 Kelvin.Zhang@amlogic.com, Junyi Zhao <junyi.zhao@amlogic.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793949192; l=2643;
 i=junyi.zhao@amlogic.com; s=20260924; h=from:subject:message-id;
 bh=ZYd+aUxW1pS5nEymTyy/Hp1Ai+f4jVO3iNWQNjSaLak=;
 b=3nC77Dei5atNTFxEprSTGjtO9TuLbZriwCaKLYoMEBIblqI877Cxzbh5Nlxzbx0RFFYujODAM
 pAHGSwpC7F+CYIcY7IxSdBSFqFM5fyinyVHd7ZUh/j7GAIKnR/A6SnY
X-Developer-Key: i=junyi.zhao@amlogic.com; a=ed25519;
 pk=hiL5PjGIksGFiWvEx9J3MhQqU/ro6vNbj72NIw4bbvA=
X-Endpoint-Received: by B4 Relay for junyi.zhao@amlogic.com/20260924 with
 auth_id=1054
X-Original-From: Junyi Zhao <junyi.zhao@amlogic.com>
Reply-To: junyi.zhao@amlogic.com

Amlogic A9 SoCs integrate the Silvaco I3C IP, but their peripheral
clock setup differs from the original implementation: the EE-domain
controller (amlogic,a9-i3c) takes two clocks, "pclk" and "fast_clk",
while the AO-domain controller (amlogic,a9-ao-i3c) exposes only
"pclk" and derives its bus clock from an internal divider inside the
controller's own register region.

This series consists of:

  - Add a vendor_init callback for the clock setup and an
    Amlogic-specific bit (AML_I3C_QUIRK_AO) for AO-specific behaviour
    to the Silvaco I3C master driver, and enable the existing
    Silvaco workaround quirks for both Amlogic variants.

  - Add the Amlogic compatibles and per-variant clock
    constraints to the silvaco,i3c-master binding schema.

Verified on Amlogic A9 (BY401) with both EE and AO controller
instances. dt_binding_check and dtbs_check pass with this series.

Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
---
Changes in v3:
  - Merge vendor quirks into the legacy quirks bitmask and add
    AML_I3C_QUIRK_AO for the AO variant.
  - Check the devm_kcalloc() return value when allocating the new
    clk bulk array.
  - Enable the clocks before aml_ao_i3c_tail_clocks(), because the
    divider registers are accessed during registration.
  - Rework the probe error paths so the clocks are disabled when
    vendor_init or later steps fail.
  - Reorder the local variables (longest first).
  - Convert comments to kernel-doc format.
  - Depend on COMMON_CLK in Kconfig.
  - Drop the silvaco,i3c-master-v1 fallback and add a blank line
    before the new if/then block in the binding.
  - Explain the I3C peripheral integration details in the binding
    commit message.

- Link to v2: https://patch.msgid.link/20261102-a9_i3c-v2-0-0c474bfccffa@amlogic.com

Changes in v2:

  - No need rework the Silvaco I3C driver. 
  - Based on vanilla driver, adapt A9 SoCs through callback 
    and quirks to handle the variant.

- Link to v1: https://patch.msgid.link/20261019-a9_i3c-v1-0-329d819d621f@amlogic.com

---
Junyi Zhao (2):
      i3c: master: svc: Add amlogic a9 support
      dt-bindings: i3c: silvaco,i3c-master: Add Amlogic A9 support

 .../bindings/i3c/silvaco,i3c-master.yaml           |  26 +-
 drivers/i3c/master/Kconfig                         |   1 +
 drivers/i3c/master/svc-i3c-master.c                | 274 ++++++++++++++++++++-
 3 files changed, 287 insertions(+), 14 deletions(-)
---
base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
change-id: 20261010-a9_i3c-9d5245d094c8

Best regards,
--  
Junyi Zhao <junyi.zhao@amlogic.com>


