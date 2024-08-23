Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AE61885B4
	for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423107; cv=none; b=sLrB/6uOHSFi+LKbrfYsNVbxeyiw8VFHN72ZqDec6RTxgatBhjTBe2i/k6yaLkGexYDoDU43YVKVfa4kpMHI5UJC85brd7duWf0m0K3vZKfm2ROlmEf2ddZsqo6IyxWZngw3kzodPD6zZWZUeRO6SOytI89XYOUQ1m+OSERywzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423107; c=relaxed/simple;
	bh=yMNFAAqUezFY1RJQ3dPyBfiGmoRotJIqI5BPCvH2a8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFobKpMB5l7jo8u2c9jhxfaRgDAvp9o27aUIFZ2Jj4Dl5JfvK9dLAPXUqdjtRcybAGT33qRsUsLglz/phT/iViXX0SiLVdL9TuGWd+wsUIh+RcAGWvfOsqMoGr64a4n122jgeC3Df9GzPUHoZ6iQKZBRgNKPw71VPEkGk1701Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: m1RDS+7uS6yqhYqQOIeqLA==
X-CSE-MsgGUID: juGiQIW7SS61tQ+e7BIqIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33461389"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="33461389"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 07:25:06 -0700
X-CSE-ConnectionGUID: DnB+wEb7RWONKk5oFJQysg==
X-CSE-MsgGUID: tL8O9RoFQDuk7K9FpINM6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61671267"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 07:25:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1shVDq-00000000oqm-10AX;
	Fri, 23 Aug 2024 17:25:02 +0300
Date: Fri, 23 Aug 2024 17:25:02 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, kees@kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH -next 0/2] Add str_true_false()/str_false_true() helper
Message-ID: <Zsibvuno_NCjTadQ@smile.fi.intel.com>
References: <20240823062046.3323694-1-lihongbo22@huawei.com>
 <CAHp75VdYbG32auRF3KgP15wA-5bDgTMTO24itTu1tdjdW3CqXQ@mail.gmail.com>
 <2024082311-unaltered-grumbly-5c94@gregkh>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024082311-unaltered-grumbly-5c94@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 23, 2024 at 09:38:39PM +0800, Greg KH wrote:
> On Fri, Aug 23, 2024 at 04:22:32PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 23, 2024 at 9:13 AM Hongbo Li <lihongbo22@huawei.com> wrote:
> > >
> > > Add str_true_false()/str_false_true() helper to "true" or "false"
> > > string literal. And we found more than 10 cases currently exist
> > > in the tree. So these helpers can be used for these cases.
> > 
> > Squash them into a single patch. There is no need to split these.
> 
> And let's see some patches that change existing code to use them, we
> can't add new functions that are never used in the tree.

Exactly, thanks, Greg!

-- 
With Best Regards,
Andy Shevchenko


