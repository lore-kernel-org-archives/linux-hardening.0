Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204733938F
	for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789649443; cv=none; b=q1TQ/8320Zx9wxFDRGUr1f2C1/MjLmLcvPqw7ascKUGXTp9Wn8Uf95RcRzU5nq+PQHcvxYR3/tx/urGruXCAocBUcFlXSKjBJh6/cnoSv3Wt1ogSAIgFzD8euhuuNr8FjwTo0rvTyyUN6zCRWc7EV0PBqHSx1u2+F6WUeG9LUVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789649443; c=relaxed/simple;
	bh=ZzWXhI3KvUI5kNn0oJ2dnLkm0fr70XcUjNU3CpyXKjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJaZ5BknGekGulrTG+iVWES3WCtLWKEe0BHi9ko2PqtPmmqPhWz9TWLIDToOngFaLUoO6qLvXr8Gzm5Y+lH8dBRloatJLpPzkguo0oKsS3eKEnD823P7Op8QR9CWQFcdvkVdc8hUmMip9B/oIK1aZhH8CXNddrGxn/eFYISfYxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrlMCHxW; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrlMCHxW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789649435; x=1821185435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZzWXhI3KvUI5kNn0oJ2dnLkm0fr70XcUjNU3CpyXKjY=;
  b=FrlMCHxWfViVdJpH+7WNj7dRS5emye04BDuqFTFsmnTYhj57/FWhIVBf
   mzu2XXTCHJBQKTtPc8b4WDDTqrzPEEDOT42vrdeVBld0cYboGuYvjm3a+
   /gXlv0uwbfpHHTp/SQa0zrAKAosGf0wFq8kTZb0SfIuv8chWCmnxJOwR7
   KdIT8+LB9uC4tgGyZQ1D+atrPCwtkRxJxxfcOjdLqAEYUYV6CGsDitOhh
   3tK4WC/bLooZ/sMfEm1a2twYWOQxPJWQpPijoMZPKPog5H4a36GHbDgl/
   6J2l7wAkY2Rw2KAIZmqWooZNlsacTEPFazuzvkztXoCPatRl7WRgqzMh7
   w==;
X-CSE-ConnectionGUID: fUh3CIUmQSKt8pOOllTjFw==
X-CSE-MsgGUID: 9oP4Ahx2Rw6j23wekWvUcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="571540"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="571540"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 05:50:29 -0700
X-CSE-ConnectionGUID: BHUVFHlUS6KIwZ6rSaE9JA==
X-CSE-MsgGUID: iF++V9+jRoaQSIqQ04iddg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="278986712"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 05:50:25 -0700
Date: Thu, 17 Sep 2026 15:50:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Thorsten Blum <blum@kernel.org>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 6/7] powerpc/papr_scm: Return the string length from the
 sysfs show functions
Message-ID: <aqviD9ow5HLGcLTK@ashevche-desk.local>
References: <20260917002312.i.923-kees@kernel.org>
 <20260917002333.2306346-6-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917002333.2306346-6-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 05:23:18PM -0700, Kees Cook wrote:
> perf_stats_show() and flags_show() build their output with a seq_buf
> and return seq_buf_used(), which may include the trailing NUL byte
> when the seq_buf has overflowed. Use seq_buf_strlen() instead.
> 
> Build tested ARCH=powerpc ppc64_defconfig with GCC powerpc64-linux-gnu
> 16.1.0:
> arch/powerpc/platforms/pseries/papr_scm.o

...

>  free_stats:
>  	kfree(stats);
> -	return rc ? rc : (ssize_t)seq_buf_used(&s);
> +	return rc ? rc : (ssize_t)seq_buf_strlen(&s);
>  }

On a brief look it's a single ternary like this in the file, perhaps while at
it move to Elvis op?

	return rc ?: (ssize_t)seq_buf_strlen(&s);

-- 
With Best Regards,
Andy Shevchenko


