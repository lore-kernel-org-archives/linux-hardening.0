Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858EE221F15;
	Thu,  8 May 2025 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746691719; cv=none; b=FlZ/uO51OmJ4st4/jnZs+LcplHDN+orxXAEj+wx0uPumQ2i5KLT5zd8tTkEMIhwB3VwAYkQhqttMHFuZpJ8ecp6xFn7QP62hvH4RF2NUjIylEjHy4dmNQvS3e8kynQ2kthZspN2ucplUwAwHLPz0Ew9kDVFQZhu4e6fDatz4yaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746691719; c=relaxed/simple;
	bh=jYdN33+CJ/NGBhRXvU2A5aABgKMcpgRwc9o3lmxpjCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7xmnZF8lAegRRpMtErlFge61AuqcCBZX9QSAuiMwUpQCGPEshjyyoGpySIR/bXwtl+0V83BSRgqW2DRNsDJE4GOGdPeX9P1DOIVOiQUnHu6jq+oT40tgyDtf4yUk349in/AXng/J9VP0vlVtfqPWOikTgosy9OCPFteMmFh/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MurQgMPM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MurQgMPM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746691717; x=1778227717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jYdN33+CJ/NGBhRXvU2A5aABgKMcpgRwc9o3lmxpjCk=;
  b=MurQgMPM+nPguPnVXulki9gt1df10uKCo2hwTSHs04LT3C0v2sT8bRRG
   D/4Pf++JEF7vgNR+LVSQm41hwvt+L4ADEruvyp0WJL3O76lT5FgPwVAec
   sAucgwNnkns106EieOAe2NSJt1OWj9qIkgtnQ1J18eRT8hXqf79aImYSX
   CJALWc2mpt6/kb5J/O5rBRXRq6lXYzo8+A3mvTZPgyfeJZJDCY6Z2JSUq
   vk66T22PlF40uIxpsVm9cr6ItnSKbIcvGZLm7/shL/wzq4PcrmFfxctUx
   NanhM2HO2GwDrJSoGqt9VSJzCm7H7CBXpSzZjQjM5mx8yk8XryjixFubb
   w==;
X-CSE-ConnectionGUID: n8nqQxq8QQepYV/oc+mjaQ==
X-CSE-MsgGUID: y9k3D3xYQLKqAPPxKViqJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="47718460"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="47718460"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 01:08:36 -0700
X-CSE-ConnectionGUID: i36FOlqRRMSFknar2JOmnw==
X-CSE-MsgGUID: prix0mQBSAG+iF7lVc6ohQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="136713973"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 May 2025 01:08:34 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCwIx-000Am9-2e;
	Thu, 08 May 2025 08:08:31 +0000
Date: Thu, 8 May 2025 16:07:54 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v2] printk: ringbuffer: Add KUnit test
Message-ID: <202505081550.KMstgTUQ-lkp@intel.com>
References: <20250506-printk-ringbuffer-test-v2-1-152200569eb1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506-printk-ringbuffer-test-v2-1-152200569eb1@linutronix.de>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0af2f6be1b4281385b618cb86ad946eded089ac8]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/printk-ringbuffer-Add-KUnit-test/20250506-200133
base:   0af2f6be1b4281385b618cb86ad946eded089ac8
patch link:    https://lore.kernel.org/r/20250506-printk-ringbuffer-test-v2-1-152200569eb1%40linutronix.de
patch subject: [PATCH v2] printk: ringbuffer: Add KUnit test
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250508/202505081550.KMstgTUQ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505081550.KMstgTUQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505081550.KMstgTUQ-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/tests/slub_kunit.o
>> ERROR: modpost: "prb_init" [kernel/printk/printk_ringbuffer_kunit_test.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
