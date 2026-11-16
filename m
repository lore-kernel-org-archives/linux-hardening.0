Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794826177;
	b=4j2dbnPcyAvXszHQCDj79n5MoWFskj5S4otpISRVsdrifQqRAXBBeks16UL831kxuZWY
	 N1yydoCzbGQN03m3vINwIsiK3e5138iCN7BEPHmAQXIzW0i+h4MF3HdpFTBpMTH/mPzly
	 bp4V4oeiV3gO/fxu2vZZjDloIHitSnqzorgUebO8apu7waxQQYJDGDX4vv1XYaTPUHYWW
	 gpHIvJnc40c/7dnUmTKmaJkqWiNbARGIal/ky1MuGC4r4sgXxbb1lwlIbcGeTLKQcRfHq
	 9jVdRFU4gLYZUJ0BwKC1MBcYdEisHC5NKCBv+aM7qhyge0goln4s5ZKIMbK0u9QcBJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826177;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=9mEt1ki6LJVDYJ303Gf1hVtG0akuG6QKkchh3nXSXkQ=;
	b=xcsgHdnQjdj91dZx2zfA4CzmTdU7uewUIQzReLic9YzxeuITcZtVxtb+/c2oyQRVWelk
	 Pq24wjXqWJ0qXe2LBdpJ6QxIArKsXJjOiz1fj+/27tAGUs+EDwtpRCUWvNos72KdoUcLM
	 ZIlXVFkaNvOsmsK+O+D1iA4xkot21oqvzh8u29MrgV2fv1E2WtjJE5Yi9B+zDymr7Vxo8
	 6gva6dJ8qrWxlnX98cmbpXbMP+enNq19Kbeuvqgpe/avXX7OPIKxeP7VNXDYOdRqNgtIh
	 k7kitMsxL4/MRvYs41vs28BVKpU/+Tkrt1HZbcxqpr+6dWAx+kbOOLxw1oMjHXS29ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8Lxn8QD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516A606A332;
	Mon, 16 Nov 2026 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8Lxn8QD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794826177;
	b=J6MCTqGwWq7/0fbVfny6G+ItdMqjZXSpPyX0yXrjikmg9XtanIR7l7uZpDSqHVFFIhjd
	 Yfw+8J6loEeetf3qaj8J0rz3EEUEyVHT/AshFsly8l8mvFd16qIkq7kZ4PWoTw4KS5OSm
	 WSpUJOMPeumCThkds+XJnKIOGC5pmqh34qkOlin7laJKXKV/aRtUqC6t2Ap9PCr/7vIqu
	 GcGGuChL0Mx/z4mPF7eCLXM196mENk/ePt1O5xdkinMezgQeGIyA+3n8S/ctxdUDYilS3
	 /1ZxtCdxkk/eaWcmvoOqnJJzgPSBjhRJH4Eh8gUeL3sswDmRhZZu1ht79chM6o4+UOg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794826177;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=9mEt1ki6LJVDYJ303Gf1hVtG0akuG6QKkchh3nXSXkQ=;
	b=l02vd+FZQlrdA+2sPe9rRJSeXnFXQxbMBieAzjfLcWhx+WMhUgWuUyN2+GOYmUlL4OUm
	 hTxXm5eF8VNLBnDD2nnOk6j+5uUdyMT4CnDFGW/iAeHBpPZhtYqbZTsa2TX1RPLCuZN84
	 k8MOp96En6JrfNQxBBLVkhNMGElyL90Dh4pQtpQid6ItRb3wpccWlVF85j2X1J18N1WwN
	 Ovysqo5KMXGp9qID9sqqsyCerkA1L/aq9kICZmPSG/vaWdG7hlleV9gxV/SfAu91Pqb6p
	 D9RDf/xWQkVWZAcRh2LnST8rXSq66+yAqmRThr1H4ksmc0YF+MuS9Z9dNImv0VG3YdQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 154551F000C5;
	Mon, 16 Nov 2026 10:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826177;
	bh=9mEt1ki6LJVDYJ303Gf1hVtG0akuG6QKkchh3nXSXkQ=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=l8Lxn8QDQO/lqPQstct8KiGbhqyEhfhaVTi2Sck5ph+ZZQY9HfEXty9oVs21OOg2h
	 O36jG77HiAQkdDFasCACjcH693qSkdyxkgxck7ZVPAxvA5GPbO5Po/iuCzQQRHZ0Yd
	 zt+mbmuGnCGoCtkqSQVD0RXw7w2WlhDhIBvdIFb1dJ/gcQvEX9EWyrIapi+0zZSefW
	 Vqv77z02uyhUdNxMb0Pi7KLD7tHQfplCwAtoByIygI1cZiFalkZnp2wcoupQvwBFkb
	 50jjwaPJG1G34m65/QHY69tv10GM2Z3hzDYAEpJIGgCZAANvaDmF+u+FCM/rz1yS90
	 xizBe7IDqzlPQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 684B04A429;
	Mon, 16 Nov 2026 10:49:35 +0000 (UTC)
From: Junyi Zhao via B4 Relay <devnull+junyi.zhao.amlogic.com@kernel.org>
Subject: [PATCH v4 0/2] Add Amlogic A9 I3C support
Date: Mon, 16 Nov 2026 18:49:28 +0800
Message-Id: <20261116-a9_i3c-v4-0-3d3222b7128d@amlogic.com>
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
X-B4-Tracking: v=1; b=H4sIALjf+moC/2XNQQ6CMBQE0KuQrq35LQX5rryHMYb+tlCjYqgSj
 eHuFgyocTnJvJknC7b1NrB18mSt7XzwzTkGtUgY1eW5stybmJkEmQsQwEvc+5Q4mkyqzAAqKlg
 sX1rr/H0c2u7eOdz0wdJ10EOj9uHatI/xqRNDbxrFabQTHHgq0RQCTS6F25SnY1N5WlJzYsNsJ
 z9QgJyhjBBIrZR2RM6V/zD9hvkM0wgLUDpHjYCZ/oV9378A3j0XxSIBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794826174; l=2920;
 i=junyi.zhao@amlogic.com; s=20260924; h=from:subject:message-id;
 bh=tEwHdY6mdhTInElfOAdG6vOt9+cf0Vk0A3dk5bHZYZI=;
 b=pc0or0fzYVQZI40xYj5aVT8xvcrZ6X6fqq6ehw9PkNRbWdB9Ln5BaE0MLtADdfzTQBfvy1E4s
 OF46/MSZkB7D8DuOJSqWIrGKGOGPSZn7bhdA0IIs1jLdN5iuzBdZGqM
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
 drivers/i3c/master/svc-i3c-master.c                | 276 ++++++++++++++++++++-
 3 files changed, 289 insertions(+), 14 deletions(-)
---
base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
change-id: 20261010-a9_i3c-9d5245d094c8

Best regards,
--  
Junyi Zhao <junyi.zhao@amlogic.com>


