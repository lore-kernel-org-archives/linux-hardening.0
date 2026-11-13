Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581074;
	b=lCXvx0BUXaSDyRX3gIsn4FgOdHH/TeVd3fNZM3EDD2ztBakQcr84p+St7bhd4Lioe30T
	 1xsnNIwicU5dv1zQuYbRnRS9+qzEOWA17gVHVWKjsGBqAvXtNQQnLH2koaGmfcze15gCS
	 HztKQ3PZ1EgFn5aVnf0pE4QeHtGmfGj5o3nDP91voiVZcmbZ/+Z/SMY4zGIXrzslp8zAR
	 b/R8xIpUxnKY9d6RpgBNycbDQWtuMgC9gzMNFXTjNv79Wyod0KADeKHBdRAM5DWEVGyPv
	 3UAaCzQvDR+23395yiRWG4mx7yKHohI7pVr3jqtL3uPKPaCpD3cYwVO7JYGgPlxlKyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581074;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=PCohGcK4MbH0+m0C2E2oEI2m0dBP6JKw67OWX2Ixdd0=;
	b=Um1AvFkCDVvxPuHrHnA5cbLPevxgMLRed3+qaRGVitro1/fzYHmu2hOYxrYEdEYKYx8O
	 qr7QCO1i4pqzrDNY0WWnSGkU7EsG/Sy5v6c5f5bNTTNAoznqZkO5oK5O29InYxQgDdV24
	 qCLspYENPSi5gk+FNinpdsXoWrrIb9zNKSBQqswk3hnctac4SKTfBXAicTSLKr/TdiTeW
	 j4fy60QwnTeQZ3f7VQZ2k0iLTOPSGkfGQtr+xs7+3UnhI0hL/zBxzxs+3fRqxO9E8aWHc
	 h2QbeozxJU8qUzTZaXGBXWMukZ0rBku7CNPJhQ6V1vOioCzb8+I2piQe5/6K1Vz7R/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="QR/RmCXl";
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA75606A331;
	Fri, 13 Nov 2026 14:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAA75606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QR/RmCXl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794581074; x=1826117074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DyI5H6asWxx+tH3VejHSQI8D30gWxhl9i+ORCFAvja8=;
  b=QR/RmCXlP7YeiKs4cIIQlvZUq5MI+AsMQylxmqVHyTMWw7lKwXW1Em/i
   C8Za6TM3AWBodCXFoxBGHaSr08gZDp/2T1d33OsWoROoCgSzoPvIyAKgL
   CKrY8ijrn5JUUe8Z3GKLModbDij415qNKB25Fy89aNmCaeMlcfguqUR7h
   NYkRZ6mO+oCr5Kdd+CHSY9nDKc/X6Cb45xQTBkQvVYxQFzmyNBXJLeWr5
   mSg01d6+9adGLilgryjfjXeZ5B43nnxQ5S4uwQTqtkv4pi/ChTIU6We76
   s4RzzQE1maf4u0JUvpoxQhZK0K+cEVM8ZKkIG5WsXfTa1ZVN5prPz1YEZ
   g==;
X-CSE-ConnectionGUID: CTgI1O+eQmaJNplK+6hInw==
X-CSE-MsgGUID: Z2Dq5KRQQLavbU3FEw0CpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3288677"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3288677"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 06:44:18 -0800
X-CSE-ConnectionGUID: rwx0kEqrS7KcRwQIohl0qQ==
X-CSE-MsgGUID: TsUR/GvvQFKYNdvTuscMYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8831426"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 06:44:10 -0800
Date: Fri, 13 Nov 2026 16:44:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Len Brown <lenb@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linusw@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 7/7] string: Implement strstarts() with strprefix()
Message-ID: <avciONW-b_WXoetv@ashevche-desk.local>
References: <cover.1794574496.git.alx@kernel.org>
 <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
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
In-Reply-To: <382a44f7c68672ecead2436d9f569ee23f383830.1794574496.git.alx@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 02:11:17PM +0100, Alejandro Colomar wrote:
> The compiler should be able to optimize out the unused pointer
> arithmetic done at the end, so performance-wise this shouldn't change
> anything.

If strprefix() is not inline how would it be done? Or I missed the point?

> This change de-duplicates the almost-identical implementations,
> and better shows the relationship between the two functions.

...

>  static inline bool strstarts(const char *str, const char *prefix)
>  {
> -	return strncmp(str, prefix, strlen(prefix)) == 0;
> +	return strprefix(str, prefix);
>  }

There is no sense to keep strstarts() at this point. Can it be simply
redefinition? However, after looking at the uses in the kernel, I prefer
to see the strprefix() be not implemented at all, just optimization against
strstarts()/strends() if required can be performed.

-- 
With Best Regards,
Andy Shevchenko


