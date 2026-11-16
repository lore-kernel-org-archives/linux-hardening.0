Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794794255;
	b=YtVdW8tE4f5yE8P6z8A4pFTzRwJbubDSXU3r8lp74UOYnOVw2HjXORVOCzJF9MQEGoVG
	 aLijVysM2vkNwOfyYxlT2/mX2nw3PDHwlL4mRZVkpW9VwtiJS8s0DxF8XOBFkMM/3mxOn
	 NOz45z0fjgWtsIkRE0iYltVUh0cUL/PbBHycxHgpsZ2BrRyx44w+Cd5Mk1eo+0QxZtO0L
	 9OI59Bu1LZb11FqMesz5Qq4mGG/zLQVCIboypdZWI5An+/wEp2agPro2sN9FQ8JccjjKH
	 x0viqJDdQThpGfCqsP6v6xCZKJxJ2y7HXm2sR+CWM20A4sJWmKHOHmuoWDDMYup2o6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794794255;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7mjaddvdfdXIqJHMDGeE0zxMt8d1OR3a8cVa2gY6S28=;
	b=wW0RoGxakATsyxmkI3tLXWbRsjrVmr0mxhxCmhOfc0wQaxO/A0grdhHrXn/f5sfS1Byu
	 23sPN5s1ANZFYgrw7NxbbozKIjcSOEhURFXpOsMbKOiNTP1ilcbcUyz5/UA8nfE+pnA57
	 PrPSR68B2L1m8Vk2eqUCAFgU6hLHgJnm3H65cho6nZM7AyAr9tYxp3LFuW4zFOfxsCcET
	 U7ue//cw5ROCxHiMaZJhMvHR0NgECfPMWuNKbnwNf9K+FVeSfVrL/Y/0ouhMmyUIm9C1w
	 4iw7FIgwuoDtjcawJzx8f18JrQEh4RONSej4BMYZOrLFgAwVL2e2Um1uVfmxiL+x11w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YZr6S5Md;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7593606A31C;
	Mon, 16 Nov 2026 01:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7593606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YZr6S5Md
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794794255; x=1826330255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gr3NUTKOR9X04vWpQlUnShjx5c3VBNHn9Snx+3Wmlv8=;
  b=YZr6S5Md1rpkdV4o6QEB7JdGWa5J2flkI64uqhLRPc+fo0pjAGHYummC
   D06G36PQCmoj7iUz3MdAdtwseOsZT3nDV5WHvyLk3KS+4iv2zqKUENtRV
   uREc4i2Vb1sc+jGJw4JB0OvJHmYxqffhqubbOe7HJkOL6Se3oRJeCQ2+h
   LJiol9gYlMoS5PYSjVDlFnIKxxmYOba5TpeAu1g81oKOkUAYyxqeKrpo7
   PA5/s151cI0aEcAaN7OfBoSEv+P7NjBbm7sNzcVT5ajGYeV8QUtZ5VsN4
   ivNIjzwwF3XjViHMLYWZ04mk7X1xexNlNZokgDc6ZCzBHfhv0XVxoVzM9
   w==;
X-CSE-ConnectionGUID: 8AGO8sOiSnOwwz4zRR1wZw==
X-CSE-MsgGUID: i3xaBU6gTBiUQTPVsYVCgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3537210"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3537210"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 17:57:35 -0800
X-CSE-ConnectionGUID: IADebuhCQ4CUXARAYLMORg==
X-CSE-MsgGUID: FuyDH1K1QKOl3dWmwOcyIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="11202770"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 15 Nov 2026 17:57:32 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xSlyL-000000017eC-0say;
	Mon, 16 Nov 2026 01:57:29 +0000
Date: Mon, 16 Nov 2026 09:57:18 +0800
From: kernel test robot <lkp@intel.com>
To: Sasha Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_buf: always inline seq_buf_terminate()
Message-ID: <202611160950.wYHyNZ3g-lkp@intel.com>
References: <20261115153430.1607764-1-sashal@kernel.org>
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
In-Reply-To: <20261115153430.1607764-1-sashal@kernel.org>

Hi Sasha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7b8cd26b6aab8cf147165610d13964f79200a5a7]

url:    https://github.com/intel-lab-lkp/linux/commits/Sasha-Levin/seq_buf-always-inline-seq_buf_terminate/20261115-103429
base:   7b8cd26b6aab8cf147165610d13964f79200a5a7
patch link:    https://lore.kernel.org/r/20261115153430.1607764-1-sashal%40kernel.org
patch subject: [PATCH] seq_buf: always inline seq_buf_terminate()
config: i386-buildonly-randconfig-1004-20261116 (https://download.01.org/0day-ci/archive/20261116/202611160950.wYHyNZ3g-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261116/202611160950.wYHyNZ3g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611160950.wYHyNZ3g-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_set_overflow+0x1 (section: .text) -> bootup_event_seq (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_set_overflow+0x9 (section: .text) -> bootup_event_buf (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_set_overflow+0x13 (section: .text) -> bootup_event_seq (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_set_overflow+0x19 (section: .text) -> bootup_event_buf (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_set_overflow+0x25 (section: .text) -> bootup_event_seq (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_set_overflow+0x2c (section: .text) -> bootup_event_buf (section: .init.data)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
