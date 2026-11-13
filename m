Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579941;
	b=p5qURWpeYQWpYMAmrAabS8BKQWJvSbHBiH8WvzQZC0TuX+QUBMKRI5Du7fkRcnWmOFE5
	 wxHeuyA9jT8LuTET+1GRI+QaKKhIT0Oy62eZpSr/s2VxymIbYOQ03apc5GetSEtweKg46
	 xUsGdf0C3/lLv6o0RlkZC4yNTKo0hcYk/EvTnMFLx0N44c31ZBBql8/2/wHKHafDccg9L
	 70FQEzUghbAzsirRhDyzFz/4BxYKQoCKcjyIHF2kZlhsqskIKdZNBZUqjZi7Ke1aRXlEP
	 +jEPVaLo/6lTktq2gwuhjOvbphdLpzKZ7i2CmOc95cyCzQB/5tcXtSg3/hqh/uWCVxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579941;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ZIDZwYhSdTCKzuLOGp8WjvoyRZJwvKmi9n5KzdK/mh4=;
	b=krvKBlt3bVXrK3j9tyCnP/ARBlljJpumH6Y1bRRz0i2UErVfOUflADPwyaO0lxdLl29S
	 x8YblP+uu/UXeSc+TQND+Zc0gLXIkNDY5+8NmhYFBB8bXTJwWRapspqRB+S74fHKSGGCl
	 5JFkz8bgFsnZLWTRX2MyTAAmkydnAEwh6LFJ+sZW6jhKvqtCQ9V76m4vbHadutw9iOpzZ
	 8Qls7Sj7lH/RRFxX/d5LuomIfFZFdsT4HZFRMa2edRGiT7rB3NZICBlBSY466+7x4DKyo
	 N6rShJTHmHrdq2h/r8Rxt2rPReEaRU2sfp49pHUwPFra2SjopT5rgzT3gbIEFfGJE6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O1QrGPlE;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01811606A336;
	Fri, 13 Nov 2026 14:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01811606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O1QrGPlE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794579941; x=1826115941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9runC+surjKSCTcqGfyMchV+XqX/vQpKF6i2133R9Uo=;
  b=O1QrGPlEIIlSZIo9UnGH2wWKvuTMkIpTiB7usB4fnLmY974p77NrYy0w
   mHIYwMuqHm5T1O6duO7vK3siEq2dYBVJDyAk/UahVXkM74u2oknVYgyVr
   0Q2ls5Ms/+N358IiW8UMGPWPfXPkyHVcz99BpkUa2ADgrnzEc6grI0QxB
   2cvH8g3cEnueEw+Q67TJHs0T4BimCUwNDP7mFOljRrWIUHAJiVdzquC2W
   s74XKNqUPl9oQpaz07Q66xu1Dq3WJa9yf5yWIqofkL7crBYg6SaY70D4F
   1eOFgx5BBz/Nd/NZiyGBOpVk3sZY4NKTfgf8tqDIyRtOh6ZSL1F9T9qAt
   A==;
X-CSE-ConnectionGUID: Ev9xi+z+Ruy4t5TuGUvSPw==
X-CSE-MsgGUID: xVGezj6+SwqX+KE7XbOjNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3416631"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3416631"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 06:25:40 -0800
X-CSE-ConnectionGUID: 6OrwJ5h2RraKNMDhOyqSow==
X-CSE-MsgGUID: IGJnJ9PPTCylYPpwDPiaUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="10830523"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 06:25:37 -0800
Date: Fri, 13 Nov 2026 16:25:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-hardening@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	robh@kernel.org, conor+dt@kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v5 2/7] string: Warn if the prefix is the empty string
Message-ID: <avcd38TtBtRtWSMe@ashevche-desk.local>
References: <cover.1794574496.git.alx@kernel.org>
 <df3a35c469c60c2c9658d66b30e67468ba053863.1794574496.git.alx@kernel.org>
 <sashiko-outbox-212859@kernel.org>
 <avcUA0z7CuQqs6Bz@devuan>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avcUA0z7CuQqs6Bz@devuan>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 02:48:01PM +0100, Alejandro Colomar wrote:

...

> > [Severity: Low]
> > Does moving str_has_prefix() out-of-line into lib/string.c bypass
> > CONFIG_FORTIFY_SOURCE and prevent compile-time constant folding of
> > strlen(prefix)?
> 
> Preventing the compile-time constant folding of strlen(3) is indeed
> a performance degradation, but that's necessary to be able to
> WARN_ON_ONCE(), so there isn't anything we can do.
> 
> > lib/string.c is built with __NO_FORTIFY and its top-of-file comment notes
> > that it is reserved for routines that have architecture-specific
> > alternatives in <asm/string.h> or get overloaded by FORTIFY_SOURCE, while
> > other helpers belong in lib/string_helpers.c.
> 
> Do we want to move it to "lib/string_helpers.c"?  I don't know enough
> about the organization in these files, so just let me know what I should
> do.

string library (generic) is for broad use, so it should really be clean from
kernel things. string_helpers is exactly for some custom abstractions we use
in kernel. Now you should answer these questions (or more than that):
- Are there or potentially be users that needs this API earlier at the boot?
- Is this API is detached from the rest of string library semantically?
  I.o.w. can we group semantically coupled APIs and consider them as a bundle?
- Due to the above, ask the first Q against semantically grouped APIs.

My personal feeling that what you are trying to do is no go for generic string
as is. If you confirm that these APIs are not used / needed at early stages at
boot, they can be moved completely to string_helpers.

-- 
With Best Regards,
Andy Shevchenko


