Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8C8257855
	for <linux-hardening@vger.kernel.org>; Thu,  1 Oct 2026 02:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.128.198.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790820712; cv=none; b=JJDMLisuQomyGJ3Y1lgFh3JPahq3IdJ2SO/oFEZLwpzg3ZLKjLiPO23Dvu5iBXtDYF/Qc0CPj9s0f/upXCTD8X0X6TioRTuSvfZ6bxG69NjqzpMxjFXTIjNnqkY7BX1oEOGPJk9imz9UBZmyYyyHk4k3Vkcfz2cBLFQ3b+OMFTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790820712; c=relaxed/simple;
	bh=GhhWu5yeP9DYiakt1YwCNfPJrRUNxXijIDjX46z86pE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FZLnePc9doO2MJYr6GHi3ZNInFrSnvJGL+px7sXXsivXSXpOxHnoHkwpWDqC2TaVAPa3vX5yrpjpq4+D+IqGjxO6nDBtD4003sj0UYJV4pCjfpYgX6CoF4SlBkNGotNXpmRzzaWfQP8vMlI0cu/EW2BcTVKOmjGLRiZuZVCHdkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=220.128.198.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 6911jaVw061903
	for <linux-hardening@vger.kernel.org>; Thu, 1 Oct 2026 09:45:36 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from mail.andestech.com (atcpcs53.andestech.com [10.0.1.153])
	by Atcsqr.andestech.com with ESMTPS id 6911jOWp061713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 09:45:24 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs53.andestech.com
 (10.0.1.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Thu, 1 Oct
 2026 09:45:24 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Oct
 2026 09:45:24 +0800
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
Subject: [PATCH v8 0/2] dmaengine: atcdmac300: Add Andes ATCDMAC300 DMA driver
Date: Thu, 1 Oct 2026 09:45:01 +0800
Message-ID: <20261001014503.786490-1-cl634@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 6911jaVw061903

This patch series adds support for the Andes ATCDMAC300 DMA controller,
a memory-to-memory and peripheral DMA controller that provides
scatter-gather, cyclic, and slave transfer capabilities.

The ATCDMAC300 IP is embedded in AndesCore-based platforms or SoCs
such as AE350 and Qilai.

v7 drew eight findings from sashiko-bot, and Frank Li asked for each to
be fixed or explained. Five are fixed here. The other three are
answered in the reply to v7 rather than changed:

  - Terminal count and error arriving together:
    The data sheet defines the terminal count status as being set only
    when a transfer finishes without an error or abort event, and only
    one transfer is in flight on a channel at a time, so the two cannot
    both describe the same transfer.

  - Descriptors a client prepares and never submits:
    The desc_free half does not apply, as the driver does not set
    descriptor_reuse and so that callback is unreachable; for the rest
    the API offers no unprepare a driver could hook.  No in-tree client
    of this driver prepares a transfer it does not submit.

  - Endianness conversions:
    The driver depends on ARCH_ANDES and Linux has no big-endian RISC-V,
    so the conversions would be no-ops everywhere this can be built, and
    struct atcdmac_regs is both the linked list node the controller reads
    and the staging copy fed to regmap_write(), so the fields would be
    converted on the way in and converted straight back on the way out.

v7: https://lore.kernel.org/r/20260916134258.2178081-1-cl634@andestech.com

Changes in v8:
  - Fold in fourteen further correctness fixes; no interface or binding
    change. Five of them answer the v7 findings above; the remaining
    nine come from a review of the whole driver.
  - Descriptor lifetime:
      - Track cyclic mode on the descriptor rather than on the channel;
        a cyclic and a non-cyclic transfer on one channel could leave the
        flag set for the wrong descriptor and dereference a NULL callback
      - Drop the num_sg field, which was written but never read
  - Suspend and resume:
      - Restore stop_mask when suspend times out, instead of leaving
        every channel stopped for good
      - Start transfers that were queued while suspended
  - Driver model:
      - Do not offer the controller for unbinding; a client holding a
        channel across an unbind would run against devres memory that
        remove() has already released
  - Register encoding:
      - Reject a DMA request line the request-select field cannot hold,
        rather than truncating it silently
      - Keep the burst field out of its reserved range, which the
        controller reports as an error exception
      - Refuse a transfer width the width field cannot encode
  - Slave configuration:
      - Clear the stored configuration when a channel is allocated, so a
        client cannot inherit the previous one's device address
      - Accept a configuration that describes only the direction it uses
      - Reject a length that is not a whole number of device-width units,
        which either transfers fewer bytes than asked for or programs a
        zero transfer size
  - Probe:
      - Use struct_size() for the channel array, which is already
        declared with __counted_by()
      - Check the configuration register read, and refuse a channel count
        of zero rather than registering a controller with no channels
  - Cleanups:
      - Return a bool from the channel-enabled helper rather than a value
        that is negative on a failed register read; pass a register value
        rather than a bool to regmap_update_bits(); use
        dma_cookie_status() directly

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
 drivers/dma/atcdmac300.c                      | 1759 +++++++++++++++++
 drivers/dma/atcdmac300.h                      |  298 +++
 6 files changed, 2142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/andestech,ae350-dma.yaml
 create mode 100644 drivers/dma/atcdmac300.c
 create mode 100644 drivers/dma/atcdmac300.h


base-commit: 0a8dda0a15d3926422d286567f945a05328a4ac6
-- 
2.34.1

