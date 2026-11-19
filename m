Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795053297;
	b=vYMdxOKifKf+F/CfeRnwcpHNdtzitm5MaoJvSpJ30Mt4SpKVpuqJhrB02SElfPYWngEM
	 hu0pqjxU/eyh+5DcEG4JvPSxArILVWgJDFG5yvazHlPPTuHId4JfFssMRJCgLgmq/eaRl
	 qFzYNONRZVJmzuKVknB9/FiREAK5YYFBiFqkzpVFueKKXtFMkCWSRFbQxOaA+8OxrQOhW
	 nlkeduui/X4Eg+AzBeIwQwqOPgZQuqaU+QsudduSDPgnuHHM4cSJIa0bGNftUzRAfdu0j
	 1P1uTl6soQ16Iu9pa+mpCrcpv4o0jkyXy30AMfqpS3KyFqSyY05B33B1HnNtb7POWYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nDoAWY11ZCr0ihHoFalCpChIz8Et8oFGy4RrYPRx3SQ=;
	b=u5lq/hIsWRAaFour9c14GML+MaZlykVPQmByfTPL6lmjddvGcnIejvsdqf0uSLT0GpGh
	 rHexI/IehMzL1twchfOrxlV6pFYv3RnCC2xh3NnPSVzJJTttKIMhfHvm5+UADsGkR7c7T
	 5Wjq+aHmDj7nSX/HUo7/pf+oPOckv7/iFeTfNW5f5OYZpjBmlzanvqkXLC9vcvwGLwKOn
	 CiBluTgW7d7J3TQeJrkCiX+s2hF4umwnjrjkcXSgIKcPZAkQ/JfeizrpxxeOwzqYmrF2F
	 D8fOoqeeO9JKofVbG2QhsXTJ1Tj22DoMr3LgxhYco0BZmJYyicAIj33UwJVR+0uvSGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nltqhrd0;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E919260A2609
	for <linux-hardening@vger.kernel.org>; Thu, 19 Nov 2026 01:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E919260A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nltqhrd0
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso968639a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 18 Nov 2026 17:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795053296; x=1795658096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nDoAWY11ZCr0ihHoFalCpChIz8Et8oFGy4RrYPRx3SQ=;
        b=nltqhrd0MMDZ7546deiSsw2uwq42t4c3i4uOD0uXOHy2rm2POJCcz0TxFstDHvoHpM
         /7crJUPoUAefBTJsrcZgBfnDlE7lNpDD/qTTwId33wMljgUFI61lnGlVDcLB1YofRILd
         FQUNgnLEgmL3uaUgOIGiu24veyJztsWw/OMqkQbHz8X5G+bHP8OojWbSlR/cjnoU1va1
         4cXxRINSVIrjwcRrrdxFNK2+yD0MrGLpdL6QMQ4MqtQO6GuTvicIdWLHmnun1fGBX/b1
         aQHourZFOB3X7BBJZbioOFbRdaH/AxGZg7lUk+4G+UF4GQxmu5WqJa1nDWRqIOXzCj7q
         qcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795053296; x=1795658096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nDoAWY11ZCr0ihHoFalCpChIz8Et8oFGy4RrYPRx3SQ=;
        b=y+Fn3ycLt15HRqDPLfMDxr+aAZFsM0SkBf2Fzj3kVJ12wjmqW2Qc8eoBVUKUDUDgvs
         y+H1M52/gnU4hhyOUEVjmN3CoxwYaFkuPdI8RtxLQe0XSw7nkk/Qq69wYFdI7VPfYnU3
         EWLdQWci9wTp9ODxxrC0M00n8a099z3JTGkITy9UO0XDUAfgrrIxP6jbH5ImR/EwMjq9
         A/Wa82Qy4T9baDnSIw7H5Rc9lpIAdl0jkdbmJMD08NwRdr1qyG2wCOuzuOqt+QmYlmYY
         y7AuFjgpWkLhvflrzlQ4awU/EqaU5PrSTpKvUk+KCO2sfgiJ5QqAnAletkJBJ1qKgLmN
         YhRQ==
X-Forwarded-Encrypted: i=1; AL+hErGDeN/HST+T9xSCdfX4225euQyMh661uDUwg/wmGP/YpS2bYrF1pLTj+2dpnhBaBNKPH9sO3MQ+I0PJ+UBMDEo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+syK1+5ujcrMFSK7DHaTaMgW0Z2l45JIZDTTvRLxtSDsd69FZl
	OCfZjHEIal8RpkALGiUMyg5DudskqeYaS+9IGv5/eLvl5qcJZ2iHxRDi8kOVv+cM
X-Gm-Gg: AZFdTZceZhrxnPOPfNG3dMnBOK86LmdXkFfJOqK3TdfHxe3TLHeeXf471F7Vsv9lmyC
	Evse6CCNgIVd3R0bUJUhDjg0iPg8va+4y9N5ah24hJkrJukNCidZzhHh8Jv9feaF7BoF2pCjHJw
	PoeYOq2vhdR8aao/VAO/lNpta95aZmEJrDWGwqi1vHYJNlnyHycftb7hYKd99Rp1RaxmPBLePpZ
	ph/It2s+YHl5u0Gd6k7OnPdzG4osCg9gSxIhFo72fv346YGezkaM0Fm1t+fYJX7bt9Y0B7rhi8z
	NNDX1GmCCIYNP4r/wC29u/VNVJR2stjMA5j/4DalUlX2tZOAA0nBHfeBejEIbzT1fQR+ikZtJrW
	UdYzgc77aDSh3TQVNh6ol+yJYdA+ReRLshtwx0VQMVF0D2GvwAsJ0IJXRkeUkROn8WFTfd7NtKF
	yA2Mqa3ydSqyP0VtPmyzPtPIAfli5iGM5jyd5Be/BssDHgxy4AGHOdR7Ulwbzxt4sjsLegg366x
	qGDsnsa8QF1M0eKFyk2y6ntSXtAd3SJk8pGbq83ockoDiW3dOfSPYI9w9q7rwYCCoNRD7hy4hxl
	MmhePplN51Ldx3tSoSrC0dNVj0bVomZhKiSvphQCeT6pL32ea9K6Ph7XFkFhor2k0ruQkswP0ZY
	GyOqM+3rXkUrnUlBZwM9l+vE81chNSLXZflIJ
X-Received: by 2002:a17:90b:2ec7:b0:3ac:a139:1b13 with SMTP id 98e67ed59e1d1-3b3d07a85e6mr4560280a91.29.1795053296137;
        Wed, 18 Nov 2026 17:54:56 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3fe03c3d4sm773081a91.14.2026.11.18.17.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 17:54:55 -0800 (PST)
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
Subject: [PATCH v3 0/2] dmaengine: ma35d1-pdma: Add MA35D1 PDMA driver
Date: Thu, 19 Nov 2026 09:54:45 +0800
Message-Id: <20261119015447.160470-1-shanchun1218@gmail.com>
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

Tested on the MA35D1 SOM board with Linux v7.4-rc3:
 - memory-to-memory with dmatest (2000 iterations of 1MB buffers, no failures)
 - slave scatter-gather with a local (not yet submitted) QSPI patch
 - cyclic slave with a local (not yet submitted) I2S patch

Changes in v3:
 - Use dma_alloc_coherent() for the hardware SG table instead of
   kzalloc() + dma_map_single(); defer descriptor free in terminate_all().
 - Rename ma35d1_desc_submit() to ma35d1_desc_prep_done(); prep() only
   prepares the descriptor.
 - Rewrite the IRQ handler: read and ack TDSTS/ABTSTS once, then iterate
   the set bits.
 - Address issue identified by Sashiko AI review:
   - Terminate the descriptor with vchan_terminate_vdesc() when a cyclic
     transfer is aborted, avoiding a use-after-free in vchan_complete().
 - Request the IRQ after the DMA device is registered.
 - Use devm_of_dma_controller_register() and
   dmaenginem_async_device_register(), and drop remove(); a devm action
   stops the hardware and kills the tasklets.

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
 drivers/dma/ma35d1-pdma.c                     | 662 ++++++++++++++++++
 4 files changed, 746 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nuvoton,ma35d1-pdma.yaml
 create mode 100644 drivers/dma/ma35d1-pdma.c

-- 
2.25.1

