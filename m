Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589AA1F7066;
	Fri, 17 Jan 2025 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094443; cv=none; b=LeOnjXC6BW9oKJ/OXB5hFxyCFf90koaUwQERZzeJowJtyWsA63jaaNuqtAYuMGgyDxiyvrFwSAUywqYkRfRBiTHNpmmATbmVrp+QxR4y6stNZpMfYV+ixkQkTMMl7ioOzTrvHP3rG2FHKTMk2O3FseVtEfcdoNeiFAa+NLH6V1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094443; c=relaxed/simple;
	bh=sz6DETrCSuVIvrFoZOEWFxSk1K1oBhDlzfT3ft3RyFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggc0Whs9OBMlcdpEy1DmRXMet8yMdm2DEwg1sECl0SsGs1R2TQ6h8DgAewdU5zvGfmE9mEVfqXM9CDVUdzlnlBSYp8IFI8kEZzyo8rxRf5mJVZ4v9OHr9RVdVpbmHhEp485JhGByW8XEQfoQ9WN7T8mMODtkaFMqJJ3E1i/R07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=be+G5E78; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="be+G5E78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737094441; x=1768630441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sz6DETrCSuVIvrFoZOEWFxSk1K1oBhDlzfT3ft3RyFw=;
  b=be+G5E78Jipr5ROAC7SLfIbR+LTynvBANVC71oGmVWBaOUx/L+ILOvZk
   OICZ4kvuaCUb4NP9lh956YmzioXC8nFWvJBwyVPh9TP5tqpdl1S8viHGH
   XekaXN8osU+ytdoxz/b5hEGEBhbgErzB9eO9CGcrmx6Njug5z9gSMNvxq
   lo0PilP2yeDgxHhT2dSfS3W7rjLErTYKVV5OG6f+Eqs8q+v3eET/JzBuO
   JbwnhX7P793ysyPoMpkxwJX3r8vLmJtIxRskmeoSPrbgiq4gxw2oONDNa
   znMK8Am1TQ0L3GH/j+Ja49DqZoffiAOUdc/5t2a4DWwtta1Yy1UMVTxoV
   A==;
X-CSE-ConnectionGUID: obhMP+xnSX2BTul1KB3t6Q==
X-CSE-MsgGUID: lWFpuPbNTBOliBDohCJaOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48933799"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48933799"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 22:14:00 -0800
X-CSE-ConnectionGUID: OtmeHGkZRIi1ujQghhg20Q==
X-CSE-MsgGUID: tFe52pjKRT2DEsEbmXSIYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="106263542"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 Jan 2025 22:13:55 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYfc9-000Spr-1E;
	Fri, 17 Jan 2025 06:13:53 +0000
Date: Fri, 17 Jan 2025 14:13:22 +0800
From: kernel test robot <lkp@intel.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= via B4 Relay <devnull+duje.mihanovic.skole.hr@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, David Wronek <david@mainlining.org>,
	Karel Balej <balejk@matfyz.cz>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: Re: [PATCH v14 2/4] arm64: Kconfig.platforms: Add config for Marvell
 PXA1908 platform
Message-ID: <202501171330.0mw1PLZh-lkp@intel.com>
References: <20250115-pxa1908-lkml-v14-2-847d24f3665a@skole.hr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115-pxa1908-lkml-v14-2-847d24f3665a@skole.hr>

Hi Duje,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5bc55a333a2f7316b58edc7573e8e893f7acb532]

url:    https://github.com/intel-lab-lkp/linux/commits/Duje-Mihanovi-via-B4-Relay/dt-bindings-marvell-Document-PXA1908-SoC-and-samsung-coreprimevelte/20250116-044350
base:   5bc55a333a2f7316b58edc7573e8e893f7acb532
patch link:    https://lore.kernel.org/r/20250115-pxa1908-lkml-v14-2-847d24f3665a%40skole.hr
patch subject: [PATCH v14 2/4] arm64: Kconfig.platforms: Add config for Marvell PXA1908 platform
config: arm64-kismet-CONFIG_I2C_GPIO-CONFIG_VIDEO_MMP_CAMERA-0-0 (https://download.01.org/0day-ci/archive/20250117/202501171330.0mw1PLZh-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250117/202501171330.0mw1PLZh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501171330.0mw1PLZh-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for I2C_GPIO when selected by VIDEO_MMP_CAMERA
   WARNING: unmet direct dependencies detected for I2C_GPIO
     Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (GPIOLIB [=n] || COMPILE_TEST [=n])
     Selected by [y]:
     - VIDEO_MMP_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && I2C [=y] && VIDEO_DEV [=y] && (ARCH_MMP [=y] || COMPILE_TEST [=n]) && COMMON_CLK [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
