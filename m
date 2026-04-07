Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0B2377029;
	Tue,  7 Apr 2026 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775534380; cv=none; b=PUDRAz3MH8odl4ZUIa3462ElvRVE3htb3YjcXb4CtOyE9iEHgGHG0BLRwOWiB6oCch0v0jhuF5MxqRfcDCRUfka8V+Q6tT8qUcuoWqfzqTUTugibj5Wfj2w2mePu4FboHNzY54b+jYWrwOkjB9CE9kSgCC2Sz1s8eXVbrPD6RTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775534380; c=relaxed/simple;
	bh=Ase9yzhgURxLh2inH9YOkEhoVRuNbYu6x85jbm/4++g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJmNg1A23TR8HyiosCsVgF9XVeDGanHLEdmoBCINAjMScU4oxoJ5Gw7BlQyFeoD1U6Y/LPIwHt03f1/qZSZXlNeW7NzSzjibE4FgUTQJQ9fLzSkdpAG2qYOTt1fJTWzX61hC3AxIs7S/3VEpPBwTxYg1nXnKW6pJhozAgKvzhZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkhM+C7G; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkhM+C7G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775534379; x=1807070379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ase9yzhgURxLh2inH9YOkEhoVRuNbYu6x85jbm/4++g=;
  b=EkhM+C7Gito6ULGaTEMuUh/gIkfOB0odiKwScB3nTVDkZADU5yIYL+d6
   J9eo67p0Yk8/BfhcvRApSYzPWKwv/LtiMN4WhIOV0TvxAzar0ACML4/Ye
   idh59O7Y+GjZbgYhoODb6k9Ns6P3JxlJvnFZFP1qnrhob5QTpiI0YzM4R
   H3xVJE1WyqfH1wXNamcWc2e2VMEN4xNCAaV8Hp/i0aKkHQOS7+ZKWa8E3
   hAFGzOFL8PttI9ITXQ0yIMgik5wOq7ENQqfBX/CzIzoKfyEZfFn+oWE4P
   kiTtf4rRBOUlN5qDIsfrAOaFiqeWNuO9gePG7ZTYJ+bp4RGcoGChZ3ODK
   w==;
X-CSE-ConnectionGUID: dSKu17CvSW6x/cS/H9Xsjg==
X-CSE-MsgGUID: mbaJcmK8RNaz3KFAh2vPPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76369616"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="76369616"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 20:59:38 -0700
X-CSE-ConnectionGUID: knZuKt7BRxueIkL6XT/p5Q==
X-CSE-MsgGUID: joojJ0QZQNejMY+mAtLN1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="232091432"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Apr 2026 20:59:36 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w9xbB-0000000006h-1ANo;
	Tue, 07 Apr 2026 03:59:33 +0000
Date: Tue, 7 Apr 2026 11:58:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	kees@kernel.org, tony.luck@intel.com, kernel-dev@igalia.com,
	kernel@gpiccoli.net, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] pstore/ftrace: Factor KASLR offset in the core kernel
 instruction addresses
Message-ID: <202604051301.skV8JLnH-lkp@intel.com>
References: <20260313201010.1622406-3-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313201010.1622406-3-gpiccoli@igalia.com>

Hi Guilherme,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on kees/for-next/kspp linus/master v7.0-rc6 next-20260403]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guilherme-G-Piccoli/pstore-ftrace-Factor-KASLR-offset-in-the-core-kernel-instruction-addresses/20260315-152241
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
patch link:    https://lore.kernel.org/r/20260313201010.1622406-3-gpiccoli%40igalia.com
patch subject: [PATCH] pstore/ftrace: Factor KASLR offset in the core kernel instruction addresses
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20260405/202604051301.skV8JLnH-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260405/202604051301.skV8JLnH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604051301.skV8JLnH-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "core_kernel_text" [fs/pstore/pstore.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
