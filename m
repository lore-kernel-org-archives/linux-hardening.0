Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276422DE6F8;
	Sun,  1 Mar 2026 05:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772343655; cv=none; b=FS8PH1M5CmbAegxge/D9miip0rhuVzdg5M5OVTSCpsKfLEjevYpRTg8iUWx5uz/pS/VSl8l3+OjuDNeLueLhS7RmmuFA/nwI7mepLw8lREIe50QK+QRk5yDWROv5gRmzYlTlSODzM0wOCuInaj7e3hPY5YUGmdVImh2n3LLMBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772343655; c=relaxed/simple;
	bh=bX7Bh1sY4G62w/8Ni4dMQ5sJQC9mYDffOQ5bN4xsBXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAiq6RAQEDHXyurs6gJ+8TUrx54uPktRDvwON5XbLCVDSo3sFQKIHa5Dp4aulk26WUS3J8fS8lS0pNc7U+hkt5TmbutvjFDeqiCEZhvegduMsrKN8TNDy9s5fcUBL1fE30ML4fz4s1pEMEUzsbsjd333N0bJeJ9Z6/tIsSnMWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8twy93Z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8twy93Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772343653; x=1803879653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bX7Bh1sY4G62w/8Ni4dMQ5sJQC9mYDffOQ5bN4xsBXY=;
  b=E8twy93Zb2VGyKDL2tAZGvej0Dagw/pk3aYreOvOEEeeSYvtvCHp341B
   vcsQusuYCkeNU05iw4e1cCBKPeZJPtohQmqkXyjzlHNrADZ0QuAkz3jGy
   KSJcNJyzd397UDmVXXkg/54BXqZZpKbKtn7TvVWIWkksAxKK10w5Dpa0N
   5T9PARHwu8Wht0//lRmq7dvaaD+wuNeBA7/z0n82KHux6LqO9YLvnnFX8
   a4uGmB2kfTBSoDgQqs983OJROxlJOrbWoECsAnlaIYTjhnOHb4jWheoeF
   M3nJk5ATAWfzbreJ2pvdoXT3a2Wdbg+O0b8saxo5BXLnDsrJWLPZ13Nyn
   w==;
X-CSE-ConnectionGUID: VFF8UaoqQayiO5iAXlrnew==
X-CSE-MsgGUID: ywYTcYvXQoK5upjkxD5Rhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11715"; a="72409797"
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="72409797"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 21:40:52 -0800
X-CSE-ConnectionGUID: GZJ0svEdTPK1NcJt53chug==
X-CSE-MsgGUID: gjnKd4RaQFedczhA8nPaBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="221430091"
Received: from lkp-server01.sh.intel.com (HELO 59784f1c7b2a) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 28 Feb 2026 21:40:45 -0800
Received: from kbuild by 59784f1c7b2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwZXl-000000001Iv-1db7;
	Sun, 01 Mar 2026 05:40:41 +0000
Date: Sun, 1 Mar 2026 13:40:18 +0800
From: kernel test robot <lkp@intel.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [PATCH v6 29/30] arm64: kpkeys: Enable kpkeys_hardened_pgtables
 support
Message-ID: <202603011334.LWFx8OiY-lkp@intel.com>
References: <20260227175518.3728055-30-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227175518.3728055-30-kevin.brodsky@arm.com>

Hi Kevin,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f]

url:    https://github.com/intel-lab-lkp/linux/commits/Kevin-Brodsky/mm-Introduce-kpkeys/20260228-020115
base:   6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
patch link:    https://lore.kernel.org/r/20260227175518.3728055-30-kevin.brodsky%40arm.com
patch subject: [PATCH v6 29/30] arm64: kpkeys: Enable kpkeys_hardened_pgtables support
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20260301/202603011334.LWFx8OiY-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260301/202603011334.LWFx8OiY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603011334.LWFx8OiY-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "kpkeys_hardened_pgtables_key" [mm/tests/lazy_mmu_mode_kunit.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
