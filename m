Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD92A4DD3A0
	for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649520; cv=none; b=BMOZfI/o8Pt+L6z0uOPZAW5d5o8UcX4vEGnZk7mryRpk3d2BO/1GbbbroeRzCMpRyi5Ny+Au+bagkVMUh7ITW/Vxs3jFw17JDv/fIxMaLfj+fGjbyfZ7iaHXKn/ImiYnFO/DRHO42GwlsLgxyszepqg9tbmnmf0WgNSnZKbgU9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649520; c=relaxed/simple;
	bh=URK4zgo8E6IO3v9Zv6fMN7B5JMjzxjebXnLV02hcgjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOQYIoVEB57c6Ol7QxiMtODUO68xPmlF+ZwMm/FThmjDfbUYlFnaR2cQWc1kCzNP1oUViRxGMfYWCxdjG2d2zorlK9fBecp8kQGm8ZXBK7jBf8bx5aU/qVXQUVxlZJvag4S0XRK1UJXAezaf/LEWk4cpVdX5Kwd3dvyqB8SHYro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MyvPmskG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MyvPmskG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789649510; x=1821185510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=URK4zgo8E6IO3v9Zv6fMN7B5JMjzxjebXnLV02hcgjI=;
  b=MyvPmskGx3XeRGGWC0L19vgkhA4dbw+/J139NMglkGcaRdQ7QHQwp0rt
   dVcIht108Gctiv3loxmtS3/BilhpK6IV2Pd9VQLG1lUoWK0SXg/QEt6Va
   FUD3pt9xUXJA3Y+Uw6vB9KmUWWMuktNQAyGj3eynwUMb9O4tUDHTF0yCQ
   LHPPvCi+ADSiDTDYEHQPLcuEmcBVBhjEvK/MPqNlSyWdi/JIxpLfbDjol
   Vm3f1v6QOaYGK/Q+9MHdZc/WKcY6hEITOnKuiIbrH37cek8eeyYHxCSiu
   2blOq0wuRvrnUxR1XN0b+xMBAT+B0B+dNCcKeeKQJKhcJWv+fOy9ABLTK
   g==;
X-CSE-ConnectionGUID: Vb8hcmYVRfWTgyGiLL88kQ==
X-CSE-MsgGUID: 5DjmtR5OS2eymYl83BlYHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93894335"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93894335"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 05:51:47 -0700
X-CSE-ConnectionGUID: fClk7Vo4TIShyUZCF0cZMg==
X-CSE-MsgGUID: sfBPcF4QSwu9v+jlfEwR+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297262359"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 05:51:43 -0700
Date: Thu, 17 Sep 2026 15:51:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/7] seq_buf: Add seq_buf_strlen()
Message-ID: <aqviXSO0qnCoioWG@ashevche-desk.local>
References: <20260917002312.i.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917002312.i.923-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 05:23:12PM -0700, Kees Cook wrote:

> While working on seq_buf conversions, we found there was a need for
> seq_buf_strlen() (since calling strlen(seq_buf_str()) would be a waste
> of time: seq_buf already knows the length). And while implementing that,
> I found a bunch of other related things that needed fixing. This is that
> series, with tests for each fix.

I like the series, especially the trick on how to capture printk() messages.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


