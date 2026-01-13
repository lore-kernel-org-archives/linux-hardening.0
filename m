Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E23803D8;
	Tue, 13 Jan 2026 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293720; cv=none; b=gHA/tCKTQk7pfjPykSyeL5nIueSZCgFEkZNPtSkyIz1kF+VVf+fqN/JnNL2LfstbfZJyKi1Y3zyiu5GDPQdGsDQOmGWVZrr38JQGaDx4cEQ+v+S+ZswPBPDwzQCEinsbzdBjEzCzl73kraT3o0ef1eu4GapvJKCVCHCw6N4pI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293720; c=relaxed/simple;
	bh=rdCdfQup+4kSnpj06pCND7wWAwUHXOWyknYZJSfjJv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5+HYA72MNIsga/53rVl2F0zHGD3LTt4B35QTKz2HQM0Iqwf4z46pUwSH38cY0cnDR3sdwp+H97XCeC2VWY4OQZEeoW58c1ZRGzW+5sm5vDlREOc6JP4vp9C4J8a5HTtgZxc2wTaUCsIci5hcKNSzm2x/1lRHSqF4DfT62HL4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnIrWxB3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnIrWxB3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768293719; x=1799829719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rdCdfQup+4kSnpj06pCND7wWAwUHXOWyknYZJSfjJv8=;
  b=EnIrWxB3Rq4/Ew1AHNU5Q9UL/DOkD73KfA5eJ+o8rl7MwusUxK7En0iO
   z6qnqVd1c0ReQ2RkXCUK/PhQcN6FwEUB/FtXZbF9COGUEcZym8ShiqEvS
   IQ97FSWuG1zHBhMoMi74GUzwY+YQoVEaEt5An7aQWRrgrdzgz07A5fSdh
   Jlj3RCcHO3NVLBwMKyZXJlWReNkvgR7LLi/DvXne4GHMgSJOeYdZoCeDn
   AuI7zxVdsHenGnl+0v1UY/KFNwCsXrk3AmlxXPZzBl/CwrmhZkR3XUbCf
   8EooqBkuLoydryKzl6r/8xLzKUt2BKOxqMCmBklMILD9uM7anQFtkBg34
   Q==;
X-CSE-ConnectionGUID: hj9BpbxaQVa71UbeiIYtOg==
X-CSE-MsgGUID: juc3Ly7MQ2Gnmt7qMb0G2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="79870679"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="79870679"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 00:41:58 -0800
X-CSE-ConnectionGUID: 3c4fC4lWTUy29UxPmIOjBw==
X-CSE-MsgGUID: h02g43C1RH2fpv29WtVzxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204136155"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 00:41:53 -0800
Date: Tue, 13 Jan 2026 10:41:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, kees@kernel.org, andy@kernel.org,
	akpm@linux-foundation.org, ebiggers@kernel.org,
	martin.petersen@oracle.com, ardb@kernel.org,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	samuel.holland@sifive.com, linus.walleij@linaro.org,
	nathan@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 06/14] lib/string_kunit: add correctness test for
 strnlen
Message-ID: <aWYFT1yoktjDLFTm@smile.fi.intel.com>
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
 <20260113082748.250916-7-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113082748.250916-7-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 13, 2026 at 04:27:40PM +0800, Feng Jiang wrote:
> Add a KUnit test for strnlen() to verify correctness across
> different string lengths and memory alignments.

...

> +	for (offset = 0; offset < STRING_TEST_MAX_OFFSET; offset++) {
> +		for (len = 0; len <= STRING_TEST_MAX_LEN; len++) {
> +			s[offset + len] = '\0';

This should be one or two characters further so you check should also check for
non-NUL terminated strings...

> +			if (len > 0)
> +				KUNIT_EXPECT_EQ(test, strnlen(s + offset, len - 1), len - 1);

...or make more tests, with len - 2 at least.

> +			KUNIT_EXPECT_EQ(test, strnlen(s + offset, len), len);

> +			KUNIT_EXPECT_EQ(test, strnlen(s + offset, len + 1), len);

I would also add + 2 test case.

> +			KUNIT_EXPECT_EQ(test, strnlen(s + offset, len + 10), len);

> +			s[offset + len] = 'A';
> +		}
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


