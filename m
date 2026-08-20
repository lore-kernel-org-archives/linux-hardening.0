Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD9147604E
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247664; cv=none; b=jFx9JDxqp0pkbsHKbnzTUZuyuQvxyaKdN11EbrMigyg5B6Z8703of87r6h42pwaQuF1jCI+d/gXwknQiykzHrHTJqKOHwUj+nIKjUqjXfKxWSC025zcO9ub6n5rxHOFdChgucZ9vgS5Ax7ZUAjTg2otmw9XYq3NjArAQgFKYfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247664; c=relaxed/simple;
	bh=gLnmQZA+aRbh0ERqhM7KIhIwzIoNAiCX0fKU0fCuWxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B3eYbMo5Q/h5WzTyHLBpwxAl41JLVehKUdAzkoSGBVpg3/5SUWAQBGn6HgeRNTflahMfuf2Kb51lBXe9mQnyMnhi1gcIjpnaO0NinQ3UpNKswKbfDzoEtpXmlaoLTWd3usDhThlsrj/28Ju0Ne+OtnOYMo80bMDDvr7wNa2v9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwD3nd+R; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwD3nd+R"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-382ef647e20so64557a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 10:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787247661; x=1787852461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XLwSGdGA3DzI4yH7FfjOEmQTOKN+rrAz8ssaqu6ui70=;
        b=SwD3nd+RXWi9Fpvs2fKeghkxRFYHj8+qtFPWhxtdx9XuPpODUf3d3rhKYy0nM4OrYg
         7uB1GqddYNFZp8k8k9nYKWdg6HBF49HTd+MbpP+gVzM8duEuqGFqfuw7qECVv9fv79hf
         ine7YT1GLoUf8DFdQ1Z2NkWEAhn2TrtpAsnA2Wv/8tuGvvB9Fc4oWgplIpyzByzB107U
         YeFA3h/dPM8WQ92OApuFcACwEYAC9l435N6qujXfLu6u2L6nxvXhx302HBclPrGTSERq
         KWVURZ406yqRg3aMFzQmnC9ivqH6NewaAyk4apgPlmv6AUt1I92kqcLf/FGJEQPnpb1R
         ZOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787247661; x=1787852461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XLwSGdGA3DzI4yH7FfjOEmQTOKN+rrAz8ssaqu6ui70=;
        b=gguZ/CxxLDdOGOiCyB+IFLkI7T1Z1ikAK0/Wen2KJxosuRiKOWO+Z+QzQSSRMn5PZ/
         1F3YOknWgb8KyfUgHA8Xe9JvJYL2Nt8vRB/6FoYstThrIfiZuqRiodAG7OAfG+1JMfme
         BjV1m8tEtfnTNmZ5YeJLov8YMNMWX9CZ1sAEvZjaaPHjPTUD8aQScsGDZa6CJQzFmkkJ
         I2xIDk0BYf+O9fU/+p7BNiOlAEluV8sXnmkRmdjmv5ya/nkDV1Y2PbklioAZexIrPMaj
         vDbZcEsG+ffefCVk+v72MvCxDPAt0jhsDfjBUc9CR3Id+6LrDp1c2LvTtFH7Y3HNRrLO
         +wxg==
X-Forwarded-Encrypted: i=1; AHgh+RoXaMCf8Sw6O7qLyjyPBvq35WWf2SjdbDphFL0ZPJ6LGHW8DI6yv2SAPUzRLHhdhvbUfHYUsIpw315FQePLEKQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mWqj6dHaT6Twbx8hhIpJBQ6jqF5RGcQCyTRv8M3du2HZy3rD2w
	UpcgoAuuMWgRWT7vFiCeGjRkuqeIaCnKRJnytniX1zW1FEWj2t0YM5mN
X-Gm-Gg: AR+sD10WcoSj99m21OB39sWkdMSKuSIgRyxP8oEra1qnkGo1Tl8Y+E0oBRXLqUgaYZL
	2aJmujlvBs/zfiabcbbnKZUp4YsQDIUdSAOwDVkeL9G0Jx4pjGQVfaXlwFUlQfRrHl3tpsuA66x
	g5gJr3/vXILA8rk+DMAY7tM074QaiT/Ztj2fXXEEozoqByAxXorFa9rixDtXBaxD10KlkOLdger
	jCmxC7RGdklvuzz/A8mAjOFv63U4TdSdq7uPebiTSH0mqt9vQtuy7MIcL+jJKAmdyzY18ZqKmlv
	hx33t6E7dh2bcdUdkbRqTQ/E470rHpFXflXhTs+f+a6RRIkGjE34+SPtj0GQVWzkWiCNv82P9mE
	39nikY382tl9gHkFCcxeqnI84hMRxwYyi1DX3ZgIPzr6iFsveC5cKpyqokVvuljWx5PzDD4FGOQ
	K8gEcasD0SgvauVUpT0KivROeq3CtBK3/8oAlVMOGK6bp30s0VajOFKuEoYSQUU6hWZFYVWV3L8
	MYcb8PFEYRk8GLh1j44TlQY4R1k+0C28jM9KSRLgKgv14v3p4rYX7uDNeZHL10=
X-Received: by 2002:a17:90b:33c9:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-395c3552d6cmr267463a91.8.1787247661327;
        Thu, 20 Aug 2026 10:41:01 -0700 (PDT)
Received: from Mac.net ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416aea2429sm17340401c88.15.2026.08.20.10.40.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 10:41:00 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nam Tran <trannamatk@gmail.com>,
	Kees Cook <kees@kernel.org>,
	gustavoars@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] leds: Add IS32FL3207 controller support
Date: Thu, 20 Aug 2026 10:40:55 -0700
Message-ID: <cover.1787247467.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a binding and LED-class driver for the Lumissil IS32FL3207
18-channel constant-current LED controller. The driver supports individual
and multicolor LEDs, per-output current limits, an optional supply, and an
optional SDB GPIO.

This is the LED prerequisite split out of the Time Card v5 series following
the netdev maintainer's guidance. The dependent ptp_ocp board profiles will
be resent to net-next after the LED and I2C prerequisites land.

Changes since v5:
  - Send the binding and driver as a standalone LED series.
  - Raise the minimum led-max-microamp value to 149 uA, the lowest nonzero
    setting representable at the maximum permitted full-scale current.
  - Rebase onto the LED for-leds-next branch.

Krzysztof's Reviewed-by from v3 is not carried because the binding changed
materially after that review. It now supports groups beginning at outputs
16 and 17, documents the RISET/current-limit relationship, and enforces the
controller's minimum representable current.

Validation:
  - dt-doc-validate
  - dt-check-style --mode=strict
  - targeted dt_binding_check
  - x86-64 and arm64 defconfig/allmodconfig W=1 object builds

v5: https://lore.kernel.org/r/cover.1786746757.git.ahmadexp@gmail.com/

Ahmad Byagowi (2):
  dt-bindings: leds: Add IS32FL3207 controller
  leds: is32fl3207: Add controller driver

 .../bindings/leds/issi,is32fl3207.yaml        | 285 +++++++
 MAINTAINERS                                   |   7 +
 drivers/leds/rgb/Kconfig                      |  11 +
 drivers/leds/rgb/Makefile                     |   1 +
 drivers/leds/rgb/leds-is32fl3207.c            | 736 ++++++++++++++++++
 5 files changed, 1040 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml
 create mode 100644 drivers/leds/rgb/leds-is32fl3207.c


base-commit: f8cca63a0a4f3475199d9ab7f86782bdfeb0744d
-- 
2.50.1 (Apple Git-155)
