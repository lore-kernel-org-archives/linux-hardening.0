Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD745130AD7
	for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935460; cv=none; b=Pnd7otadLorRKW2AVbiEB4OEK0fMMm5RiqDi9fqs+yX1qLBb9cYpnS3Z2S264YD8ZOASKk3VGtjILzUXHBdCXobmjeyCxfV33pHuNar6yPLaOhRK6+s1fOR1K4tbiiEKemaAUhwzrvArUgoYCG4I4fERKfht37T830NgkKIHnRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935460; c=relaxed/simple;
	bh=FXy5TSdw3eB+4IJKUrVjY59TratUN40LRkurdDVsDuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EphJgIBOwlVUN7/Lv8cgCX59dEvtTgt2/tpfF7PBAs12FoF3i86NMu+wFJyfxIgy/iqPRRRJVddZCxOv7QtfQ1mlFpz/1yDTVdtMObUI5K2wrsu03+PL8i+Bf2nNRI/5oO6gaolQq27LYIeUEzm1YrZ1Xbeaddgh3K9KhcOtNRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FB+sikvq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FB+sikvq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707935458; x=1739471458;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=FXy5TSdw3eB+4IJKUrVjY59TratUN40LRkurdDVsDuE=;
  b=FB+sikvqfoHN3AVO3XJ5mS5h6YWRyeKajtNSu3scC41NxPhL5IwA01Pv
   YO8TZvEZA9hqCch4j8KGfMvUfFz43QuYsIPK9hfbQ0a6yIQmzbHlQgJML
   5FHvJmLZI02XNIzvVNWRtss1VB90P7IITAzuR1JN1CeeVoBNAjUr54yrw
   WG5gvBqXMtQoSZmsDW75slHmdwBwn+d9CGJevtZ+9v3EiTC1RDcyukUdp
   wBg7sRaNi2LXYY2AJXrpZWSWKrXozFmgIz8svpITekRPGt9gqzka1HuaF
   vc57h7/75SWzSvOd/AFTrLOlx15SCHpcgOM+JSrQyIjNAAg1ZLui3mQSg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19508906"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="19508906"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:30:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="7884696"
Received: from kwszolek-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.63.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:30:56 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Michal Wajdeczko
 <michal.wajdeczko@intel.com>
Cc: linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] lib/string_choices: Add str_plural() helper
In-Reply-To: <Zc0Bz5hUHWgHu9UQ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240214165015.1656-1-michal.wajdeczko@intel.com>
 <Zc0BkKXZfIkwnvRs@smile.fi.intel.com>
 <Zc0Bz5hUHWgHu9UQ@smile.fi.intel.com>
Date: Wed, 14 Feb 2024 20:30:53 +0200
Message-ID: <87y1bm6gpu.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 14 Feb 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Feb 14, 2024 at 08:08:16PM +0200, Andy Shevchenko wrote:
>> On Wed, Feb 14, 2024 at 05:50:15PM +0100, Michal Wajdeczko wrote:
>> > Add str_plural() helper to replace existing open implementations
>> > used by many drivers and help improve future user facing messages.
>> 
>> Any user of this, please?

git grep "\"\" *: *\"s\""

>> > Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>> 
>> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > Cc: Jani Nikula <jani.nikula@intel.com>
>> 
>> Move these Cc to the after '---' line.

Why?

>> 
>> > ---
>
> Besides that, check with the latest MAINTAINERS updates,
> you missed the maintainer of this file.

Come on Andy, you might have Cc'd Kees yourself instead of just
nitpicking about it! Done now. ;)

BR,
Jani.


-- 
Jani Nikula, Intel
