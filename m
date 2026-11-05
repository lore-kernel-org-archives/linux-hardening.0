Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879995;
	b=wzMKeNZ7hFLEJEJ69Sq2HUxxQe4e7tZw3xWkcDJ5oql602M2a1qLunjN8HOsmbE8XgZ1
	 CHpEun4PkaF/BoM0TEfE0A/6TaTyanh3icd68V/8vkcMxRNOt1EsWNRkgZnHWnQhrkhI2
	 2I+q4DVV6+0n/3xLM9mrRP9+BM1650xFsbKyrhqhIq8k4repQfRJR2cLlqUucdCFpxdPt
	 szycmWW9+3mX4g10VC1PYqZKraRp1EksQjWoYlz9RRDPWKJZbj4afV1ITfh8/0vISyW29
	 WvKs7Bg1qh2Lxov/T+/Fbg+0nx8+CYz5ju+E/TSiCvGhImZcv7p2/uKDCVPmRMjT8mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879995;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=55ziTKuLaUytKA90JjVsAjKL4og9cquzU6OFv/arPMc=;
	b=eNvj7DssMf0oHvGzOlMOgusK/th3nAlz/dmzTHV1zZ/z7tYDIklWmSoY1BxEDgAsKfJw
	 jrj+KfJ17sBX0LSObh6AZtPR1eVbA2C+Qt2aaJM2RTBIVblj2fPmxzSw8JS6WI3EdJbNR
	 0YZXhdbO5GiDMWLz6oeWi97FrbCr5Pix4Kh4n1HRZUIACe9Qx4NC4KV4TpEZ2gmnz9K23
	 16gYr9MqqHHjzvBxziuC9C/Te0Hky/LImqPReNYKWHNJPrOKXSiJJasioJ51BxzTffWB2
	 q35QKefDILOBaBl7L59FesoqcG4AsUZOYd/Egr3JvxG7hPQ46hN49ieGiFtd24E9dVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YbDiy4rs;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C6606A31B;
	Thu,  5 Nov 2026 11:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 523C6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YbDiy4rs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793879995; x=1825415995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8YvxtWgLQBW0AzQWnk0oKqSHDpGrA9Gbt/fWjyjghwg=;
  b=YbDiy4rsz2k1UcVf9ymx2c4OSv0Vi6DkJEIYUrrs4HuBWpyNoNIOZjKo
   a6KpXfZdddmUuoJIxE5Qzg1q5jxtX2ShLRI8bat416KKVIc6+4xXLry7y
   0IP3BztDIokCx+tpb40Z0sPtIIeATqcv4bsuS4eyfVfhPFaFwmQ9nr11k
   GM3dFsdnTzZ0MvFsCzuM+O5X/s4RDTtC+GCq+gnyrRlVWBVXHGPje+huw
   3fkIB+2qcQQmCAGjyfRYN8hIfYNAlYeYXxREKoUWkAyjXtiGpo5rqRKTQ
   0Dtf48DJ/qOyg692wDY0udpMuoTOR9JBRa1trgu9sXFDH5kIRemVVYMgo
   A==;
X-CSE-ConnectionGUID: WAKQ7i5BR5WhDhUvEo3Fhw==
X-CSE-MsgGUID: 5QEXNvO/SbSPW9g3/F7TTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2756505"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2756505"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 03:59:54 -0800
X-CSE-ConnectionGUID: 1uRZnbrxRheLw/xzWZLFaQ==
X-CSE-MsgGUID: xp2+bDVwRnS+waA63Sa6CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6867168"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 03:59:47 -0800
Date: Thu, 5 Nov 2026 13:59:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
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
Subject: Re: [PATCH v1 0/2] Add strprefix() and fix a bug with it
Message-ID: <auxvsAZ4D-osszY1@ashevche-desk.local>
References: <cover.1793876837.git.alx@kernel.org>
 <CAHp75VdFH146fNhw1ysUbgCPbpv+K++kWvbyZxU=V7tDh0T88Q@mail.gmail.com>
 <auxn9fKsOKeIFIJa@devuan>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auxn9fKsOKeIFIJa@devuan>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 12:38:47PM +0100, Alejandro Colomar wrote:
> > Date: 2026-11-05 13:24:18+0200
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>

...

> > > Testing
> > > ~~~~~~~
> > >
> > > I've built this patch set with 'allmodconfig'.  I've not run the
> > > resulting kernel, though.
> > 
> > No, all lib/ new code should be accompanied with new (Kunit) test
> > cases. Update the respective lib/tests/* for that or if not yet
> > converted to Kunit something in lib/*test*.c
> 
> Thanks!  Does this sound good to you?

Let's put it this way — it's a good start!

> BTW, I don't see any existing tests of str_has_prefix() --the API I'm
> replacing-- under lib/.
> 
> 	$ grep -rn str_has_prefix lib/

Can we use a common sense? lib/tests/ lists these:
printf_kunit.c
string_helpers_kunit.c
string_kunit.c

One of them (supposedly string_kunit.c) is what you are looking for.
If the test cases are not present, create them! It's as simple as that.

-- 
With Best Regards,
Andy Shevchenko


