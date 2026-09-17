Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CCA4582E6;
	Thu, 17 Sep 2026 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629257; cv=none; b=QrLXpnZUm8kATTwEXirJSlZBLoJjq4kvhHwWri6X3uHgbOUsISR1Wfl6YKSHYgYFnTy2QJZfFOLx3dD08HYrMdRoIQAMrNHZdQhwNneN0X0WDCOJczYTi4yNwbAWwBlIoLsHekp2ooTFLIX0JOehfEjTmJl6bwSDYqt2UN0Ud2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629257; c=relaxed/simple;
	bh=RlCMuVQzYjDXZ2VccFacMR69PuHcSWzUI7SY2De5rvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbIthSiJh4819ObLEYoB3uJ/MJiCIDWnPDejf+cnIGTsZTLur6GT9EeKp19YB9j1gZfRY/aNcQja6Di73GSOOIuJURR8k8OcMaFgsZkbM2rlmijGd2zVJaDoIRpYcIvwlEb5Ab6hHhB89JyIa3APcsyJ/6ybh3ngm00klkGU1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZ5p3RTe; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZ5p3RTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789629253; x=1821165253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RlCMuVQzYjDXZ2VccFacMR69PuHcSWzUI7SY2De5rvE=;
  b=kZ5p3RTeEReyyvPpMR8MUX7W1Q7f+hrVIMNZ/l2k4kF7DH3767VTuVRJ
   PwQkooYPeYLsXIgLiiQs2s021XTdm4FMkyxlMBWkoMDGPXs0DM8+XQo1Z
   Jkyne8C3cKfTzfIbtt9SufLuxahf23zBQMUmmt9IuJpMvwikhFk8opdgU
   GM9erzaw/xS94Yr9nNeMg/3L2Yc8XTp9DYPdony+OL39/XExmm1y4JSeQ
   3yEkc5DEMERO4qUKIFWt/3+4Mgf8tdSTL91WjI873cb88n8Le9t6uxQJn
   X9+8UnSdv9I+z6pgny2vAy7/jvCdE9PMf17l8UyksYjEvqUTcO6GFJWok
   g==;
X-CSE-ConnectionGUID: 0t96hwPnR2++QC8TAX/SmQ==
X-CSE-MsgGUID: +szUCEN5Rv+zqGLeM9kk2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100687430"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100687430"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:14:09 -0700
X-CSE-ConnectionGUID: 0TDiA8rrQVmJbLFwZ7/q7w==
X-CSE-MsgGUID: LOcKZTudRp+MAgZ9nwtplg==
X-ExtLoop1: 1
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:14:08 -0700
Date: Thu, 17 Sep 2026 10:14:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 1/5] lib/tests: string_helpers: check null terminator too
Message-ID: <aquTPXq3d2CoW7Am@ashevche-desk.local>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
 <20260916-string_unescape-v1-1-7f8bd986fa33@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-string_unescape-v1-1-7f8bd986fa33@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 07:38:06PM +0200, Jonas Rebmann wrote:
> string_unescape() returns the number of character written to dst, not
> counting the null terminator which is always written.
> 
> Ensure string_unescape has included the null terminator by adding a
> separate check.

...

> -	KUNIT_ASSERT_EQ_MSG(test, q_real, q_test, "name:%s", name);
> +	KUNIT_EXPECT_EQ_MSG(test, q_real, q_test, "name:%s", name);
>  				  char *out_test, size_t q_test)

The commit message doesn't explain why it's safe to continue the test if the
first assertion fails. Care to elaborate?

-- 
With Best Regards,
Andy Shevchenko


