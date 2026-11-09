Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202147;
	b=qcOWAapY4gDC3MTuW2+3YQiCjF2JXqlgqd7zgIHTo1STp2SPuSSneprM4J7rX/owJVHE
	 XsLcU7rdDNpAlzWeFu6SwWl+PV8GJLa/AffNG8L2kTgaOnzSUeTqoy8Z4OO32hwxitJQP
	 kZjhB2CIOHMyfZs/Q08YALVnvGUrPr6/BycGFdEzaCsn3nep4h8/hNWbYf1Z7hjzTGz3P
	 tAEeRvzmPOJBAHsNYg/HHfPwN8OM/nn9ktPdG5Td/swbdMfWWuFTGnRBn77m6cvaT1i/z
	 /wlcfSvKjv1E1NWYkU/aIQqcvEc+jZXy2dVBh4+IBIuVD44UFLHSu+vWcAuT2fmfYBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v/+iqzE3D85GzraKFwMggPSN+1bOaRD1qrvalwGxknE=;
	b=O4J46iPbWK0WZjyD5wqUhW2tIXtPqc0PYU4AV/4WO1K09nx9XhGOxnK8UhkYJbfdF4Xb
	 /P+nXQhUYj0r6Egy2UyINtLu92A2Mkogbur9mjEU/BszO91k68GxnRcmHAeUTRziAS4oI
	 F3aWw7MueDlWN3Tpu9zgkKHm+OGyIzSuTcmLrwfsb/ZLhcCyobR3vp6hZ5SYOh8JnZg7T
	 adx01dDz97a6LFLDSSk2Q2ra0WfrgoAMOVcE9XnBtPbgZWi0BsriBVeBIe1aNleIBN9/6
	 bFEFVPWbqLIo2UC1VZr04GCf1iniHZGbpVZBPzoGUkokJ4jMFrp8qgoaFG6nc0u6l+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mAO8/BpX";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB19606A322
	for <linux-hardening@vger.kernel.org>; Mon,  9 Nov 2026 05:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AB19606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mAO8/BpX
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b1015a4259so311832a91.0
        for <linux-hardening@vger.kernel.org>; Sun, 08 Nov 2026 21:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794202147; x=1794806947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v/+iqzE3D85GzraKFwMggPSN+1bOaRD1qrvalwGxknE=;
        b=mAO8/BpXwOeqG2k5o2qTSWD87qR0fy8I2rHRO/KQL7ZsrY/kMN7Pa3BjGSLFr9pF5X
         nHF1LMETZjVkNH6LfnvUoOJ+lDKgSFkThlp4XrZgWj8vdoykCiCx58M4agfvf2kx2OBF
         MczxltN5kEnxYvkbsgMHeC3Cxd0JV8KBo/YOe1kFBVv1zXLoqT4GKQlbiBDcnRcdNsun
         ZNiCdw4je4YmffE/A1yUJEdeVTvmNJgMr7pqzoJkeUwfP7sxUZ0Sft5x6uZruQ9eE/aJ
         xM3flX4ZdsA3hVk0dAXD3HW82CrwQAEG/MZCcMg+/dxnwIfeIiYM+wWlSfPGDdqm+yzo
         8fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794202147; x=1794806947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v/+iqzE3D85GzraKFwMggPSN+1bOaRD1qrvalwGxknE=;
        b=og1a+E2W+1t70qppTw7ABSbiWQBpY29E4hVAy0dJmi3fo/xPMK3S5CIQdHxhPHzN5J
         kQty50KuJe8ySR+OGvFfgMHNO7JQekcdfHK92BmQdEbavzhvDVUWwOFNwlJQSmZLTuET
         meeXq6bkhP+Ztm3s90ETmnvtbZQ0NRSGy2U7YKEmSkgM/diAow8hcxvh7uNFc7bCQiwJ
         kzf76DfEfR8ObQD9vypMp5kthFRivr3yZ/omgeZo8HIQ1PBL6l2J3zEMwuF/jFb4FB63
         eXQZvvK1ocDJvDZP4pHe4ZfPHbNr4A6Dvxv23zZJtvxzms/PopfsO++VibGk7likBjir
         QHmg==
X-Forwarded-Encrypted: i=1; AL+hErHp/TQnqvGCxTQAzDqfRoSuexMcXrTs/dgZDcNmnW3qDrvpFugiBweTmA4POIa0GOyHm567C8yE6A0e4flJzRs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+jxtqFidERXOsBe0gJ+5M9L1MrU07yBpoA4hj0tcen3V/BUPi
	7njmEOlxV9/276JLTKoyMljFi+JSS0jM7NNRGPPvSm4qSgLo8mXDVr3k
X-Gm-Gg: AYBFou05YBjB2JkoqrAf9F/jF/E5EvgxLT+ClzhyExQYcQ1gQpOgqjykOs0edMDb91H
	qgT49QVB1RDlMY/jrJkpSS6HrkDOVgt2+MVbH/jbuxDxEjNVxkaP1iofKT7MwAdTI7h/6AioQfh
	kRQOagwhoe8AJMd2EDoxxkR5ReksP/FH7wh+PKhyKwFBpZrJ1BPTyeCs0nRzyyNc2eHIAor34lr
	f3T9SIsJSjMFyGsk262o5ijkLPyMXfsRvdFe6iLONugmxIQjzmmkTpctDYFPmfIcXP3MLp8lxKF
	fSzgtuR0rSqVnjaix0H3jbQRs3RmiC/BNRU7Uz5oVIeSLsO6OLX1cKAHRQi+56tJlMBc9y05hBs
	iEPVMetJs5O+RXsEFoWKnV9QdZEM75p7wj0mbDaXkudkIK6XM9mWXsUQSn3v4c+0VymdoagUMZL
	zwLas4y8mroaQbGHDJSPbBpaKADp2hKEg7hpd16IhWCA+0PadbnXv1oTPJwe9mEUPtTnQ2eTRZ+
	dR4JD3lJiDmWP4yeWGXXfviQSe2wZJYQYQdQ60vl5eWM/TSjOzVvQWCB+cZhoege4I0TxUNhfci
	MRFnabyyO641LXuRYsizy28gGUqy8uflf67xX0vm6Hgc1zFZEeBSJsUNpJZdvNqhEJzddLWTfjt
	5yVeELT/bBhd4+IArNPVR/qOOFjyiwa4UkoMf
X-Received: by 2002:a17:90b:4c88:b0:39e:6d82:dca with SMTP id 98e67ed59e1d1-3b12d442907mr2821498a91.30.1794202146776;
        Sun, 08 Nov 2026 21:29:06 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb9681385fsm1180899a12.6.2026.11.08.21.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:29:06 -0800 (PST)
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
Subject: [PATCH v2 0/2] dmaengine: ma35d1-pdma: Add MA35D1 PDMA driver
Date: Mon,  9 Nov 2026 13:28:58 +0800
Message-Id: <20261109052900.2960473-1-shanchun1218@gmail.com>
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

The driver supports memory-to-memory, slave scatter-gather and cyclic
transfers.

Tested on the MA35D1 SOM board with Linux v7.4-rc1:
 - memory-to-memory with dmatest (2000 iterations of 1MB buffers, no failures)
 - slave scatter-gather with a local (not yet submitted) QSPI patch
 - cyclic slave with a local (not yet submitted) I2S patch

Changes in v2:
 - Address issues identified by Sashiko AI review:
   - Program registers on descriptor start instead of prep.
   - Fix interrupt completion handling and return IRQ_NONE when idle.
   - Set PDMA_TBINTDIS on intermediate memcpy chunks.
   - Validate scatter-gather lengths and bus width alignment.
   - Fix channel request assignment in of_xlate().
   - Safe controller teardown order in remove().
   - Drop peripheral timeout support to simplify driver.
 - binding: describe the hardware in the description, and drop
   dma-channels and the dt-bindings header.
 - Use a fixed number of 10 channels and trim the includes.

Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>

Shan-Chun Hung (2):
  dt-bindings: dma: nuvoton,ma35d1-pdma: Document MA35D1 PDMA controller
  dmaengine: ma35d1-pdma: Add MA35D1 PDMA driver

 .../bindings/dma/nuvoton,ma35d1-pdma.yaml     |  71 ++
 drivers/dma/Kconfig                           |  12 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/ma35d1-pdma.c                     | 672 ++++++++++++++++++
 4 files changed, 756 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
 create mode 100644 drivers/dma/ma35d1-pdma.c

-- 
2.25.1

