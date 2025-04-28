Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DCA264A67;
	Mon, 28 Apr 2025 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745840431; cv=none; b=mV4hdr9cOMnro8Qf01yNdO6F672CNoy6gVvsRyfYtqwl1KDLoSy75cdpzfy9JR3Pi+ZPeSe0rtFOY6reqmjQsqpnqS1YiXHndlXtD26dXzunMC5pEmsKEmmfJKT2GN52tCiKVZFX5aBf587IXc/kCwBQFDQPeQir7lovH+wVnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745840431; c=relaxed/simple;
	bh=2ljdbjIEAmsAMoG7EZuv5JDe8PK4yJfG5z1oFt03uik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eVoH82UfIGuSH0n+dNyNGDFGTSh9+eWP9Bs4EzuCwCoTKys1uhYDoYtlqLTEisM5jCZSLIwaLnu7FTMAXxE/wB4d88Kx1TO8jNRmvehlCE5aRy5Pw7xwnv5mNs8lC/2AYrtwHLTby1aLt1Zcpt/+om47uovd7bPX3sIRzkYsIJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMlqDxrS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMlqDxrS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745840430; x=1777376430;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=2ljdbjIEAmsAMoG7EZuv5JDe8PK4yJfG5z1oFt03uik=;
  b=GMlqDxrSFE8HCHCRw35rYnGzBAXeCYZ3syfIsj2A+GkNkLAqzkG04rHi
   LLjB0+qXPAqJFlSxR5Yto6JSlEspGZzrOKlv+H6Oe/I4Bwplnd/kCNY5A
   58MgZnsnj2ZD8zHHweIGJUq/SKsG90XViJFv4BFYMn1+9m0/BXhFy/xaa
   ONhUd9LmKMbJRrxl28UcbFbklcqVPmkOZpvN67kcPLP5aHbZKSTPQHvNj
   5MxUkk1lxNDGknRaT82VC8kl1tk/f8HKG31RpGAb294sP6hcaFit0SsX0
   zk6aAp+m+OYHwQk2CX4fyNYPtv/sTKub2FnqZMLiYVpvu3YTCqQOM3676
   w==;
X-CSE-ConnectionGUID: nOM4/Qr9QT6FqbjEeIqVYA==
X-CSE-MsgGUID: X2YuJ8iUTDq6n3CcryODIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="69925580"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; 
   d="scan'208";a="69925580"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 04:40:29 -0700
X-CSE-ConnectionGUID: 5iHD+CUZTyKAnyN9TDF4lQ==
X-CSE-MsgGUID: pHkfg4rhQkW7AMEaFOTh1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; 
   d="scan'208";a="170719838"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 04:40:20 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matt Roper <matthew.d.roper@intel.com>,
 Gustavo Sousa <gustavo.sousa@intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Gnattu
 OC <gnattuoc@me.com>, Nitin Gote <nitin.r.gote@intel.com>, Ranu Maurya
 <ranu.maurya@intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>,
 Angus Chen <angus.chen@intel.com>, Juha-Pekka Heikkila
 <juhapekka.heikkila@gmail.com>, Yu Jiaoliang <yujiaoliang@vivo.com>,
 Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: Remove const from struct i915_wa list
 allocation
In-Reply-To: <20250426061357.work.749-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250426061357.work.749-kees@kernel.org>
Date: Mon, 28 Apr 2025 14:40:16 +0300
Message-ID: <874iy8y0nz.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 25 Apr 2025, Kees Cook <kees@kernel.org> wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
>
> The assigned type is "struct i915_wa *". The returned type, while
> technically matching, will be const qualified. As there is no general
> way to remove const qualifiers, adjust the allocation type to match
> the assignment.
>
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Jani Nikula <jani.nikula@intel.com>

for merging via whichever tree you find best; please let us know if you
want us to pick this up via drm-intel.

> ---
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: Gustavo Sousa <gustavo.sousa@intel.com>
> Cc: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: <intel-gfx@lists.freedesktop.org>
> Cc: <dri-devel@lists.freedesktop.org>
> ---
>  drivers/gpu/drm/i915/gt/intel_workarounds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
> index 116683ebe074..b37e400f74e5 100644
> --- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
> +++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
> @@ -156,7 +156,7 @@ static void _wa_add(struct i915_wa_list *wal, const struct i915_wa *wa)
>  	if (IS_ALIGNED(wal->count, grow)) { /* Either uninitialized or full. */
>  		struct i915_wa *list;
>  
> -		list = kmalloc_array(ALIGN(wal->count + 1, grow), sizeof(*wa),
> +		list = kmalloc_array(ALIGN(wal->count + 1, grow), sizeof(*list),
>  				     GFP_KERNEL);
>  		if (!list) {
>  			drm_err(&i915->drm, "No space for workaround init!\n");

-- 
Jani Nikula, Intel
