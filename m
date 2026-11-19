Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795062171;
	b=ndSAcvsWaqALu6WZyYKNTkLoqzZqxJvxaJZ8dmCQpz2ylTTkiCyG0eJTIYetURp7mGev
	 H/AHvDAuGMQwzkp7cTfW2iLDNPLbE10ROPLCHzZJbim9FevuUkjezz3wWR5sJZqdh+z3A
	 3dCnoss5/G1sVFP1c3XdNdetXfjfBXvTQRXSkwAlYeIltJxvCLMuxWQo0De7XydeuED96
	 fQKTUzcULPCriUuUpepk88qFhRKjvlnN5G00lqhHp+WKXE5e25PH+zXGKWA6QQtXEG0vB
	 dnB1OFceIXvjvC41U8N2TslMj4o2tgp+rb0uQstA1oEKEmz0yvxHuMUp+drqSuKVoJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795062171;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Yv6d6bSBIIv/IerploKHMuR5GZabm5s7nfjxnfDm4VQ=;
	b=dostWU6IiZ9EnohKh17EhgTOQ1QmoxuFopv+8H1mEkRyjaookGH2Y8wpmXjynO1+4yhC
	 ryqOY4+FGiDJKfdUB7eqr194Z+PMaqu9/pF/IPe6eOr1pfEX7tSgDvWrHuTIgkzLqYIzc
	 q/S0xEiFAEyJj7cuS6bQc35JBLVBWLTh9tJy1RQ1t2w0Wpbr26h+J1ly+3cR0qRV03EJq
	 ZX0X0kUdfVTLcYS4VupLKQV1nHlcGk3K2osS1Kwup1nBJkVZ0VTS+zISE8dgq6YQ0D0D3
	 4B6NIiyfFzUcJvYdVdJKNfA2/nOnhCocGhHYOifhKj9yNTxEVYqhAF0VxStu9Xp/B0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOez1qSc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC87606A333;
	Thu, 19 Nov 2026 04:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOez1qSc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795062171;
	b=ZohhETKuv2c9AGcgHgwOXYIFyucFqArrmvFrje7EcnqLnze0BoAIBhHlA4x4YBkLNaRn
	 QUf7tZ5VZe/mPTLTwt7S2t7RN6KlByNyrduID5Dsbf5IOpusk0IRzWT1iE3SpwRwMiRtd
	 xgdPoqWI/Pm9NB59WP0nu4jH8k2XHr3AoxpTZe+V5E/eD6fG4GIvha2kxRrkHhEZdTUIu
	 f/fJYwwcJHJnQSWGLHNQAj6OkCwH1mgZAQjdjjQZ1yRo64LOVMHspwi+/hSdSJbi9yWUS
	 mTZ58qWbYpo4I7Vip/4W0DqFlfJS9RKz1hC8QY5lt6VGBrEfbWgCvchLtUQG37PctuA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795062171;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Yv6d6bSBIIv/IerploKHMuR5GZabm5s7nfjxnfDm4VQ=;
	b=NjNuaRYtLgxMKO8A2fTpk7aoQ/eEeuPttPKveVfx8M4+ezMZpaJh+OtOYp9g8V/dnbmz
	 4Qx/ezcQh8p0bQjNAFuZ05JlORPZt8bo2bPu7jIN+yTF7A98UxgyJNDeb50DiTlZT5mow
	 9GIEl4SRwhWEuni1b1yns61YnrSQGKaIEc7zZkcneOZRXUxbnWn9OOgopSHXvWm63kyjS
	 Qk6L8hJS6Q2WUZk+M6hqekN62L8ryZwdjJrOQzM0NNG7kHPCjPXV7M4wEJg7ChQ7T6P+i
	 jAZ0gF/VRUu16Y52qqPw6lEGGl+QHNIF+MuSePjFQ+miW8jJIKBWF/C+hYS+YdBVa2g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A726E1F000C7;
	Thu, 19 Nov 2026 04:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795062171;
	bh=Yv6d6bSBIIv/IerploKHMuR5GZabm5s7nfjxnfDm4VQ=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=DOez1qScdIAhF+wpQyPSTiXaHmcKfua41dF1J/JMKgsxd3Ur0LYt5lCoMx+Pv/R+9
	 CWoJ+DZ6Vk0XfHAqNsqwWwQjoCA/5h4XzUC309EAUmQBZ8pbeBFDtQP9q4yV7MSq06
	 6FbOlTVs9pbnF1hybIGJPnG8cyCJntXJoYSajssyzC8GWgWuDDxU8tnOMvt2LJVKhH
	 g3PAu1BAnAEayE9ZVOETnVrPKCKRISRqbk9pBO47z0/OrnVQwf/MneiuIR5NG6vlX6
	 wg8X59fKFjmkpRmruVyP4yBoqNw2SY3sfawea760vhFiRo3M44LGZ+8sqKBaFJJSMw
	 g7Q1z7OMGYh1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0660E4B0D5;
	Thu, 19 Nov 2026 04:22:49 +0000 (UTC)
From: Junyi Zhao via B4 Relay <devnull+junyi.zhao.amlogic.com@kernel.org>
Subject: [PATCH v5 0/2] Add Amlogic A9 I3C support
Date: Thu, 19 Nov 2026 12:22:45 +0800
Message-Id: <20261119-a9_i3c-v5-0-6ec51f8fb59d@amlogic.com>
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
X-B4-Tracking: v=1; b=H4sIAJV5/moC/2XO3W7CMAwF4FdBuV6Q7aSl3tXeY5qmxkkg06BTw
 6oh1HcnAfEzcXmk8x37qHIYU8jqdXFUY5hSTsOuhOZloWTT79ZBJ1+yIqAWAUH3/JmMaPYN2cY
 DW+lUKf+MIaa/89D7xyXnX/cVZF91bWxS3g/j4Xxpwtq7jvJ1dEIN2hD7Dtm3hPGt334P6yRLG
 baqzk50hwh0g1QgiF1ZF0Vi7J+heYTtDZoCO7CuZcfAjXuG9gHiHdr6qjdE5FZInf8P53k+AaC
 VN5lbAQAA
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
 Kelvin.Zhang@amlogic.com, Junyi Zhao <junyi.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795062168; l=3278;
 i=junyi.zhao@amlogic.com; s=20260924; h=from:subject:message-id;
 bh=xV4H0o4G83ywiHtiXYg2J/lDkmvf0Uuq0lK84mEN59U=;
 b=ASWcwZgj9n6dw2BnDntV1w4pXAefYU4kmHwXGxCQ7A2VkjXfTmf9bLqUvXPIrIjyFVzs5XuNO
 CEjjd0iNLcGAfKkz/H7NHz4FBgFQ0OMAqIX5vwTdcrAgHhF7tOaQzY4
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

  - Add the Amlogic compatibles and per-variant clock
    constraints to the silvaco,i3c-master binding schema.

  - Add a vendor_init callback for the clock setup and an
    Amlogic-specific bit (AML_I3C_QUIRK_AO) for AO-specific behaviour
    to the Silvaco I3C master driver, and enable the existing
    Silvaco workaround quirks for both Amlogic variants.

Verified on Amlogic A9 (BY401) with both EE and AO controller
instances. dt_binding_check and dtbs_check pass with this series.

Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
---
Changes in v5:
- Check the clock count and name before dereferencing clks[0] in
  aml_i3c_init(); a DT node without clocks or clock-names would
  previously NULL-deref.
- Factor out the fast_clk lookup into a shared NULL-safe helper
  svc_i3c_master_find_clk().

- Link to v4: https://patch.msgid.link/20261116-a9_i3c-v4-0-3d3222b7128d@amlogic.com

Changes in v4:
  - Move the DT binding patch before the driver patch.
  - Add CLK_OPS_PARENT_ENABLE flag for ao tail clocks.
  - Enable fclk before allocating the new clk bulk array.

- Link to v3: https://patch.msgid.link/20261106-a9_i3c-v3-0-804b69b9095b@amlogic.com

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
      dt-bindings: i3c: silvaco,i3c-master: Add Amlogic A9 support
      i3c: master: svc: Add amlogic a9 support

 .../bindings/i3c/silvaco,i3c-master.yaml           |  26 +-
 drivers/i3c/master/Kconfig                         |   1 +
 drivers/i3c/master/svc-i3c-master.c                | 301 ++++++++++++++++++++-
 3 files changed, 311 insertions(+), 17 deletions(-)
---
base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
change-id: 20261010-a9_i3c-9d5245d094c8

Best regards,
--  
Junyi Zhao <junyi.zhao@amlogic.com>


