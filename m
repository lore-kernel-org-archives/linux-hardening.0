Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FD5217665;
	Mon,  9 Dec 2024 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737953; cv=none; b=kuMbDWkNgObCHuoTnbxWqtv13yR2Qf5/6FHLP5qx69bkpVvk3FeMtdkTb4L9K+k3sG0979FTDHiGsWgG3noq58U8Mp9LjWGRzF5CrIp6cQE5tPVDLmSHlCvwB7DwoU3yo+/cIBb1h2q5fXZ1AuwaAoJ9KZBPXc3CrWuBrJqBRG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737953; c=relaxed/simple;
	bh=QK8t3doX4427AgFW5c7+ZlsJZTM8e5QQTn7PJ3MiCe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k+3253jqE+RdnhAMb3vWcfltLmYYbqVLz3Ww+2tZe0EnrCmCX/ADq7oqIY7jobxXEbRN/PQwHE1FoNinwTeMwkQauW1QGq+ceR3IeygMRULXLA7LRJFoKcE07KGXAi10XHeYUD6UQhyAW0ocQJTSdK+fY7gVPFcGEu7jcdfIiSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Ky3f6Smg; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=DnwjRk2w reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Ky3f6Smg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="DnwjRk2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1733737949; x=1765273949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vCOSzguE5smY7X3uU2S+cYXVmp6ep2y6ONwY7bkEaQw=;
  b=Ky3f6SmgZPkaZcXS6GE14gCBbZllQzGQqHHj3M9eLslsE2Ph6sjMrBwX
   Lb4R92qqMWle4LVtFWD4aR/uxcPEzVY78evxSU4ERQjUzPm7/ayw6WRtJ
   QOWKMnKL9gyS6hlyW8GJN2UHK+/WhbJLRsF0AKRu5WTVU3HR5GYzEnSTG
   7IzjVLPP110bdDyFk6Ggsa/t4UutrVvgnkbJjmTmFWlWHYTwSezFyXz5s
   9uPTFTcM4nvOszpKnXmxUsUVO5AGYgkNASHNkiKlBYed+KOBeCNGvsYbs
   Pp2ZvrCi0ADJviSBhV9AgNtdRkmqQSsNyjpGzRGNIly81+eU/Vmk7NjQ5
   g==;
X-CSE-ConnectionGUID: v0l5HM21S0CnAgO0ZCZRJQ==
X-CSE-MsgGUID: OSL/ddO3TFOKicyZEhfkqw==
X-IronPort-AV: E=Sophos;i="6.12,219,1728943200"; 
   d="scan'208";a="40481347"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 09 Dec 2024 10:52:18 +0100
X-CheckPoint: {6756BDD2-E-90CD5875-E0265C0B}
X-MAIL-CPID: AFAF0358426999AB480C9A5F2119583B_3
X-Control-Analysis: str=0001.0A682F1E.6756BDD2.0099,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07F92166523;
	Mon,  9 Dec 2024 10:52:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1733737933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vCOSzguE5smY7X3uU2S+cYXVmp6ep2y6ONwY7bkEaQw=;
	b=DnwjRk2wR1VQQqxBHqHzNiqUe/HKDqfUgY1FMWDuGH867ZxfognDBfaBja1wyfmp2I5aE8
	oN1rjIwFBUFM4EnhHfMc0gdCdb+zf+IfM+pgi12xz5d2VzJCNefLWjJOhbm92ESQeRkRvS
	KouPrHTSKfHRZCDIH6oJA0gPHkWeri1k+J4We6IWoyIFOuIxQhnOUR2NuM6E/cmhgbupJr
	kZ/e1adfUbe+Nt1MmyZwyOPLPROXJZFr0YkafnpUy62Y0CahM2ULN1euVQLkOKloee7v+6
	PzgHu7+2wRG5MRmwYvBpqaKTf/kycHvvaaLAd1YfUp90Pwn87ZeopqAhHbbckA==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Felipe Balbi <balbi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Devarsh Thakkar <devarsht@ti.com>,
	Hari Nagalla <hnagalla@ti.com>,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 0/5] TQ-Systems TQMa62xx SoM and MBa62xx board
Date: Mon,  9 Dec 2024 10:51:31 +0100
Message-ID: <cover.1733737487.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This adds Device Trees for out AM62x-based SoM TQMa62xx and its
reference carrier board MBa62xx.

Two of the patches are adapted from the TI vendor repo ti-linux-kernel to
add RemoteProc/RPMsg support for the R5F core. A similar patch has been
submitted for mainline by TI themselves for the closely related AM62A SoC.

Not yet included are overlays to enable LVDS display output and MIPI-CSI
camera input.

Changes in v2:
- Collected acks and reviews
- Rebased onto v6.13-rc1


Devarsh Thakkar (1):
  arm64: dts: ti: k3-am62: Add DM R5 ranges in cbass

Hari Nagalla (1):
  arm64: dts: ti: k3-am62-wakeup: Add R5F device node

Matthias Schiffer (3):
  dt-bindings: usb: dwc3: Allow connector in USB controller node
  dt-bindings: arm: ti: Add compatible for AM625-based TQMa62xx SOM
    family and carrier board
  arm64: dts: ti: Add TQ-Systems TQMa62xx SoM and MBa62xx carrier board
    Device Trees

 .../devicetree/bindings/arm/ti/k3.yaml        |   7 +
 .../devicetree/bindings/usb/snps,dwc3.yaml    |   6 +
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi    |  24 +
 arch/arm64/boot/dts/ti/k3-am62.dtsi           |   8 +-
 .../boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts | 917 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi | 346 +++++++
 7 files changed, 1307 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

