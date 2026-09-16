Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C74F0554
	for <linux-hardening@vger.kernel.org>; Wed, 16 Sep 2026 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.128.198.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566211; cv=none; b=Jnkh9jwx4czlPC+S2yi/xnYDWOtFlYu75vBF9fNAZJFD9uZ2K7ribjmBQr9T2AZWfe8wTI6R8BmFeKJ7eAn1dq3PQCPRRdHyorduRyXAeizU3JI6m0hiyt8mR5xPFranmaSruSP/KTIjp6OQdYVkQfCB/LzFATcAggk/OwLoBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566211; c=relaxed/simple;
	bh=hwhIGeT1MDe1KLdko0k71UW6Tz+PVyJbY8+8TF5L2jk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FvgoRKB+vVspzKi+bqDMVduL0rKXCW72cj0dBCdPxfmIpx5s9B/owR2xV8Sx9SqpYmlLFTo6JtuzWLdNDHryXc/X+4psL1UXN6pcA7g6C6/3m8uo6U/SMnZOquY0wZQNK0IZCicGrPQSsgXmGtHuP3z5q7WvLVF3sraNweXI3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=220.128.198.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (atcpcs53.andestech.com [10.0.1.153])
	by Atcsqr.andestech.com with ESMTPS id 68GDh475010197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 21:43:04 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs53.andestech.com
 (10.0.1.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Wed, 16 Sep
 2026 21:43:04 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Sep
 2026 21:43:04 +0800
From: CL Wang <cl634@andestech.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A .
 R . Silva" <gustavoars@kernel.org>,
        <tim609@andestech.com>, <cl634@andestech.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/2] dmaengine: atcdmac300: Add Andes ATCDMAC300 DMA driver
Date: Wed, 16 Sep 2026 21:42:56 +0800
Message-ID: <20260916134258.2178081-1-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs53.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 68GDh475010197

This patch series adds support for the Andes ATCDMAC300 DMA controller,
a memory-to-memory and peripheral DMA controller that provides
scatter-gather, cyclic, and slave transfer capabilities.

The ATCDMAC300 IP is embedded in AndesCore-based platforms or SoCs
such as AE350 and Qilai.

Changes in v7:
  - Rebase onto the current dmaengine/next
  - Fold in twelve correctness fixes found by review and confirmed on an
    FPGA; no interface or binding change
  - Interrupt path:
      - Acknowledge only the status bits that were actually read
      - Key the acknowledge on channel ownership instead of on in-flight
        state the handler itself clears, which could leave a completion
        unacknowledged until the core disabled the line
      - Use raw spinlocks for the state shared with the hard IRQ handler
  - Termination and descriptor lifetime:
      - Do not run the callback twice, or recycle a descriptor, when a
        transfer is terminated while its completion is in flight
      - Initialise desc_node when a descriptor is allocated
      - Wait for the channel to stop without holding the channel lock;
        the poll could spin 100 ms with interrupts disabled
  - Suspend and resume:
      - Move the PM callbacks to the late phase so clients terminate their
        transfers first, and name the channels that fail to idle
      - Drain in-flight completions across suspend and resume
      - Do not restart an idle cyclic channel on resume
  - Probe:
      - Register the DMA device only after the interrupt and cache
        coherency setup, closing a window in which a client could obtain a
        channel through dma_request_channel() on an unready controller
      - Do not read-modify-write write-only registers
      - Name the device in the probe-time reset error

Changes in v6:
  - Rebase onto dmaengine/next; no functional changes from v5
  - Fold the MAINTAINERS entry into the driver patch instead of carrying
    it as a separate patch (series is now 2 patches)

Changes in v5:
  - Update copyright year to 2026
  - Remove redundant headers (init.h, iopoll.h, mod_devicetable.h)
  - Move atcdmac_init_iocp() before of_dma_controller_register() in probe
  - Change builtin_platform_driver() to module_platform_driver()
  - Implement .remove callback to support safe module unloading
  - Update Kconfig entry from bool to tristate
  - Add MODULE_AUTHOR, MODULE_DESCRIPTION, MODULE_LICENSE macros

Changes in v4:
  - Use items list format with descriptions for reg property in DT binding
    as suggested by Conor Dooley
  - Re-add Acked-by from Conor Dooley for DT binding patch

Changes in v3:
  - Rename DT binding file from andestech,qilai-dma.yaml to
    andestech,ae350-dma.yaml
  - Deprecate IP-core-based compatible usage and align with
    SoC/platform-based strings
  - Dropped Acked-by from Conor Dooley due to the above binding change
  - Remove "andestech,atcdmac300" from of_device_id table
  - Replace deprecated tasklet with threaded IRQ using
    devm_request_threaded_irq() and IRQF_ONESHOT
  - Update locking from spin_lock_bh() to spin_lock_irqsave()
  - Use builtin_platform_driver() instead of module_platform_driver()
  - Remove "select DMATEST" from Kconfig
  - Add separate MAINTAINERS patch (patch 3/3)

Please kindly review.

CL Wang (2):
  dt-bindings: dmaengine: Add support for ATCDMAC300 DMA engine
  dmaengine: atcdmac300: Add driver for Andes ATCDMAC300 DMA controller

 .../bindings/dma/andestech,ae350-dma.yaml     |   67 +
 MAINTAINERS                                   |    6 +
 drivers/dma/Kconfig                           |   11 +
 drivers/dma/Makefile                          |    1 +
 drivers/dma/atcdmac300.c                      | 1625 +++++++++++++++++
 drivers/dma/atcdmac300.h                      |  298 +++
 6 files changed, 2008 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
 create mode 100644 drivers/dma/atcdmac300.c
 create mode 100644 drivers/dma/atcdmac300.h

-- 
2.34.1

