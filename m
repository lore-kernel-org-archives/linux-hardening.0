Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A60379994;
	Tue, 20 Jan 2026 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894214; cv=none; b=Hucjk25jdc4fuDPaDutsVlQlt8IkLuhqeYwK1gjMm+/lWn1LMPbGh1e1x6Of19+1fwzRNDb6jkR4mUuVrzhWWFTWqcTekX3DqcBodMs2CHBLpqZR5mL8zrYgGXi0eu5GBSu0YWLRrtYK8NeLTdjtmQcC1Nb1/W1vurvjQ2h4CmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894214; c=relaxed/simple;
	bh=PiHIgy9pcNcdJAMceILghC2Fv+8K8xr6hlv+TwIM2Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+G3rvALhEmTdszw3mnh9m8ziGMJ10WSJw63m1qUYfSVchoXOoia79pzXAEUxFzLZqVLXVYkJoRtfDHnv1Co6INcRz7I2BEDtdug6+ckL6yeiV+tA1jdTVudWX5mmNQnt3qH2swliGl9BSpZiEP+aJgHi3p0pGIYqVvFdimo5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VzknItaq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VzknItaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768894213; x=1800430213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PiHIgy9pcNcdJAMceILghC2Fv+8K8xr6hlv+TwIM2Yg=;
  b=VzknItaq3gx6q+rchKofKOsLjkxLrxWP/Tmb7FjPsy0jpgrB1jZIuL0R
   FEOgNsQOiWSwn9BmwMgYw0FPIX0PdoXSEKHiDSPaW76IFEm6UO0Z3pqr4
   y40cWbOsQbeoqLG7XLWxKg06AHnrQFEwbJ4LEAwLiez/YOJSK3dmeBvTY
   DL4MX1PMwNhQHpi4/+a9afmxCtU4QzojKSOd8izDmlKMXzO1pZdeJMyEQ
   ouJERp2y162fcii8uaJNmF8qUj1TXoOZueIaNxdR2tsnWlAqZGBbUKPZk
   UNocbLTFJW5HomJU6/ZA7G1K8AJBWqmk6Q2L3FKuYDIO28FIcMBrf8KWk
   Q==;
X-CSE-ConnectionGUID: z4quZ6IeTgav+8gN5+rjlw==
X-CSE-MsgGUID: QBikXCCGQY+X4U5C2UV3wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="87675963"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="87675963"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:30:12 -0800
X-CSE-ConnectionGUID: xxK9hBXyQtKPYrXh5SEPWw==
X-CSE-MsgGUID: x2HfyupBQ2aWASUyUHTbEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210519062"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:30:08 -0800
Date: Tue, 20 Jan 2026 09:30:06 +0200
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
Subject: Re: [PATCH v3 3/8] lib/string_kunit: add correctness test for
 strrchr()
Message-ID: <aW8u_hqxNThnnizm@smile.fi.intel.com>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
 <20260120065852.166857-4-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120065852.166857-4-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 02:58:47PM +0800, Feng Jiang wrote:
> Introduce a KUnit test to verify strrchr() across various memory
> alignments and character positions. This ensures the implementation
> correctly identifies the last occurrence of a character.

Acked-by: Andy Shevchenko <andy@kernel.org>


-- 
With Best Regards,
Andy Shevchenko


