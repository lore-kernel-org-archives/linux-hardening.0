Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FBB1FF7C7;
	Tue, 20 Jan 2026 07:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894142; cv=none; b=DEJVOu4o5ZW5I2PWBvFbqpxQsYhN+bOvz1fsiWFdXXXSeH1HYoBfzbJZTqoB6T0N/XeEbI2nG1Aj9+N/rdIVz6zXSvI8l1TucKNtH0glwQQ5Mn0cbMOjVxkagvkiavyMP1NdzxBiGWVez3pXZPKi2POIt0wKcsjw/oTxYwVM5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894142; c=relaxed/simple;
	bh=sAp1+vaHM3hb/JwJTI2V37THMHOSLDD7cH4NC0bdoO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/ewPoKLo8ptvCS2GLUEeoH3ebrNjP99iVOwY2Psyb3lLhS9Zhu4yg4KNxG7jP7hqivvkME4lXukJ/BGYK8AOjzwsByB86an2UrxZ2CwxmMDBuIgB71adDZvcxwOqp4Ret+UnxJMqeqheNsokN0z4Yv1rf94eDR1+HaoaAxabBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+UKVG6I; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+UKVG6I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768894140; x=1800430140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sAp1+vaHM3hb/JwJTI2V37THMHOSLDD7cH4NC0bdoO4=;
  b=b+UKVG6ISdS00ClFwyvy29TudaCWTgbbB7Q7MZoQIlEgLgfZatEAHvfa
   6DKtzLU35QR89lkMqx0Avy/67fxlTfaHX4MT64yz77EjcFj1M/yrhKvDQ
   4lXGcTAtrj91csWiDLNU+5VS3BWZ9T2OcDhmcFZxwN3kCa2QXsxl5rigo
   Z0yWAdIY6ercL4VtNNZS686skaW2KHfxdza56vWdbI8Tt6OPCsaUFVQ3Z
   OpeIh5TX9FSQVzzKkfEDA/D6EBY8YewaStr8rPdUkP6GEMs0TdcBiGCSV
   S2GEv4z63+v2kNi7de7ZY6dx2hrvtwB5nPyadS3kyLoS8581OA/jAL71h
   Q==;
X-CSE-ConnectionGUID: h1Gf9cdoRAqPlhi0xC2Izw==
X-CSE-MsgGUID: jE6jORZ0QNm+JXN6z1Dh9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="80817199"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="80817199"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:28:59 -0800
X-CSE-ConnectionGUID: Z3NshSj7TN6iP/nQfbYOKg==
X-CSE-MsgGUID: r+tg7TRGQcGL7cGtQXODgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="237311151"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:28:55 -0800
Date: Tue, 20 Jan 2026 09:28:53 +0200
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
Subject: Re: [PATCH v3 1/8] lib/string_kunit: add correctness test for strlen
Message-ID: <aW8utSeRsKSD8kg5@smile.fi.intel.com>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
 <20260120065852.166857-2-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120065852.166857-2-jiangfeng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 02:58:45PM +0800, Feng Jiang wrote:
> Add a KUnit test for strlen() to verify correctness across
> different string lengths and memory alignments.

Acked-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


