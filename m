Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183F2165ED;
	Mon,  9 Dec 2024 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737955; cv=none; b=krgfade47AJ+dEkHd2pDihhoALryiTnJaSNXkWsqL3DfqbLccQtQAZiqEShCqV2gMCKHVH9VJNuwCoR1fyO/L9QALMwIT3H3/NN04Er2A0+XJ5uOfrvpu4on5jmIa9aw17Fy5QSkT/zvqPHeF6D157NO7U/Rmp/wVXLss7N5XXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737955; c=relaxed/simple;
	bh=00nYDP+xnBKyfR4RxVnNMHKEhbQmgSGsiAwybbplk/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tyl9DtWG8PlnJ3gE13u7E0GlgHF3IaDpPkktvqKmVizwXs57xNaHRTop4SxWVSZYosIZCXi6r7+P+c0FhhfT4Y5VWmNjGwsQBNOgcVuhTGUE6iH+4zBYvRdeV1v75sJSVUerPUgGuHP2sxI1M7ORAjzKr8mp3VpH2Wt/Js0vQi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=cxm+pIwm; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=bHnY7e2E reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="cxm+pIwm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="bHnY7e2E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1733737952; x=1765273952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FxXlfxmgNpRV0Ehy7hG8zSnkx/0wP9jUGiJf8EVruJU=;
  b=cxm+pIwmWAWonky3RJBdX0NI4PAZiIm50gnph3BGQ8XM+nfzD+SJlaL0
   vDOFz6G6RlQ0FZTU64P0XLTWhcDNpPQD0//AUfPdt/rX8YnPWjNnlP1HJ
   eYPliNZYg+lw7z21w9r0bIodud6nz0hFYybIKZdJyk4Pqa7jG6AclLG6O
   kUzxDf6t9Vwnkugc9x0dep4a+7V1U3Il1+t4AxXyOTjQWsLTdPeYbHGCX
   PzfcprkAgJuMnAGz9gAqHydEg7WlASS0qxLrIf04bxq2ydwgxRnnQtZcZ
   +Pb3eCwKdZ9e5Nv6FQVRWREvsYX6JIk7+NMXOr8h2RDDtFcYMswjSQNj0
   Q==;
X-CSE-ConnectionGUID: BxRCi10GRx+7ui8n8aa+fw==
X-CSE-MsgGUID: vKhLrubESEWcbf9f1qlt9w==
X-IronPort-AV: E=Sophos;i="6.12,219,1728943200"; 
   d="scan'208";a="40481349"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 09 Dec 2024 10:52:23 +0100
X-CheckPoint: {6756BDD7-1B-F5DC7025-F79421CB}
X-MAIL-CPID: AEEDAEE32E251DC926589738C74D6095_0
X-Control-Analysis: str=0001.0A682F25.6756BDD8.0017,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E01451665C2;
	Mon,  9 Dec 2024 10:52:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1733737939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxXlfxmgNpRV0Ehy7hG8zSnkx/0wP9jUGiJf8EVruJU=;
	b=bHnY7e2EPmfgRTgcivshXC5iLJEdMSz1GnJXW6+DBEV5ql4FMDtMuZ7vLVDaTQoVQt3DnL
	6j2miROUabeU7Jet6IrxGpth0k0Z/W3TQLfbJGbqAJPualjY1ey/zheKW3g0s4YVqpXpF8
	VIGbjU3mm3z4E9jTk3j+165sXT4VQ8dD70QhE7LpS6jhFXLcAdpL0pmZS0zRGe1D8QyCA4
	a0Z1Mcm8HXnyd7qkwic5/e2zQVc4bLzSiB08/rrWKCajptZmj71vhYvMc/W6XYiBgc+lZz
	GVs9vwx+0vAjz0ThM3mGTvEz4XHPOIAIT229LvrEfe/NicLl+aQm9GvSWxEVwg==
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
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/5] dt-bindings: usb: dwc3: Allow connector in USB controller node
Date: Mon,  9 Dec 2024 10:51:32 +0100
Message-ID: <06497b8aadc0b5becced274d0a5fbcd808d87a48.1733737487.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733737487.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1733737487.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Allow specifying the connector directly in the USB controller node, as
supported by other USB controller bindings.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 1cd0ca90127d9..2976fb1a58061 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -68,6 +68,12 @@ properties:
         - enum: [bus_early, ref, suspend]
         - true
 
+  connector:
+    $ref: /schemas/connector/usb-connector.yaml#
+    description: Connector for dual role switch
+    type: object
+    unevaluatedProperties: false
+
   dma-coherent: true
 
   extcon:
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

