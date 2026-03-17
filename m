Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6993D399002;
	Tue, 17 Mar 2026 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736177; cv=none; b=I7ZKmoxQSBwYwOsClS8n7bYJM/D7kFWfdVVJvQGM/AYqasku0zu1kFxgxe58gMMq9rnSwq/4N9yWnmtpGkPrQlkqfIIHXGpGC5AY/q74s6McfAR5OoPqBI/hbY47/WjZqdU7ar9Rc9OXNIFKsdOiPCXaEPdGIHTGV7/LOXlF2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736177; c=relaxed/simple;
	bh=X+MD+pE6OWMHY9WJ891hMAif/HdfHaLxVfFye6J6Szc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liWdEwmSVnMZX24e/Fqi4fBMU38nHzPjsTtB4G6/nICApNJXneV6HS9zH5QLi871ReOt6H+C3Pakpf5WrIcUYepkFR2IPf90E2qykRn5odhljyvNZRPYzSCvocHza71FkhrFGENvAT9NaeFRil8U+3Y7s3Kse3OgAvPSkdnJq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6IU79oh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6IU79oh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773736173; x=1805272173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X+MD+pE6OWMHY9WJ891hMAif/HdfHaLxVfFye6J6Szc=;
  b=h6IU79ohB8/tKV3wDKNE+R9SmFBB/CFyKSG2aEYj8ir15Mu3zJLV+OCC
   qEkydPZOeGzJl6BdLRSslNpeNww10+xmE1CS0pY7E4auQv/o2yw0oi8hC
   eJ5uxTI3YE/2jZa3+LFPHTU7g7uOY2kjodr1cmx5/NmnpiiWxV5Tujj2N
   cRNBu1c65m1ETRSpPpWCYtGtplImwjGXXaOb7hlrsRGOn5GqqolNcKnr+
   FV2ys8AtK4fcab/wURkhhPJ5a/RAbszT+5reB8FLBeqqAZZA5xXlJq96t
   r3LzSvyF6jCnNOBDPP6KGEJoFxA+UxR1Z2xWLEaoNH0K3LszaMYx/O9V0
   w==;
X-CSE-ConnectionGUID: 2VE4KCczTZ66y6GV9CD8vg==
X-CSE-MsgGUID: akY0s+fQQxqYWSRuiNzdjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74463898"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74463898"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 01:29:32 -0700
X-CSE-ConnectionGUID: fmBuebBcSqSRF2XR2cil+Q==
X-CSE-MsgGUID: VHHHy6VHSJCE8+sX82JNDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="245216504"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 01:29:29 -0700
Date: Tue, 17 Mar 2026 10:29:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, Len Brown <lenb@kernel.org>,
	Josh Law <objecting@objecting.org>, kees@kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ACPI: processor: idle: Replace strlcat() with
 better alternative
Message-ID: <abkQ5-TPZgrdwlAV@ashevche-desk.local>
References: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com>
 <202603170957.D9ZQ5sVR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202603170957.D9ZQ5sVR-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 17, 2026 at 09:17:56AM +0100, kernel test robot wrote:
> Hi Andy,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on rafael-pm/linux-next]
> [also build test WARNING on rafael-pm/bleeding-edge linus/master v7.0-rc4 next-20260316]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ACPI-processor-idle-Replace-strlcat-with-better-alternative/20260317-014800
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> patch link:    https://lore.kernel.org/r/20260316170158.1596857-1-andriy.shevchenko%40linux.intel.com
> patch subject: [PATCH v1 1/1] ACPI: processor: idle: Replace strlcat() with better alternative
> config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260317/202603170957.D9ZQ5sVR-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260317/202603170957.D9ZQ5sVR-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603170957.D9ZQ5sVR-lkp@intel.com/

Yes, thanks, I already sent a v2 before getting this report.

-- 
With Best Regards,
Andy Shevchenko


