Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793617549;
	b=YAxn6d3NLppLU+LY35Ej4gb+uB3q5TxF3S7eY6JwRKPoayK96CH+zxSAiV3RN9ff0JOn
	 HwNP3+sPB738e5a7gqmzYYrlnvyqHj1X8Bzk1uBLU/Tki7HU4TUFbxJeBLvDzFaJ3Ufye
	 Ye8azpiVvAvo90dGIvsqqV6/MpmXyg09QVJ/JJkBWkDCJX+cO7siUPbbXzpSx3mp8ZMU8
	 mX27ENVOveghKQz7+OSJcHw3f3hZoIKXL0TM6eh+Fc0wZNKDJi57wsCNmksVIkXh6Tv9d
	 Yt9Gwbc7X8qdTb4B2aa9NHC2qpn8ewYuGEXYfs+cHeyMuda1fKkjAYCXIm6NNPNykKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617549;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=dOrw03ZY4M0Y/JC7nnm0OdrkCVNUcDRGbuVdDy6WXrg=;
	b=q+3M3kLQzcEU23BapwgX2a3+J6gkrelD9tP+q48iPrYD3/ObbW1lHpDhIj9iX5239bip
	 PW/tNBonOkkkGVgLY5lBEaOPxBoDrw5w6BxRq1f+lgsKkF6aedOypM4v9q1C9EH7o0gT8
	 Z0xnl9CiOLa3GuIOQDdGFWhRwQByVyPTBhK0MMO1rFa78CYfzQ6dL8JwIXS2jHl4GYmHy
	 bXAlZdJgLg+KzlvnVweS1BzkBit6CYHH1/3tWxv/GnJtjZox5MlT1j86OwQjXOZJKK41L
	 OWE1EuwBq5A5YTWwFKoZalPDmC3lbgNjmC6VorU1BJTT8q1i6xdkFGAs9ctbmKdE9WQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YvD/ucDp";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D8E606A327;
	Mon,  2 Nov 2026 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvD/ucDp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793617548;
	b=fcb1kxNs4faN8sZ5H0sWR4Fdt02WnNP7/mCQ3WcieawhkwjjdaIfO81BYGRi0gtYTfV7
	 0fMRXfBfQHPDzAaJx6ObX2hNFGwSvM7U3SFzB4XXL7MSb427sEW55XZCByK7gienZoR0v
	 /ThYlFU3hi4j5K3iPKMDwWNTTl1d+rw1cqo+o25yscB7EvURuOUTzoQuBhAl143wKOySy
	 MkJTl+wZpxTCVfotJfZqEMCSkuXZfJA/SAZshIq2oQ4iSisrMzzSEZuAzUhXzBtQufDk0
	 Nm5TDYMmbysbeMRaWHnBn/pp85OqoBURjD4u3TmnppR6cueLCvW5emcZQVYF4t6GE4A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793617548;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=dOrw03ZY4M0Y/JC7nnm0OdrkCVNUcDRGbuVdDy6WXrg=;
	b=q74A1BZx5Qa9QKkDkOx25W6/EE1wj6YnIWRsnAOmihtTT5zNQ5qww82kYA7Vjc907+AO
	 g5voEb0RhPrKCXLElQ9mMHvSLDQf7XueBzU3yWeF8w0fH8EOKitbD4LRL6a2k9EyUx+NQ
	 3ZEtTD+3GFZ6SX8F8YcyRPrUe7JDmhOFv7MApHuKfbTo3FG8DtC3X2OAy9aIFBANCQOT2
	 FY/ciGsCBDFpT7gFzlP6xrkv1wCGeNluaINSpihB/NQtDSlm0yu+KAsxrNC2FwCXaG+zu
	 8boPw3Y8NSM9hEgjn3IWb+fub29cOOrQ8IhwQuRyBswNaINQEigwY82i5wF2ZSc2/Cg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BF3CE1F00A16;
	Mon,  2 Nov 2026 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793617548;
	bh=dOrw03ZY4M0Y/JC7nnm0OdrkCVNUcDRGbuVdDy6WXrg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=YvD/ucDpSBv3rK8itVesUFA6gAWbCc0AUT6TbbSKgOZhUB5ZBSi9Q6fU5nwmP0ahI
	 k3WbDqtZsx+Ihag3GvALimV+jtWw9tzCwnKDjQdnkG2YUPbO0g0r+bhAs5qEWZqrI5
	 wfIi9clTPXNc7mU9/d6kkE82SUStr42Ynx/nTeNYRF1YUIvGq8s8XuKZasgzB4ESit
	 VbbGjhqZEaYUDsRc6Zkq7D4PYRj8CDywmmZ92JHHDHf2+/H+htGykar5UqSuQpMqx3
	 VLwpEGi0C5xMr+BTlrpZ4lxcfMPG8Cd0x5raI3xYLGRV7MY6jDD60rW4qsTzYVv/xh
	 NW31Z4IRVT5CQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1D3E3464AD;
	Mon,  2 Nov 2026 11:05:47 +0000 (UTC)
From: Junyi Zhao via B4 Relay <devnull+junyi.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/2] Add Amlogic A9 I3C support
Date: Mon, 02 Nov 2026 19:05:38 +0800
Message-Id: <20261102-a9_i3c-v2-0-0c474bfccffa@amlogic.com>
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
X-B4-Tracking: v=1; b=H4sIAIJu6GoC/zWNyw6DIBQFf8XcdWkAH5Gu/I/GNBRQb1OlAUvaG
 P69YONykjlzNvDGofFwKTZwJqBHuyTgpwLUJJfRENSJgVPeMMookeKGpSJC17yqNRWVaiHJL2c
 G/Oyha/9n/74/jFrzOhsT+tW67/4UWPaOqDiigRFKSi50y4RuOBs6OT/tiOqs7Ax9jPEHtvKD/
 rAAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793617545; l=1695;
 i=junyi.zhao@amlogic.com; s=20260924; h=from:subject:message-id;
 bh=UJx6v15t+vGPfwRUpHt2I4ZrP80lRsdJGExEg/joTkI=;
 b=18IKIcD3tbqV1AO5x5M/aDMWsCEGnolOANX6OlHDU5VZtiKG9Yc8hSPlxSfaAGD1RSWjtCX/g
 RqH0pwQyVEiC/nAKTPWnya0TuURq6v+ASS1FxJPezuDRnUqKoehW52b
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

  - Add a vendor_init callback for the clock setup and a
    vendor_quirks field for AO-specific behaviour to the Silvaco I3C
    master driver, and enable the existing Silvaco workaround quirks
    for both Amlogic variants.
  - Add the Amlogic compatibles and per-variant clock
    constraints to the silvaco,i3c-master binding schema.

Verified on Amlogic A9 (BY401) with both EE and AO controller
instances.  dt_binding_check and dtbs_check pass with this series.

Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
---
Changes in v2:

  - No need rework the Silvaco I3C driver. 
  - Based on vanilla driver, adapt A9 SoCS through callback 
    and quirks to handle the variant.

- Link to v1: https://patch.msgid.link/20261019-a9_i3c-v1-0-329d819d621f@amlogic.com

---
Junyi Zhao (2):
      i3c: master: svc: Add amlogic a9 support
      dt-bindings: i3c: silvaco,i3c-master: Add Amlogic A9 support

 .../bindings/i3c/silvaco,i3c-master.yaml           |  24 ++-
 drivers/i3c/master/svc-i3c-master.c                | 214 ++++++++++++++++++++-
 2 files changed, 231 insertions(+), 7 deletions(-)
---
base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
change-id: 20261010-a9_i3c-9d5245d094c8

Best regards,
--  
Junyi Zhao <junyi.zhao@amlogic.com>


