Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1422A4E5;
	Wed, 16 Apr 2025 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785961; cv=none; b=sDX9D1GOSr6OMA6TNH2fTukNacjX5QXUKNcHvSp0uzIwidtX4asEcEOeNewflFivbvTdQDcapITqCf17XzWqwtWL0BGjG47mRzAoqYE0108WIs3coFYViTuelN/6ehWkp5jwlSRVj1hUPCwckFJTD4jlM2G63dKcbU0sUuUUCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785961; c=relaxed/simple;
	bh=jGokpnFOqE6CW4PQnkZgtiGtX+d0K4vFQAPTpPYAqCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhREzrhpBkGyWozoq8kOwXc1vSuIwgev09XUjv6WSqkQQbhhD2sMSDsIyMIkWC4NILPs06+0In2pdEySarRfqGLTitkqDcn/H0ka5zz6WGAAr7WHiv9EuRUsN8X75g7VyEXN5zKYVMWbdMcUQDk4/KJ8C87m7zo7KSYIzeiQUnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+4KlJdn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+4KlJdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744785960; x=1776321960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jGokpnFOqE6CW4PQnkZgtiGtX+d0K4vFQAPTpPYAqCE=;
  b=n+4KlJdnMOn9y68xAWOM4bDVmGJV7Tk1npwb1ucifzE8b5ynYLnqA6AG
   o1iSLtpmpCw4MSIhMnLCCkxVGuHKaUgEvSzxLdYLqDBtvfk3elLX13L0d
   QLOWm+bNDOSZ5gjsxb8Re0TJ3Fu7g+LnXe7sDLf96ebExVmVqZmVv8eaJ
   FtzxKd47RSKpiNLIyLWgK26G5IXNidxXtcVZucoATrJmeIVJzjV9Hh6qX
   px+xv5pcwfrBI196BCLP2K77Iqn24Hp6DL0NU3ZUE9yWhtw/8ffsoobeI
   DxYeqZ4hB/E1HrKSS8TBGO2fRN3vFuwZdDtBPFcqZJCZF+wvp/mL9zljw
   Q==;
X-CSE-ConnectionGUID: FQU8xltQS/GVcW2CpXa/iA==
X-CSE-MsgGUID: skH2XKWlQcmIr5r8jb7Igg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46408901"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="46408901"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:45:59 -0700
X-CSE-ConnectionGUID: 8nE96dtOSQu/lMLES/GcLQ==
X-CSE-MsgGUID: yciDKKQQRaWVp0Ux3mGmwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="130201223"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:45:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4wWu-0000000Clkq-33e2;
	Wed, 16 Apr 2025 09:45:52 +0300
Date: Wed, 16 Apr 2025 09:45:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Mark Brown <broonie@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Tony Luck <tony.luck@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mod_devicetable: Enlarge the maximum platform_device_id
 name length
Message-ID: <Z_9SIBPsf4_cQ77Y@smile.fi.intel.com>
References: <20250415231420.work.066-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415231420.work.066-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 15, 2025 at 04:14:24PM -0700, Kees Cook wrote:
> The 20 byte length of struct platform_device_id::name is not long enough
> for many devices (especially regulators), where the string initialization
> is getting truncated and missing the trailing NUL byte. This is seen
> with GCC 15's -Wunterminated-string-initialization option:
> 
> drivers/regulator/hi6421v530-regulator.c:189:19: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
>   189 |         { .name = "hi6421v530-regulator" },
>       |                   ^~~~~~~~~~~~~~~~~~~~~~
> drivers/regulator/hi6421v600-regulator.c:278:19: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
>   278 |         { .name = "hi6421v600-regulator" },
>       |                   ^~~~~~~~~~~~~~~~~~~~~~
> drivers/regulator/lp87565-regulator.c:233:11: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
>   233 |         { "lp87565-q1-regulator", },
>       |           ^~~~~~~~~~~~~~~~~~~~~~
> sound/soc/fsl/imx-pcm-rpmsg.c:818:19: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
>   818 |         { .name = "rpmsg-micfil-channel" },
>       |                   ^~~~~~~~~~~~~~~~~~~~~~
> drivers/iio/light/hid-sensor-als.c:457:25: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
>   457 |                 .name = "HID-SENSOR-LISS-0041",
>       |                         ^~~~~~~~~~~~~~~~~~~~~~
> drivers/iio/light/hid-sensor-prox.c:366:25: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (21 chars into 20 available) [-Wunterminated-string-initialization]
>   366 |                 .name = "HID-SENSOR-LISS-0226",
>       |                         ^~~~~~~~~~~~~~~~~~~~~~
> 
> Increase the length to 24, slightly more than is currently being used by
> the affected drivers. The string is used in '%s' format strings and via
> the module code, which appears to do its own length encoding. This size
> was chosen because there was already a 4 byte hole in the structure:
> 
> struct platform_device_id {
>         char                       name[20];             /*     0    20 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         kernel_ulong_t             driver_data;          /*    24     8 */
> 
>         /* size: 32, cachelines: 1, members: 2 */
>         /* sum members: 28, holes: 1, sum holes: 4 */
>         /* last cacheline: 32 bytes */
> };

Since there is no even potential ABI breakage, I'm fine with the change.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


