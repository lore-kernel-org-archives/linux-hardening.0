Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586437;
	b=LEwznbWZJBdL7WIxJiYPU+mAcr7L+zWUw8HidkFc3ADOtoXzNJzHN7MxEYBrrU/zJOT+
	 weq0HnJEDOCYV9fiaP4iYnLHVZOLGip9//5hvlZbGC2dIWCDu3kmK+7FvP8z8PfQKF38U
	 8bKM+mOxBh33K9Ve3Zl41od/dP/gZvl31XbuNs0rQpJSSABaR3+DvNAW6PCCz7TPJ5cZO
	 4AgQuashCXyEKDABHwtLpJqIAmv6v9uzaLKGESgTaQNbDJzv8OPldRvB1G0YW6upZfiN3
	 XsJDF+2a6mBTvATrPoPJTpenfIuYC98oytmsNN54oc/1J6D8NW6x0LgSUTZDB6jtUbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586437;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=eqqPvAVweSDQC4nfMMrwbJ/e+VHUHrm3P0JfUhplYAg=;
	b=JmlHKIZPSOBi6CuUfIIEa2j+o7xT1vHZnPV9HwQTrK4HLfZ4OwsdiWJu6Obwu3pdza7t
	 AdOP+vFThgTHxh3/03Tp9mBKC14c9HWgxxma84J8R5e8z4yrS8dbFc+Isr5LXYXiMtOaL
	 bSDiqATeqyoAYrfxgrW0my7NGNbqEylKkvXOifmTN4xUqn1nCs8Fp2ySgj18WYp5kNeUl
	 1gg67wu12ESZsvDuxx3MJyJ+501KpUMOkZ1gqiyZhk1Q4Wqhhhuk1hAwKaoUHgLQZAQWD
	 Yg3cLrTTHdB4mJYwS6quTa8F/QBc65ngMWIym6e2/9j+NmkrcvgEz7/AMqXJ/PBPnXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oImutv8E;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AA8606A896;
	Fri, 13 Nov 2026 16:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68AA8606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oImutv8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794586438; x=1826122438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZxpIe9p+77IfV97JqhNEZFr24LjF0d/rGyco+9n85Hk=;
  b=oImutv8ER3M7mK6xFacKWn2hja9yot24vxQvEvIjY0z0LrFav2VBiH1/
   haLZXkRnQmg7KDyjvkoxOXagswsz4Vl3xedrIvSgwN2vmEgTNcb1FS4Js
   D2SRGjrJFRb7HvQ9qRh7ThnAeNAfPNFEGETGnIk3j8YT+4I5gbSdP1olV
   NTJyX1etmdgxgh8vcID14rJi47emu84AP65p1SAw5m5/bPdCPDv3cnCzE
   75bIDGu/Djx/feVRzfzf656qykLsVJxQ+7FOWP2Za/JcOfgAhzXcxC/Fs
   STaUPa4WvUC2vJE/Qloy3Uc+fQo+rUZkXuIY2wZGG/e1G7iZwhO+hhBlm
   A==;
X-CSE-ConnectionGUID: L5qjFq4AQ02t/AAnT46Xtg==
X-CSE-MsgGUID: WJcWnawwT+yHYsJM1PTfXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3405692"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3405692"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:13:57 -0800
X-CSE-ConnectionGUID: GqQHn3+RT72bJnuKPxw4+g==
X-CSE-MsgGUID: lakWYUizT3+tzJffm1SMKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="10859688"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:13:51 -0800
Date: Fri, 13 Nov 2026 18:13:48 +0200
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
Subject: Re: [PATCH v2 04/10] device property: provide
 fwnode_property_get_names()
Message-ID: <avc3PNEMESd3ewBh@ashevche-desk.local>
References: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
 <20261113-fwnode-for-each-prop-v2-4-4edc23d5cf50@oss.qualcomm.com>
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
In-Reply-To: <20261113-fwnode-for-each-prop-v2-4-4edc23d5cf50@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 04:47:04PM +0100, Bartosz Golaszewski wrote:
> Provide fwnode_property_get_names() - a new fwnode function that allows
> callers to retrieve the list of all properties of given firmware node.

I don't understand why we have this patch separated from previous one?

-- 
With Best Regards,
Andy Shevchenko


