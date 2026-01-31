Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E748275AE3;
	Sat, 31 Jan 2026 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769853157; cv=none; b=TBuyVXS8/r8Gtfa2/f+wwCrxPINLNwMFqCeIzyJgAi3iua0DZxSljI8cau/f4JUg5scHD7A6OU4qnJ28lFzaG7VnzOTOhqLK/IcTB6/ziMZ3gFazIYL3gXBQryIkPi8Ec/bOGOXAfqC5nBL6N1MDtO1IMLFmXUIoQ8W5evSadQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769853157; c=relaxed/simple;
	bh=prkCbPpCK0uSsTKs9tYKLKVPMYFEczVRQ2cVcHOj6bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICCYZD9Fx22ShJJz9q943RTbtM0o3vPlZZ+pNZKrzjEYAfLmTWZ+eUde3y9XZpk6IvbTVwPX1z7eQL+L6t2gZzq15ttoM80vVKq9Mltkp55Jiv+otj/hw9k9swnHDzcnxsY8X+RyjEJbRiACSXqvJzrO9R7d0rq4MwUr4+9Gg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zg0H9CQa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zg0H9CQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769853155; x=1801389155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=prkCbPpCK0uSsTKs9tYKLKVPMYFEczVRQ2cVcHOj6bk=;
  b=Zg0H9CQah8/2CRt6R2lux+qdwM2wtkgLTGRrcnMLZv/mAYDIlynQetej
   +FHfeGAocijRzLdCuvV7yth3vKZgsgPJNGunKhymK4BWBWwRdHyoS0eMf
   kw8DhKemn+EClxEGKeTVcY97CWfTcgLVrC+FKvSe8V9AQUgaEAPVazVJG
   Vpi16sacGx0J6cOTNx8jFYM2M5gkcJgFW6/XYm96oIt8JIBuZLRA2JLmd
   fE2IKIkUL/eLSJJ/M58nRoQMMBRZFa/xRYyHTwP4Gu7OaM0NgXmPe+pOy
   hCEvkSexbCzIjEEuJocvMGyLMUrZgxCTdzV/Vimu1/8IMUing3FFAlKF3
   g==;
X-CSE-ConnectionGUID: c6SzGos/ThKxPfoxfmpMCA==
X-CSE-MsgGUID: wu0+rLAVTky/aUf1aFcCpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="81825379"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="81825379"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 01:52:34 -0800
X-CSE-ConnectionGUID: 8oBHYl3SRW+h/ERs3D/XjA==
X-CSE-MsgGUID: idkdaagRRoOHqiianH1HEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="209287642"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.97])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 01:52:29 -0800
Date: Sat, 31 Jan 2026 11:52:28 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Feng Jiang <jiangfeng@kylinos.cn>, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, akpm@linux-foundation.org,
	andy@kernel.org, ebiggers@kernel.org, martin.petersen@oracle.com,
	herbert@gondor.apana.org.au, samuel.holland@sifive.com,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	charlie@rivosinc.com, nathan@kernel.org, linusw@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 0/8] riscv: optimize string functions and add kunit
 tests
Message-ID: <aX3Q3O8qEasNeso8@smile.fi.intel.com>
References: <20260130025018.172925-1-jiangfeng@kylinos.cn>
 <202601300936.6EDA32E96@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202601300936.6EDA32E96@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 30, 2026 at 09:37:36AM -0800, Kees Cook wrote:
> On Fri, Jan 30, 2026 at 10:50:10AM +0800, Feng Jiang wrote:
> > This series provides optimized implementations of strnlen(), strchr(),
> > and strrchr() for the RISC-V architecture. The strnlen() implementation
> > is derived from the existing optimized strlen(). For strchr() and
> > strrchr(), the current versions use simple byte-by-byte assembly logic,
> > which will serve as a baseline for future Zbb-based optimizations.
> 
> I'm happy with the Kunit elements here, so unless Andy has other
> feedback, please feel free to take this via the riscv tree. (Or if riscv
> maintainers would prefer, I can take it via string.)

I have an impression that I already gave some tag. Why aren't not here?

-- 
With Best Regards,
Andy Shevchenko


