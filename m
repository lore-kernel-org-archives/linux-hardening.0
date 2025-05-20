Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B325C701;
	Tue, 20 May 2025 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747720807; cv=none; b=DghKTPMdlJ3ky/rQSGyTQ0eVn1YtPHMvTWGgVXZODRC8Q6RiqL+PbFhCzmL+XzYF9LOQ1t5G1sT58omrxZVrapy5PSuBTBbeOVclliaa4CTzJy4hMPMLbJGrYfkI5YMB1iIJKydi1JwaCGgI6qbgYhfAryhFqwB/Br2biTYcUCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747720807; c=relaxed/simple;
	bh=dMgMAG9XNL5bV4MfmNIisiKf+nZMmc8QZRDWJohNcMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E66lqnCGNkIAHtpfHS901puGzMatMQjzzuOBa12ve/iETw/rgMpenzsE53fmt9n+KN6aRJz7G9mx4JjmY7kN1LfYefr72lQlAnYZYt92qa7N5Hn0eKNAD3HP9JsX7by7sKQ5v8knjgnacfZRkNfSweTLUEXcGljtRrb3pl4X5i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrNDBxoX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrNDBxoX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747720805; x=1779256805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dMgMAG9XNL5bV4MfmNIisiKf+nZMmc8QZRDWJohNcMw=;
  b=MrNDBxoXUZjf+2WBklhv9tpSqdRTcPZU2P2U6No0GJkrcI6ru5Euc8rn
   0DdAemL+efa2QhP2xYeSASStFQooYXYCytQf8A5ka7uoxz6z4gWiAty5O
   aMwr6I1p+l+f7Mx8Of58N84GnT31w6ha/BH768jx/5AgMuoGSpFYV6AZW
   vi0ReD+cd1CdBJ8ieUoG6dTnhxAhX2wZean0YBzHHk+RN1Dz+wt7JcJCx
   56v0N5JDreLUqzXXIhF6MMcAgMgQD4WJ+NTydaHVuM5ZH3U19Td2nMj9x
   jaHRI+QerLrqB4n47o6Xb8ItZNBLGOoAon8tOEAyYV24ue5AxNosDjKFj
   g==;
X-CSE-ConnectionGUID: rzzfhikNQhyNJ2oECw+9CA==
X-CSE-MsgGUID: ZNq+v3DrRHWxcvuaDNTC1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="75040140"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="75040140"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 22:59:59 -0700
X-CSE-ConnectionGUID: V6IWy+CVSQKKPzFwODsdSw==
X-CSE-MsgGUID: gWNRCweFRyOb2wsc97k3Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139472155"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 19 May 2025 22:59:55 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHG12-000MCm-2W;
	Tue, 20 May 2025 05:59:52 +0000
Date: Tue, 20 May 2025 13:59:21 +0800
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
Subject: Re: [PATCH v8 3/5] rust: add bitmap API.
Message-ID: <202505201339.bUfYKFye-lkp@intel.com>
References: <20250519161712.2609395-4-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519161712.2609395-4-bqe@google.com>

Hi Burak,

kernel test robot noticed the following build errors:

[auto build test ERROR on rust/rust-next]
[also build test ERROR on akpm-mm/mm-nonmm-unstable kees/for-next/hardening kees/for-next/pstore kees/for-next/kspp linus/master v6.15-rc7]
[cannot apply to next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Burak-Emir/rust-add-bindings-for-bitmap-h/20250520-002216
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/20250519161712.2609395-4-bqe%40google.com
patch subject: [PATCH v8 3/5] rust: add bitmap API.
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250520/202505201339.bUfYKFye-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250520/202505201339.bUfYKFye-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505201339.bUfYKFye-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error[E0061]: this method takes 0 arguments but 1 argument was supplied
   --> rust/kernel/bitmap.rs:396:28
   |
   396 |         assert_eq!(None, b.last_bit(2048));
   |                            ^^^^^^^^ ----
   |                                     |
   |                                     unexpected argument of type `{integer}`
   |                                     help: remove the extra argument
   |
   note: method defined here
   --> rust/kernel/bitmap.rs:301:12
   |
   301 |     pub fn last_bit(&self) -> Option<usize> {
   |            ^^^^^^^^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
