Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3621F33F371;
	Tue, 20 Jan 2026 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895334; cv=none; b=bTleqoZnxSEQd4jDBMRmkKANnFGICGVBOwY6Lek4NKxKYYcvVKDrJD1keI8lD+ZnYpzQPgT3LPorsswH3M9dYa7M/xgq6EARW/OtTYvhSdL+A8aKs3qG5EblnNWMmZnb98TGRs96hGUtYMnIV7XyQWEJ59G/2jxDWCXFN3Iv30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895334; c=relaxed/simple;
	bh=k0kTOpVAbMSgIAQ+svuxOM9SArLZcXQbklyV/T0JbM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoxEsU0pICDV74NN+8Vsr9L+bbtMPWNdZ68tUuLbvwQkXGy6V2KvunAGb+Nwe9MHt3s+Om5Beu1luZ1jY1vdf5fSHxAVSFw+9REIdwjTJhOT1DHSRSb/OEBhpDkGb5tya83mCm8NUHsselIoTZ9pAq/yc3Njv5U6q0mjxs5rX/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SE6pIb+7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SE6pIb+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768895332; x=1800431332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=k0kTOpVAbMSgIAQ+svuxOM9SArLZcXQbklyV/T0JbM4=;
  b=SE6pIb+72+myc2eKIOvitH0O9zMhGRCE6RsATb2HV+rl+Q7EmQhfUZUn
   eC3dQ1xtyfBO070aAS24M7Y9oJJFFBOIdUpVmnSNfCy1D0oYxshF9SgKs
   2WdT7yOUevhgLonVtVapRgGUTtqkHna4uXmpUUwswieKfe4g3o37H+aM2
   WobyZek1KKGyXbuA08ZwrKcDw/8LP4LAbohNznk8xOYSQKI2emfKjBmv7
   icOZ2NRgowpGfcxBaWkehsC6zDHLLzOoglDrOBRDrQPxBjkk4fYimnbl7
   BojGFNyRB3vGu8yESRJu4KOBQq7t1OoY8cXmGAJ3ebLr5g/CcKQhRIC8P
   Q==;
X-CSE-ConnectionGUID: 29ebhltDTRiQ648fdPjQfQ==
X-CSE-MsgGUID: uAw3uEy7QSy452P5Q0SYug==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70184358"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70184358"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:48:51 -0800
X-CSE-ConnectionGUID: HKKCPH71QCOrf9Cdrgn0gw==
X-CSE-MsgGUID: n4YSA7VTSAehW5YoidIuSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="206102045"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:48:46 -0800
Date: Tue, 20 Jan 2026 09:48:43 +0200
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
Subject: Re: [PATCH v3 5/8] lib/string_kunit: extend benchmarks to strnlen
 and chr searches
Message-ID: <aW8zWxjpVMSTFPYM@smile.fi.intel.com>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
 <20260120065852.166857-6-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120065852.166857-6-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 02:58:49PM +0800, Feng Jiang wrote:
> Extend the string benchmarking suite to include strnlen(), strchr(),
> and strrchr().
> 
> For character search functions (strchr and strrchr), the benchmark

strchr() and strrchr()

> targets the null terminator. This ensures the entire string is scanned,

NUL character

(Also check terminology everywhere: NULL — is for NULL pointers, NUL is for
 '\0' characters.)

> providing a consistent measure of full-length processing efficiency
> comparable to strlen().

Acked-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


