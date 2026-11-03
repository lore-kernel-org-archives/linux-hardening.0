Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672534;
	b=sFVz6O55OCC1DShuzbgLlbjBDiqYOL6AQCiKnVHtSbTI3mar/OrAqYqiSVjXZQPyjZqP
	 RDNQZDw0hStnOnDRWGUBmxHhfIuJC8QGCEqKFRX9lkwHaBvFuMp5OF/qP8KalsCMVBd9r
	 I2QehLSGiss+jGXhcsBPMR1OconutmQybkb0bK/JKErVHgQM74a4eMskFOHb+kcfNrU5f
	 2qwnpPsCU8oTbz3jtFJWP+oko5ebOVp/VX2b27HYB7tsZu48M803S645iZN7Lr/uvKAl4
	 W6hk9aKZLGYqy8BOKQJBhm02TxNBgyhHJNk2jGKzST2CLhLymjLgeitRXMrVX9peR7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r7CZHsFtToEeDraAns18SBV26Wozlx1z/SodGdtdGHQ=;
	b=WoDhrt409sRYVOpaGP0FuaQJgthrWxYgF28RnxdUaJOAtmEBOAEkrEfnCkzv5sOsficg
	 Rl5OQIfIG/mtTcWF9ST58VRnDJASZaUYyJrvfzRqVQNSjL7QEi4ILm8udDUZaRDNWMX6o
	 rCibTIJ9v1aDnwI7K6HljYR++e+3WMs5cEyBQXcxq1RkiYYWUB6yy2ItzF4cKYM17loBz
	 Zc16nKrgGUxvt6Ti8+4EeFajVBtKSwK+6LnLgym8HSpJWU9qn26f3bIdY29Ani8tEfQPX
	 spAsE7/uOnxLHzs5ZI2Mn4ZApcs8D4kIr2BFP6UJ5V9RuJxHIdsH230qCeTcW1LPRXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pcvJJlQH;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F309606A329
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 02:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F309606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pcvJJlQH
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9cf928dc9so1071425ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 18:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793672534; x=1794277334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r7CZHsFtToEeDraAns18SBV26Wozlx1z/SodGdtdGHQ=;
        b=pcvJJlQHlGOF0cpRM0UZePAnDC0vqeuBRizCxvexJ7QOLkN8zL3s4Cjs3WJ/t5DCBc
         d3lY9QkXohvzSDMe3oJ+hXgdx8im/eKScekNjdD5xWcpzme7sOuLYx170dlJIMYZlszQ
         YPdulHvcX71xyKzwLy00njaxlw1cMOFw8ZeSm+ZVYAdo6Ubhj9QafHmSlaGYXtsJpi2W
         902Ac+nkX/bTmhzQd4fdw5AVucBp3I6xec0Zok7FolDgMaPxy6bDM+qClB4y1BTAm5cU
         lSPpWGTzBUxCl1zoIyC8IwHL59W2TLZTBU/801Ml6a5Zxl0hbtaPi+Hb4VZ3RjnC/o6k
         ytOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672534; x=1794277334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7CZHsFtToEeDraAns18SBV26Wozlx1z/SodGdtdGHQ=;
        b=jxnkZjM+1VZ/NGSP6yuf1Vr64r7nhaaEByryDmjjg7u6qLI4LzzjlPZVY3y3Q07Cb/
         EWJ/4TtpK5HfZJ0F/ZnnY0b0psyI1D7ZK/Ztbgf2OLMTLEVQUk7/rX6u+RKiGEke/JdW
         R+teluwVDfXvF0nq1ulxDaqtu+QHgIXgkwkLvvsQJG74bqL9EwEJMOaS7gi5M+FIwcxQ
         h8iGEi9ZuoFfBEdVI1lGlXY2BQrtJpalWbxCE1+TnKkDk+XJ1yxNS+Ty+r0fEuX/byXN
         6Z/LqSq8C/2yWWbS2O1bBAHt1zbSbcanEsdYvKaW3v/R2digamexWcEJEnkeBTd9RBXW
         yh5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzcEEwvO2dVWhlf9vuFAZZn70tQ/DKC0uXXRtCdOGasBhwKQgKzsT29g0ni9MkB7aM9eMhp8j8JAtsU9sR445Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EzwDhfgcJxn3eQb8k3F4TvalysE4kabfRSMZs23+FIEu9K7SD
	a3YdCIqEmDbcHd+vfuxYg+ddabaM57iRliB2Iq60nfxO3dEgMlwEtbwx
X-Gm-Gg: AYBFou3EzwlRXo4ljK6U+LRp9cDauZWDm61T81q+SGR6LWO8vs9x679ghup/JVQt2x2
	/N+56RVe+j/uFpcBzH/we6o7YYfniPd3GNsOuZ3rYOTHKy1pOf52EZmfWm3RljrZBY1G7LJnvci
	0uBIdDzLZHzZ0+o5uOBkpGN6W2d3/4pgd2pDPJlcKyqv/ZzIBg72AqOqwJTDHVqLMNwseXpPAhu
	oYUUjz1FFEuth3OsF0oFl0R7Atq2zSLMo9+4BOGxr3s16KbJX6wdfspBqfM2X6aco3LQViE2JSc
	VtzBCs1XMBxsdDe/kaYDm0WTeB7SbU0lW95UIYtWbYwzjgxHUIdIk9Zmcl85iJqSnHb6/wK0q2I
	qRPHQkZZT1Yq02smM1uqQo2/WXlgHClzY+uKS3QMAEwq0iRiPI5aWn9oveqjiOnLzzpMIYo8Mx4
	JLV3ocjKoealcv2p/V5NLwJRFtAgp29DWOKWVe/zAxfkp+yfPt0gpwJ4eEz7jcKAxZ5cYRwldq4
	8KMa/Bc3p4cfrF8qlI8T3qSIcW5IxDKCV04m1/uu4pNwO78rErx577Z2otMonVPmYANA/ZalSyv
	CsGaOOGnogAzx0iXWVrAd0HcNMTEHXDNYlxWGr/JKREz/UvyZBONGlufkLP49XGwz0yGOSJghCg
	pkQCUULX95Ae+kUs=
X-Received: by 2002:a17:90b:55ce:b0:3ae:3f20:7058 with SMTP id 98e67ed59e1d1-3ae897bafd5mr6113235a91.36.1793672533832;
        Mon, 02 Nov 2026 18:22:13 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7dea24sm1570124a91.5.2026.11.02.18.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:22:13 -0800 (PST)
From: Shan-Chun Hung <shanchun1218@gmail.com>
To: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	vkoul@kernel.org,
	Frank.Li@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Shan-Chun Hung <shanchun1218@gmail.com>
Subject: [PATCH 0/2] dmaengine: ma35d1-pdma: Add MA35D1 PDMA driver
Date: Tue,  3 Nov 2026 10:22:00 +0800
Message-Id: <20261103022202.2139674-1-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the PDMA controller driver and DT binding for the
Nuvoton MA35D1 SoC.

The driver supports memcpy, slave scatter-gather and cyclic transfers,
and a per-channel timeout configured through
dma_slave_config.peripheral_config. The timeout is needed by the
MA35D1 UART driver, to be submitted separately.

Tested on the MA35D1 SOM board with Linux v7.4-rc1, using local
(not yet submitted) QSPI and UART patches that use this PDMA driver.

Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>

Shan-Chun Hung (2):
  dt-bindings: dma: nuvoton,ma35d1-pdma: Document MA35D1 PDMA controller
  dmaengine: ma35d1-pdma: Add MA35D1 PDMA driver

 .../bindings/dma/nuvoton,ma35d1-pdma.yaml     |  72 ++
 drivers/dma/Kconfig                           |  12 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/ma35d1-pdma.c                     | 780 ++++++++++++++++++
 include/dt-bindings/dma/ma35d1-pdma.h         | 113 +++
 include/linux/dma/ma35d1-pdma.h               |  24 +
 6 files changed, 1002 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
 create mode 100644 drivers/dma/ma35d1-pdma.c
 create mode 100644 include/dt-bindings/dma/ma35d1-pdma.h
 create mode 100644 include/linux/dma/ma35d1-pdma.h

--
2.25.1

