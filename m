Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F504382
	for <linux-hardening@vger.kernel.org>; Wed, 11 Sep 2024 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726016431; cv=none; b=ICT8tRRDBm+edtk2DCoeTW/oWg+PycUueikGpn7zz+uEbwiLjRHDZMZTNAQGMtOtheL34YPU7m5A9DFLWCYOCW1FUwEwZvnS8pCVIKniAhxE7/g3XyJD3PJeoYoG5GDPVBTqH+6cEKSrFEQVZszyIPvSw3x0p9y44wzLRt2Z9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726016431; c=relaxed/simple;
	bh=RSnYMTc4kOL30peuolmn2wbb4qCZ8pFXcGqItnLbGt8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BzB19pNwistelDYAGg9Mg+i0BjcLA5Qh2hkRJ8uRxdoHPK6Y9X0srbu/x0iH1754YkzkAj2ODMeoVgXAiOJyufKiHTDpuzKkIHVH/osdfTR4G41fAG60FMXRdWMCCafPAxYJPOW3cyfZ/RfP3n6x6ElfNEJDXbA/hm1jsjkp/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X3MbQ4pshz1HJPJ;
	Wed, 11 Sep 2024 08:56:50 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 628AC14010C;
	Wed, 11 Sep 2024 09:00:25 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Sep
 2024 09:00:25 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>
Subject: [PATCH -next v3 00/10] coccinelle: Add some rules for string_chioces helpers.
Date: Wed, 11 Sep 2024 09:09:17 +0800
Message-ID: <20240911010927.741343-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

We found that many of the detection rules for helpers in
string_choices.h are missing. This series of patches is
intended to complete these rules. We have verified in the
latest kernel tree that these rules can detect many places
where the string choices helper can be used as a replacement.

Here are some of the examples:

```
drivers/gpio/gpio-mvebu.c:917:6-18: opportunity for str_lo_hi(in_pol & msk)
drivers/pinctrl/nomadik/pinctrl-nomadik.c:1109:16-19: opportunity for str_high_low(val)
drivers/pinctrl/nomadik/pinctrl-nomadik.c:1116:13-16: opportunity for str_high_low(val
drivers/gpio/gpio-wcove.c:396:6-16: opportunity for str_hi_lo(ctli & 0x1)
drivers/pci/hotplug/pnv_php.c:367:10-41: opportunity for str_on_off(state == OPAL_PCI_SLOT_POWER_ON)
drivers/mtd/nand/raw/brcmnand/brcmnand.c:1844:40-63: opportunity for str_read_write(edu_cmd == EDU_CMD_READ)
drivers/mtd/nand/raw/brcmnand/brcmnand.c:1437:33-35: opportunity for str_on_off(wp)
drivers/mtd/nand/raw/brcmnand/brcmnand.c:1467:9-11: opportunity for str_on_off(wp)
drivers/greybus/svc.c:76:9-37: opportunity for str_enabled_disabled(gb_svc_watchdog_enabled ( svc ))
drivers/thermal/thermal_sysfs.c:59:29-36: opportunity for str_enabled_disabled(enabled)
drivers/dma-buf/st-dma-fence.c:508:10-35: opportunity for str_yes_no(dma_fence_is_signaled ( f2 ))
drivers/mmc/host/omap_hsmmc.c:1644:7-43: opportunity for str_enabled_disabled(host -> flags & HSMMC_SDIO_IRQ_ENABLED)
drivers/input/mouse/elan_i2c_core.c:202:2-4: opportunity for str_on_off(on)
drivers/macintosh/via-pmu.c:626:10-28: opportunity for str_enabled_disabled(option_server_mode)
drivers/usb/mtu3/mtu3_debugfs.c:482:5-39: opportunity for str_on_off(regulator_is_enabled ( otg_sx -> vbus ))
drivers/net/wireless/intel/iwlwifi/mvm/tt.c:355:4-10: opportunity for str_enable_disable(enable)
drivers/nfc/pn544/i2c.c:215:7-20: opportunity for str_low_high(polarity == 0)
drivers/media/tuners/tda18250.c:110:3-12: opportunity for str_true_false(triggered)
drivers/mtd/tests/torturetest.c:191:30-35: opportunity for str_enabled_disabled(check)
drivers/bus/intel-ixp4xx-eb.c:225:5-8: opportunity for str_enabled_disabled(val)
drivers/net/ethernet/huawei/hinic/hinic_port.c:1133:3-9: opportunity for str_enable_disable(enable)
drivers/net/ethernet/huawei/hinic/hinic_port.c:1245:3-9: opportunity for str_enable_disable(pfc_en)
drivers/media/pci/cx23885/cimax2.c:227:4-8: opportunity for str_read_write(read)
drivers/media/usb/em28xx/em28xx-video.c:941:4-9: opportunity for str_enabled_disabled(flags)
```

Changes since v2: https://patchwork.kernel.org/project/linux-hardening/cover/20240904091451.3328272-1-lihongbo22@huawei.com/
  - Remove unnecessary outer parentheses for new rules as suggested by julia, thanks.
  - Remove unnecessary outer parentheses for old rules.


Changes since v1: https://patchwork.kernel.org/project/linux-hardening/cover/20240829112455.232263-1-lihongbo22@huawei.com/
  - Add more rules for helpers in string_choices.h.

Thanks,
Hongbo.

Hongbo Li (10):
  coccinelle: Add rules to find str_true_false() replacements
  coccinelle: Add rules to find str_false_true() replacements
  coccinelle: Add rules to find str_hi{gh}_lo{w}() replacements
  coccinelle: Add rules to find str_lo{w}_hi{gh}() replacements
  coccinelle: Add rules to find str_enable{d}_disable{d}() replacements
  coccinelle: Add rules to find str_read_write() replacements
  coccinelle: Add rules to find str_write_read() replacements
  coccinelle: Add rules to find str_on_off() replacements
  coccinelle: Add rules to find str_yes_no() replacements
  coccinelle: Remove unnecessary parentheses for only one possible
    change.

 scripts/coccinelle/api/string_choices.cocci | 240 +++++++++++++++++++-
 1 file changed, 232 insertions(+), 8 deletions(-)

-- 
2.34.1

