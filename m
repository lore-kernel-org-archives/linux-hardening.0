Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B12134726
	for <linux-hardening@vger.kernel.org>; Thu, 15 Feb 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013486; cv=none; b=qFMq0FTaTTuCFt98ECxGIr+uONqF5ltWodmYaOLADWJ3HHHLRDp4vvC0phc+acg4RVEYtuUAt1NF0Mxvn22I27F2PAmuMq3gyLFgCg5o9tqPPXQLDpUMRUrmKSOdw+g0dqKQ6RxTzmQzzpyX6S4MarH/3kFceRO1vfdaLsYXEpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013486; c=relaxed/simple;
	bh=wQnWEY+AAF2mAaCE2hY3GrTaOgyXiVe+vTAuRgbfZpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTpao0d1vJkpylnzaQkHDc4zto3cQsuVKgezcAG4UQDn/03JAbDaFB8ak88lCzAO49Enn7pg1rsPhtqsUbn8HUYpNfmQpr58SEXVTO5SitTPKSYoMuF7V/SJ+pLgvrXmvI6eAlmtPsYXdg2ywblFU5csXV+CvkOEX1BcYOq1s3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CiPSBR1u; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CiPSBR1u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708013485; x=1739549485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wQnWEY+AAF2mAaCE2hY3GrTaOgyXiVe+vTAuRgbfZpM=;
  b=CiPSBR1u2bGtxXUfex5HN8Xuc4jt8EjbqqyD7l1PlOqml2u+DvXqjoAc
   9q3Vajej8vgy3lUvOnYJHGaKAa/eLcwR32D9FQHfYp2n+LrH1cyghiKPi
   8rf18q/usNYM8meit2Fc8k4XdfWaI+WD94n8FaTHte1Iue1SdZ9nvea8A
   VSJND4/iEmQESDiURE3GMDsJxtNSiryGQl2gYMYzuoUIvG7qypjJ3h3Fg
   Kl0FrqaC6/lkAx7KqOtb9ladV6tC2ZSvHDyK6EwCS7aCTT9c8e/H1gJf/
   paVJTAtNpwarHCtbTAbIrU0dBwXLZOt9GwQFZUQmd++6hplzXog9BWmA0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2225954"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2225954"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:11:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912186928"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912186928"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:11:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raeKQ-00000004pwd-1TVg;
	Thu, 15 Feb 2024 18:11:14 +0200
Date: Thu, 15 Feb 2024 18:11:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>, Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/string_choices: Add str_plural() helper
Message-ID: <Zc43ojO9aymdzVo7@smile.fi.intel.com>
References: <20240214165015.1656-1-michal.wajdeczko@intel.com>
 <Zc0BkKXZfIkwnvRs@smile.fi.intel.com>
 <Zc0Bz5hUHWgHu9UQ@smile.fi.intel.com>
 <87y1bm6gpu.fsf@intel.com>
 <Zc0LQ8YAWBwNptBF@smile.fi.intel.com>
 <202402141104.642F85D@keescook>
 <874je969g6.fsf@intel.com>
 <fc1b25a8-6381-47c2-831c-ab6b8201a82b@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc1b25a8-6381-47c2-831c-ab6b8201a82b@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 04:37:18PM +0100, Michal Wajdeczko wrote:
> On 15.02.2024 16:20, Jani Nikula wrote:
> > On Wed, 14 Feb 2024, Kees Cook <keescook@chromium.org> wrote:
> >> On Wed, Feb 14, 2024 at 08:49:39PM +0200, Andy Shevchenko wrote:

...

> >> Or a Coccinelle script that could do some rewrites? But, yes, if you can
> >> include some examples, that would be nice. I think the helper is fine to
> >> add.
> 
> please find below requested Coccinelle script:

Thanks!

Btw, what to do with 0?

-- 
With Best Regards,
Andy Shevchenko


