Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB92431AAA2;
	Tue, 13 Jan 2026 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294106; cv=none; b=LePvKkLB7nMSg4zX6GnRf6cjdJuswWzi6bB2XQBWIrMlEkkGiU/vnGmSQ4AryP4eCzhTo/zMP72Rwf1IwrLqgpA4RCUBeqR1ro5YiIatBgvdh1s/Va8kn0VDaZgXHiBUeRfeHMiG923nWpMhdWsPSGfIkNaI0HRrFbvlTuqFeic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294106; c=relaxed/simple;
	bh=/Z8m9ne8uMWPSyQ17MDx7WtVbnaLwvr/m/iHHlitTok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE9+jhNCmN9F52jBeRu4fKMZVgep0Q2BKhqIifwr8IF7dt9x8USFPaY8o8KfSIrVAPC91iJ9nIkFRSXIcUCFpAjNXGS9CKbtRIEpCtmTsI13l+UPHfllq6l4BCofxGINkuIXoLfPkZMt4SV5MHkSlIIwVdo5CZRcke/To0p7LBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PoDuU/JT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoDuU/JT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768294105; x=1799830105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Z8m9ne8uMWPSyQ17MDx7WtVbnaLwvr/m/iHHlitTok=;
  b=PoDuU/JTXU2B/Jcw6RuFr2rjTm7Ao0h7+xffEzTecZOdATH6RMT8XV8d
   Z9MhbRd52TNjQgcxQD0QzTJJ4C37cnEdgbMMn4aPZeScvpYgbEXwue4+r
   +Gga6nX6Y0JzsWuBZNv7597yTdLK3Qkbo0O8bu3c5cYDnQ4mOOhrWpMhF
   +60k+5JrruPGxE17t28iuwrUOHlsTWY/R3WhHiCsHaOhIVEkhdBwkiOQQ
   QgHTqkW7gL4cBTAYCfNVJw5S6P3OFGzwQcGA7jWo3IixTvhXZpXiUbJwp
   t+VC1GZmqoEBTPDT9/54A4LRLQDffnlKakDmKV2w0yEJRDb1i20ocWBY3
   g==;
X-CSE-ConnectionGUID: VzYSxUJRR/qJM/gB23v03w==
X-CSE-MsgGUID: YpsfIuXqRFGglEfrUf8u6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="68579659"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="68579659"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 00:48:24 -0800
X-CSE-ConnectionGUID: RlkPL+LBRJGO3qW9byN2pw==
X-CSE-MsgGUID: spgj6BHXQv+xPGtLwavlrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="241844401"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 00:48:20 -0800
Date: Tue, 13 Jan 2026 10:48:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, kees@kernel.org, andy@kernel.org,
	akpm@linux-foundation.org, ebiggers@kernel.org,
	martin.petersen@oracle.com, ardb@kernel.org,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	samuel.holland@sifive.com, linus.walleij@linaro.org,
	nathan@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 12/14] riscv: lib: add strnlen implementation
Message-ID: <aWYG0AAsDix5rs1Z@smile.fi.intel.com>
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
 <20260113082748.250916-13-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113082748.250916-13-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 13, 2026 at 04:27:46PM +0800, Feng Jiang wrote:
> Add strnlen() implementation for RISC-V with both generic and
> Zbb-optimized versions, derived from strlen.S.

Now you have benchmark tool, what are the results? Please, put them in a short
form here in the commit message. (Yes, I know about cover letter.)

-- 
With Best Regards,
Andy Shevchenko


