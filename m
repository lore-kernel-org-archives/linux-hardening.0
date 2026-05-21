Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B566339BFF4;
	Thu, 21 May 2026 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385636; cv=none; b=p2KhMsNvESY5ibPJSakE7DT7Pkt930P5cs3ZasToS1GeW5jKeP0oI2JsZmlhoo/ceQfqwt0ZxKaXUSdyYXjMnJJ9akpXTq4okLKUFW2UsxLfj4FWgDEi3ana2HvVjPu4Tf6bpU4bn5WReu0VwmR3RM9MM7NOYDraqjNuNuRFaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385636; c=relaxed/simple;
	bh=SG/bi0uKIZA2q0jyofyNGZhvUNh6QNcGl1aw2pgczl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJGJ+NZa62AQd0B59MhL5X5+ZdrThJNgsFSX4EHFmrYmgI7r9x9T+zT+mRhcF4P2ggr4sjv95RwwzDQAk2mlJnHh4OajTt0sGrPd4uwv3isvEMsvaQAPHVvOrNi5uP/OZTRZFO2QClTJ+uhySa/AW4qik3vwZ4u02jBMwOGODtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXUxcq6C; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXUxcq6C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779385635; x=1810921635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SG/bi0uKIZA2q0jyofyNGZhvUNh6QNcGl1aw2pgczl4=;
  b=BXUxcq6C4uDAcjDslXwKPsrKoL0Vd0iFUvKGYVvCnBU5jnWcADJM83sY
   XfX1onU6PWtD16V99389tCtItukLhL5VCbTo798zS+CjY8L0GqWLZ2pJ8
   TFGGs+l375y1GuItEQrKbXFFJRNuDqvLQUKu8gZsZRpgKdDk72MGsVxzr
   m/GKzfi8FcFuNs3EaJPIfuBchcMdQZAgHE7Kh6bosfRBliW45OND4DGSO
   KnMNmfzlUtqt3dlBC6OpOYdUdpPoqaq1EK0KNypREjVKCzX8Jb9t4TZLm
   JEFTESUPDPtJ1et+g5EZifa766udnTO4DouvwKL3BfLOuj42gXoFL7rEW
   w==;
X-CSE-ConnectionGUID: XUtzu2mLQj+yeH6Ok3waAg==
X-CSE-MsgGUID: d0UPqzhhQwyC1x6YcbXFWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="91704588"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="91704588"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 10:47:14 -0700
X-CSE-ConnectionGUID: BUfBpWnQQDKT7FMYHEQecQ==
X-CSE-MsgGUID: CCLjpKE9Ri6/exGrWVbINQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="270951214"
Received: from lkp-server01.sh.intel.com (HELO fdb68b0ce653) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 May 2026 10:47:10 -0700
Received: from kbuild by fdb68b0ce653 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQ7UB-000000000vB-129u;
	Thu, 21 May 2026 17:47:07 +0000
Date: Fri, 22 May 2026 01:46:23 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Kees Cook <kees@kernel.org>, Harry Yoo <harry@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/util: Use kmalloc buckets for kmemdup_nul()
Message-ID: <202605220158.VO5WnXl7-lkp@intel.com>
References: <20260521124026.work.036-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521124026.work.036-kees@kernel.org>

Hi Kees,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/mm-util-Use-kmalloc-buckets-for-kmemdup_nul/20260521-204404
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260521124026.work.036-kees%40kernel.org
patch subject: [PATCH] mm/util: Use kmalloc buckets for kmemdup_nul()
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20260522/202605220158.VO5WnXl7-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260522/202605220158.VO5WnXl7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605220158.VO5WnXl7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/util.c:37:22: warning: variable 'user_buckets' set but not used [-Wunused-but-set-global]
      37 | static kmem_buckets *user_buckets __ro_after_init;
         |                      ^
>> mm/util.c:38:22: warning: variable 'nul_buckets' set but not used [-Wunused-but-set-global]
      38 | static kmem_buckets *nul_buckets __ro_after_init;
         |                      ^
   2 warnings generated.


vim +/nul_buckets +38 mm/util.c

    36	
  > 37	static kmem_buckets *user_buckets __ro_after_init;
  > 38	static kmem_buckets *nul_buckets __ro_after_init;
    39	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
