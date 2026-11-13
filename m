Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586495;
	b=vtDaTCsalOI+Az6Bc8hFJd7WCK/7KtzRfx4+EQuvnc72L3GRF2W89ESlmUM6KLBSCylB
	 ZXJQWszbcSIuoQCxjPZsiLHwCdP/WHiFndKVZN1WVDJoPkSj4JVU2/dLC2I1Vwxacdm5r
	 PiaKppwESVsJHHo42ivG2X6giT0k/AOvIlo7o9ruy5GEq2ZI6CXY80No4LX0srFDuRsGG
	 cVq6mDdbcsxuvrsxppNw1EC3HVozdHNr7f8bgdL7voz5z4rD9DhawATTnB0ijsTpmH4Ij
	 Du5iPtRr6pI5DgbbXqPuaR5ocHvYFVSx7JXZxn4zQy/YtxKQ167CI207wlanYPbO+9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586495;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=sf+6edYMzY6NnrlxJWJeYP4C5uZDtVBlONkpHHMFEZo=;
	b=KKdTqycrtcnEqvTN1+GJgofUuXlk3yQEeBa71E2Kg2Fcffp6rWejAObIFbyrgXxfxS5Q
	 PKl68qyobZHSY4abp5s/dy0qPdtQiu5+07QXUf7wqQrivF1ehk9m0K37pcD7YiXKLB076
	 SjRvEgWWs6j6kmTjsoFsntfy7QbKXK80sxPzQ7/rPFAGWtNBMtt5qooskBfRmmb4turqV
	 i4forwOc6hsTLPeKR26gasWH5EuXyYLLEguUUuq1nVpc+coIKa87GMaI80aCrKbYGRpP+
	 cVCVzpCbqenJBdRK1pqKJDyEC/7cmzgpMPpp5wxsoxE27WTkLheVY32KE+HoZe0ylqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iNSeqRDW;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68502606B2C9;
	Fri, 13 Nov 2026 16:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68502606B2C9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iNSeqRDW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794586496; x=1826122496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+zDWrisG46NzjviE4PtgI5vDp4QnTOm36Mo4GT1CJrU=;
  b=iNSeqRDWBxKWlicY8EekgRqulaV459H1NX8Oh9hKae79Ezht7bM9mRUt
   9wKEjDkLWsOJomzna4zXTrwsX2YV8sAqUIbprqn0z0Ky08I9XE7iSmhuT
   REKM2Tc6ArT1s16kI5Hf3ynb5FHKVMexmtundAfEcIuokj17MtOEcwPKW
   R8TRdRGzXwjc5nJd/LN1iu94rPpP9sMPreuIokiVkBoBwt/OE5AjlyTmn
   7Ykdja9fXw89saZVToIGsdVBF7qOA2yuGSXfadcZysYRouMeaAbBUw6O4
   +UB1SO2myBKvg23HQA8EcmzBd4B6olHn67DMubFNlM/IdjQBdOEPp/sKl
   w==;
X-CSE-ConnectionGUID: wyKXKgFrT1WEFGqd4Vgxrg==
X-CSE-MsgGUID: 84ViUfQbS8++cWcGphcTKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3470485"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3470485"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:14:55 -0800
X-CSE-ConnectionGUID: KbbtHvXoSiei8QzDIkkMxQ==
X-CSE-MsgGUID: n2uxiT2dQlq/0961XDln/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8870703"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:14:49 -0800
Date: Fri, 13 Nov 2026 18:14:47 +0200
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
Subject: Re: [PATCH v2 09/10] gpio: shared: removed unused field from struct
 gpio_shared_entry
Message-ID: <avc3d7a1rEfV_xtP@ashevche-desk.local>
References: <20261113-fwnode-for-each-prop-v2-0-4edc23d5cf50@oss.qualcomm.com>
 <20261113-fwnode-for-each-prop-v2-9-4edc23d5cf50@oss.qualcomm.com>
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
In-Reply-To: <20261113-fwnode-for-each-prop-v2-9-4edc23d5cf50@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 04:47:09PM +0100, Bartosz Golaszewski wrote:
> The index field in struct gpio_shared_entry is an unused leftover.
> Remove it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


