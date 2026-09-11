Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8797B44F574
	for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.128.198.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112531; cv=none; b=Xxjr3TFJRctEBnJpjxk91tCMW/kYLChDRmeqQrBkvzmHcVe9E0D6yN7eLTDt12wkHvKSeKexxyLPO9FnGeB1hFYKaf1JgOsxbNPjEVt5bU5vdbN8JfxQDmw45jzYSKgWwTVlpCCCBWRPFD3aouFJhoOuxM1pZCE9cJ4671EIpIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112531; c=relaxed/simple;
	bh=BMkgbPKviKHC4rd29McGJoIAKL4ZtGWMSuVQcHUw27I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tVrlqmUPN//ZnEFDJ9RqTtkn4gWa88GKHbp8mYBdJEdsVlOYwKjHROV37sIb5m9ifumKAMjkZybYwN9mFtqSET2Y01DeOP7wYtgA7KZkxHmyWQL/d05Bb3dft6cbluF/Qme7/vE/3VyQUE3L8ZI7sCNYJlMYVBznuPyKiN5AmIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=220.128.198.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 68B7PmFh008636
	for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 15:25:48 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from mail.andestech.com (atcpcs53.andestech.com [10.0.1.153])
	by Atcsqr.andestech.com with ESMTPS id 68B7PY1v008516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 15:25:34 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs53.andestech.com
 (10.0.1.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Fri, 11 Sep
 2026 15:25:34 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Sep
 2026 15:25:33 +0800
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
Subject: [PATCH v6 0/2] dmaengine: atcdmac300: Add Andes ATCDMAC300 DMA driver
Date: Fri, 11 Sep 2026 15:25:22 +0800
Message-ID: <20260911072524.1297406-1-cl634@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 68B7PmFh008636

This patch series adds support for the Andes ATCDMAC300 DMA controller,
a memory-to-memory and peripheral DMA controller that provides
scatter-gather, cyclic, and slave transfer capabilities.

The ATCDMAC300 IP is embedded in AndesCore-based platforms or SoCs
such as AE350 and Qilai.

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
 drivers/dma/atcdmac300.c                      | 1518 +++++++++++++++++
 drivers/dma/atcdmac300.h                      |  296 ++++
 6 files changed, 1899 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
 create mode 100644 drivers/dma/atcdmac300.c
 create mode 100644 drivers/dma/atcdmac300.h

-- 
2.34.1

