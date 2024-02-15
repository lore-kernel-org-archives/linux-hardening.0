Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846CB39FFA
	for <linux-hardening@vger.kernel.org>; Thu, 15 Feb 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016713; cv=none; b=GIuC8An6mIv5MkBn4JyQg1v+ne/ofiP3NG0uI6MrHWlYkxCPz9XqNvH1WHy0bXA+VHEMtiFzLauI2UTZFf4F/Om7u18V+7WAEGQQ321R+dGw6RMEThsNzghI88/+inhClcy5dy3ZLFEOdk66vJOU0kv1vxSN5ZzC+vQMrXxohg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016713; c=relaxed/simple;
	bh=rCQIpC3Cl4nlnVV5QtkseK8DHgLwL1FLiJwZGrZsUtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHInMVk/ziLTqW9LjMcZnEGzrZCRSJLf9P3ZPWAfao5XIDcNAA7hD3SjzaKI9fkD5WDD8Yq7b+IkXHjbWbzAmK4QqvePxvHzCT4YArbEsljs0zeKDX+Txtxk3f1zTRewXhpfvn0JxHZe/6sus2ZPawgZxLnhldACFb/bJPwgj5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsoxmldX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsoxmldX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708016711; x=1739552711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rCQIpC3Cl4nlnVV5QtkseK8DHgLwL1FLiJwZGrZsUtA=;
  b=nsoxmldXf0yjOJNv1+J1YYXI25UhsMCqE1VxGDPGudp5HQPXv7lx+IQA
   /GzKlnwWIdpiVpnBfmZbUVvfGnLpD/9xwJoVr9HTXSpBfPe0ZawRwJXLy
   0yGGMtKRW9QSvlRy4Sxcwk3pClwL+YwYJQuU6fbCYwrTdqpqqA121EC3W
   7LeApqa/SmvXVLG8314k5s6djqih4Z2ZsjZDy1TMEx//1a/dPSQh8EbH3
   Q825PDe+trDMCnzZC+bI26lJMq5ilzpWbZ5gU8hFc8iDQ3IWXILbYSJRR
   S3bVwE2MtvwHiGl08oXhp2xcpK2pPvYPMWFd8PU5cLpaluxuYSIWuTBf0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="1990084"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="1990084"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:05:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912195002"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912195002"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:05:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rafAY-00000004qdE-3kaT;
	Thu, 15 Feb 2024 19:05:06 +0200
Date: Thu, 15 Feb 2024 19:05:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>, Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/string_choices: Add str_plural() helper
Message-ID: <Zc5EQhQC0DaHZIgO@smile.fi.intel.com>
References: <20240214165015.1656-1-michal.wajdeczko@intel.com>
 <Zc0BkKXZfIkwnvRs@smile.fi.intel.com>
 <Zc0Bz5hUHWgHu9UQ@smile.fi.intel.com>
 <87y1bm6gpu.fsf@intel.com>
 <Zc0LQ8YAWBwNptBF@smile.fi.intel.com>
 <202402141104.642F85D@keescook>
 <874je969g6.fsf@intel.com>
 <fc1b25a8-6381-47c2-831c-ab6b8201a82b@intel.com>
 <Zc43ojO9aymdzVo7@smile.fi.intel.com>
 <c5c13073-d543-4f80-a8b7-cc080cf04cbf@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c13073-d543-4f80-a8b7-cc080cf04cbf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 05:55:43PM +0100, Michal Wajdeczko wrote:
> On 15.02.2024 17:11, Andy Shevchenko wrote:
> > On Thu, Feb 15, 2024 at 04:37:18PM +0100, Michal Wajdeczko wrote:
> >> On 15.02.2024 16:20, Jani Nikula wrote:
> >>> On Wed, 14 Feb 2024, Kees Cook <keescook@chromium.org> wrote:
> >>>> On Wed, Feb 14, 2024 at 08:49:39PM +0200, Andy Shevchenko wrote:

...

> >>>> Or a Coccinelle script that could do some rewrites? But, yes, if you can
> >>>> include some examples, that would be nice. I think the helper is fine to
> >>>> add.
> >>
> >> please find below requested Coccinelle script:
> > 
> > Thanks!
> > 
> > Btw, what to do with 0?
> 
> code is based on this rule:
> 
> "With countable nouns, zero is always followed by plural nouns."

If it's not documented / commented, please add one.

-- 
With Best Regards,
Andy Shevchenko


