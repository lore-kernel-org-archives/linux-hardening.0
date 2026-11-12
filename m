Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496677;
	b=5BmC5B4dMGs7JTnoab+Ar42VsWaqNQLw2oyUs+/DDvRTRzqRlC25ESh2Tx4mik8tnCW/
	 yIDEdOAm38TraI4VIlrxtoQm5UIG1QAfgN582HAgiJjZsEA4UREwzzx8JMD7IHb5thTAV
	 wZibjGReZxkINqVIuhwa0UsEt+v1OA+3YNUz88XcaYB7NuRgUreS7Q60Goe/QIObkZ+Wn
	 3BTvfr7Uo7KAwHhiBxb3Y/fU/DE8FlLAjem+lyeDkf7s7gSPSM3c5DebCXGH5BT/qdoUy
	 SBSssbgKlBjqdC7eTSgRWiK62cOasQ50jm/fjjyNGKom1VL+eoqSJu9WHuHynzcFpEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496677;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=HcfmMvR1qzdPr89sAfJlOhAVra0ryuXlnn4zleNOQ/A=;
	b=1rZ4KI3xLMG2yjAXukXvMmyXMVZnv6EEh2jApuFhSIq6lJuyTfmMnJdSKtl1AV8C9u+1
	 sq0cy3t6uDwY4xvmASriwEwMRPOCBa/oYzZyaDBaV28siyrhdADtZZOatsiI6q6pH3g2g
	 MxFNp0iT2sJxySkhwrMfrq/IIBo3KV3P9by49eC0hNj1F7zy8vMFMpumA1ktbKE/pmx/L
	 q+ifdd2PdO5XLLOjfe2RHRmvTEO0WrwX5+rkSI0Cz7TbFrvToNIg0Ks5Ry4CCCn1shN3E
	 ysANQR2EoQY9BZ7hqUuOY3/LWphx9+JK7K8ATtXo00APnUTi3t/7rtoX4XVogJ5yTpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mptqeHQp;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5F60A2607;
	Thu, 12 Nov 2026 15:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFC5F60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mptqeHQp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794496676; x=1826032676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=l/sGAcCwfQqpuM7I0t6QaN2LlZZJmg+0QyYbf8b7HSU=;
  b=mptqeHQpJSZTOSP4M25z/P/ctZ66IGcbwPp33hzoSvUF7iRlP63B0wOv
   50vrYEJ0wW1jAdwMWwQr/ahWAPQqWUvbzi+AmSGldACwuKN/wfP+VuXbl
   SsDmecnc4VWzFzUtwtFpSue/ErUVgfm/mS7iefxxdYTBkxJl4Ys4Aja4u
   +wUtaGHoYr6AlxZsc2SSqb2N3raJFwoMGVEaOQ4TxOJqrNHi+ugWaCOGO
   5xh00qRrq8fvAQVDlghzQVT3nfUhw+Xf47LEDEHHw7tWOBocmZSW3g3db
   3546b5rSute+DjnMr+aJYZJ4KqGPb0GYRCd1P88ktaDM+yEBs7/dDyM5v
   w==;
X-CSE-ConnectionGUID: FfhNQK9eT2CcCrZgau8tLw==
X-CSE-MsgGUID: 3I+HOVLeQI2cZ3qJqhqMSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3149356"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3149356"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 07:17:55 -0800
X-CSE-ConnectionGUID: wfIkWaJLRrmvIrOEp8se0Q==
X-CSE-MsgGUID: /2i6zEKlS2WGLvvpV+ybAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8853135"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 07:17:49 -0800
Date: Thu, 12 Nov 2026 17:17:46 +0200
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
Subject: Re: [PATCH v4 0/6] Add strprefix() and fix a bug with it
Message-ID: <avXYmk5sZKS0rm92@ashevche-desk.local>
References: <cover.1794425425.git.alx@kernel.org>
 <avTIWshl9klX0obF@devuan>
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
In-Reply-To: <avTIWshl9klX0obF@devuan>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 11, 2026 at 08:57:30PM +0100, Alejandro Colomar wrote:

...

> > Testing
> > ~~~~~~~
> > 
> > I haven't changed the implementation of the function meaningfully, so
> > haven't re-run tests.  Since the changes since v2 are only about type
> > safety and diagnostics, I have built again with 'allmodconfig', just to
> > make sure it still compiles.
> 
> Ouch!  It seems I had built before adding WARN_ON_ONCE(), not after.
> I just saw a compiler error in a background terminal after hitting send.
> 
> 	$ make 
> 	  DESCEND objtool
> 	  CC      arch/x86/purgatory/sha256.o
> 	In file included from ./include/crypto/sha2.h:10,
> 			 from lib/crypto/sha256.c:13:
> 	./include/linux/string.h: In function ‘str_has_prefix’:
> 	./include/linux/string.h:619:9: error: implicit declaration of function ‘WARN_ON_ONCE’ [-Wimplicit-function-declaration]
> 	  619 |         WARN_ON_ONCE(len == 0);
> 	      |         ^~~~~~~~~~~~
> 	make[4]: *** [arch/x86/purgatory/Makefile:12: arch/x86/purgatory/sha256.o] Error 1
> 	make[3]: *** [scripts/Makefile.build:572: arch/x86/purgatory] Error 2
> 	make[2]: *** [scripts/Makefile.build:572: arch/x86] Error 2
> 	make[1]: *** [/srv/alx/src/linux/linux/master/Makefile:2244: .] Error 2
> 	make: *** [Makefile:248: __sub-make] Error 2
> 
> Will fix that for v5, and fully test again.

Are you sure that it's okay to use asm/bug.h APIs in string.h?
The include/linux/string.h along with the backed C implementations is really
special in the kernel. Hint: check which stages of kernel boot use it.

-- 
With Best Regards,
Andy Shevchenko


