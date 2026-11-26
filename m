Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669978;
	b=LrwJcRzZQAl8XVdz6xHsDQcIiS3zGfjs0CvV5At5HVxbOomcTmhQMw1MICpIKoVOu/ak
	 qEZlZ0hTikuz/ix/ICYqS6hYgSWEjOIpCp92Y9qYsv35TDV5rOf68wO4b+WMb5exMKry2
	 9Hf3/FitYQ2FbtfVgyG4t5VyvFmOLF67rqWA/p/uTmAE6SAAaJ00cTMOtpcHFkKx8+BwX
	 IPL55wdBPUMa2VuACjrlg9gDCsubYNsNNJvq5KH2l2anbQSHtzcoX/4AQJ34Chi0Hh9/h
	 Fb9ZngQ89VhJmlEtNrFDqQWTSOviJnVj+81XyoN/L4HrWgJ20nk4L/5Eyk/M4kEQOMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669978;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NWrQlHdndkQpP/UsFk1jr4UJq8XO0pP/4sq3hQBHB9I=;
	b=0tUGnNLlo5S71+2vo7N/N+pUmZBmVDwy3qZugiyTNKPAjKXYu+VAAfkhtzySyl2guYbO
	 671i2Vm5lTpzXdqypI0O7mLOItZVXrbxGKzol41Gw50SXZmAkjGoCo5zoWpbIuFvk5wnq
	 6+NsDdtvbvhZ6D7aE2v0cELqkmXSR4ko1srmaBUzuGoWvpKiRjdIeFRgZv1SBS1H03lzm
	 blmoXZzgZhDnx++4ud18Dzg4hhC82qbFOeSrLu53F0wUMVyHYyJNc4Q+KDQS4ET19qU0h
	 n2F4WfJaM9osu+V5Afl42JelQWPL/ivQ9Ckypn0y38/ZFpLHqHB9NGA5JTkOYQm2xBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Lq0b51tc;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1415B606A31C;
	Thu, 26 Nov 2026 05:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1415B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Lq0b51tc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795669978; x=1827205978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NqKhtBpJzofc/sJUBakwaXOayso/8xRaZnEIKxBMMEs=;
  b=Lq0b51tcsARYWLIWz1anX59ZBGIBS+ybu+IQhROW3UCSXIytxASPztaj
   pn9OFIEu92PjHiiaanflTQxtJE1cC6+Edy1KqP0PtnMYvmtMQaPX4W9Fn
   H1FpNwYRHCeknDqaTSbNS/jXCJR7VzYVci/3iO4q7dUVixtFGuxxra+9e
   XxIS2Co61yH2SZqfPVrwlAVGyopvdP1QZef/cT1XFfmC0HkcSkb62KZfe
   iT/zBaGPonnOr45iD4zf1V76APTMrvRC8Cqx63TMgYE6crcLSgRW89qI5
   GEvkxvxKjGzbsKJl2z6OL6ZoEOtIcbTNMMmxWNorE9RkuryXhZqbRYWpz
   Q==;
X-CSE-ConnectionGUID: kl1evThKTbmVlHNN6S/fLA==
X-CSE-MsgGUID: 4Sli+D+PTCSMyWwirefj4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4632446"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4632446"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 21:12:57 -0800
X-CSE-ConnectionGUID: Oj6siLx/RmWUXqQXQG7QTw==
X-CSE-MsgGUID: DzDwKbanSm6fIbND0dzqDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="14112070"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa013.fm.intel.com with ESMTP; 25 Nov 2026 21:12:53 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWRmr-00000001TJi-3Ik9;
	Thu, 26 Nov 2026 05:12:49 +0000
Date: Thu, 26 Nov 2026 13:12:19 +0800
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
Message-ID: <20261126130340.K8Rznt4t-lkp@intel.com>
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
config: arm64-randconfig-1003-20261126 (https://download.01.org/0day-ci/archive/20261126/20261126130340.K8Rznt4t-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261126/20261126130340.K8Rznt4t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261126130340.K8Rznt4t-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/gpu/drm/imagination/powervr.ko: symbol 'pvr_exp_fw_support' undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
