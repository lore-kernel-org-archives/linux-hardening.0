Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2A82749E5;
	Thu,  4 Sep 2025 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989509; cv=none; b=KnVqJAn+IDYALgdP46NnZd6SUpaegsNVTXxeP13DEf7qUF5yKnEAJA3y/7WFLOcrT0mCXf/BHz1n66qAOYnFzKmWWj1ZxyQwfZ3Kvt9Y6pjs+CX/KXMhgRq5fiyYaBZgeHikQL3XIp+1170oNiU3vEY+VhZJIbFDNPgnPhK4Qeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989509; c=relaxed/simple;
	bh=FBGLD3KXpGnBfJUXJqFViPTZk56264NLPCfYoX+fVpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7O/P6syHiwicHgVhekykvjOf7eLXUnY8AR04A1LPZYP3uNqQoS1+CvLUg+F96+yW1qH1PuOur9fMsD0UCoiphGodgw8cvkET4Iyy0hO/DFyWPKAjiz3gr2RPbxYkBJi7Ad0X1Y5oJ2nOUpyMkOnnGdfICv7u4OwA5s54eP6sis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5TcjKiq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5TcjKiq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756989508; x=1788525508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FBGLD3KXpGnBfJUXJqFViPTZk56264NLPCfYoX+fVpM=;
  b=M5TcjKiq2zQSbtSJABbQLujviAwxhupadab6b0fqa0Zf8EU3j8kXrsog
   MhWRLSTiKRNVoV7medXyPztMiA/ozYT9ymB6yA2TU0eli2fMWSmxCfdOE
   xSZUUSCsNwPfJlfBrF1Xz6TAS36XNeVtMYYzGPsRDNzHTfSn83+yTw/qv
   CsUhq1CDSUexTkPjyS2oD8zckyppDg+UNlow+TGSgJf3jEPLXfDrfbhNZ
   97Ej4zGWp82Oz1s86G/xadli4/qGwyCkplqXlecK+BMMmYBv7XysTrk1q
   4HIYWyam6/3VX8Yq5sI39h1TImE0ua2OPJwg7qbX56XNWgWEWRebp72z/
   Q==;
X-CSE-ConnectionGUID: CCI12jfVS/GojIH6OgrjCw==
X-CSE-MsgGUID: tNDq1kz3SsakGgwhb5QZpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70030657"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="70030657"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 05:38:27 -0700
X-CSE-ConnectionGUID: nO4eeNixTqKJl6ZGSDOJpg==
X-CSE-MsgGUID: uVrUxsVqSRSnPCJvRO0NNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="176223164"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 04 Sep 2025 05:38:22 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uu9E1-0005IF-0F;
	Thu, 04 Sep 2025 12:38:06 +0000
Date: Thu, 4 Sep 2025 20:37:31 +0800
From: kernel test robot <lkp@intel.com>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>, git@amd.com,
	michal.simek@amd.com, alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
	jarkko.nikula@linux.intel.com, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, radhey.shyam.pandey@amd.com,
	srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
	manion05gk@gmail.com,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: Re: [PATCH V3 2/2] i3c: master: Add AMD I3C bus controller driver
Message-ID: <202509042006.MI4nEHWs-lkp@intel.com>
References: <20250903095906.3260804-3-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903095906.3260804-3-manikanta.guntupalli@amd.com>

Hi Manikanta,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.17-rc4 next-20250904]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manikanta-Guntupalli/dt-bindings-i3c-Add-AMD-I3C-master-controller-support/20250903-220233
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250903095906.3260804-3-manikanta.guntupalli%40amd.com
patch subject: [PATCH V3 2/2] i3c: master: Add AMD I3C bus controller driver
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250904/202509042006.MI4nEHWs-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 2e122990391b2ba062e6308a12cfedf7206270ba)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250904/202509042006.MI4nEHWs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509042006.MI4nEHWs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/i3c/master/amd-i3c-master.c:156 struct member 'daa' not described in 'xi3c_master'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
