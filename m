Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DCB27585C;
	Wed, 28 May 2025 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423444; cv=none; b=teZCqozypTd1iBNIevwmbam2JFC9Vg4+SgbC2MtD/cUCapn2wwdsJQxTOVMM8WN1sNDuhABMSqjkosqVmw9qpFkcgf6hhWJYV7WvZEBmTixPIDhlkpxgUTcMYzWPEkoFCyH9BIjbmisvS99STsQ0HWCONNjs81LAq0HyjRgPUBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423444; c=relaxed/simple;
	bh=af5JUKcthRKAQgniGzokaJiKen7a00vYt3vsaVOT2BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIeNe1xujOecDdkRbzTkBkC2YjFH4KHoapvlcz7uXXlc/1gJuIGh4hxP0ak1xxC+kVAjw5WF/el+wBarvmtfg5GkRk9gFr9iTaN/gZmt+MiTHQPs/YXOeI89CNmucxmlP3s6TLTgyYiQmfgNI5DCS7UPMPKQZSUKaLBOnfclFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDQqpOGv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDQqpOGv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748423442; x=1779959442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=af5JUKcthRKAQgniGzokaJiKen7a00vYt3vsaVOT2BQ=;
  b=BDQqpOGvazRQYzXDMeBL8ZZPmcDXvDpvLFZPj+Lb/kyQopBbrFS7R4Jh
   iw0N3esyK0cTLifD0WqjMJ69VcInRmVZgATrIJu4WI2WdJscMc2WG5ywC
   lIMvP32W0stfJBf1Qd/oX+WjOEGcP1tdFI4qA18MMV+HHwOaU7A5QfPUH
   lZKrQ1xR8T/bnCYr67INx593XyJRCQQThjrzEcT2g7vkPV55Zg6NO7P+I
   00j6A+bLxsTV1vOytN83FGf6tIS9iJTB89gUE0aDC8bq5Xu81GeebVa2+
   OZksV10TUFZ+ZdYhSTD+Xvs6Hr1xxY5atpo/rD/A0bPrak3x8uNheAKbj
   g==;
X-CSE-ConnectionGUID: QTS/5hW1SYG0w6St1B7Q7g==
X-CSE-MsgGUID: zvM3jp4iSF+XBCpBebVBXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50326608"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="50326608"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 02:10:41 -0700
X-CSE-ConnectionGUID: Ig1TGYOjTf2XVusvXjCvvQ==
X-CSE-MsgGUID: 8Uw5VHDBRgSXHe3hgjU49g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="143012443"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 28 May 2025 02:10:37 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKCnz-000VTk-01;
	Wed, 28 May 2025 09:10:35 +0000
Date: Wed, 28 May 2025 17:10:18 +0800
From: kernel test robot <lkp@intel.com>
To: Burak Emir <bqe@google.com>, Yury Norov <yury.norov@gmail.com>,
	Kees Cook <kees@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v9 4/5] rust: add find_bit_benchmark_rust module.
Message-ID: <202505281613.EHiMAdkN-lkp@intel.com>
References: <20250526150141.3407433-5-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526150141.3407433-5-bqe@google.com>

Hi Burak,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-nonmm-unstable]
[also build test ERROR on kees/for-next/hardening kees/for-next/pstore kees/for-next/kspp linus/master v6.15]
[cannot apply to rust/rust-next next-20250527]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Burak-Emir/rust-add-bindings-for-bitmap-h/20250526-230435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20250526150141.3407433-5-bqe%40google.com
patch subject: [PATCH v9 4/5] rust: add find_bit_benchmark_rust module.
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20250528/202505281613.EHiMAdkN-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250528/202505281613.EHiMAdkN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505281613.EHiMAdkN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0463]: can't find crate for `core`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
