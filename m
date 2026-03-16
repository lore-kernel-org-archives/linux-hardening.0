Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6280314D05;
	Mon, 16 Mar 2026 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686871; cv=none; b=ifFVVFxqt9pzDNQ6QRje3YgN/KYYpzpvbT3OdvIEbsRm0CgUB9+tltNArLfPUxfzoHeXKOC/lhn5ya4wGLBvw0nXFciuVgJIIyktcLkHQAQtc50kIir5TnxiXIdMYLS6mMl2lYiLlnwR0AhjWwpD27P6TzcuGt8/UBuBDK+WNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686871; c=relaxed/simple;
	bh=uZOmVZ2UWUcAzumRLpmvYaj0grP6dv0PdyoAncR2MIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edPBuh8YQ97TYGP+dYvmbOVPqJxq0XS9PeTT1jujy1P2huLKkM2+xw1faF8Cq6q/ntverd/woQZH0JYQ4t+Vwb0tDNFD/N7pAe/ZFYbb2iU6G8qY6bCVQztb8gIsZ7h85TTMHf/fkJ2IsxI2JrTrXxvSWRHvJ6itjlPDYqb8KuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfL76DCz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfL76DCz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773686870; x=1805222870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uZOmVZ2UWUcAzumRLpmvYaj0grP6dv0PdyoAncR2MIc=;
  b=ZfL76DCz26sE7MxHdqWPuUX6HzrCBBbPMXKf1YKa0uF2tAsqKCgLX6XJ
   TdpB826rztj3nJUbVYH3d/iMou80k+vXdoqiO0qeWOMEnLBRWDkHCvZKU
   9iWesdQ+VIGDxqmS2/EYwt2pHvUZJ6w9nsjqdr3b01NKx6wInanEDGoos
   poxq2MEUrFLisn/VtYQDi8mBMPfY0yli5fW9HOnJmHWS3W1XjpB6RH7A9
   qy/IsZ9Fbl8TRSQbgiRcydjm+Kms0LHdMdjnLNLMvZDdRAgUCAL1/eWxG
   4LoITA1NFVkkbB3knLbxqzy2+ptG9FtzXgi+CjJB7hFpI8f1juBhbJ4Ns
   A==;
X-CSE-ConnectionGUID: bGaw764dTZGFwdyvUuZ5kg==
X-CSE-MsgGUID: IdgeqWQVRX2GAdSGK5kczw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86068181"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86068181"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:47:49 -0700
X-CSE-ConnectionGUID: KC7BjTdRQnWi2N4lXiFP0g==
X-CSE-MsgGUID: emFOsXm3TxuGMyTSLF80iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226690989"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 11:47:47 -0700
Date: Mon, 16 Mar 2026 20:47:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Josh Law <objecting@objecting.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, kees@kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ACPI: processor: idle: Replace strlcat() with
 better alternative
Message-ID: <abhQURnuNUPwiy_6@ashevche-desk.local>
References: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com>
 <4FC4DDD1-E170-46A9-888A-41D2CD6D97F3@objecting.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FC4DDD1-E170-46A9-888A-41D2CD6D97F3@objecting.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 06:43:58PM +0000, Josh Law wrote:
> On 16 March 2026 17:01:58 GMT, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >strlcpy() and strlcat() are confusing APIs and the former one already gone
> >from the kernel. In preparation to kill strlcat() replace it with the better
> >alternative.
> 
> Is this patch in relation to my string.c patch?

Yes.

> You would have to do this for about 120~ files.

Not me, just showing you what to do.

Btw, what kind of assistance do you use for the patches?


-- 
With Best Regards,
Andy Shevchenko


