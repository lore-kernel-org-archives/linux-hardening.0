Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5B2EA480;
	Thu,  4 Sep 2025 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988917; cv=none; b=KPxN1uEpG/mP4MgAVbLQKpm4aQXpjjHM5WSYhR8A2mkUrOaNcVFUjzJGR8p6uoDP/ts6ZSbZbVNGgpGiXmMuupR7mnMfWl2FW5btvm5lBJtJH6E/Rsub7JGkKNMEzLYPUHZGk1s6s9ndWYQJa9Y8INy6xRIAjdxiDdl+3sS/7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988917; c=relaxed/simple;
	bh=3kXMsEvtVTGzcyhvJNBolHNZKok6L0CuTxiUsIfG3nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScWww3KearYBvnPdvgpIb5F2px9vTxpBPa6iCVWVxoVHQ6rIGqvkAPVidLmCmGv2LNUaS61zA4BtCNp5pas3TTEI1PR3HJs+PSartAst9KaPJD0814hhWGsXUZHNwQxCrOLpJk5CzXSMPeXuIuIEAtP/1gnueBBkc8iGuDyFmR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZGRaPS2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZGRaPS2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756988916; x=1788524916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3kXMsEvtVTGzcyhvJNBolHNZKok6L0CuTxiUsIfG3nk=;
  b=aZGRaPS25Pcm9Gv+fpgW3Kvgrg/wSp8IoR5gDP+VMksvFiwLhtQHoE28
   zxdaAx8F9Qc7BmGN6Re1G7I8lBxZVyvHtMitwOD65VeDbfFAq4FBSm2X8
   A6ki87pCqaJ5T9VxE8t0iUOHw//r19JBUgoGH//O8AbwqwRKk45n6KFIr
   Tdg5HdJbnDa+NRBGY5segxin8DItzG1685/5tgg2ajayE0YSLN0SPz8P+
   xzSgi3DkfT2HoQMQWTemxDn9e+gD3wfkYFikGvA200yNaWMUc/HEFYOne
   XF6/ncqip7RNs3zNHuLSB5uORJdVkvq4IM0VzTD51S5lEuHTstAk89Lpt
   Q==;
X-CSE-ConnectionGUID: QAcxiTqETZK3huwMlJ32ag==
X-CSE-MsgGUID: MhQGH8yMRfKIOU/22GnvBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70420812"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="70420812"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 05:28:36 -0700
X-CSE-ConnectionGUID: IDJ6lS2mTt2m9S789U3zXQ==
X-CSE-MsgGUID: nKkv4LIVRSW6f7ykFF5arQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 04 Sep 2025 05:28:27 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uu93x-0005Hz-0p;
	Thu, 04 Sep 2025 12:27:56 +0000
Date: Thu, 4 Sep 2025 20:26:32 +0800
From: kernel test robot <lkp@intel.com>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>, git@amd.com,
	michal.simek@amd.com, alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
	jarkko.nikula@linux.intel.com, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
	shubhrajyoti.datta@amd.com, manion05gk@gmail.com,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: Re: [PATCH V3 2/2] i3c: master: Add AMD I3C bus controller driver
Message-ID: <202509042018.CCuFpnkb-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.17-rc4 next-20250904]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manikanta-Guntupalli/dt-bindings-i3c-Add-AMD-I3C-master-controller-support/20250903-220233
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250903095906.3260804-3-manikanta.guntupalli%40amd.com
patch subject: [PATCH V3 2/2] i3c: master: Add AMD I3C bus controller driver
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250904/202509042018.CCuFpnkb-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250904/202509042018.CCuFpnkb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509042018.CCuFpnkb-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/i3c/master/amd-i3c-master.c:182:9: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     182 |         return FIELD_GET(XI3C_RESP_CODE_MASK, response_data);
         |                ^
   drivers/i3c/master/amd-i3c-master.c:338:29: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     338 |         while (cmd->rx_len > 0 && !xi3c_is_resp_available(master)) {
         |                                    ^
   drivers/i3c/master/amd-i3c-master.c:102:8: note: expanded from macro 'xi3c_is_resp_available'
     102 |         ((u8)(FIELD_GET(XI3C_SR_RESP_NOT_EMPTY_MASK,                            \
         |               ^
   drivers/i3c/master/amd-i3c-master.c:382:29: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     382 |         while (cmd->tx_len > 0 && !xi3c_is_resp_available(master)) {
         |                                    ^
   drivers/i3c/master/amd-i3c-master.c:102:8: note: expanded from macro 'xi3c_is_resp_available'
     102 |         ((u8)(FIELD_GET(XI3C_SR_RESP_NOT_EMPTY_MASK,                            \
         |               ^
   drivers/i3c/master/amd-i3c-master.c:592:20: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     592 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                  ^
>> drivers/i3c/master/amd-i3c-master.c:592:30: warning: shift count >= width of type [-Wshift-count-overflow]
     592 |                 pid_bcr_dcr[i] = FIELD_GET(XI3C_PID_MASK,
         |                                            ^~~~~~~~~~~~~
   drivers/i3c/master/amd-i3c-master.c:53:26: note: expanded from macro 'XI3C_PID_MASK'
      53 | #define XI3C_PID_MASK                           GENMASK(63, 16)
         |                                                 ^~~~~~~~~~~~~~~
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:20: note: expanded from macro 'GENMASK_TYPE'
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/i3c/master/amd-i3c-master.c:835:6: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     835 |         if (xi3c_getrevisionnumber(master) == 0)
         |             ^
   drivers/i3c/master/amd-i3c-master.c:90:8: note: expanded from macro 'xi3c_getrevisionnumber'
      90 |         ((u8)(FIELD_GET(XI3C_REV_NUM_MASK,                                      \
         |               ^
   drivers/i3c/master/amd-i3c-master.c:925:15: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     925 |         info.pid = ((FIELD_GET(XI3C_PID1_MASK, pid1_bcr_dcr) << 32) |
         |                      ^
   drivers/i3c/master/amd-i3c-master.c:925:55: warning: shift count >= width of type [-Wshift-count-overflow]
     925 |         info.pid = ((FIELD_GET(XI3C_PID1_MASK, pid1_bcr_dcr) << 32) |
         |                                                              ^  ~~
   2 warnings and 6 errors generated.


vim +/FIELD_GET +182 drivers/i3c/master/amd-i3c-master.c

   164	
   165	static int xi3c_get_response(struct xi3c_master *master)
   166	{
   167		u32 resp_reg, response_data;
   168		int ret;
   169	
   170		ret = readl_poll_timeout(master->membase + XI3C_SR_OFFSET,
   171					 resp_reg,
   172					 resp_reg & XI3C_SR_RESP_NOT_EMPTY_MASK,
   173					 0, XI3C_XFER_TIMEOUT_MS);
   174		if (ret) {
   175			dev_err(master->dev, "AXI I3C response timeout\n");
   176			return ret;
   177		}
   178	
   179		response_data = readl(master->membase + XI3C_RESP_STATUS_FIFO_OFFSET);
   180	
   181		/* Return response code */
 > 182		return FIELD_GET(XI3C_RESP_CODE_MASK, response_data);
   183	}
   184	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
