Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911027;
	b=nKlcwK1yx2Pw4j9GTM5/mFzn1cwSnSkbg1zN/yUI7XzsQU8lu4FivIxK49mZ6KdoyegL
	 7t+kZRx+XfwOt16L+u3lz1OXCXFJM+ofP5XEfaRaayGFPhUltuyXwH3AOYKsJks5xS/it
	 PQBYcEtozGooXRblwrEOcrbLB9MztdjmpmBFXd8DhkrNtMzGUKYXDF3jVHzQ4ol1WpjVR
	 IMRqILiyodR4TrMBr/R7PD3Eeo+ePmVlHakYKKELksEezigEXghmCgonj0lulnqMZ6z9y
	 nrVe9+kuFHarpm+rqGg/SwwtlylORXPo9B4utUZ6c2jKrOcTETDo2GSqKRvcVbW0Sqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911027;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=VymKjGyAJ2q2GfXg59+jpmA7NxuGTz8C+f/PCqXEurU=;
	b=PzH5JnNP2bVp7C7TSUcz7pmhp4mY5v2NrPo/N0OruIQPh2kff8sacQtilxytXPT+wgPD
	 AS+nnTNo/r6VXTNPffJEsBUUm/VBTjYJu/547eGjK7NpmHkrTcF0EVdxvYN9HQ6pBfXxD
	 iKxi7Kqk4isWZror44el5N/MPtuRnwM5pipXLvPlnjxbH/oHHxkHPiGXW4LgVOn+9PXw0
	 0iZxsry1bbdA9MlkbmZC29RlUvfz4K7dx8qu32q5HU8JqegLMujIauNDbzK1eJZocoXte
	 DOt53LvxSlRK8yiLyEF9D4H7gCoaABIg0cxcl/sPY4ESiSNR2M5olgC3fmiyfQ5ZOWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z3wSleuz;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB510606A323;
	Tue, 17 Nov 2026 10:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB510606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z3wSleuz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794911027; x=1826447027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g2/a/v/77F7SZjM2iQWCePueXVd22kk+1HO6GSj35yQ=;
  b=Z3wSleuzSaYZRZ91kreHBHCV/tn1nxTLfEqQ0hCZ6rWdAWUXlvNXlLTm
   ZwlBQdb/2UewJ/Ne7zLvrKDpI7fdE4dl1bFDaDYfsrXWC3MTaIF+QVWy0
   hMs8EraWuY2iLxG/eOom2XV+5CE1w9laTWoaw6aW9HXfieX9YxdzPrF47
   H9Wy8Mb4xIxxTiSP8Hiy5YnKMweFmgkBxDwrH8A5z4Uxr8vVaT0LjflIY
   ++YO9qF3V352JHEarNfAzwVw8FCu0DNyH+nlzZNYHZugHdx3+bjJ5cY4S
   9IX1y+8cnexzZpaHl+3m85J2ipT6RKoQj+1ScQgGul9IVZLG2GECOBBz3
   A==;
X-CSE-ConnectionGUID: WsZrlZWBSIePnIROfgQHJA==
X-CSE-MsgGUID: uFkJ0UTJSQ2kIiJfywOKzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3698086"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3698086"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 02:23:46 -0800
X-CSE-ConnectionGUID: MCFlTQPTSiG2kSjVPlvirA==
X-CSE-MsgGUID: KbmW/sXKTm+5ZspZvPHxvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9934710"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 02:23:40 -0800
Date: Tue, 17 Nov 2026 12:23:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
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
Message-ID: <avwrKmg3uyvP19pq@ashevche-desk.local>
References: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
 <20261113-fwnode-for-each-prop-v2-10-4edc23d5cf50@oss.qualcomm.com>
 <avc4g9cbAOEElzRX@ashevche-desk.local>
 <riqrrdjxaygsphy2mxe5xbsrokjtw6kyrneiyzsh7kld4qnrwf@iaa73bchswrz>
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
In-Reply-To: <riqrrdjxaygsphy2mxe5xbsrokjtw6kyrneiyzsh7kld4qnrwf@iaa73bchswrz>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 10:50:38AM +0100, Bartosz Golaszewski wrote:
> On Fri, Nov 13, 2026 at 06:19:15PM +0200, Andy Shevchenko wrote:
> > On Fri, Nov 13, 2026 at 04:47:10PM +0100, Bartosz Golaszewski wrote:

...

> > > -static int gpio_shared_of_scan(void)
> > > +static __maybe_unused int gpio_shared_fwnode_traverse(struct fwnode_handle *curr)
> > >  {
> > > -	if (of_root)
> > > -		return gpio_shared_of_traverse(of_root);
> > > +	int ret;
> > > +
> > > +	if (gpio_shared_fwnode_ignore(curr))
> > > +		return 0;
> > > +
> > > +	ret = gpio_shared_fwnode_scan_properties(curr);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	fwnode_for_each_child_node_scoped(curr, child) {
> > > +		ret = gpio_shared_fwnode_traverse(child);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > >  
> > >  	return 0;
> > >  }
> > > -#else
> > > +
> > >  static int gpio_shared_of_scan(void)
> > >  {
> > > +#if IS_ENABLED(CONFIG_OF)
> > > +	if (of_root)
> > > +		return gpio_shared_fwnode_traverse(of_fwnode_handle(of_root));
> > > +#endif
> > > +
> > >  	return 0;
> > >  }
> > > -#endif /* CONFIG_OF */
> > 
> > Hmm... What do you exactly get from the compiler without this uglyfication?
> 
> The alternative is an empty stub for gpio_shared_of_scan() and keeping
> CONFIG_OF around most of the code in that file. I think it looks better
> this way.

My question basically was what will go wrong if you drop that #if completely?

-- 
With Best Regards,
Andy Shevchenko


