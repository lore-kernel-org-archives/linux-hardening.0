Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1E69463;
	Thu,  7 Aug 2025 04:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754541961; cv=none; b=glVPHHHt9n+xmIH1Cnwf+mLTUH2RyNBO8jJMszezTN9fWHqced3oHb+UPHNPlzkQTdou8znh54Ak+QOu4ion4RwlZiyw9rtHZlW3g3trUM7eExgFJjjRz7QOke8eTi6FRdFUXQytRPRJt3UmFk81VwWjDjiyE3eW1UMcljkyo/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754541961; c=relaxed/simple;
	bh=y4KlCdk+5pgiOMnQfj5r49PM4fycrXkrnw4MykWMmxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZyyIUBHsxf7p7V5zUCWHb8Eq/g2ct5j2w0J3YC99DZC1vwkSZUU8+TOLJVMHMzVe58vRBC90nVuOO/l7Uia47G+zkgTFoj8b2Zq3oMPYVJi6o1Lfx9sOCakszDFzkweT37i51Nv01scsm94iFMTdnMdLJZI+Yvuhg5/zeH3Ik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3Ttadx+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3Ttadx+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754541960; x=1786077960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y4KlCdk+5pgiOMnQfj5r49PM4fycrXkrnw4MykWMmxc=;
  b=A3Ttadx+sXTUVqToQMXWFjX13qVmk85qVR4G3DsQQe9Js8SsM+SjYYOo
   ErfWbWEm0XzeYMvoIV1aRda8Umqq8IunV5iWuGR7X2NWMCwLdB/0mgJL3
   ZBAqIrBVcV2wxoI0EUH7FbSjKcIAquGnKsGSUzZ8d4OTiof9sp7nc+DU/
   aZhCk7LbTlLAJ1AqwTpFYLlGw3+F6SmoPtzvXRw3hjZdXSkdFAXUkfUQw
   59aws4Zz5Cbumnks0J04TwXl3Yw/vcQCQrnqmlwyKfA7WYPilavulQVBm
   UvuKRqpPe+X1CfjxADwi/gVS74R+y56TyuKyv2PLKdHFH76ykYLKkwTiG
   g==;
X-CSE-ConnectionGUID: yUsNd23BRgiq1neAIUGaiQ==
X-CSE-MsgGUID: lKpNxo/dQGG7WizCuc2whQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="68243797"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="68243797"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 21:46:00 -0700
X-CSE-ConnectionGUID: MTg9uMhUTZKgCZSax4O11A==
X-CSE-MsgGUID: 6evjZ82ATGmPVueWzXp+Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165308362"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 06 Aug 2025 21:45:58 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujsVn-0002NS-1x;
	Thu, 07 Aug 2025 04:45:55 +0000
Date: Thu, 7 Aug 2025 12:45:25 +0800
From: kernel test robot <lkp@intel.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Kees Cook <kees@kernel.org>,
	"open list:GCC PLUGINS" <linux-hardening@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, liaoyuanhong@vivo.com
Subject: Re: [PATCH] gcc-plugins: Use swap() to simplify code
Message-ID: <202508071233.Bf6EgGd2-lkp@intel.com>
References: <20250806124341.382446-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806124341.382446-1-liaoyuanhong@vivo.com>

Hi Liao,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/hardening]
[also build test ERROR on kees/for-next/kspp kees/for-next/pstore linus/master v6.16 next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liao-Yuanhong/gcc-plugins-Use-swap-to-simplify-code/20250806-204609
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/20250806124341.382446-1-liaoyuanhong%40vivo.com
patch subject: [PATCH] gcc-plugins: Use swap() to simplify code
config: i386-randconfig-012-20250807 (https://download.01.org/0day-ci/archive/20250807/202508071233.Bf6EgGd2-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508071233.Bf6EgGd2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508071233.Bf6EgGd2-lkp@intel.com/

All errors (new ones prefixed by >>):

   scripts/gcc-plugins/randomize_layout_plugin.c: In function 'void performance_shuffle(tree_node**, long unsigned int, ranctx*)':
>> scripts/gcc-plugins/randomize_layout_plugin.c:203:17: error: 'swap' was not declared in this scope
     203 |                 swap(size_group[randnum], size_group[i]);
         |                 ^~~~
   scripts/gcc-plugins/randomize_layout_plugin.c:203:17: note: suggested alternatives:
   In file included from /usr/include/c++/12/utility:69,
                    from /usr/lib/gcc/x86_64-linux-gnu/12/plugin/include/system.h:244,
                    from /usr/lib/gcc/x86_64-linux-gnu/12/plugin/include/gcc-plugin.h:28,
                    from scripts/gcc-plugins/gcc-common.h:6,
                    from scripts/gcc-plugins/randomize_layout_plugin.c:19:
   /usr/include/c++/12/bits/stl_pair.h:715:5: note:   'std::swap'
     715 |     swap(pair<_T1, _T2>&, pair<_T1, _T2>&) = delete;
         |     ^~~~
   In file included from /usr/include/c++/12/bits/stl_pair.h:61:
   /usr/include/c++/12/bits/move.h:196:5: note:   'std::swap'
     196 |     swap(_Tp& __a, _Tp& __b)
         |     ^~~~
   /usr/include/c++/12/bits/move.h:196:5: note:   'std::swap'
   scripts/gcc-plugins/randomize_layout_plugin.c:216:25: error: 'swap' was not declared in this scope
     216 |                         swap(newtree[randnum], newtree[i]);
         |                         ^~~~
   scripts/gcc-plugins/randomize_layout_plugin.c:216:25: note: suggested alternatives:
   /usr/include/c++/12/bits/stl_pair.h:715:5: note:   'std::swap'
     715 |     swap(pair<_T1, _T2>&, pair<_T1, _T2>&) = delete;
         |     ^~~~
   /usr/include/c++/12/bits/move.h:196:5: note:   'std::swap'
     196 |     swap(_Tp& __a, _Tp& __b)
         |     ^~~~
   /usr/include/c++/12/bits/move.h:196:5: note:   'std::swap'
   scripts/gcc-plugins/randomize_layout_plugin.c: In function 'void full_shuffle(tree_node**, long unsigned int, ranctx*)':
   scripts/gcc-plugins/randomize_layout_plugin.c:227:17: error: 'swap' was not declared in this scope
     227 |                 swap(newtree[randnum], newtree[i]);
         |                 ^~~~
   scripts/gcc-plugins/randomize_layout_plugin.c:227:17: note: suggested alternatives:
   /usr/include/c++/12/bits/stl_pair.h:715:5: note:   'std::swap'
     715 |     swap(pair<_T1, _T2>&, pair<_T1, _T2>&) = delete;
         |     ^~~~
   /usr/include/c++/12/bits/move.h:196:5: note:   'std::swap'
     196 |     swap(_Tp& __a, _Tp& __b)
         |     ^~~~
   /usr/include/c++/12/bits/move.h:196:5: note:   'std::swap'
   make[4]: *** [scripts/gcc-plugins/Makefile:54: scripts/gcc-plugins/randomize_layout_plugin.so] Error 1 shuffle=2972943921
   make[4]: Target 'scripts/gcc-plugins/' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:554: scripts/gcc-plugins] Error 2 shuffle=2972943921
   make[3]: Target 'scripts/' not remade because of errors.
   make[2]: *** [Makefile:1258: scripts] Error 2 shuffle=2972943921
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=2972943921
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=2972943921
   make: Target 'prepare' not remade because of errors.


vim +/swap +203 scripts/gcc-plugins/randomize_layout_plugin.c

   190	
   191	static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prng_state)
   192	{
   193		unsigned long i, x, index;
   194		struct partition_group size_group[length];
   195		unsigned long num_groups = 0;
   196		unsigned long randnum;
   197	
   198		partition_struct(newtree, length, (struct partition_group *)&size_group, &num_groups);
   199	
   200		/* FIXME: this group shuffle is currently a no-op. */
   201		for (i = num_groups - 1; i > 0; i--) {
   202			randnum = ranval(prng_state) % (i + 1);
 > 203			swap(size_group[randnum], size_group[i]);
   204		}
   205	
   206		for (x = 0; x < num_groups; x++) {
   207			for (index = size_group[x].length - 1; index > 0; index--) {
   208				i = size_group[x].start + index;
   209				if (DECL_BIT_FIELD_TYPE(newtree[i]))
   210					continue;
   211				randnum = ranval(prng_state) % (index + 1);
   212				randnum += size_group[x].start;
   213				// we could handle this case differently if desired
   214				if (DECL_BIT_FIELD_TYPE(newtree[randnum]))
   215					continue;
   216				swap(newtree[randnum], newtree[i]);
   217			}
   218		}
   219	}
   220	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
