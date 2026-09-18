Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518B51A143
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750369; cv=none; b=sjE88+aFkceV7OSPrmxO2Hi9+ew6UyYygs3Rb4oaiT3XTlWgxB3yp1w5mdXjY/3m5/ARunkXTX6lOe0QQm5W6P57JmNtJxSPWHtg8Rh0qtsurY+4X1EWH2Nt+0qGtHQMwFiID2yR7NWHwoNQpoIAX+2wf9819+3xphUl+13HttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750369; c=relaxed/simple;
	bh=ut9bu0ogvOe3LaZe7HaU4YRdS8uXZFfbEqCnduNcrb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnFz5vLtQR0VAqYa3CIPWUgZyrGYrNRyWWtSJD7mhx+AUIxTR1m2fMp6+A/08Y1y/i4ZJ7CxYcDu18dwbp0TattWZB/UZpXUjt2oYuoZPXKlB/D0NzOgSab5U4JpIDpXp2xADCwyE1E2LGyIY+AqiAuqa5pPuo4SbK7XYDEoAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=E5JVYXGu; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="E5JVYXGu"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cadeafso73917585a.3
        for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 09:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789750359; x=1790355159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oe9FkoIahCgEzPBuPDqtCAL2bGeR9kc9QC4Nw24cDKs=;
        b=E5JVYXGu57Y/67BCAKxRz5yPwLfPxcgv6/MZt99eSldvuFl7BWxiWIO1RE4Y69QTK9
         UajLCGadRl40RX3VDBkonBYkX1Em3iai0tdjS8rNdfyYc/lXfOmGWqlfL/M10Eq/SePg
         y5L8zT7xvcKX1WcRIQRzukr/w3kx4nHxUNBmr2C9l/jF2D5dkPHGakBzVRPICV5jA9Wd
         wM7s1h03hHoPUrcTuQiNnb6q5+uBqCR07Oexy15x/Osz/3e478tMvJwJDjc6CB0T00RQ
         OkJcK1rjwlLDARKkNzi1/PYoGzdwg3TXYg42fVoPcZfZHl/7XAG2Nse/MIiSTXTbnCar
         wB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789750359; x=1790355159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oe9FkoIahCgEzPBuPDqtCAL2bGeR9kc9QC4Nw24cDKs=;
        b=OtPJXylONFEQ0zWlqlbBnW7hlNvyGvf5DNsNHHomKIdx90XdPfj+oFeF2jwfS+CCKn
         NTMP7yViEMj+IvbNE5fIZvDEOWTe9CwGiK/8BpxVTsHhZ6WISNFDXOdcI/eKyxnU18L1
         h3/HBH+eAtRfp9t3+VW02rVttGUkBgZ9NUGf9Iii6BjLOk/EdIrq13nhu1BNdf1YhuXQ
         we/kLYEofpUyDNKN9mgP96f6y4KoAGug5KZiOIi78bcvqonx5Z91q+tpU71PG6BQnQQT
         k4pj7fw1eC3W0XNqXLRFVa8wi9g+m4j/RUmMb+1sxFa8SmeGc2KDR1MFUSUeVAYl0NSL
         WCXg==
X-Forwarded-Encrypted: i=1; AKwUvBzb+pcBpxehVcdAKLccKFzy7PUxLa+vGl/a9Q0rKx5kAPLeJZylgnqXKl3cjiqCesi47dpBjs8/9B8anOIIPOM=@vger.kernel.org
X-Gm-Message-State: AFuF++kg8izPeqeSpvZSfpcy/nky/KXeKPAK2+tONCcBbT2spRiJBQIl
	eIIYj2SGOEyXnPoKIwqJidiT5IrjEXpgrvRd7/HYFVtWWaQnF+OPf/V27J1YW2ipq9M=
X-Gm-Gg: AYBFou2ni99v7FYwm83Q+8qGMgovIF8FG3lygHY2i+/PXceH0GGhghLAbDUYVmQrXTa
	9vs5b2kMUtJp1gKh+sYDvtJSU2LHAi7uZzCdQP0K+Z+8HYXrOj0bbJU9xP8YyGTaIqtpONalF6T
	jVfIQQ3e39EAP6or70he91vKr1NUugt0IZUl/CnMM+o5DpUlMpiIxIKyrPMcYSBPOcMfiQ1UyGL
	DRlTHQpPmWIAkOy07ECsm4i+3bLyVMKfoHFxdeN/ZUpMk9mgRxJfd7Fiq/8YujgjETRojiqm2+7
	ow39pJ9mnk89whfY/ah/Lv+PST7EGylot3Z8vhmghKwwXH49Q1jOD6oPLmWuHP9h8rRJitsHOO9
	rTsZs77VhZgvyS2rqRpasB3vksYw/yeqTC2Lj4Mjv6rSD9ydxyzsran01qy8ZsdU+5u6KiSnzdt
	tsqtroXl7Nfg+anApCy7MR/2XE+ncebC2307G2aKPbM0QSm9ddIk9wck5vgIe+UQVHAv3O8LX51
	YU=
X-Received: by 2002:a05:620a:4103:b0:93b:d7a2:dd39 with SMTP id af79cd13be357-93bdca3fb9cmr469299485a.73.1789750359512;
        Fri, 18 Sep 2026 09:52:39 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0f0762dsm183582785a.39.2026.09.18.09.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:52:39 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	abelvesa@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	p.zabel@pengutronix.de
Cc: daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: mfd: introduce the TC9564 config syscon
Date: Fri, 18 Sep 2026 11:52:30 -0500
Message-ID: <20260918165234.687224-2-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918165234.687224-1-elder@riscstar.com>
References: <20260918165234.687224-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the binding for a system controller used in the Toshiba
TC9564 SoC.

Co-developed-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../bindings/mfd/toshiba,tc9564.yaml          | 56 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/toshiba,tc9564.yaml

diff --git a/Documentation/devicetree/bindings/mfd/toshiba,tc9564.yaml b/Documentation/devicetree/bindings/mfd/toshiba,tc9564.yaml
new file mode 100644
index 0000000000000..32e73a727c82a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/toshiba,tc9564.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/toshiba,tc9564.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba TC9564 System Controller
+
+maintainers:
+  - Alex Elder <elder@riscstar.com>
+  - Daniel Thompson <daniel@riscstar.com>
+
+description: |
+  The Toshiba TC9564 is an SoC accessed by a host system through the
+  upstream PCIe port on the PCIe switch it implements.  The switch includes
+  an embedded PCIe endpoint on one of its downstream ports that provides
+  access to various SoC peripherals (including a clock and reset controller)
+  via one of its BARs.  A system controller provides managed access to the
+  first two pages of this memory region to ensure accesses made by these
+  peripherals produce well-defined results.
+
+properties:
+  compatible:
+    items:
+      - const: toshiba,tc9564-config
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    syscon@0 {
+        compatible = "toshiba,tc9564-config",
+                     "syscon",
+                     "simple-mfd";
+        reg = <0x0 0x2000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index cf846853fdc79..b2d3257b8f892 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27674,6 +27674,7 @@ TOSHIBA TC9564 PCI DRIVER
 M:	Alex Elder <elder@kernel.org>
 M:	Daniel Thompson <danielt@kernel.org>
 S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/toshiba,tc9564.yaml
 F:	Documentation/devicetree/bindings/misc/pci1179,0220.yaml
 F:	drivers/misc/tc9564-pci.c
 
-- 
2.53.0

