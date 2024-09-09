Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758C1136663
	for <linux-hardening@vger.kernel.org>; Mon,  9 Sep 2024 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897816; cv=none; b=alwKfGK+9spfrgtd5Gve9dCZWDWMfUIG1+Ej503lfTqpfAmeQPLmdEM22TMHaYFdaRPKU9S2Midk5Jtg2I+Ar0CyuDNWSDshWuQH07hk5NOzjhUAiSa7S2c5uhd4in71jKiHXC4hyIVimthQs0jio+pDyVgVk/tJuuEQ6Arxgz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897816; c=relaxed/simple;
	bh=o3SSCjaXCkkah5AqXDB8haQ3D8O4a/RXpvGj13mt1to=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Opq0NzOGbEp7j77O4fCp7LG2ajFPP2GmbSBwzEOtj9Fho6GL5Y6YCSddn3qEahUCEb1qx/U0DBIjyDG5nt4w4suLmPJmaT+gKq6gozUDZE5wKeVm4DR45tEU83zhBNm3ovDhZtbxzpzxp4G6G3MOzLZXmyS7qhvlsu7b9227lBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Hr1eXHBG; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Hr1eXHBG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pHF8/FVUT/A4fNzBJtZbLpJxlNxFJURRlKXj0h2hW60=;
  b=Hr1eXHBGn8imV1lFkUM6D13Ek1nJKNh9gDCEls85kyP5WQ6W4CEXGdzb
   aeYpv3s2Odu0Fpd9Bggi3rFgUbSBULFnsKAk+IxXxwcTxcIIYBQwVc/Qo
   hBVkVlOs2eWagFpordG+5nflXoHZ8SqSpEC6JLDPljNPjmILabEokEOst
   Y=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.10,214,1719871200"; 
   d="scan'208";a="95839067"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 18:03:33 +0200
Date: Mon, 9 Sep 2024 18:03:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Hongbo Li <lihongbo22@huawei.com>
cc: kees@kernel.org, andy@kernel.org, nicolas.palix@imag.fr, 
    linux-hardening@vger.kernel.org, cocci@inria.fr
Subject: Re: [PATCH -next v2 0/9] coccinelle: Add some rules for string_chioces
 helpers.
In-Reply-To: <20240904091451.3328272-1-lihongbo22@huawei.com>
Message-ID: <b494bc69-a790-b939-d1bf-29968dfd75e8@inria.fr>
References: <20240904091451.3328272-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 4 Sep 2024, Hongbo Li wrote:

> We found that many of the detection rules for helpers in
> string_choices.h are missing. This series of patches is
> intended to complete these rules. We have verified in the
> latest kernel tree that these rules can detect many places
> where the string choices helper can be used as a replacement.

Thanks for the changes.  The comment about the unneeded column 0 ()
applies to all of the patches.

julia

>
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
> Changes since v1:
>   - Add more rules for helpers in string_choices.h.
>
> Thanks,
> Hongbo.
>
> Hongbo Li (9):
>   coccinelle: Add rules to find str_true_false() replacements
>   coccinelle: Add rules to find str_false_true() replacements
>   coccinelle: Add rules to find str_hi{gh}_lo{w}() replacements
>   coccinelle: Add rules to find str_lo{w}_hi{gh}() replacements
>   coccinelle: Add rules to find str_enable{d}_disable{d}() replacements
>   coccinelle: Add rules to find str_read_write() replacements
>   coccinelle: Add rules to find str_write_read() replacements
>   coccinelle: Add rules to find str_on_off() replacements
>   coccinelle: Add rules to find str_yes_no() replacements
>
>  scripts/coccinelle/api/string_choices.cocci | 276 ++++++++++++++++++++
>  1 file changed, 276 insertions(+)
>
> --
> 2.34.1
>
>
