Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA648F7D;
	Fri,  5 Jun 2026 04:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780634482; cv=none; b=tMZvBSRiGZ2ku/kJxXTCe4MKJhfweeLigWDWUnrNVsr/BXgJdM0bFC7mfctzw6McNk6XYGfZbFPx/j3zLA1N6Pcccw34u9XTP6pLdEvzDO642aNNOuQV04HPykLEwf8PP4nwV4A8Uwzcd91ejl1ADLHKmKcaRdhD4PZs0hi3fU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780634482; c=relaxed/simple;
	bh=1AFrwY/BSimsB97s7u0GmuZBm0KhXdAB1m6+EDusagc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFW0c0wvLIjJAHLJ38XbIe6Mw/R3NpYhZ4OJxHURnuXvotV+9kSB/z90LqxWL5YtOCpXxNWgsN8WHf5wxgrAWGEUQmx/xvsJ/TavV4CeBMY4K4FU8r4QEBjAVaP9ZscbcrfThdSRteX4mpcUpqsqlo+yC+kDHnQx5yKw5cNqEyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGuA7Jjd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGuA7Jjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780634478; x=1812170478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1AFrwY/BSimsB97s7u0GmuZBm0KhXdAB1m6+EDusagc=;
  b=EGuA7JjdaRXDFQiUvf00a9ka+ICCcd+rxQ4K83bI2kgUc2G2kcUJqarZ
   VcU6E1sNsWJ5cb3fiEU0CrPqdIqlA5Mqw1Bbh991q1fYUTFGqZBbQVJmE
   O7oAAqBouLs986Fy27SQdbkMvPDHDIJnQJgKFR5xEzZZRIAxDJUBNKlMH
   JkGnTSaGexLa1nXpCPwu5wn15rka9PzONBj+uiUk/cARcGI8nkLrNbExw
   JXGA4SQw7wZBanZ97uhxc7CU2feSvuKIx+QaUg2KL4+GkOJHflb0paS/w
   iloOSDS0MkEWvDR1s2gG9KzEEAJXjZ13TgsnOGU+OIYQRV/5fQR4GKo6R
   A==;
X-CSE-ConnectionGUID: gYn0dpc/RiCJZXrXcN36fA==
X-CSE-MsgGUID: hvS7+3fZR+edqwY9xywmrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81447936"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81447936"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 21:41:17 -0700
X-CSE-ConnectionGUID: bxWrAD5MTmmC4kpDWxNKSA==
X-CSE-MsgGUID: kXdC4nTnR1+aBAI0D7XcZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="240279339"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 21:41:13 -0700
Date: Fri, 5 Jun 2026 07:41:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Arnd Bergmann <arnd@arndb.de>, Jiri Bohac <jbohac@suse.cz>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	linux-hardening@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/setup: replace strlcat() with snprintf() in
 setup_arch()
Message-ID: <aiJTZ9P7_bvRWlqw@ashevche-desk.local>
References: <20260604131752.1327556-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604131752.1327556-3-thorsten.blum@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 03:17:53PM +0200, Thorsten Blum wrote:
> In preparation to remove strlcat() from the kernel [1], replace two
> strlcat() calls with one snprintf() call in setup_arch().
> 
> Also drop the explicit size argument of strscpy() to further simplify
> the code since strscpy() can determine the size automatically when the
> destination buffer has a fixed length.

> [1] https://github.com/KSPP/linux/issues/370

Make it Link tag?

...

>  	strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);

This also has third argument fixed. Don't you want to change that?

>  #else
>  	if (builtin_cmdline[0]) {
> +		size_t len = strnlen(builtin_cmdline, COMMAND_LINE_SIZE);
> +
>  		/* append boot loader cmdline to builtin */
> -		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
> -		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> +		snprintf(builtin_cmdline + len, COMMAND_LINE_SIZE - len, " %s",
> +			 boot_command_line);

Hmm... Wouldn't GCC complain on this? (Build with `make W=1`.)

>  		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);

And this has also third argument.

>  	}
>  #endif
>  	builtin_cmdline_added = true;
>  #endif
>  
> -	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
> +	strscpy(command_line, boot_command_line);

-- 
With Best Regards,
Andy Shevchenko


