Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794790384;
	b=veEk0M1ndnVsTFO8SES0hoOhxNEhscMiQ3YwTyUcVHPx5W8JV8SntndEyQWVzBP0XoX9
	 l9SWcVtfEL9DRIQ0mJt6+RLgodoIZVHHPVt912sRqN5sq56PWoiyZ8mfbMPtcxzF/zOEg
	 1C/ylvLknFwsy/aj0X7I47vstLb/5X8IWTRcEhla7tNyqhE8zjwytHALxkkW97JGR0tz8
	 TRwf+SQ6zOjm9v1tpL2vO5xHNT7RV0SwdYq0H+OwG2/OaqtC65BHsZ7HNzOPjXb6iHcbM
	 IPkrIq5H+XQbA3ImjVHF3tvCbEPzEIjK80A/CwqKTAmzt27nhAOjIxYNCCKolLFUtCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794790384;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=TbXR1DlKKuOwhV3PqlSfdkNh4TOa9cw6NjlogJdKa+E=;
	b=mDoRDuR+GP1qnQUvsQW3oH18fjhg2hH0LwWwq3obBcEZAVopMzEMLY6L0/0hRfpBzxxR
	 Zfx3rc23irOIj8xyvgWpVY8/HB221wR/7hhwNr8Iu+ZbNd4cq/oPd4DC7KUeYlkLKTaY9
	 KUFG/mUWuzmyQJznEw6cM48tGfWgZH1LIv4LWIDiePJYNYQ1v2Gy9rUVycS6TjwGkMPav
	 J9iU2xCqelbClVZyZYpqclqnDf80EcLjv/9U7qPZY4yg4vjgFDR+jPUiijx2e1hER4zFE
	 gPUVgpRjsjsk8yTdt65ps7kCN8csL7++HLSCELMUC3YBOgchKiDgc2xs0jDobPm/WAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ov0zrn7S;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35A8606A32F;
	Mon, 16 Nov 2026 00:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D35A8606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ov0zrn7S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794790384; x=1826326384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oC4EL+G54eJpi+ckY286iUB3+w/3VL3BuLJIsdbKVSo=;
  b=Ov0zrn7SH4OOOV0OUcesz/WiMjxwqCq9H7EucNOcS9TrGeRB6eshldqG
   MJrSQZEHPgXjAyJ409UqbaPENJfZiNVyUzXObKkE6iJu06Qo923sIBiF2
   oj6yTGNeFJSCmXKKPU8/ZYTiYILBESNJKym5LYOT+4JdBmGaalDd4GBZK
   G7PWZB7biuB7aAeIwcNvD7pMi31DzMGSwSui3HFG7gg+9WFrHINBHee5s
   qbpe2EQPYSkTs27hwk5IBoz/ViX827JYDG8xiWQ78+1j7zW9GanEFOApI
   XVEoIhGhfDXgHxSMVTjOAil8mTRCEVWKWJD7XxCaE74wCQtEFgICytJtm
   g==;
X-CSE-ConnectionGUID: zk/I/jEVRJqNssHpk3ITEg==
X-CSE-MsgGUID: AszOYwQgTEa+uPsMBFIgbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3436245"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3436245"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 16:53:03 -0800
X-CSE-ConnectionGUID: XlWbHG4ZTUaLA2VnjtdcFg==
X-CSE-MsgGUID: qIe+KKi/QrmnQzUK/p+f1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="11141439"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa012.fm.intel.com with ESMTP; 15 Nov 2026 16:53:01 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xSkxu-000000017YW-1ua5;
	Mon, 16 Nov 2026 00:52:58 +0000
Date: Mon, 16 Nov 2026 08:51:54 +0800
From: kernel test robot <lkp@intel.com>
To: Sasha Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Petr Mladek <pmladek@suse.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_buf: always inline seq_buf_terminate()
Message-ID: <202611160835.RPhYOuAv-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20261116/202611160835.RPhYOuAv-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261116/202611160835.RPhYOuAv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611160835.RPhYOuAv-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_set_overflow+0x3 (section: .text) -> bootup_event_seq (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_set_overflow+0xd (section: .text) -> bootup_event_seq (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_set_overflow+0x16 (section: .text) -> bootup_event_seq (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_set_overflow+0x1d (section: .text) -> bootup_event_seq (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_set_overflow+0x2b (section: .text) -> bootup_event_seq (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_set_overflow+0x35 (section: .text) -> bootup_event_seq (section: .init.data)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
