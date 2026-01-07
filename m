Received: from mx-relay60-hz1.antispameurope.com (mx-relay60-hz1.antispameurope.com [94.100.133.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754227FB32
	for <linux-hardening@vger.kernel.org>; Wed,  7 Jan 2026 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.133.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773709; cv=pass; b=JPVWHOrPNjPn9yygt8fGhFfLOrcRe90Q7koKn2bg28IalFbayrECyZVdUc0wWaH48LJk2UGmN4wdwBqv3yoVN/B4H3Ft9Ry5Giy3mahW05GUi3mBjJ8BW6TjADrEQr4PDIQJ6Idt/uiiFsRaUP9J0lqC4qjvD9z5pqVa8gFPksc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773709; c=relaxed/simple;
	bh=7u8exuXQjSXGB/DyVWcwOa1yDoZ2QjCtK0ZqC7RyvUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uh3RRrUC3k3AFII0bQn2pbGREEUYLUtPvQJVR6RxRRYBY4ZhPJDkwbdRL1ReqXvSP2djmamQqela+SOcQisOxNbPBEdF0Lik6QGcnOS7KrjckskHXWouK7sMu8PJrz4qNWXve4BMcY6l56kUUb/f+MP4QT+IRbGt3YyhMtiRsfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Aw0oqcXO; arc=pass smtp.client-ip=94.100.133.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Aw0oqcXO"
ARC-Authentication-Results: i=1; mx-gate60-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=qugGupbuLuQZHC/ObrVWEf0IOnY90j2BdMV7Fr/z0ho=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1767773677;
 b=HwgY/rMUgIXtUD/c/YPJd/I9hx/XZSiuDRIAmsxJiAYZDmLWUmt0w3XKlxhNkK7uqWDkFs+D
 GI00jvgPowV24VjPaOjj8C/Ih1fh1/GDHFuqTvmyLqt8qVY9XSVuN68e4I4GHyXjxgaHhipggW/
 uz7Ot/fwebCOmoLoPdn0Y0Zj0QM0+spOY0o4hCS0wdtrvd++a1on9m4hdsedh8/iWDZpQ55fjtu
 lge9CqoDOoJpHfF12+X/TBfUsoXzo7knekv8/3QZTwSwjK66v9K5Th6zW9QSGY3jdqOAyF7eCvw
 LtJw28RGTzorlu1LQOvjVMFjNiRfpDS0CZAUQVtrTYmjA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1767773677;
 b=qcKgLJTJNlf5n7xSfm1YFcld7+kt7U/Or+2v8eIkR6usv1c1bD/NiF1UW66CaQuP6jT74oy9
 i8S1tef0unD0z4qIi9ABuYmdnzH5TxtoKcUCWawCZXY/xKmTXMj+pqAGkNyNi29THikcsRMy2hw
 WzwXXLzZpFblWETVAP6LJwnGjsVDEoGpash5TRK0ffAWWHTolS+I1zIYrTL8WU5xVbsLOSdzYYp
 T+YIGRH5q2m03Qgl1m4O2ii/QMpnyMnwyJI3TC2H6PhEeb5jDhtc2wj++qoFgU9UQSaNk9zDP+t
 AXIxprnZ0BsM6AhWGBoaEgLG7lN+OBJ/Y8dAZ+Q22l4dg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay60-hz1.antispameurope.com;
 Wed, 07 Jan 2026 09:14:37 +0100
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id B030C220D37;
	Wed,  7 Jan 2026 09:14:21 +0100 (CET)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v5 0/2] TQ-Systems TQMa62xx SoM and MBa62xx board
Date: Wed,  7 Jan 2026 09:14:00 +0100
Message-ID: <cover.1767627010.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-hardening@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay60-hz1.antispameurope.com with 4dmLRL38j6z28w5w
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:772d89e85c1e185e9e888a8d7af96ee7
X-cloud-security:scantime:1.844
DKIM-Signature: a=rsa-sha256;
 bh=qugGupbuLuQZHC/ObrVWEf0IOnY90j2BdMV7Fr/z0ho=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1767773677; v=1;
 b=Aw0oqcXOj9O2fEpo4nouqM5QK838qmYMzbDzx78e70MyO3OXh2KAvq+OEOqEEAYpdWdu7+IF
 di11Mc08LPyFMUfdEUViigCNO1t2Hq/ih5j1h6ARNvdHfOnuC3Vbh2XXJp9o56dTOogNZ3Yv3V6
 nd7Dwc6mWHE+ho41TFSCZh14+98SfyT3HKoc10nJi/A/1+yOG2o3Xc0AOnEfKTURygf/iz/MiYG
 xxAsjsa1HH1pNhcpf4x/yGPz1ocEDBEcrvU3YBFparjheR6rhxLjk3cTdPlB+j1eROsovjcxDjX
 tx2OlWHfKNFfGl8F+Ijfrx6KSfePSiqQ2dNqixXFTx3hg==

This adds Device Trees for our AM62x-based SoM TQMa62xx and its
reference carrier board MBa62xx.

Not yet included are overlays to enable LVDS display output and MIPI-CSI
camera input.

Changes in v5:
- Rebase onto latest ti-k3-dts-next

Changes in v4:
- Rebase onto latest ti-k3-dts-next
- Reorder boot phase tags after other standard DT properties
- Add missing supply regulators in SPI-NOR flash and USB hub
- Set status = "okay" in &cpsw3g, as it is disabled in k3-am62-main.dtsi
  now
- Add disabled 1400MHz OPP entry (will be enabled by bootloader if
  supported by PMIC configuration)
- Update copyright years in new files

Changes in v3:
- Rebased onto ti-k3-dt-for-v6.18
- 3 of the 5 patches in v2 have been applied already and are dropped
- Include k3-am62-ti-ipc-firmware.dtsi, drop now redundant configuration
- Change node name for MCU reserved memory to 'memory'
- Use rgmii-id PHY mode
- Drop now redundant ti,rx-internal-delay
- Update simple-audio-card,name to match other TQ SOMs with compatible
  configuration
- Reference dss_pins in dss node (actual display support will be added
  in a follow-up patch series)
- Consistently use GPIO_ACTIVE_HIGH define
- Drop unneeded usb0 quirk flags
- Add boot phase tags

Changes in v2:
- Collected acks and reviews
- Rebased onto v6.13-rc1

Matthias Schiffer (2):
  dt-bindings: arm: ti: Add compatible for AM625-based TQMa62xx SOM
    family and carrier board
  arm64: dts: ti: Add TQ-Systems TQMa62xx SoM and MBa62xx carrier board
    Device Trees

 .../devicetree/bindings/arm/ti/k3.yaml        |   7 +
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts | 930 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi | 331 +++++++
 4 files changed, 1269 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/
