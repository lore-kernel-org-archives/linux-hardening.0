Received: from mx-relay76-hz1.antispameurope.com (mx-relay76-hz1.antispameurope.com [94.100.133.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BE8220F37
	for <linux-hardening@vger.kernel.org>; Mon,  6 Oct 2025 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.133.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751407; cv=pass; b=MR8TtqhMtcIP6cx9Dc2r52h2mLZVFt+Ij13cA9xIzTewX/Rkt41jD5efdlo2C+fRuGyUIk2+XfcTbloh+dXDH/0ZzXrOvo4I+2bLz7cfhRImmJeRfyIUu9lMoTxrsrMZyaRT6lLfuW6c/AF3RDWLq10hQQn67l5EOKCJ8ugpbtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751407; c=relaxed/simple;
	bh=lQusUQvXdBnjoaLEEe4P5A98H/WHgUn83QJF2IuKnxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ppOTcL3DAX+zS/QR/uSfUuAIzdsLgZ5fAuBTcuv6fqcJRDnyLownceHNCvH7BSICrDIgNCwoyJiMlWem0s1ULf2umA1bM/hqNUL4ylOg8rAkE2p3qGHEvak9LP0uT4oiyWsD8sLycVi34cS2Hrbx51H1k8kv/8jc0Yc+/T2JOjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=EKX+kZjO; arc=pass smtp.client-ip=94.100.133.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EKX+kZjO"
ARC-Authentication-Results: i=1; mx-gate76-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=Nwv2x3AV2URX4eDt226Z25gIAY13bxvGxt/6sHiSWCk=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1759751359;
 b=i0+B/L7LdrOBdS24CepYYUpxDRhmTqzv3Nidlmlx6+j0qZDmRcoV5WCZGaOXI1Xn4QeMj/J5
 2/4mE9HqKV8tDOZL1o/oZJo9IqO5cF399nhHPSozROVTBrcVUholfuGN3gvAPFIGhGep8xj4rGE
 2FZge/3LU3bV+H3qIkJ0cpdwhEzKZcIQRLtwSnKnQQDkJS/MW4QYeKzeHQZrE/nG1utUUwg8hM3
 paxdQLbXjognpHya+pS6fCG6FXaDbIvhQ+koQXXnjYZSA9gsUeH+i5hvVn9j/LmOYf1fcsriEBc
 PuqEctK0xpzQn6JO2A6U/khwb9m7q37QtUFT6PQBBfdDw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1759751359;
 b=fotrdoj+M1jHTtB4Uq+G+DvlivBXWlOSgEqFZx4dHzbfS8Kf5HwejMeGIjXBv+0/jK/VrX6b
 8Vg4Zprsc9QioVVgrlM/60YmJPy3zbbEHTN2VGNumxVHHzr8Hyh63nz0nG1jwdEixzwdxoefrP7
 DkYObmV2l9g58AYCf2UrI4gCjvByvX21QxdZQ76lL3Ag9KPZGXJiLFrDAwi4NhTPqkPGTkyoip+
 +YRB4peCwHeV9KdUuMpsGnOr0MH9heR3onxyJN82H2J1wEE/K7puj1JaAHW/K2GZxo+reqSejV1
 3RPO2dBJ3R4pRGMhVaIWOTq8NxrsC70s+4zPksC0X/FSw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay76-hz1.antispameurope.com;
 Mon, 06 Oct 2025 13:49:19 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 67843220CBE;
	Mon,  6 Oct 2025 13:49:02 +0200 (CEST)
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
Subject: [PATCH v3 0/2] TQ-Systems TQMa62xx SoM and MBa62xx board
Date: Mon,  6 Oct 2025 13:47:46 +0200
Message-ID: <cover.1759749553.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay76-hz1.antispameurope.com with 4cgHbz2JRWz4LZB9
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:48afd15d2880b31a25c63c7ab36f7410
X-cloud-security:scantime:2.103
DKIM-Signature: a=rsa-sha256;
 bh=Nwv2x3AV2URX4eDt226Z25gIAY13bxvGxt/6sHiSWCk=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1759751359; v=1;
 b=EKX+kZjOLM2wUCr9BdB+tOL1O3oWev6B58uX5U72FE4XY5LaMFihb8oIZX2WTm0Df5fQCqVA
 T4H6Ad/HVQaDeLDs5A4sePeBYnq/6Wj3IN7rJY2y2TamzRu/wvGZq9BH2DggGNnFlM9dgkqK5FK
 oQ9UIfxIBbyBLdpSLSegfTZRr/sYHd4SxU6LbGs0vpmXqIJuoekT0AaBVYfm6Crjw0QnOhNss/y
 X0epGyI7XX/dyhkrJ3Ou/jjA6KOGS89xnZgW4pcSBiKAX58p9qBuL4cbPORaOP2OKrzwPF+5DIY
 P3sQARw912mEaxc59OmXWBMvi4ScbxEvlq9SAX9ZK4/BA==

This adds Device Trees for out AM62x-based SoM TQMa62xx and its
reference carrier board MBa62xx.

Not yet included are overlays to enable LVDS display output and MIPI-CSI
camera input.

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
 .../boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts | 928 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi | 319 ++++++
 4 files changed, 1255 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

