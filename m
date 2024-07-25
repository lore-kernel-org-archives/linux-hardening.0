Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFF0196C6C
	for <linux-hardening@vger.kernel.org>; Thu, 25 Jul 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721902738; cv=none; b=JH14EK0zO0YaFlu/L+1Lj/aRvkjDsmdBWpYP+R+IyqVE7h8JojEqMs9HiQi3mvCbJPAcZK6ddIJpc7xEmqgIrgCl0jKMrIebpBpbgkqToU2IoVtZfsCatTw8nOakLIvKphQ7NHxZbgcqG1qcGeIPr/Z6vhkvAd13DNQGc3w+9w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721902738; c=relaxed/simple;
	bh=jy+2kt5StGajtWqgcD3/x/0S3Xdl5VLd2ynPrNcGQVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BX2wmr8+RGQrUnxw06+reT3ZY8nn7i09ud1w9fQA2QMZhqg/gS/Ijy6F4hrtwmByYnVPNj14TRiAvVTGRAR7lW2HgEOufXzksGsy1VTCxuvFf5TztB07QaeABq5Wd3pqCB3+kVSBtI4JOYjioC7GVghLvpdALUxtp5oIkCyfuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWhuUB8v; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWhuUB8v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721902736; x=1753438736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jy+2kt5StGajtWqgcD3/x/0S3Xdl5VLd2ynPrNcGQVk=;
  b=EWhuUB8vB5uCG5zZIQOucM02ASXO210xzDg8gS4S+6KWRAcE4b3xXC9o
   NZJotb7K9PPAaV1JEh5gZ0P5nZ1dh+Yj4JydmGk/J4QUlNOO6dH00glP4
   jyrkPRN+5kiwJ0vOVOYvW46tZkiYBzDWY2m+n7vsKEs0ofgotw8w35+3c
   8IyPtLTnBqUBSkCzhigEUZ3lsP77Wnppa8fRZeRaFU5gdxJxMDjUhILJh
   pPgegd2hJK4BoxH8LsBROZELqG/9sNml7SPt2e+6HtpxNe22ewX0Klw29
   pTnd48Z2V48hQqhcagvt8nVduA3uM5d7hDLfDNkb4UZIQ8DP1mGDMXrbY
   g==;
X-CSE-ConnectionGUID: gHfNm9O8T3+Hujz4eh3rtA==
X-CSE-MsgGUID: w2IZVHlERGSARLso04G+cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="31047528"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="31047528"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 03:18:55 -0700
X-CSE-ConnectionGUID: FFM3d7G8Rm6iyArRJw6Qow==
X-CSE-MsgGUID: NAB6o66KTrqnxLqVB/s8Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="76089786"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.245.82.99])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 03:18:54 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-hardening@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] coccinelle: Add rules to find str_up_down() replacements
Date: Thu, 25 Jul 2024 12:18:41 +0200
Message-Id: <20240725101841.574-2-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240725101841.574-1-michal.wajdeczko@intel.com>
References: <20240725101841.574-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add rules for finding places where str_up_down() can be used.
This currently finds over 20 locations.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
./drivers/net/bonding/bond_sysfs.c:511:32-38: opportunity for str_up_down(active)
./drivers/net/bonding/bond_procfs.c:101:37-64: opportunity for str_up_down(netif_carrier_ok ( bond -> dev ))
./drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:6088:5-36: opportunity for str_up_down(e -> flags & BRCMF_EVENT_MSG_LINK)
./drivers/media/platform/ti/cal/cal-camerarx.c:194:3-9: opportunity for str_up_down(enable)
./drivers/net/dsa/mv88e6xxx/port.c:178:2-38: opportunity for str_up_down(reg & MV88E6XXX_PORT_MAC_CTL_LINK_UP)
./drivers/net/ethernet/faraday/ftgmac100.c:1737:5-16: opportunity for str_up_down(nd -> link_up)
./drivers/pinctrl/pinctrl-stmfx.c:382:7-11: opportunity for str_up_down(pupd)
./drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:2175:6-14: opportunity for str_up_down(state . up)
./drivers/block/aoe/aoeblk.c:40:4-23: opportunity for str_up_down(d -> flags & DEVFL_UP)
./drivers/ntb/test/ntb_perf.c:1224:3-39: opportunity for str_up_down(test_bit ( PERF_STS_LNKUP , & peer -> sts ))
./drivers/crypto/intel/qat/qat_common/adf_sysfs.c:28:9-35: opportunity for str_up_down(adf_dev_started ( accel_dev ))
./drivers/fsi/fsi-sbefifo.c:459:39-41: opportunity for str_up_down(up)
./net/ncsi/ncsi-manage.c:1282:8-26: opportunity for str_up_down(ncm -> data [ 2 ] & 0x1)
./net/ncsi/ncsi-aen.c:78:13-23: opportunity for str_up_down(data & 0x1)
./drivers/net/phy/phylink.c:1788:49-51: opportunity for str_up_down(up)
./drivers/net/phy/phylink.c:2109:39-41: opportunity for str_up_down(up)
./drivers/ntb/test/ntb_tool.c:299:2-4: opportunity for str_up_down(up)
./drivers/ufs/core/ufshcd.c:1186:4-12: opportunity for str_up_down(scale_up)
./drivers/ufs/core/ufshcd.c:1559:3-11: opportunity for str_up_down(scale_up)
./drivers/ntb/hw/mscc/ntb_hw_switchtec.c:513:4-12: opportunity for str_up_down(link_sta)
./drivers/ata/sata_via.c:362:8-14: opportunity for str_up_down(online)
./drivers/usb/host/oxu210hp-hcd.c:2784:39-44: opportunity for str_up_down(is_on)
./drivers/net/ethernet/smsc/smc91x.c:1178:8-19: opportunity for str_up_down(new_carrier)
---
 scripts/coccinelle/api/string_choices.cocci | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index a71966c0494e..d517f6bc850b 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -39,3 +39,26 @@ e << str_plural_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_plural(%s)" % e)
+
+@str_up_down depends on patch@
+expression E;
+@@
+(
+-	((E) ? "up" : "down")
++	str_up_down(E)
+)
+
+@str_up_down_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*	((E@P) ? "up" : "down")
+)
+
+@script:python depends on report@
+p << str_up_down_r.P;
+e << str_up_down_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_up_down(%s)" % e)
-- 
2.43.0

