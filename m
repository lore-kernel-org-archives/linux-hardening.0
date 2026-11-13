Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581284;
	b=YiYiEbfmQcRBvqDwBjtjI9Hi1VgHl/qUUihXDXuH0WfBvyagNKHFrk8TMSQYF157mZWH
	 hInl9ESXXfJYHG/X9/0I9xwvPNi2Gqwz3TubJpfMXrUwepGDIEhw5c9m9+nGUJVzWudO9
	 73AyemanZzzxjpGZGlyXgm4gLqKEixLxWNzV/8v+3txFl6AWEJUekEOa+wimBnpEmADqH
	 jTtmTEJV3qacNPEfle72nlNiYy0k/E8uoibwW7Xt9MDvAj06yua4paJ8fXNJJyiDyEAbJ
	 gqGqAAyIl5s3w87QU/55+1F91gdhxw/PelbyvdR6cbcKImkFqQkgv7EXBe+/hrTqtDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581284;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=aIBk4rSjn8B0K4wUs8oS5U1trZ1HzjT4mfYr04c9C5A=;
	b=Bm8ddhhG50DraP/P7XqG001u0hYjFUb9dYuQJ4AGddw13DYNP87tbCzVRkGzY6UCER6a
	 z8smu4gpOBTE7h4PCTfpGRUcR8UDdCakGjmsz1bBZ0HdL04tZZhwAXPV9YWXdC/PABbQu
	 46lUgyL4CzOS4KMy/Jh8FsRf+Nfwb7TGuab5DTYSGUQc/kbvzfcvzP5W+qosX8tNw1Yeu
	 fQw37BoVEHOcq/tbCcOZ913qntpQrG7XXtWOqm3vUdq2zAQM0wS04tvQK0FuidrNkhC6C
	 mF0M2kEvm9uTo4LX+PFZBEmVVeAhhNGKI33U3uJqd6G/OF2k+pZwuZUkoznB2IkyOXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HQo9Ob0R;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB003606A32D;
	Fri, 13 Nov 2026 14:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB003606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HQo9Ob0R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794581284; x=1826117284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yX9p1HtRUXhQngAEtVPacN6yL6qsAp558i61nVU+Yhw=;
  b=HQo9Ob0R83whKVzEp52FwnqZNYVU3SkjDjyGA6ez8aPPB6NoassJN0Fr
   jXyC8aM7J1ldMlNtEyVZjJowamu6snrKvZUtkX+PzKNehHhQvNlogW0/0
   YR4Vn3YPjVBHhp9rrVhoTi4LcGq32kjGvxwJvQ7DVSUfmMI0fcxHcmc46
   +iSFpGI5M5oD8mYrfzdvYTYW5AuxjQcHfrwNi1CzXrU33EItMRjIjATZT
   win2FpBv69zO6bIri+yNUaxDl7ziteJkTccLKMQFzar5YmKcacmSc1xr9
   3PNll4gQO5JvG1ppg40p+QEsm2oQ/emW6SpkWepAuO2vrYvcrzxUZTnJN
   w==;
X-CSE-ConnectionGUID: yezIwCG7SF6FpPI+JqdlcA==
X-CSE-MsgGUID: 8iEyWDlvTrOfARdgtOK2LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3463719"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3463719"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 06:48:03 -0800
X-CSE-ConnectionGUID: X1D/LeLzQ+ui8rZwEbY5sw==
X-CSE-MsgGUID: S5B+0Y9kTt+TeyN365jamA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9101431"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 06:47:56 -0800
Date: Fri, 13 Nov 2026 16:47:54 +0200
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
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/7] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <avcjGlgQBnXHaFFh@ashevche-desk.local>
References: <cover.1794574496.git.alx@kernel.org>
 <f25bf43d7f18c99019a52b9ba9a1e46fa68174c7.1794574496.git.alx@kernel.org>
 <avcfuBAbNkBrk6uy@ashevche-desk.local>
 <avcf5V0B52MV4_PZ@ashevche-desk.local>
 <avcg2NEwaV-AuuCl@devuan>
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
In-Reply-To: <avcg2NEwaV-AuuCl@devuan>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 03:40:31PM +0100, Alejandro Colomar wrote:
> > On Fri, Nov 13, 2026 at 04:33:37PM +0200, Andy Shevchenko wrote:
> > > On Fri, Nov 13, 2026 at 02:10:29PM +0100, Alejandro Colomar wrote:

...

> > > > Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > > > Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
> > 
> > > It's unreferred Link tag, spurious? Please, refer to it in the commit message
> > > to understand why it's here. Use Link: $URL [1] and use [1] in the text.
> > 
> > Ah, perhaps you wanted Closes tag instead?
> 
> Yeah, it was for linking to Bart's report.  BTW, is it okay to have two
> consecutive patches with the same Closes tag?

I think so.

> I guess it is, because they close different aspects of the same issue.  But
> at the same time, the first one doesn't fully close the link.  I guess yeah,
> I should just put it in both.  Thanks!

-- 
With Best Regards,
Andy Shevchenko


