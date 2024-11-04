Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CB41AC444;
	Mon,  4 Nov 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713730; cv=none; b=X92ifcrUAyXM1HycNZdK4nnqKBj7I+cSLxlApP3S+YW6cksn8DqNjpvPzggWFHX3w/Ais+VuYQ4mW3EStAu9U1VwPMaWbvJ3NePwZLYIOtfzc+YykVJUdDDfV4yaH3cHHp9ttK8ttXr0MVOQWS+ll7cnfly5BXqokUSG/QcN6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713730; c=relaxed/simple;
	bh=A7W7MDEi92BjvLCgszwMOJz8AfKtcu5tgI/KMzjYy8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lKfmjv8A0b34GnJOT8gNtpB7CEcfdzDoHwCVbbnAmlLrCM2BGZVNVviFUhM9eVTKcGCFpe5x4E2tDTovz9XqKVVZ90ump3fnih6p8qY6W27xlqtwDpVnK/rUfFzSlKBq29m3Vj88TQbMEMKsPTo4VcKADV1aloeXCgsvWdT+0tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=RlrOnxdM; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=dJ+HnWEW reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="RlrOnxdM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dJ+HnWEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730713725; x=1762249725;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UuICAiXjI2F2FZ7Bp8hHTJ3HSlAaQYfbOcnrt69ITL0=;
  b=RlrOnxdMompzhRw+ER2hjRIZMxrCBkUmUK4FYGZkBldBAKfsQ2oWXG0j
   rJkd/NHh3Va3xoSa+dv4R2kbX2sQClYi2Yz9xzz+J4/sMya7xyyqIgJf9
   HIHvrJhuglEqUKssVwF+tHjFh3V0WbFTIvxnLVQ6Z5zt2YrwL5cLL5kkt
   HtsrVRxN9dY9+aJpOSfVj8ZVSClI6e7FcVVUth/9ppaAjAJOPzIwnZe+D
   i1jffg/9MLoGe/X/kqExKvRWf8e9xj150emk5ZIqQj9/suM/tGKo6WEli
   QK+sZv9W1EsMXKllert4p2H6laifh7ztgVd+YzANtXiS5cPQq//LVHOba
   A==;
X-CSE-ConnectionGUID: AX9g3WdTRRmwfGWeP6AMEg==
X-CSE-MsgGUID: l8qAhk0iS3eaSMyVNSAXJw==
X-IronPort-AV: E=Sophos;i="6.11,256,1725314400"; 
   d="scan'208";a="39827136"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Nov 2024 10:48:42 +0100
X-CheckPoint: {67289879-37-90CD5875-E0265C0B}
X-MAIL-CPID: 52AC217FE19ABC40E7F5504158A6E480_3
X-Control-Analysis: str=0001.0A682F1E.6728987A.0059,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B0F8168150;
	Mon,  4 Nov 2024 10:48:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730713717;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=UuICAiXjI2F2FZ7Bp8hHTJ3HSlAaQYfbOcnrt69ITL0=;
	b=dJ+HnWEW+KL3hZnB+0WamBID6ucVTyS01r63sBMeXhF16iLb60oDKT0/rsnOa5IgM2dBLt
	rS8XKKA2y2QOQZ59WO0mb++iJTqSQva+HmHG2Mm9WpiFFAEag72VdX2l8s7wUU+k4lBvA7
	Np5fFfEblAUW27tdAKP4h6xos5QWIeq+DBHWN6rtc8DTfIGbiNAmlsrRzmeJ0k9472QQhH
	0ShCiFB+H5c0tjNtdmQ3MDR9NmaAZ5KI/a9Ng9AAXalBv34j9Gy61JRoGk8UTkAS0xqhZU
	LDQPQzKtR6iuANDKrLO+GNA2++8tcxb9e4xUeUNMn5RXF9IuFddx3NAZHafYEA==
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
Subject: [PATCH 0/5] TQ-Systems TQMa62xx SoM and MBa62xx board
Date: Mon,  4 Nov 2024 10:47:23 +0100
Message-ID: <cover.1730299760.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.0
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

