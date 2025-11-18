Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00582773EC;
	Tue, 18 Nov 2025 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490450; cv=none; b=oT1T9pP2RnsemvMQV+vhzBytKXGSs4nxC1Qy5FbZXD3CbChdL9oP0V1xgOfPg9417S+kUu4kPaHWeF0l4Lspo1rxXQup67osnwRgyJS9BN+uhGb9EmG1Ywa5Z0REbXhLvVVmTjDPFJgTmeJoYIBpT2Jjb903ZhebUQELMVK6yTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490450; c=relaxed/simple;
	bh=mf2A4uVAyMMwo+CUEGxMYnNkPKDtt+P9HeZnK68CIVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKifgr0/bYvueo1yE13VuM7gV1ZDusVStW/re7/a27hc3weRiEj/FB7o4jiZXrGsEMNqhD/XV6kdfZiPtpCurGamDHwISnpbs39Cofgjw5gjqntuaeZ9hHVafmNxc/1dHV0kL+nz4/bNpaMurjXs0redxR4Jf2Y0lWqICoUKehQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IxEt288S; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxEt288S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763490449; x=1795026449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mf2A4uVAyMMwo+CUEGxMYnNkPKDtt+P9HeZnK68CIVM=;
  b=IxEt288SETUSsxIEiPP6MVDwFzEfGbq3HI/OeFfkoUuR3vWfxO7dLgDD
   eIXDeD0y7wpEjTyFShdYmOzww2wLibsFgn8GKt++pzsqRt5StYNWiPhB6
   BWS0k7Wh4G0c9MavY5OjarHcUckb7lrNRGC2ZhQ4FpSfpcBaR3J8HARRk
   yfZ3kth7BxGtJOkfUMWP4i541K+0dBFx5HQ8kNBd4gp8Hl3++WEzd6CV3
   6rJOR0AD74DUj2+kXRkdfW4akfoX8WBbAr0mLF6m5/+9zNghicgPzkABn
   6yNluo+/Yuo2kpLj0KNfX2Gxw1sK2PHkiXa0AyyxV1cpsINgf+zp7aDDx
   A==;
X-CSE-ConnectionGUID: 5dG1jiagSHqLNBRgjOpSng==
X-CSE-MsgGUID: 5NnwHF9fT1WrhqkSfnI6Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="69138837"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="69138837"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:27:29 -0800
X-CSE-ConnectionGUID: zB2Lbr9lQH+2gNyP6kd5ZQ==
X-CSE-MsgGUID: OTldZ9g2TtassnA7j3GTcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="221736138"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:27:27 -0800
Date: Tue, 18 Nov 2025 20:27:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: kees@kernel.org, andy@kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] string: Fix missing kernel-doc descriptions in string.h
Message-ID: <aRy6jISBogIIT-0o@ashevche-desk.local>
References: <20251118180008.2620929-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118180008.2620929-1-kriish.sharma2006@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 18, 2025 at 06:00:08PM +0000, Kriish Sharma wrote:
> While running kernel-doc validation, several warnings were emitted for
> functions in include/linux/string.h due to missing return value
> documentation or missing parameter descriptions:
> 
>     Warning: include/linux/string.h:375 No description found for return value of 'kbasename'
>     Warning: include/linux/string.h:560 No description found for return value of 'strstarts'
>     WARNING: include/linux/string.h:573 function parameter 'str' not described in 'strends'
>     WARNING: include/linux/string.h:573 function parameter 'suffix' not described in 'strends'
> 
> This patch adds the missing "Returns:" sections for kbasename() and
> strstarts(), and provides parameter descriptions for strends().
> These changes resolve all kernel-doc warnings in this header.

strends() fixes are in Bart's tree, will be soon in Linux Next I suppose.
The rest seems good.

-- 
With Best Regards,
Andy Shevchenko


