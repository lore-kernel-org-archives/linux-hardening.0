Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543FE132C23
	for <linux-hardening@vger.kernel.org>; Thu, 15 Feb 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010417; cv=none; b=RO8c+xFh5EyuWv+8/eUuStXfscwhd1qX1Pd11vZGaIpf531axh+4CCNqPJi5+u2KRDQwp9F8hJKGcy8mVm/89GFsrAJBsNJ8V3/hDYCqLqm8mYVJV9tVev0miEENBD8NY63FGMnpiu0hszKvht05ZrtkFGUs9lIQG+Zv7f6Tp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010417; c=relaxed/simple;
	bh=qt7VsP5WqYtQpe9neowlVvrueQG/PmC+mvbkKKj+EcM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i+Gw5eq+weNrHd8f9Be/3FWJeJuwzj+L8e6eTXGCMkOp8YmKoWtzOOo2BELxxT+dAL6U6QhwY19Dk980wGRxBvUszkFDBwxAUvJnCeVCsZ87IcuslcgznVgLAT8LvV6+VwA4DP+Ao6KEVrh+ca3bByYcTJmgw4WEMyCkiBJNHlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+lsRAvK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+lsRAvK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708010416; x=1739546416;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qt7VsP5WqYtQpe9neowlVvrueQG/PmC+mvbkKKj+EcM=;
  b=B+lsRAvKNwK07BS001OlGEIiXZIo3XeeOblPI3wCBvuQJnGRjdZ2hKBO
   n92ojPoKEi5NSdPZug84Blt5fKHO+vbIkLauN4v/bHgTDdj+ljYDos/ui
   GUJkf4ckJxwebiPzOMZ1I1YCWKY2XT7YC+Ii4a/ZHkxClIjZNjnXr/kVL
   etbM36W962ogDHxmGRg21OXXu6kzjTxO+TBPqmKyNBjNvkShbvxWphTW1
   0leX2xL7EE9w8128VuxymkzS5B6gbuqSs0ynVmcZXV5uhyr1dn1XJbxSz
   ISyWr/7v4JCgDldZP61nxqzMgrhMqtXH9WQewUXV5+4NMNCdwpN/AycdA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2240704"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2240704"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 07:20:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="3548868"
Received: from kraszkow-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.44.13])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 07:20:12 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Kees Cook <keescook@chromium.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/string_choices: Add str_plural() helper
In-Reply-To: <202402141104.642F85D@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240214165015.1656-1-michal.wajdeczko@intel.com>
 <Zc0BkKXZfIkwnvRs@smile.fi.intel.com>
 <Zc0Bz5hUHWgHu9UQ@smile.fi.intel.com> <87y1bm6gpu.fsf@intel.com>
 <Zc0LQ8YAWBwNptBF@smile.fi.intel.com> <202402141104.642F85D@keescook>
Date: Thu, 15 Feb 2024 17:20:09 +0200
Message-ID: <874je969g6.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 14 Feb 2024, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Feb 14, 2024 at 08:49:39PM +0200, Andy Shevchenko wrote:
>> On Wed, Feb 14, 2024 at 08:30:53PM +0200, Jani Nikula wrote:
>> > On Wed, 14 Feb 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> > > On Wed, Feb 14, 2024 at 08:08:16PM +0200, Andy Shevchenko wrote:
>> > >> On Wed, Feb 14, 2024 at 05:50:15PM +0100, Michal Wajdeczko wrote:
>> > >> > Add str_plural() helper to replace existing open implementations
>> > >> > used by many drivers and help improve future user facing messages.
>> > >> 
>> > >> Any user of this, please?
>> > 
>> > git grep "\"\" *: *\"s\""
>> 
>> You know what I meant.
>> Second patch in the series that shows usefulness of the first patch.
>
> Or a Coccinelle script that could do some rewrites? But, yes, if you can
> include some examples, that would be nice. I think the helper is fine to
> add.

In all kindness, I think it's actually better to get the inevitable
bikeshedding rounds done first. It's trivial to add users after
that. And for simple things like this it should really be obvious to
everyone what the usage would be like.

My first attempt at adding a plural helper seems to date back to
2019. Yes, really. Personally, I honestly can no longer be bothered to
put in the extra effort before there's some indication of
acceptance. (Like there's here now, thanks!)

>> > >> > Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>> > >> 
>> > >> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > >> > Cc: Jani Nikula <jani.nikula@intel.com>
>> > >> 
>> > >> Move these Cc to the after '---' line.
>> > 
>> > Why?
>> 
>> At bare minimum to reduce noise in the commit message.
>> If going further, to be environment friendly (no jokes).
>
> I learned the above-the-line CC habit from akpm. But in looking through
> recent commit history, this does appear to be the exception now. I'll
> need to adjust my own workflow for this too...

It just depends on where in the kernel you look, every subsystem is
subtly different. In the drm subsystem if you added the Cc's below
"---", you might be asked to move them above.

Trivial for whoever applies the patches to do whatever they please with
the trailers, impossible for the contributor. It's like The Trial. :p

BR,
Jani.


-- 
Jani Nikula, Intel
