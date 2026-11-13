Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586767;
	b=GjwXwcVe68Xg3PQ6nlzMuCnAK9EJ5xHjBcy4hMh1R+jLokK4cwrd1HiW5BwKINd7fsKN
	 BmTlt4N1m22r0iqVCOBaKQS7YVGMoocTg+bBwinVn8puOeO2yGTaMoSPMngEceS1Stedd
	 oqkvrfKNKd1pMlmtTAY04a4nMvOhi4Cf4DltAmPwcHutl/dglIc41nYVjBmtH3H4WFsYw
	 2ybcPKehwsBgdr0R+oujG5kKqCqz2heeOKFXbkVfqoskWkc/kWqlxWUXDo1Q9KphAjS0u
	 bf65LwZndZwI1bMSHPwfqGQNNbyTPnrRsyJu1Fdd2oR05KywBrXNoFIL5opKjuBPl/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586767;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=oO/L4wT+HAyKwurpfHTFIZjxjNbn4DtR8FDLIyKt6mQ=;
	b=uWi0IdWnhv74H/sW/5lLocjE0f45g4M8NVL8homYlOeuskaR+y/gnmCnoW0ylpWx/K96
	 51/VxhTljOL5ui1fMibJPOMAEn/kZ3vHnmygWn9HMSqi+F2Kb/3vKF3/NKTSH05FmScIk
	 wwxYOo+646bP8/uOkLh63NSqDK0Iqnf/9g/Ay+QfcaJgLfdgKHp22wm5n/0hpUAbHjBPp
	 d6MS0MCcDlEBW+NXyIvdi0ieYPSLSkJLX+rNRXi6+jStgK1k6pKN5OBkmkJSKqy1vwngz
	 yje6wOIEyhyyRixE5pV4hpCebBrq+n8waNMOoQdhjJ8VSFUmHElu0r8euMQj7HOFPxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C4ScWfhF;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CDA606A881;
	Fri, 13 Nov 2026 16:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32CDA606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C4ScWfhF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794586768; x=1826122768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w/H3vxilWiIY/oBeomI3Vr9aXfPsr8K8inhIjjgOnYo=;
  b=C4ScWfhFMkAry+zfOO/DjBIL6OrgZY+CvDgWtfqfEh0GF9RVzR1b5/sb
   xZhfvWHNLnIh20yCYevfn9Pw3x6XyO58neFB/DT/hYSNj3WHzJxRmQChf
   TuFlxCt5XoHsH5qWt163GfpnK23ysMb3nN2vOETCAyeU5nDBR4y/LwNNl
   7hd0fFubaJScuslYTPnFCu7aXGV1tCdzLmubUiWyUmudbh2yZQ63Ub+Y9
   K0e5NAUFiCsP9SGJOtpeS0fA1ZSYQ+D3sTH1EF9qWUKVwPWzAUVnH3ek+
   ztIjuBJkAkxIlbfqONbaSIyBlLn3sNYnwONnSNBNHrchGKuZL7Se9/084
   g==;
X-CSE-ConnectionGUID: HUoctku+SD64Zas1iCnhUg==
X-CSE-MsgGUID: UtTxuqX2S0qvNim72gw0Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3282226"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3282226"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:19:23 -0800
X-CSE-ConnectionGUID: sqDIhBnTTNqwivE1rQNtUg==
X-CSE-MsgGUID: /+xFyyifSpayyMkgOohuzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9128992"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:19:17 -0800
Date: Fri, 13 Nov 2026 18:19:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 10/10] gpio: shared: generalize most code to firmware
 nodes
Message-ID: <avc4g9cbAOEElzRX@ashevche-desk.local>
References: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
 <20261113-fwnode-for-each-prop-v2-10-4edc23d5cf50@oss.qualcomm.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-fwnode-for-each-prop-v2-10-4edc23d5cf50@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 04:47:10PM +0100, Bartosz Golaszewski wrote:
> Ahead of adding support for sharing of GPIOs for other types of firmware
> nodes, convert as much code in gpiolib-shared.c as possible to using
> fwnode APIs and guard the remaining OF-specific bits with CONFIG_OF
> guards.

...

> -static int gpio_shared_of_scan(void)
> +static __maybe_unused int gpio_shared_fwnode_traverse(struct fwnode_handle *curr)
>  {
> -	if (of_root)
> -		return gpio_shared_of_traverse(of_root);
> +	int ret;
> +
> +	if (gpio_shared_fwnode_ignore(curr))
> +		return 0;
> +
> +	ret = gpio_shared_fwnode_scan_properties(curr);
> +	if (ret)
> +		return ret;
> +
> +	fwnode_for_each_child_node_scoped(curr, child) {
> +		ret = gpio_shared_fwnode_traverse(child);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	return 0;
>  }
> -#else
> +
>  static int gpio_shared_of_scan(void)
>  {
> +#if IS_ENABLED(CONFIG_OF)
> +	if (of_root)
> +		return gpio_shared_fwnode_traverse(of_fwnode_handle(of_root));
> +#endif
> +
>  	return 0;
>  }
> -#endif /* CONFIG_OF */

Hmm... What do you exactly get from the compiler without this uglyfication?

-- 
With Best Regards,
Andy Shevchenko


