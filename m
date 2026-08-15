Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABED1EB5CE;
	Sat, 15 Aug 2026 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786784291; cv=none; b=HWoHPpx5DxsG5ANuVggfSfmlyzZpQgHDqi+EzPd/TBbkrSqPuQ3mQpvE8noWWmmI3bTBp1Bsnk/69JKY5gAdGuDnVrHQraN5vSjl+gH50fO2q0AAjnKZNILCOVoG4mcGzKOIxlEmC04QomoE4qCnmM2D9nXDdbsiWexSzKW/lIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786784291; c=relaxed/simple;
	bh=83rVzdc43/8GHpNstu2sZht933k01ghuS0VejBxZSVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXTKa0k+Ge6M63QYtn92niiWYEOnWfyvbFPuGoh3TJEj+ggbH74br9YpoUjSQQ9HOQK/ETYGziaGJFL5rxa+9ZHs8Hs3GysPrxKIqjc9Pae7dRErZW0Muz8Whmr5qJ01iV/PtiJ7ZYm26Rq9OU1b9aN36Tif0M4Cd93UxOscupk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vl1OsyXd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vl1OsyXd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786784289; x=1818320289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=83rVzdc43/8GHpNstu2sZht933k01ghuS0VejBxZSVg=;
  b=Vl1OsyXdqh6dQ45u6L5QIvtooIfayjY2hZXMkBnO43b4PrdBBkT9MpJe
   BwGBaaH7DmaQHy3OFdR6VUEqQ2j2L68LPDaI+BixzK2GnNqUDx0K3L04b
   1azUZ6fXWaSaRDekeksAolytGyi1pid7uMrKLvhXEavz+0dbBCOL+m7Q1
   UFPq3P9jWgO0RSB5MT94hVhaZIEGDLoZV0zqXxmcNXeVyCKE7MeRV5gL9
   nNFrCPY6oseKpFjoNQiWSFcj8GmUkRvk0y8YOt7SCIU8NxZ5EtPNoaLBr
   V8m5lYGO8V/JcRYgZKZvhLDMGXOf6YD2rerv9G1WvYZd+g9NITTVu2so3
   g==;
X-CSE-ConnectionGUID: hnftVAsOQPiiArceO2mEPQ==
X-CSE-MsgGUID: HpugK26aRyao2s+WIorTiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="74880130"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="74880130"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 01:58:08 -0700
X-CSE-ConnectionGUID: Px/3JtpTQZ60BRBsGld8xg==
X-CSE-MsgGUID: EilQOjN2Q8GYgk8GmAABfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="262662014"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.12])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 01:58:06 -0700
Date: Sat, 15 Aug 2026 11:58:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 1/2] vsprintf: Don't leak pointers for %ps without
 KALLSYMS enabled
Message-ID: <aoAqG0kKxvBbed0M@ashevche-desk.local>
References: <20260814144854.746840-1-bigeasy@linutronix.de>
 <20260814144854.746840-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814144854.746840-2-bigeasy@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 04:48:53PM +0200, Sebastian Andrzej Siewior wrote:
> The "%ps" format modifier prints the name of the symbol which is more
> valuable in terms of debugging and does not leak the actual pointer.
> 
> Without KALLSYMS it will leak the pointer which is not intended. The
> default policy for pointers is to print a hashed value and not to leak
> the actual pointer.
> 
> Print "(unknown)" for any symbol resolution witout KALLSYMS enabled.

Hmm... I would expect some test cases to be added/modified.
-- 
With Best Regards,
Andy Shevchenko


