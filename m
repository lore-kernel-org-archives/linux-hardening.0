Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794285166;
	b=k3wVFqJy/6SOticTjhCBFsEdVnEZb3x8OM/3LMKcmZdmAR5R574e7sk6XQzm0XtqtDfA
	 8WqSF4Xs3ROczbw4EGE7tvFVxctORjyfEM7BohRHEyoNLaQZoQ01p05KfpM0Zsk+ob6Ha
	 DSDfn/QCwRbYSuajC95thV/1BXCE/KDhHfRUH4972+wvERi9PRurhpRMNG9krM9yTVn5y
	 vuGT4s5xbZxwDGzt/Y958pHJtwiL2x2T9j9aiGRd8SlV3NFEy9k7xk0zVwOySmr/A/wwO
	 l+Mw15hrFmgE1axolVJWkg5H8owI7bDPdx+AwJKPLq0Sv68n0cwXE0S4rfv/GnmoBuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285166;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=lJ5L7CEgpbBamg96wwtTWVDwlCPuj+qiAj900U97JDE=;
	b=hMUYVGIr7z9xwHkTMn0yAJjU4nTw7eN7o3YukC+B5gi5kXslzSOm2lcAD529nrO48cCI
	 APvmOQIaVGQfk/q0UHDvohqGCDXo6Iji+omrDhMh0ArN3DPM/3wwVjTFhWMrCS3BJkuaY
	 lzGHo/5mGLCzOM9rplsRwYyMueblqTwG8g0WqcMu11r9phgYQAlM/jbR17iruL4dh91IY
	 QHPbSjX/o+m+JKSB0W4l7V0FSmaoHuxySqRfGV1MY1U0ZYr1m39g/R18sIod2xx4etlH1
	 1cE99lmukPquXXiy2sHFzEn//aGHAkzoPu59/Qp7UeC86X39oj1O0GSizoVSODroq1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvofsAKJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED751606A325;
	Tue, 10 Nov 2026 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvofsAKJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794285165;
	b=vSRc2MDPmOeouYDlyXKd2mbUIdppqhvo1CtKS4dUZ9TEO9oUjrPMUlRASOcR1hKmf5f1
	 Crwp4vPVUuD2oL1Uq3ZxZPLJp1+z+fQ2+T4RpY0DUZgp54nNZDHutzpTVv/gyugOO8Gea
	 SucMt0hz0yQniHxtM+AGnHs//o+x7M6kzRnmr7EXTdaiL0Yc+oCe4SfvmlKCKIe00NTah
	 k/RFdPbL/Ai3JjSdZHnQDxQE/rG271hJkHuJks5W7xbUThIJtj+WeGJycBw2KzKMpqg4g
	 nZlfm0b2KaylOpaNKT5+aXaJsmUvHMYv5GbEIIdo2MO3vLWuR48sEpaqvZZmLCTrwyg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794285165;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=lJ5L7CEgpbBamg96wwtTWVDwlCPuj+qiAj900U97JDE=;
	b=t02KgjNfwnyqefRMEMAovHBcUAqn795HU39tre/T3/BdNT6FuymxdZjHCX9JWo4fTj05
	 utM9lfWOnZY+fZSeaQLHYngHzebXjRj9RyItFJP6OJb8w0I3ZntBb5YHvlXs2eydrdUvX
	 bflBnreIBbvyU1wkBWtt9uCfCzOqa7x7OteHCIQrIcDeLzHPR/ucH6SCFb/AFpPtZezCf
	 PogniAFaeGMBZdZNfdU77Mr+yLsGPe46YfGBZTBRRFIS6npnizEgVlgbNpNVUcNSmWhbB
	 ptQ/3lLyHyjjEIJ89dUH/jQ/JiDXNmaQZ+JGtLXKkbtAvndQpz6KBhk4UaVbTL/tpQg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 16EE21F0089F;
	Tue, 10 Nov 2026 04:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285165;
	bh=lJ5L7CEgpbBamg96wwtTWVDwlCPuj+qiAj900U97JDE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=IvofsAKJD50dfqwwh8ez6zpVXDq2eTgBtu+a5OpD1dzbUKZB+tr9XF2AUN7cwp3QJ
	 9Rzn5lurL0iNxpt2nkxqam0FhUvvBA/saLFYEbn+K3h2+8pAS+5z9NPTDsvCmc/9xQ
	 wGTTEL/QfvhzFJOpY0MV4hbVz1o0MBdtFOI8BR3ws2XrWTgvXgrwyXwlTAF3opSQM1
	 PtJNra9UeR97n46tz6tCTq6gN01zQx66ZaQL96lKGl5GF/5AXaEuawIwfzhuuubBe7
	 rZVgfH/uj6pfmFOovZovHwI0uIO90cymKblurDtE58k0/0e54rC4EL4oYF7DCVzK/3
	 SGoOo0CNpskpw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7A2E04884F;
	Tue, 10 Nov 2026 04:32:44 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Subject: [PATCH v14 00/14] gpio: add Ambarella CV75 PL061 support
Date: Tue, 10 Nov 2026 12:32:25 +0800
Message-Id: <20261110-cv75-gpio-v14-0-e586aad0467a@ambarella.com>
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
X-B4-Tracking: v=1; b=H4sIAFqe8moC/23PwW7DIAwG4FepOI8JAy5hp73H1AMQp2Vqmwo61
 KnKuw9aTUumSFwM/n6bO8uUImX2trmzRCXmOJ5rAfplw8LBnffEY18vmBRyC0IYHopBvr/EkSu
 lehOgHwiA1f5LoiHeHmEfu2edv/wnhWsLaB2HmK9j+n5MK7b1/ebCM7fUY7ngutuGIDvrtO/e3
 cm7RMejew3jibXkAmKGAWdL1afq1UCKvAJ0iKseZl6KhYfqSWDnHYFFA6tezr1ZeFl9kBIRtRA
 E6/urP18DFl61/w9WAWhyUuj/fpqmH6leRYi3AQAA
X-Change-ID: 20261007-cv75-gpio-333d7c1dfe11
To: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
 devicetree@vger.kernel.org, Long Zhao <longzhao@ambarella.com>, 
 Long Zhao <zl020895@163.com>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, Chanho Min <chanho.min@lge.com>, 
 linux-acpi@vger.kernel.org, Kees Cook <kees@kernel.org>, 
 linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794285162; l=3845;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=hmwRhAwOQJERpqRYoCVynFOKAyLDk16JB4f8XUUoDj8=;
 b=h3+5ODRX6nWu5dlFxXml1metUGEOTL16pLIa0yxWO3XH6RlNdjfHHvoSICKluqkKTY57HupDc
 E8LBtcJHkeEB9rQRJ5vpeIbxtgGieB39KwMHMLQeNoqSxmsKceix9+Z
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

Please take this series through the GPIO tree. The quirk, the PL061
conversion and the Ambarella layout belong together.

These patches convert the ARM PL061 data path to regmap, then add
the CV75 layout. They also request ACPI GPIO events for an external
irq domain, and remove the gpiochip before tearing down its irqchip.

The data path uses gpio-regmap with two layouts, ARM PrimeCell and
Ambarella. ARM PL061 sets GPIO_REGMAP_QUIRK_SET_AFTER_DIR. IRQ stays
a custom PL061 irqchip, attached through gpio-regmap. regmap-irq is
not used.

Tested with lockdep enabled on the CV75 EVK. The board boots.
gpio-hammer toggles gpiochip0 line 26 ten times, and gpio-event-mon
on line 27 records alternating rising and falling edges. unbind and
bind work; the chip re-registers and both tools work again after
the rebind.

The registration error-path leak fix is already applied in the GPIO
tree as 80415a6ff295 ("gpio: regmap: free the irqchip if adding the
irq domain fails"). Apply this series on top of that commit.

Changes in v14:
- lib/string_choices: add str_rising_falling() and use it in pl061. (Andy)
- gpio: regmap: keep removing the gpiochip before the irqchip. (Sashiko)
- gpio: regmap: rename the SET_AFTER_DIR subject from gpiolib:. (Michael)
- gpiolib: collect Mika's Acked-by and move linux-acpi below ---. (Mika)
- gpio: pl061: collect Andy's Reviewed-by on the IRQ logging patch. (Andy)
- gpio: pl061: collect Linus's Reviewed-by on the parent local. (Linus)
- Link to v13: https://patch.msgid.link/20261102-cv75-gpio-v13-0-4f93114ea204@ambarella.com

To: Bartosz Golaszewski <brgl@kernel.org>
To: linux-gpio@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Long Zhao <longzhao@ambarella.com>
Cc: Long Zhao <zl020895@163.com>
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
Long Zhao (14):
      dt-bindings: gpio: pl061: add Ambarella CV75 variant
      gpio: regmap: add GPIO_REGMAP_QUIRK_SET_AFTER_DIR
      gpio: regmap: remove gpiochip before tearing down irqchip
      gpio: pl061: drop redundant pending check in the IRQ handler
      gpio: pl061: convert register access to regmap
      gpio: pl061: use IRQ_TYPE_LEVEL_MASK and IRQ_TYPE_EDGE_BOTH
      gpio: pl061: use cleanup helpers for locks
      gpio: pl061: keep the parent device in a local
      gpiolib: request ACPI GPIO events for external IRQ domains
      gpio: pl061: switch data path to gpio-regmap
      gpio: pl061: add Ambarella register-layout variant
      gpio: pl061: tidy up IRQ trigger logging
      lib/string_choices: add str_rising_falling()
      gpio: pl061: use string_choices helpers for IRQ trigger logging

 .../devicetree/bindings/gpio/pl061-gpio.yaml       |  25 +-
 drivers/gpio/Kconfig                               |   2 +
 drivers/gpio/gpio-pl061.c                          | 548 +++++++++++++--------
 drivers/gpio/gpio-regmap.c                         |  24 +-
 drivers/gpio/gpiolib.c                             |   9 +-
 include/linux/amba/bus.h                           |   1 +
 include/linux/gpio/regmap.h                        |  14 +
 include/linux/string_choices.h                     |   6 +
 8 files changed, 430 insertions(+), 199 deletions(-)
---
base-commit: 34cf6dafc47441dfb6b356a095b89c3585a93714
change-id: 20261007-cv75-gpio-333d7c1dfe11

Best regards,
--  
Long Zhao <longzhao@ambarella.com>


