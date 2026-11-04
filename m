Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827284;
	b=t2koO4SkAPsW1opRi5XhdNMKNktl0YGmGDc+Hv0NhSrsD5l3TRx4r48bLBhuwjYEaMvu
	 XnnrJ+U6E+LTNbBVutsWANipXaxov2V0CuT7IjUD8GjManczUYcyvFCOfWSBTV0jVRCBv
	 E9wtF+ZmLgK+6Xq2nFCxyhc4vWE4vWW9nMVmUQgEf1x+NbqBeoOkCjr9wgfdqdhNFRbJz
	 e/n9UPa9DI8U/uxjh97/ipxSnWbF0ZeLW1rn/UvdE+xFJ1xHqdob5Y/kS09IhHM3/Qef6
	 9j7sZJNuT6K+t4Ok4DPSz92hI7bZg8gVoLRlecL6+RYdor2bWfx87o9OQo/ccFpOm4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827284;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=IcksJualoxCD+RbsRNqMUhCl1MksyKQfsnT7rrH9XWg=;
	b=Uhlmvdt7Of3aIWJk4E1PhPReS9i4lDL1CeQNscaBbegZby5aGYtM/Ev26wETAd1wKf1B
	 QW0nqdtBoxNclWdZjh12QyTAYlGtiq9c6SAsDRWHEsLTqpscJpJ1h8q1L7Cn59zXRjzHC
	 HulYa/xv8Yz34fzudxnHiw2rItpdyJdkv+S1BOzXKoI4R2upnFOu4TYhlptR/TjmRmviJ
	 mjgNq7Yew3+sw/tM7MQHs85oQXrgzaYDow0T2AQPZPetvERv2GwMIg6vWdWrcpmR0vyAF
	 yFgRsHn2FUXmhwirwKKWa74O+ufG7oWLUKElAQ+fr9QTGHFgd4bRBNdrDp8+HgE+uug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AdeAKqls;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6A1606AC13;
	Wed,  4 Nov 2026 21:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF6A1606AC13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AdeAKqls
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793827285; x=1825363285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S0pDrHm/5JF1z7CNDN38W+riXTwGcVCO/zqTm7h3PdM=;
  b=AdeAKqlsexRrUcKSZR+9Smclx1irEBEa8qMn3EpXFTufn0OAFaIzt5Xj
   7/gMr9tTu9ou5Ckck9CJr7dKqyg384j87OXurgYRMW0T8RLbGUqBiwtMn
   Rduq801l5Zdk8qIdmHsP0lTt3GckRxzI/XfykCX48unUC66x0xDyIACia
   RuPH0965QbmK51JEy6NBkVMWsfsAYTr8palV3EWmzSBoIL4mM/nNLM/9u
   NyOp3hq8mAQ5ZdhFvgFDvpbIqn4vuLs3ZZzqMTG62cLGoaYELijjptjGl
   UTKEyJbb9Lug1T819p6d4K3ncnUYSD14CpGQJJmTyie+utDHGMU+sVcar
   Q==;
X-CSE-ConnectionGUID: scNUlqsUTeCJ49mmREBoBQ==
X-CSE-MsgGUID: 7kkPwjF3RHCUq9rVdBKLrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2483719"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2483719"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:21:23 -0800
X-CSE-ConnectionGUID: Sb6uK8xjTTyP2o/Kx9Qy3A==
X-CSE-MsgGUID: DA9Y5zsOTMiL5sB/0kTVaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="8603557"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:21:18 -0800
Date: Wed, 4 Nov 2026 23:21:15 +0200
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
Subject: Re: [PATCH 5/9] of: property: implement the .property_get_names()
 fwnode operation
Message-ID: <auuhy40x1BMoW96-@ashevche-desk.local>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
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
In-Reply-To: <20261104-fwnode-for-each-prop-v1-5-6e28fe1c72c4@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 03:03:47PM +0100, Bartosz Golaszewski wrote:
> Implement the property_get_names() callback from the fwnode interface
> for OF nodes.

...

>  #include <linux/string.h>
> +#include <linux/string_helpers.h>

Same comment as per fwnode patch.

...

> +static int of_fwnode_property_get_names(const struct fwnode_handle *fwnode,
> +					char ***props)
> +{
> +	const struct device_node *node = to_of_node(fwnode);
> +	struct property *prop;
> +	int count = 0, i = 0;
> +	char **names;

> +	for_each_property_of_node(node, prop)
> +		count++;

Hmm... Don't we have a helper for that already?

> +	names = kcalloc(count, sizeof(*names), GFP_KERNEL);
> +	if (!names)
> +		return -ENOMEM;
> +
> +	for_each_property_of_node(node, prop) {
> +		names[i] = kstrdup(prop->name, GFP_KERNEL);

Can property be statically defined somewhere? We might want to also optimize
these duplications with const variant (here or elsewhere, for fwnode generic
path, I believe).

> +		if (!names[i]) {
> +			kfree_strarray(names, i);
> +			return -ENOMEM;
> +		}
> +		i++;
> +	}
> +
> +	*props = names;
> +	return count;
> +}

-- 
With Best Regards,
Andy Shevchenko


