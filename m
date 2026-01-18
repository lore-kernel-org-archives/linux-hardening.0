Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2EC14D29B;
	Sun, 18 Jan 2026 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768734762; cv=none; b=ES9bQyfXWeGumwF25ON5TgzUlxSooUyVBIMW9HRi4YfjMSMeaRbVsmkmgyjw4GE8p22CgvEqud0CYQaA3+IYapDiGJQ4sIbaEAOrpHY12huaalPLb4S90A56NqGN+plR4Aj9iuJqY5CnmwQzXGMWDb78OGgEfVi0LF9Jg+PVRhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768734762; c=relaxed/simple;
	bh=HHxCyNzV3yInMvStIhW6ArCPtYeGfj46Oo+tdRp799I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9UY3JEU2pDAXYLV2/9Y592WDZAGkeOVAKELdzhxZFOf3/kGsvSzl51jxqjbDnJFreETp0DW7zsBCwYdffx1JJ76L3+Fs2VK9iBTXDffEiIzzuQXZ3SRcGqgppgpLe6ZixVLn4ae2mT2eb5OO7/72SL+5PJ63mLQYPMBH8TIfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VIYLDly8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VIYLDly8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768734760; x=1800270760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HHxCyNzV3yInMvStIhW6ArCPtYeGfj46Oo+tdRp799I=;
  b=VIYLDly8zZA0D68euPym3FUzKeIyuYJgMe8h6GT2/AyJB+EdvgKop2Hf
   Ufm7t7IXfrqOjmXat7ZK/Hz2apf7OWfCzpajXlUU0xpEwNNeUzfLafJoS
   TfPKGj+jRp9oTwlsr6oFCHGqV9vbQea90i0K82oDH8BtjiNRFhVkr3uYK
   +ynO7KF8/Fqie81+6JBtPmDlTgbiwU5eCiDEgjeoRf2PrkfdOMJTwZVrO
   oqzGaYYgHbEoEkrwO4EmSWsBjTYZKMoUrZxkxeLUrT/wdun0dJn9rqjZS
   a17VHTPydmIzL8JKXFcRTpbAyPdgKGfO+0UaRHRFGo7nRglKZgTxTVUMb
   w==;
X-CSE-ConnectionGUID: e4uMK4x2Sn+jB2F93cJkgw==
X-CSE-MsgGUID: 0xfHv4YrRNORQNiO+YzVVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11674"; a="92644629"
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="92644629"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 03:12:39 -0800
X-CSE-ConnectionGUID: PIXJ2vq7QNi5BYlfWbWcDg==
X-CSE-MsgGUID: peddX7tYQkWOJ3/j2M7omw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,235,1763452800"; 
   d="scan'208";a="204775832"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 Jan 2026 03:12:34 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhQhr-00000000Mtg-32hi;
	Sun, 18 Jan 2026 11:12:31 +0000
Date: Sun, 18 Jan 2026 19:11:32 +0800
From: kernel test robot <lkp@intel.com>
To: Feng Jiang <jiangfeng@kylinos.cn>, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, kees@kernel.org,
	andy@kernel.org, akpm@linux-foundation.org, ebiggers@kernel.org,
	martin.petersen@oracle.com, ardb@kernel.org,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	samuel.holland@sifive.com, linus.walleij@linaro.org,
	nathan@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 08/14] lib/string_kunit: add performance benchmark for
 strlen()
Message-ID: <202601181845.EiSSqJu7-lkp@intel.com>
References: <20260113082748.250916-9-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113082748.250916-9-jiangfeng@kylinos.cn>

Hi Feng,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/hardening]
[also build test ERROR on linus/master v6.19-rc5 next-20260116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Feng-Jiang/lib-string-extract-generic-strlen-into-__generic_strlen/20260113-163741
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/20260113082748.250916-9-jiangfeng%40kylinos.cn
patch subject: [PATCH v2 08/14] lib/string_kunit: add performance benchmark for strlen()
config: i386-randconfig-015-20251207 (https://download.01.org/0day-ci/archive/20260118/202601181845.EiSSqJu7-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260118/202601181845.EiSSqJu7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601181845.EiSSqJu7-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [lib/tests/string_kunit.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
