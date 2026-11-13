Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586194;
	b=xU2xy3Er2egUThh91hVEjgfEmE2jH1hd7AcjDlg5xz4XdJOvxXUlAkr6WjZebxsH7ZDc
	 7IiejbEfONyUdVNij1OKfi8w77BwbxjiJX1eg1gMLGaS3ayhxfiaDJ3bi3irjkOJ2Inwl
	 MiqjXy0LLOj5B2aNzIVVoLnXuDeEwYdEe++GhWLTgLXl7vD7KI+o05IgTz+tlFvotJWlF
	 StooQNgnhRude4R4iZLQV3V2BWD0MagCUOALbiR2LKp1/RQwrgJCvJKgHFxgMqcotM5oW
	 eMXGEEoOl3AOiezv/winIlVcnTL4Ms3veWzjyIiyzuTK1Xx6bjaI1Fn7wfN/qfpJ7MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586194;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=C0MWHQysDEd87y5/D+eFZ6XJDew4RfFsL3e3ZqMqHq8=;
	b=HDXd4/MM7makTAeDMEh6+eW6juYfyoCu6Z4z801cFkwientLS4+zOyqnFvsaMnKLxi8D
	 ttpxbBZk+X3B29t8n69NlzM9ND2L8WzBaON7+rr/pDOD293rDUMW/x3YUFTKG6iBs2ftE
	 HMhO73p/MvaenjfLyIFUBdo6B1SxN2rWVU1HTicsRztjUWfj++be8smuuEVD27MYtuYRq
	 V9wEAik6D2Ev362oJSHb3sYbo5XWigzqcIxcQF4QXPPLpwPa4EVDYN4C0QCevBU8Cca0d
	 mBc36urOtQVRsM1cyZvt6AIrlgAkzJeIPBseOCpPkM3aYUNcxoXOe2KHJJKjAsspxlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="P0F/EtZ6";
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4AC606BA8A;
	Fri, 13 Nov 2026 16:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB4AC606BA8A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P0F/EtZ6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794586194; x=1826122194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xVqysPj+hkTB/imj3I1xoTZQjZM3hYs2UW5h7nd8/3o=;
  b=P0F/EtZ6FuiKpSve/T5LzEYCZEuO9q4nX6K358bbC7jJTQarpukByzoL
   T+A3+klmoFR37ncCRlP2Y8+MiYNplF1G2OHvS/8sMkTibPOGv8WRhT1UE
   qyknjepMhaO7JwZ/2mtqMTGGFbwfUzIQCnRAXaF+2UrTP93zPoRrk5Xkl
   v1oH1Vr+GZYuwPH5A09HzSbWLLNH8VqVB6avC8qvWFm3CMNAwfq+nVAbA
   Mh61DuTr2T+O5Bc1DekfsXqAXe42cUwhGeniSvlT0oOFZ2iusLhZKYXX0
   h9r7VxY8oIvjXIvzDNo5H6l2Upzjlz4DXQ/mr7dudts0V3v3CcW6oPWG4
   g==;
X-CSE-ConnectionGUID: fyKigYTzSx2g3JPlhkHcKQ==
X-CSE-MsgGUID: Q3Ap7+FjRvSw5VwBEsmnNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3263231"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3263231"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:09:53 -0800
X-CSE-ConnectionGUID: mWlXUNYZSjiGDDL7C9Ocwg==
X-CSE-MsgGUID: ZwNL6jx/SEK93Cxo9lbYyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8800970"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:09:48 -0800
Date: Fri, 13 Nov 2026 18:09:45 +0200
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
Subject: Re: [PATCH v2 02/10] lib: string_helpers: implement a CLASS() for
 string arrays
Message-ID: <avc2SeHYGmAcG37O@ashevche-desk.local>
References: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
 <20261113-fwnode-for-each-prop-v2-2-4edc23d5cf50@oss.qualcomm.com>
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
In-Reply-To: <20261113-fwnode-for-each-prop-v2-2-4edc23d5cf50@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 04:47:02PM +0100, Bartosz Golaszewski wrote:
> Provide a CLASS() for managed arrays of strings. It can be used for
> automated release of temporary string arrays when they go out of scope.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


