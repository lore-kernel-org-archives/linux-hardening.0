Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795808274;
	b=JPN9h68GF+UznuOidTykjvlZzeX1Xn9lVnMjiNf9lBmeU7O1bgS6OzTznbhexQmPeM2K
	 Kj2p+us8SYatf/QA/IYpkhjS0Dwfp3Fl4muBXnH0BBjvw0C26HMKHzrkVmrW5lUGk9dLT
	 drLQR1zABDHIvZUnHy3ctJJ5l00w+iX9i6xXxYiMi4SqSRuGmQPqXQDzbgleE2FTP1qyd
	 3Lg6Z3RZFx7cxyENRNrNyrFhtc86KugNLVEFuqvk4QoDyCsqra4Tp+2O26qBlLm7wSD6n
	 BzkYJUbWKrJODJyPiLSpi9i6PRJHRgimts6uHhOuyP/bVSlQCD+g84ORF0OHn/eqtng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795808274;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=w4DCdH1N8UX2GtBtVnpn1DIaJ2/ES0rCVlhlxaDS3QI=;
	b=lNwc14+/fbkB/74o3gooTYsM1J0ZFCcJzSH4w5I9e6Sl9Jr2g+uP/a51CKLQWu3b20RS
	 Z07TbF8FYmKwmb/kkIrVIjJJK2y/BdyQIZcMAN10oXnCdnQkB5FNaVA5ZhAkxE1Rt7vtJ
	 bgGzjc/bLUWFGYUTbGBKxk/C7T5/U6KyqCEzKCHLaGnhXXiml7SMY/Ae0w7Ec+5FYmq5E
	 Qo46z2hhotsy71aAvVH/87Fp7IWURnpDhS61vUz3WxZGM4tXpX6gTP8TPOWvo7EgAGiol
	 WqXZq4nxom71rhffudzS4TnmvmjeDMB45knRu8P0yAYBP8vT5jBvXSYahBl+MPzCczQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bAlhb+iz;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F8B606A31C;
	Fri, 27 Nov 2026 19:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80F8B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bAlhb+iz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795808274; x=1827344274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zE+2E/0tKXQ7uwcDPT37wQcSd57BL3umH2kOyf1J+i4=;
  b=bAlhb+iziAkVsuGwvQPOcebXpacqpdxC9S83KGxilhaS/xqlnc+7wQZ9
   UXZ1RkYDIHRImezCR8uvdCeY7i6ZP14ZAIGC/POztBvSdYN1xqBzAHK8d
   GvHns7alfO6bD2D+Vt1ZvYlmVuaTXoQCSZiCeppAAhBunQjeSQakQIcwY
   W9l/ylF3YSJfWsA4BbAi3HTvoMnnV9I7w8HY8fWOsmyDAPupxzW7lwB1H
   +s3SJW2+Lu3l15vi5au4Sqc9910UvvXPBDxTilvPMvOLscbYUz91iDgp3
   lPsum2bm+ZTbxQEA7cecw8Uzi+vjLrBnxdt6IBbc2Eieu9koXm5v3ktmt
   g==;
X-CSE-ConnectionGUID: HVssfeUnQcm6yEtcB+Sh5A==
X-CSE-MsgGUID: qzyZDu3nQsG6D0h1cCLpeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4628005"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4628005"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 11:37:53 -0800
X-CSE-ConnectionGUID: DVB8FTOOQ5GNP2Nufelj7g==
X-CSE-MsgGUID: SBA8Mns1SkGxD8bxpMD/Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="14219744"
Received: from igk-lkp-server01.igk.intel.com (HELO 146cf1e082f1) ([10.211.93.152])
  by fmviesa011.fm.intel.com with ESMTP; 27 Nov 2026 11:37:48 -0800
Received: from kbuild by 146cf1e082f1 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xX1lS-000000000Ks-1jDf;
	Fri, 27 Nov 2026 19:37:46 +0000
Date: Fri, 27 Nov 2026 20:36:54 +0100
From: kernel test robot <lkp@intel.com>
To: Alexandru Dadu <alexandru.dadu@imgtec.com>,
	Alessio Belle <alessio.belle@imgtec.com>,
	Luigi Santivetti <luigi.santivetti@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, imagination@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org,
	Alexandru Dadu <alexandru.dadu@imgtec.com>,
	Matt Coster <opensource@mtcoster.net>
Subject: Re: [PATCH 3/6] drm/imagination: Save metadata from firmware
Message-ID: <20261127203348.WkidhfEf-lkp@intel.com>
References: <20261125-b4-commonize-fw-segment-loading-v1-3-69657fa52ac3@imgtec.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-b4-commonize-fw-segment-loading-v1-3-69657fa52ac3@imgtec.com>

Hi Alexandru,

kernel test robot noticed the following build errors:

[auto build test ERROR on c88084027d0e922dd925b96e5a0d184ba04a8f43]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandru-Dadu/drm-imagination-Remove-get_fw_obj_gpu_addr/20261125-134829
base:   c88084027d0e922dd925b96e5a0d184ba04a8f43
patch link:    https://lore.kernel.org/r/20261125-b4-commonize-fw-segment-loading-v1-3-69657fa52ac3%40imgtec.com
patch subject: [PATCH 3/6] drm/imagination: Save metadata from firmware
config: arm64-randconfig-r2102-20261127 (https://download.01.org/0day-ci/archive/20261127/20261127203348.WkidhfEf-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127203348.WkidhfEf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127203348.WkidhfEf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: pvr_exp_fw_support
   >>> referenced by pvr_fw_info.c:150 (drivers/gpu/drm/imagination/pvr_fw_info.c:150)
   >>>               drivers/gpu/drm/imagination/pvr_fw_info.o:(pvr_fw_load_metadata_and_device_info) in archive vmlinux.a
   >>> referenced by pvr_fw_info.c:150 (drivers/gpu/drm/imagination/pvr_fw_info.c:150)
   >>>               drivers/gpu/drm/imagination/pvr_fw_info.o:(pvr_fw_load_metadata_and_device_info) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
