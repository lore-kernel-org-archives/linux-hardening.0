Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F4A155C88
	for <linux-hardening@vger.kernel.org>; Sat, 28 Sep 2024 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727553489; cv=none; b=pO9NwfCKPnBcYzXjT28XbMzaD7GsjgfQDekOoqgk8Quz9QrZ3t8c3kZCK6hU8s2dUICS2eHxIDDv35DQqhME3JUCuGVPoA/FQCxyilyGE4ArwFFl9G1/mrivdtMuiE1dg6ypTYvQ/NPVjWTaj7pMjIVwghriT3hVkMMdmckkm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727553489; c=relaxed/simple;
	bh=te+MW+iswoIvQj8odoexgv4sMsnXbjYMpToWTz/tbqc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Wn2hXxC1rsC9LoSReDnqOeNdA/wFuTE8rJ5PWoYzIvPQPJk0iHBdwD7M9T3rPe4Z93ZTYAznJWeBURMHy7lK/EHRwAaS5m3XyoxDInVUzh0c9xsVoQzmuMvITM/L9OntLw4saVJ26qBddQ9cwEu/woeOZPMn51izEWa2bFtYQEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=bVL/az2h; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="bVL/az2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bBTc+m1Lybiyd2jhJYJNaZ5Lw5ag2OiShGThL+GdPIM=;
  b=bVL/az2hsDakpF1H4iD8VzZlWf/Nk36DeJv5VvzvLXz6Vg69n6Sh+i90
   6fbP2HXyexD7bJ+aEq0Q6SgPDa6swlHPE9OoYR1rMtSFzEyw1SO5mEwVP
   udypdzQJvtXfSwczx+hzbfdFBWg58FTeMBEqAqVoVfhxxpHuMhOnQk86k
   Y=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,162,1725314400"; 
   d="scan'208";a="97673628"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 21:57:56 +0200
Date: Sat, 28 Sep 2024 21:57:56 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Hongbo Li <lihongbo22@huawei.com>
cc: kees@kernel.org, andy@kernel.org, nicolas.palix@imag.fr, 
    linux-hardening@vger.kernel.org, cocci@inria.fr
Subject: Re: [PATCH -next v3 00/10] coccinelle: Add some rules for string_chioces
 helpers.
In-Reply-To: <20240911010927.741343-1-lihongbo22@huawei.com>
Message-ID: <alpine.DEB.2.22.394.2409282157330.11896@hadrien>
References: <20240911010927.741343-1-lihongbo22@huawei.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 11 Sep 2024, Hongbo Li wrote:

> We found that many of the detection rules for helpers in
> string_choices.h are missing. This series of patches is
> intended to complete these rules. We have verified in the
> latest kernel tree that these rules can detect many places
> where the string choices helper can be used as a replacement.
>

Thanks.  Applied.

julia



> Here are some of the examples:
>
> ```
> drivers/gpio/gpio-mvebu.c:917:6-18: opportunity for str_lo_hi(in_pol & msk)
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1109:16-19: opportunity for str_high_low(val)
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1116:13-16: opportunity for str_high_low(val
> drivers/gpio/gpio-wcove.c:396:6-16: opportunity for str_hi_lo(ctli & 0x1)
> drivers/pci/hotplug/pnv_php.c:367:10-41: opportunity for str_on_off(state == OPAL_PCI_SLOT_POWER_ON)
> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1844:40-63: opportunity for str_read_write(edu_cmd == EDU_CMD_READ)
> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1437:33-35: opportunity for str_on_off(wp)
> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1467:9-11: opportunity for str_on_off(wp)
> drivers/greybus/svc.c:76:9-37: opportunity for str_enabled_disabled(gb_svc_watchdog_enabled ( svc ))
> drivers/thermal/thermal_sysfs.c:59:29-36: opportunity for str_enabled_disabled(enabled)
> drivers/dma-buf/st-dma-fence.c:508:10-35: opportunity for str_yes_no(dma_fence_is_signaled ( f2 ))
> drivers/mmc/host/omap_hsmmc.c:1644:7-43: opportunity for str_enabled_disabled(host -> flags & HSMMC_SDIO_IRQ_ENABLED)
> drivers/input/mouse/elan_i2c_core.c:202:2-4: opportunity for str_on_off(on)
> drivers/macintosh/via-pmu.c:626:10-28: opportunity for str_enabled_disabled(option_server_mode)
> drivers/usb/mtu3/mtu3_debugfs.c:482:5-39: opportunity for str_on_off(regulator_is_enabled ( otg_sx -> vbus ))
> drivers/net/wireless/intel/iwlwifi/mvm/tt.c:355:4-10: opportunity for str_enable_disable(enable)
> drivers/nfc/pn544/i2c.c:215:7-20: opportunity for str_low_high(polarity == 0)
> drivers/media/tuners/tda18250.c:110:3-12: opportunity for str_true_false(triggered)
> drivers/mtd/tests/torturetest.c:191:30-35: opportunity for str_enabled_disabled(check)
> drivers/bus/intel-ixp4xx-eb.c:225:5-8: opportunity for str_enabled_disabled(val)
> drivers/net/ethernet/huawei/hinic/hinic_port.c:1133:3-9: opportunity for str_enable_disable(enable)
> drivers/net/ethernet/huawei/hinic/hinic_port.c:1245:3-9: opportunity for str_enable_disable(pfc_en)
> drivers/media/pci/cx23885/cimax2.c:227:4-8: opportunity for str_read_write(read)
> drivers/media/usb/em28xx/em28xx-video.c:941:4-9: opportunity for str_enabled_disabled(flags)
> ```
>
> Changes since v2: https://patchwork.kernel.org/project/linux-hardening/cover/20240904091451.3328272-1-lihongbo22@huawei.com/
>   - Remove unnecessary outer parentheses for new rules as suggested by julia, thanks.
>   - Remove unnecessary outer parentheses for old rules.
>
>
> Changes since v1: https://patchwork.kernel.org/project/linux-hardening/cover/20240829112455.232263-1-lihongbo22@huawei.com/
>   - Add more rules for helpers in string_choices.h.
>
> Thanks,
> Hongbo.
>
> Hongbo Li (10):
>   coccinelle: Add rules to find str_true_false() replacements
>   coccinelle: Add rules to find str_false_true() replacements
>   coccinelle: Add rules to find str_hi{gh}_lo{w}() replacements
>   coccinelle: Add rules to find str_lo{w}_hi{gh}() replacements
>   coccinelle: Add rules to find str_enable{d}_disable{d}() replacements
>   coccinelle: Add rules to find str_read_write() replacements
>   coccinelle: Add rules to find str_write_read() replacements
>   coccinelle: Add rules to find str_on_off() replacements
>   coccinelle: Add rules to find str_yes_no() replacements
>   coccinelle: Remove unnecessary parentheses for only one possible
>     change.
>
>  scripts/coccinelle/api/string_choices.cocci | 240 +++++++++++++++++++-
>  1 file changed, 232 insertions(+), 8 deletions(-)
>
> --
> 2.34.1
>
>
