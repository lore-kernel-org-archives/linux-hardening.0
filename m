Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E7E38B9B1;
	Tue, 20 Jan 2026 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894174; cv=none; b=bQfwMEHqodn8coHKMTK69YBIdTlqs9CTI6sRzYWwEIdY85vf1xE214QrPKBQMU9OxXk8go+qlBKheEWlbiXfX8ke3m0HyJfXnOJY/V/fBd3vBqvtW1aYRdcIlKOQ5ekFqn8tqNARj6np6m3GRIaDBcD/annhxNpFvADR8ZPnXr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894174; c=relaxed/simple;
	bh=VFJg5Tsh5Y6kNkUdZJLetVy+n3IRkDCFbBgjrVHFpLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3UgodaCacOQ00Mc1dsKfgqXKIfhl7vKjlkgMPJRLA5pTvpOUXNF2yusH70YngS5AVqbVn3UGyQNBh8ElLMWU7h4VNgzpydpfs+hUNAKgAvZyi3ugrfaL4Xgd6ZU9G6G952E50Q9hP3zzY+LRveIqFMqEhcyYXY4OycuXg2HHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJF0vYmi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJF0vYmi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768894173; x=1800430173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VFJg5Tsh5Y6kNkUdZJLetVy+n3IRkDCFbBgjrVHFpLI=;
  b=LJF0vYmiYr9hL0m7kNrfC54hQwB9C3hU2hj09DUMmM8Q9RL/l1scap0B
   RJIXagupu1G8MT1kD7B1IWYCzUEyIWEbsPIiQ7a9jhUwzTq4s+ivCY7fP
   Er8HVs7r1PNU7/r/6LQZm8Wh7xRicy9b3gYsn16JhZrYLP8C4oB05+3hj
   jPMqmvZH0SlNH/jSD9fr/DI2pYRvggdrUHNcTrV1118KST+fMidOqBHv2
   zHchhcHIYLhlQz6LjuUKYBjDWUnqyMNK0/PNMoFIQJU3UcW4mmmGPJGL9
   uloYzFMexK3vgCiWPA3fqk+1lFnBJ7xXfeeoAho0FBmPMGpUR6Gg8llwL
   Q==;
X-CSE-ConnectionGUID: p6wEtn+eRwmbJTNc7aQHqw==
X-CSE-MsgGUID: q7sUvPnWQLK8b1jYo5moQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69296632"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="69296632"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:29:32 -0800
X-CSE-ConnectionGUID: UltLPqvTSwyYBl2JfJSQ5g==
X-CSE-MsgGUID: c7B9OWueQOqwxnDniRaxug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210544968"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:29:26 -0800
Date: Tue, 20 Jan 2026 09:29:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, akpm@linux-foundation.org, kees@kernel.org,
	andy@kernel.org, ebiggers@kernel.org, martin.petersen@oracle.com,
	ardb@kernel.org, charlie@rivosinc.com, conor.dooley@microchip.com,
	ajones@ventanamicro.com, linus.walleij@linaro.org,
	nathan@kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v3 2/8] lib/string_kunit: add correctness test for strnlen
Message-ID: <aW8u0yaLT0Nr1kTW@smile.fi.intel.com>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
 <20260120065852.166857-3-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120065852.166857-3-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 02:58:46PM +0800, Feng Jiang wrote:
> Add a KUnit test for strnlen() to verify correctness across
> different string lengths and memory alignments.

Acked-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


