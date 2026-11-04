Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827066;
	b=AI6w0l38ZzrcOnoP7YLTi/C3TMpIPKlNVMX7tT2FP/6iYHB4by93Vn6bCgVfeDxMI6nk
	 hKVqz1qn8J0cw0Tc+9bNjgUAaqPq88eahu49v1qcHX0v2iJc6S2a1Cu61iQ3G7qK+u0bx
	 BPrX/cVwzTlu5tanXlQRBzw770lQnjgETNFFkIvwFypIloxj+R8pRVgmkoar/fSNJsAfb
	 Th44mEymK8qtI42NnzEG5hgx/JEyvineKvUcSQlIix4yt1ogl7trwQJs2mgfC3mOE/10j
	 QqwRRBqxXqmjQsNqXrl48N/kjB3hqL57PJfDvdV3xgruX0KFFaKwmAaeHqpiZuHnCCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827066;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=mI96Y8ShDpKzHCEcP2OgiUqcR+z8DiP4BqJSlsmOoSE=;
	b=cEVmQ5bEi8twbaI89NdeGg1+UYCQruBmZY1B3W8UpbRxdj8t3QVHT3WUyPo+ORwt29RN
	 wGhZn9BeZuG7zlxtJP41vy9hsiYBz4qeiywOC6qxiEUouQsWWf5mkOCzHFEHMYeuJGnu2
	 qZzjOFQYe8guKNRKC83syJKDyrPvzB+5jSwrUln3KcYP3Q3y48c/3BL8atsbPVI0/FBww
	 gsQS2u78BFRODQIeu7q4FHcKvUBhM3ZUKpPanK5avMaeTmLyodgHawp/c393DmTZSk1PB
	 WuU2T3Z8HogWBv+6oaUpXSsj0w9NZ7xfFC2aMq+6fBoZBdypUlSnZKfK2CnJcEKMfFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TsBCnEka;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAEE606AE17;
	Wed,  4 Nov 2026 21:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AAEE606AE17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TsBCnEka
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793827066; x=1825363066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OxFD2y0vi2PbpMdz5Za1fUdK4ldU1V6rTl4KYYCPlCQ=;
  b=TsBCnEkaakiPbPe6ANqqfntg++d5y3jlJz6k6zBT2+XSEEUNuQw5V0kX
   VsJHGk5s5ExnA1PaxcPNDXVky0PyA3/kqduBlGo45fbsMsEMNRlJQzsBS
   dP9FL4SyWJfzn/8/WQ9fOlm8gzdwxvcWO7YqfrMfXqfLfkOsPHZjvLn07
   dvlavMZzWI516Xv9E2kToV9tVRWv7y60ehW0lgKCdidQvWD8f9IJsHQ/x
   AjxdDNQBBDsrrtCtpdsNCpY4VkG/RDZzvLWVelVJXJZcSp9JH7rE0sUvq
   gQqVvq3177Qt5JrVk42WwpkbNmed2OfNZ9hwP2mldweNFxlIGWsSxe1db
   g==;
X-CSE-ConnectionGUID: dF6hgHKDRR2Xed/zfqnxKg==
X-CSE-MsgGUID: dXJuVqIRQye2KKkd7xKWnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2505018"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2505018"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:17:45 -0800
X-CSE-ConnectionGUID: 82oTkYOsSO2+b2xk6C7VnA==
X-CSE-MsgGUID: kwSFyqLDR6iZxkWvyXwKVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6841615"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:17:40 -0800
Date: Wed, 4 Nov 2026 23:17:37 +0200
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
Subject: Re: [PATCH 4/9] device property: provide fwnode_property_get_names()
Message-ID: <auug8QoQ62ETGg1D@ashevche-desk.local>
References: <20261104-fwnode-for-each-prop-v1-0-6e28fe1c72c4@oss.qualcomm.com>
 <20261104-fwnode-for-each-prop-v1-4-6e28fe1c72c4@oss.qualcomm.com>
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
In-Reply-To: <20261104-fwnode-for-each-prop-v1-4-6e28fe1c72c4@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 03:03:46PM +0100, Bartosz Golaszewski wrote:
> Provide fwnode_property_get_names() - a new fwnode function that allows
> callers to retrieve the list of all properties of given firmware node.

...

>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> +#include <linux/minmax.h>
>  #include <linux/of.h>
>  #include <linux/property.h>
>  #include <linux/phy.h>
>  #include <linux/slab.h>

>  #include <linux/string.h>
> +#include <linux/string_helpers.h>

You can replace string.h with string_helpers.h.

We already rely on the fact that the latter includes the former
elsewhere in the kernel.

>  #include <linux/types.h>

> +/**
> + * fwnode_property_get_names - get the list of all properties of this fwnode
> + * @fwnode: Firmware node to get the list of properties for
> + * @props: Pointer to an array of strings. It will contain the address of the
> + *	   string list containing the property names.
> + *
> + * Return: Number of property names written into *props. If > 0, the caller must
> + *	   free the array with kfree_strarray(). *props is only valid for
> + *	   a positive return value.
> + *	   %-EINVAL if arguments are not valid
> + *	   %-ENXIO if no suitable firmware interface is present
> + *	   %-ENOMEM if memory allocation failed

> + * The list also includes the properties of the secondary firmware node, if
> + * any. Properties present in both nodes are listed once.

I don't know if this paragraph is for Return section or not. If not, it should
go before as the Return section must be the last one in the kernel-doc (it's
documented). Otherwise I'm not sure it belongs to the Return section. I think
it would be better as a part of the description which should elaborate on the
returning values in the parameter.

> + */
> +int fwnode_property_get_names(const struct fwnode_handle *fwnode, char ***props)

Triple indirection is rare. Do we really need it?

> +{
> +	int ret1, ret2 = -ENXIO, n1, n2, i, j, count;
> +	char **prim = NULL, **sec = NULL, **merged;
> +
> +	if (IS_ERR_OR_NULL(fwnode))
> +		return -EINVAL;
> +
> +	ret1 = fwnode_call_int_op(fwnode, property_get_names, &prim);
> +	if (!IS_ERR_OR_NULL(fwnode->secondary))
> +		ret2 = fwnode_call_int_op(fwnode->secondary, property_get_names, &sec);
> +
> +	if (ret1 == -ENXIO && ret2 == -ENXIO)
> +		return -ENXIO;
> +
> +	n1 = max(ret1, 0);
> +	n2 = max(ret2, 0);
> +
> +	CLASS(strarray, prim_props)(prim, n1);
> +	CLASS(strarray, sec_props)(sec, n2);
> +
> +	if (ret1 < 0 && ret1 != -ENXIO)
> +		return ret1;
> +
> +	if (ret2 < 0 && ret2 != -ENXIO)
> +		return ret2;

> +	if (n1 == 0 && n2 == 0)
> +		return 0;

Shouldn't these checks be before any CLASS()? Otherwise seems strange to me.

> +	merged = kcalloc(n1 + n2, sizeof(*merged), GFP_KERNEL);

Shouldn't here be something from overflow.h?

> +	if (!merged)
> +		return -ENOMEM;
> +
> +	/* The strings are now owned by merged, only free the container. */
> +	for (i = 0; i < n1; i++) {
> +		merged[i] = prim_props.array[i];
> +		prim_props.array[i] = NULL;
> +	}
> +	count = n1;
> +
> +	/* Properties from the primary node take precedence. */
> +	for (i = 0; i < n2; i++) {

> +		for (j = 0; j < n1; j++) {
> +			if (!strcmp(merged[j], sec_props.array[i]))
> +				break;
> +		}

match_string() ?

> +		if (j >= n1) {
> +			merged[count++] = sec_props.array[i];
> +			sec_props.array[i] = NULL;
> +		}
> +	}
> +
> +	*props = merged;
> +	return count;
> +}

-- 
With Best Regards,
Andy Shevchenko


