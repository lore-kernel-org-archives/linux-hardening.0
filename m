Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283332;
	b=wrrJwvTJDruQHCIEeyvNFNAWzxIwT/gBgWxFM6UcB3R5AJ6GF1sMhw2ixh3mEiCWGfz5
	 tgEqoNBsueQQKwV/wzcY984dTRKdKjXq0u17D6P4Cq+7oF4CHZwz+lawDqigSk/0OYDtp
	 46cO1RcFKOFfkfAYRfVbeYzqA+fqdJcV6R7FaHi/dZbu7Z53MzR0yjRLc54OW5N88eVh1
	 1X2AlDb8gtrxxO1azyvssrXilee9fX8RW6pbl6C6MOrSkvzkONWmRsjhi6BGNWo6sCGeH
	 qlPVngPIc/Xn/PTe3Xf+TuCxMx2AWiPIOHBJvEib6PbeBCE+1+l8OQcSZHOCuXQ6iDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283332;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=FXCuaVCpwWottBu6pKn0235JvcEeLrLl5Q+bEkHQaYw=;
	b=StIYOED3oOisVxy7AsG5C3jWyTp9db2j/2QLoi9WZCx/SQyQfnvTgw1KxUOezMV+YMVi
	 fI6UnbcCYnmALnuh2EiYP914s8aojJoZaxF/d2qZQhXa5xQG5TZRsC/FJAVoTXwdMVHQc
	 NcjjJmUePqqoFhuJjJF4iSZxVfZtCg2X3WjqLJdIfHP0ivdq7iIukerWn0I+5Tom3z3he
	 Jb8q0arUelVyDi/MOIohFGU8tT3Ha7H0nch+AyrEj6eysEhglkzd1vqFRmYVwe5PaWI+r
	 3CiijQws1pTHIzhkUnKTeNdo92yuAJjr8PNxSkjP2iMXGGDMadjC+V6lICgF9wzJs4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j8pbvOeR;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB0606A338;
	Thu, 29 Oct 2026 14:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DDB0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j8pbvOeR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793283332; x=1824819332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=paK5BtdnHvkl9MWSDM60ujXzIQ0HaPpBPCelVsr0Pp4=;
  b=j8pbvOeRjooXJjh6BjtQOdUrPFu/oBz2Yt+k1kiFgoeS/VGlAzmmS3Q2
   VEu/sEZNXmqah/vNcBD2NHp+KYhlggcxqyH/sf+0HsH4JPuChXVZ9WwoT
   Lrg1iqll1PLLYcGGV6rbboTUaZ4+eeHR1oBXrRRpWEfttoXje5pTuXZpM
   1JsnJmyO+bhnmSHEugeodE5dlEig10cnzd59v/UAhG8ZZjTNw9HnDEF9o
   /R0FzXXZbuX+IDs+Mb/m4av36dz2TFbrsUQu4QSrqiKslJQy6fskFbX1I
   NYaOxsRRNV45c4UqZdudZ473bkzwyDnDCSO8jOf1nSa9eIA5B7etm+Bwb
   g==;
X-CSE-ConnectionGUID: 5CUChUjVQJiXyMdxvmpImw==
X-CSE-MsgGUID: dD1Xq/jWTy2vrjyL+CFNfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1909669"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1909669"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:15:31 -0700
X-CSE-ConnectionGUID: gdXbYC5HQWC+X7Xakw3OSA==
X-CSE-MsgGUID: zDN3ZckETP2ibAHWTm4tWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="6991104"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:15:28 -0700
Date: Thu, 29 Oct 2026 16:15:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seq_buf: Mark a seq_buf overflowed when terminating it
 loses a byte
Message-ID: <auNU_ilniwUpxSor@ashevche-desk.local>
References: <20261029053250.i.220-kees@kernel.org>
 <auMwo_T_FsZp5UsB@devuan>
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
In-Reply-To: <auMwo_T_FsZp5UsB@devuan>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 29, 2026 at 12:47:04PM +0100, Alejandro Colomar wrote:

...

> How about not allowing a full buffer without a NUL terminator in the
> first place?

/dev/null is perfectly valid device, although I dunno if seq_but designed
in a way to support this case.

-- 
With Best Regards,
Andy Shevchenko


