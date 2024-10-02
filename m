Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E41D078B;
	Wed,  2 Oct 2024 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880331; cv=none; b=ZD3cL5TeFUuS7dY8EulxHQ0uBptQ8a29N5vGxTdKCQpjRND4N63OSVd8xxRPSxxbipKNQeF1pWPehwS2jWfMkV74wBjLMh+LeCVD42tmVLUvYyDud9EIGfbEAPabmrragDVpyMPtgieO0gz3ZAdzDkasmak6rJVdJ8Nbi2SEI3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880331; c=relaxed/simple;
	bh=sFxZjljjSXBgJC8LqT/w4yAiyxCVhdFMZpVnVU5PYlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpF0b09co3YwvOeoxerKFs5gtUMc3oAmMZj7exU/doG8IkxIB9/yEb/CaQMS/PJ5qQxncw7a7Y+s9a8lfPW9I7VLQw/gddhThQaa8/H2Nq+Frd92XV6VbPv6vEDTFneedlaySk2AoYZfvBFA7cwTgVvNXyu8KgIC8MR9mw87ulM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: s5B6Iqv3Rp6glSYdEd/3Xg==
X-CSE-MsgGUID: gsKTfV4ZTBywkoSQbcWmjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="30837951"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="30837951"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:45:30 -0700
X-CSE-ConnectionGUID: th2POc9bTdSb8UA2ju9N5Q==
X-CSE-MsgGUID: vZ4xxf2eS965SesFLI5JNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="74324416"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 07:45:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sw0bU-0000000FhxU-3YTD;
	Wed, 02 Oct 2024 17:45:24 +0300
Date: Wed, 2 Oct 2024 17:45:24 +0300
From: Andy Shevchenko <andy@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: kees@kernel.org, akpm@linux-foundation.org, pmladek@suse.com,
	rostedt@goodmis.org, linux@rasmusvillemoes.dk,
	senozhatsky@chromium.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printf: Remove unused 'bprintf'
Message-ID: <Zv1chIuTlOdu-ved@smile.fi.intel.com>
References: <20241002012125.405368-1-linux@treblig.org>
 <Zv1Uk_3W2hu1M8-9@smile.fi.intel.com>
 <Zv1ZN8XZmSZTD-78@gallifrey>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv1ZN8XZmSZTD-78@gallifrey>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 02, 2024 at 02:31:19PM +0000, Dr. David Alan Gilbert wrote:
> * Andy Shevchenko (andy@kernel.org) wrote:
> > On Wed, Oct 02, 2024 at 02:21:25AM +0100, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > bprintf is unused.  Remove it.
> > 
> > bprintf()
> 
> OK.
> 
> > > It was added in
> > > commit 4370aa4aa753 ("vsprintf: add binary printf")
> > > 
> > > but as far as I can see was never used, unlike the other
> > > two functions in that patch.
> > 
> > Please, rewrap these lines to use more room on each line.
> 
> Something like this? :

> bprintf() is unused.  Remove it.  It was added in
> 
> commit 4370aa4aa753 ("vsprintf: add binary printf")
> 
> but as far as I can see was never used, unlike the other two functions in
> that patch.

You have two blank lines in the middle, do you really need them?
I would put it like this

bprintf() is unused. Remove it. It was added in the commit 4370aa4aa753
("vsprintf: add binary printf") but as far as I can see was never used,
unlike the other two functions in that patch.

-- 
With Best Regards,
Andy Shevchenko


