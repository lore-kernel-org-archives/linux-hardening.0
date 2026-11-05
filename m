Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872843;
	b=uO1CIpmV5L6utGfBTzDCbbKC2mIkAeVHo3+8IH1tf87UTILYpcrNHhnifSxTdW8w8UQf
	 Sv+octsD2GyKORGcJoDPIZIzKpiVlKjQWD6C7FdJuVnAne07i6EOYuqgYCjD4CrzhO4QR
	 J3ySU5LTtZPJ05L3ujSO0ALug7Vog5VJOPpYlhEh9dnG4wB+x3VtYRZxC862d4odTY2Xl
	 auFgd36Gb0zkWl1kDVlPt7RCDH80ZTxF+BxR0dEyojg+VqXSNvQ6DnFw4mQiyfb/Ob9bX
	 K9HytTfEUHC39cIIIwEplzl7xowjAzr2lupbgwbGex/Q7IZfdislBR+FLkwGtaw2Nxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872843;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9gWIZ556XELV/JZHPdAe42L4BaKxg02n4+cgVq+thzI=;
	b=QF5uB6gapw0vvkAWpHczZWxDJJ49KnIS8T8tYQF4mcQoeeGzCAyPfhgn5c1BNq7x5LSu
	 XC/M4ExhfzeFMrm2JUbmC64xJBxxWf4QWPuxoD0NptYr4C+3KplAaHJMMtBX13QmeooBs
	 u3BP0dlS9Dkxtv4TaoGzPtDrYDBSXpM9RH8/JF9iqVm6HmFb54bGD3djlL3QhvN2VXIEs
	 vq+dPWB7JzuzzgbWUr5R9O4H61ibujGSlwDiP5R/XTguBYoKv0ts/0x/lZApTypgR8/7A
	 BjS3yq+8gkmmYJD5jy8LY7DdjB4Nyb/q8wHuK29VuN+2BA8CfUbXw93U6I5E+FqgmGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PBJmRi5k;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBADE606A339;
	Thu,  5 Nov 2026 10:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBADE606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PBJmRi5k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793872843; x=1825408843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z2H65UprW7zW8X/iim3pTFZF4OSbKQfsuukCJNwgJ8k=;
  b=PBJmRi5krXwXp/lWwIejtxGkwqeeUujHhzM4QhFGH4/9OVKYOGoy/FJY
   GUwltGtFuD6ddm9NsUfJJmssn/VDuufi0IpkSIP/cINhOX0drNHriJsE8
   YmmRSCHusbUXof7dh9MWDGQ3f6Zs0W1wuduDCWeDoTJh/001zjwQvkZ/r
   ogbGV7QAVkaf7vZqAH8U8gYtHYJA4cuT6YGeahY/vJJ4ybjOJe9fYHohs
   kRxAhg84cZICsgOtvfWfRjVsAAqQNuXrMnj7WiBlnInc+EkGTo2rfPnQ1
   69z/oKXB5D1ooFYrR5TZ7lpHNhuPhlTTkBDW6+cJqGjsczZkmSmxdevkS
   w==;
X-CSE-ConnectionGUID: el5fV4B6Qt2d23gnI1aq5Q==
X-CSE-MsgGUID: S1U+r8aLTLiX7xYibPZC8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2669792"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2669792"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 02:00:42 -0800
X-CSE-ConnectionGUID: Ryrj45DQTF6F9fytzqA4ug==
X-CSE-MsgGUID: CDdCSctqTauHKpXvMmTb7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6862765"
Received: from abityuts-desk1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.182])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 02:00:37 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 3CC51121B97;
	Thu, 05 Nov 2026 12:00:48 +0200 (EET)
Date: Thu, 5 Nov 2026 12:00:48 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
Subject: Re: [PATCH 1/9] device property: fix fwnode_name_eq() for empty node
 names
Message-ID: <auxT0Av4jDvcIGBS@kekkonen.localdomain>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com>
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
In-Reply-To: <20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com>

Hi Bartosz,

On Wed, Nov 04, 2026 at 03:03:43PM +0100, Bartosz Golaszewski wrote:
> str_has_prefix() returns the prefix length on match and 0 on mismatch,
> so the mistmatch case can't be told from "empty prefix matched an empty
> string". For instance: the OF root node's name as returned by
> fwnode_get_name() is "" and will return 0 for any name matched against
> it and since len is 0 too, fwnode_name_eq() will return true.
> 
> Do what OF code already does in of_node_name_eq(): check if the length
> of the expected name matches the length of the actual node name before
> comparing it.
> 
> Fixes: a9c8c738066b ("device property: Add fwnode_name_eq()")

Is there a need to cc this to stable? I'm not sure if anything is affected
there, probably not, but it's hard to be sure.

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/base/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 51109794d7275ddaf4571584d0e77d8573ebb475..a97575ff9199004b4f401f432aed6c95e40d0c25 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -700,7 +700,7 @@ bool fwnode_name_eq(const struct fwnode_handle *fwnode, const char *name)
>  
>  	len = strchrnul(node_name, '@') - node_name;
>  
> -	return str_has_prefix(node_name, name) == len;
> +	return len == strlen(name) && !strncmp(node_name, name, len);

I'd test strncmp() first as it's more likely to return faster. I'd also put
the variable on the right side as that's the typically preferred order,
i.e.

	return !strncmp(node_name, name, len) && strlen(name) == len;

Either way,

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

>  }
>  EXPORT_SYMBOL_GPL(fwnode_name_eq);
>  
> 

-- 
Regards,

Sakari Ailus
