Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5B23236F;
	Mon, 10 Mar 2025 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630330; cv=none; b=T9zwjyFBiEwL3L6yp1tuUC9HQC+Ft7p1eUcmgHXEDj/WbOLbOh+JpsvFeqw3338EAjVxhSppq/10POOgocdMVukhNgB58lJqHqnQwduQgz5rEoQzq79c+y2DgWrB0Ox8pUFlVdvbWPHRnodpWkp/8jovv/L20Pe1fWP4BwCqrZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630330; c=relaxed/simple;
	bh=tHuQXVfwdwumezI14+1I8Z7BOYdQJZlEMGf7cXaU6Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKCtcGw37dACnbSUxLt+7gjJeL2tIJ9uLfd4dvDazuR5qNj2yPlYAdqbWSPr6GSaGuDWkayQvY7Ydvhs18D6+NMdzfdn9OplisNV4lV798lcTfZxZcnemjnGG9vq1o5KHl8xgbIvOpmMETKUzjtql560+0GnnQ7vimZPNqo4pXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sn1owhBO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sn1owhBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CF5C4CEE5;
	Mon, 10 Mar 2025 18:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741630330;
	bh=tHuQXVfwdwumezI14+1I8Z7BOYdQJZlEMGf7cXaU6Sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sn1owhBOgCAvEp1rse5nYp7P3/BHV2yh6ZmZpkyuo5/YkfJBg7Fj7SQNvLgu3ZZCI
	 qIsNFnppJBSVT1bxZjgt/zvidCosfqNdraxNFpvGTtueKWcpfgbdBji1NZqub4POKD
	 +FCnP1Zl7AA3LuLXgSi6O2W+vX8p0zcRQaLz1hKCIVvaxXQwZZoVD2c/XaWmB9OaGW
	 OqTkKqVMIk+hJfNnEhQwtmjrNLoAxaPMQS5onjlD63QL0y+/fIoCKx3ax+hIHLE4LN
	 07S6+QTgGfg9FeNIolCjmC6BJyUFVytPLhlAj8iqCX3UDohmS81cHiSQCSJz4EeZrL
	 D+KdU5TASKRmA==
Date: Mon, 10 Mar 2025 11:12:07 -0700
From: Kees Cook <kees@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/3] ubsan/overflow: Rework integer overflow sanitizer
 option to turn on everything
Message-ID: <202503101111.74738A99@keescook>
References: <20250307041914.937329-1-kees@kernel.org>
 <202503101035.rpwDzqYD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503101035.rpwDzqYD-lkp@intel.com>

On Mon, Mar 10, 2025 at 10:54:12AM +0800, kernel test robot wrote:
> Hi Kees,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on kees/for-next/hardening]
> [also build test WARNING on masahiroy-kbuild/for-next masahiroy-kbuild/fixes kees/for-next/pstore linus/master v6.14-rc6 next-20250307]
> [cannot apply to kees/for-next/kspp]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/ubsan-overflow-Rework-integer-overflow-sanitizer-option-to-turn-on-everything/20250307-122130
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
> patch link:    https://lore.kernel.org/r/20250307041914.937329-1-kees%40kernel.org
> patch subject: [PATCH 1/3] ubsan/overflow: Rework integer overflow sanitizer option to turn on everything
> config: s390-randconfig-r112-20250310 (https://download.01.org/0day-ci/archive/20250310/202503101035.rpwDzqYD-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 14.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20250310/202503101035.rpwDzqYD-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503101035.rpwDzqYD-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> lib/test_ubsan.c:62:16: sparse: sparse: cast truncates bits from constant value (7fffffffffffffff becomes ffffffff)
>    lib/test_ubsan.c:72:18: sparse: sparse: shift count is negative (-1)

Can we exclude certain source files from sparse? This whole file is
basically an endless series of intentionally bad operations. :)

-Kees

> 
> vim +62 lib/test_ubsan.c
> 
>     55	
>     56	static void test_ubsan_truncate_signed(void)
>     57	{
>     58		volatile long val = LONG_MAX;
>     59		volatile int val2 = 0;
>     60	
>     61		UBSAN_TEST(CONFIG_UBSAN_INTEGER_WRAP);
>   > 62		val2 = val;
>     63	}
>     64	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
Kees Cook
