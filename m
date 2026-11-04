Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828045;
	b=oNs++X7rpjqDPv55zzXB9wp+COlkMfl8zvVm6wLtDbnF0XYKKReowjyeIP25H2L39rJV
	 rTdHtlL+O1Lz8wPHCCAf9q/TcBmBeVS/oBpTKQPHFfEKuEGYCMcWrnlJY9lY1th32pxnI
	 vGEPmx64y9MCXoHY5XgbcpeNyxpGsYbSWRWp82CYooA7IGpANdXPylDkZmD5wCdtMBlu0
	 XqxUKVwwSiYzptjsFwK/OScnVns4FjxfH131IFikHHBjSOEGASxT9q4A7LkymlGn/L2jo
	 /S5kuRazVmG98dOxLWc7rY2sXBPryy9L206BkhXsVMmipkEGr6NgPrIt+TSemG56D0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828045;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=9nKvJbaUcji5RiFFkvoszphTBDYEbMKLXoOUcUhjA9Y=;
	b=bjQICjKS5FnXTFPUFmeZLuNVZag3Pijcv8E/OYuOSvSV+xb+gJBUn34Azy/yP7D/uRou
	 Zt6aEE0zckN2C0dv1WTTWPv+v0hAiF5z6O3biXh2ZXWgdHGWp5Fi53AbwhkjFH+QmOlEs
	 7GV3978d7h85Hc0nrwkjQ4p2+OUU6wEzvBK3mrjjVl8NI8M7eqcLCo/JlFE4YEMKuHLs9
	 aqQ1E3ip45EgK0qbfXuxpqSHfXZetPzk41f/pxp6sGY1iHJypyoMPe5w3Hc9pxUuPWRIE
	 /7yVl6VdjyuZTMclTDwUPRwGZgiM7pYQnM0u5VH0PdgnC9lpGrwrRnSU1OcRlhXVOHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="El/1Rl9a";
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C882606BA35;
	Wed,  4 Nov 2026 21:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C882606BA35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=El/1Rl9a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793828044; x=1825364044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dSHD22sqoPeJn+6jn0TgmhqlpAHpJfnJ/nqGrnYSGlk=;
  b=El/1Rl9a2hDoOzX1KY/EmvJKihDFF3W8O6fWO/I0jMFR8YAcjrvzFNYN
   L2So0F6xSefrZQXMCfEyAWBZWosqwkhOZFtBf3BUVNEPETRLbNb+wMbjM
   qletnCiq4BvTGah6PTzEYf/b64ShjpEDrqhYwhadLl89eTJDIEO3em+yI
   L1NGV8jGX8nceTRcZStwAs2Ao3NIAGlISFH5KbfEknR9wZPQVBKbt3pZH
   9PY+AAwCnZQNvLnsX0h5K626KAi82vAYjaaHOrW1l/BG9HLaLT2sGzaMu
   9+A3MymaqZH+ezpQELVH5zikAqJy06ryGHRiXkjFgZXQYcUxwTdaF75xO
   Q==;
X-CSE-ConnectionGUID: cMaTYde5SL+vi4ZDRXWtCg==
X-CSE-MsgGUID: tPDOqx38Th6lkhncZTTQiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2605453"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2605453"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:34:03 -0800
X-CSE-ConnectionGUID: KwuCGyO9ScCeYbqAy0WSvA==
X-CSE-MsgGUID: d1PmHtYQSVS2sjsse1bh1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="8605631"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:33:59 -0800
Date: Wed, 4 Nov 2026 23:33:56 +0200
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
	Linus Walleij <linusw@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 9/9] gpio: shared: generalize most code to firmware nodes
Message-ID: <auukxCs4Be4idQPj@ashevche-desk.local>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-9-6e28fe1c72c4@oss.qualcomm.com>
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
In-Reply-To: <20261104-fwnode-for-each-prop-v1-9-6e28fe1c72c4@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 03:03:51PM +0100, Bartosz Golaszewski wrote:
> Ahead of adding support for sharing of GPIOs for other types of firmware
> nodes, convert as much code in gpiolib-shared.c as possible to using
> fwnode APIs and guard the remaining OF-specific bits with CONFIG_OF
> guards.

...

>  #include <linux/string.h>
> +#include <linux/string_helpers.h>

As commented before...

...

>  static LIST_HEAD(gpio_shared_list);
>  static DEFINE_IDA(gpio_shared_ida);
>  
> -#if IS_ENABLED(CONFIG_OF)
> +

Do we need an extra blank line?

>  static struct gpio_shared_entry *
>  gpio_shared_find_entry(struct fwnode_handle *controller_node,
>  		       unsigned int offset)

-- 
With Best Regards,
Andy Shevchenko


