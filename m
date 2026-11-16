Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826868;
	b=TrJAoiimiCHAhL4o9AbnEWNf7MN8meUBohLIiuVzsSaEohvmvc8YsHVAHfBNpQ3/de+v
	 T+h/+HY1aK4eiY9pi3Z10NVh8pjJSAUNxXHgh1cpSAMa0oRhikzMp+2myag1sHTkaYpeU
	 kFauOUUwL/gzElwarsoqXyRQhNbVqKYT20Lcdz1bEKmTdaiMUgKJlNeoi1ThfgzkKS5aB
	 PsgJURjLTQcayfVyaxxZbUyNljfmNZUw+wcIGxEGdgpeC8ddlw3UccVWdfmjblPhChIgr
	 9FGBtxqCXXpHqf72IM0UBVAgswCVlpy26T8ceD4WA2m6dqGupr5i8RDLdBxgwkm9KoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826868;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=eim4R0oALlPhbXndhNtGDbbO6UebXkionbyh8Up2aOM=;
	b=s8bWBKuWS7B+791Z+xLz2Xei6L2Zt4wrAmu2c4xGso5Gvly0xvW8tXmdXhnwcV40EDrA
	 ftMIoqYMsx6eBHqx7kfKTYrpdDW69DeTTaejXDy/iA8ZNYiL1Ipm3nvOimmO1DOsAOmKE
	 dTN5HZwmEBA84lXKD6quRR7dgj4Nw3+/xblHufRVz9z8zH0xRXo9oc8WZwfepPOmdLrJ1
	 yo+2EpnoREZTfVRq42hXzimYoCKN6u1/d0Yk3aKxHCDnhcjVaWhisTh/npi8oe2vzPflf
	 T4jxZcHXkOpMZ0rJXH/HXBAMmXPPR49BEhzURsX94hwHPmpznUDW+GNtJcapFGvPWcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cg+Kx9a7;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC337606A31C;
	Mon, 16 Nov 2026 11:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC337606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cg+Kx9a7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794826868; x=1826362868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KGVQ04RLKs8bI5V89Lbr81euoVhR1N+VdoRT/hJlFCU=;
  b=Cg+Kx9a7jks0BnDfRyjIxmmAceIuQYnP4s08vY9kct4ySkpQ6dtwtbaO
   Am6LpnFIKmN/iLgl2Gp/DWuOiEFopO+o6lMfGx4jNwzioKoGr1Eontytu
   g3W8XpDT4bq5lpVH2RfoXaYziYNyUx+Hw6DPb6itOUi53O+GqZ3gVWGUq
   XKLRYgXxemkcqWddzMlflGOmmgnhw8Mv3TSttEF/wt1uUEmXo1K0MECu1
   kUjj9z+KQTZQCc3nXVY4rw9hqfXJi8a+Scq4S+oTIEVOMFx5oBRUiYA51
   VzesxLYK6wmI0/zreLQSDFsIXw4QFGLmANhIsTwLKTFHtIKTN2QAtRcjA
   Q==;
X-CSE-ConnectionGUID: ziTD9D5RT96F10Nqbvz9Gw==
X-CSE-MsgGUID: s7HO3eQHQFuDLk+fubZCNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3412134"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3412134"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:01:07 -0800
X-CSE-ConnectionGUID: umavc8asTIWzgqWjk4xFOQ==
X-CSE-MsgGUID: +amdLsoJQGeQtAFweNlZAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9709537"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:01:00 -0800
Date: Mon, 16 Nov 2026 13:00:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>, Joe Perches <joe@perches.com>,
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
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
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>,
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
Subject: Re: Off-by-one in arch/mips/bcm47xx/time.c (was: [PATCH v6 02/19]
 string: Add strprefix())
Message-ID: <avriaVSTl4jL0OEo@ashevche-desk.local>
References: <cover.1794667407.git.alx@kernel.org>
 <0eaa4ce73a2b164fd49e3a9f71244a2e3f45b7bb.1794667407.git.alx@kernel.org>
 <c113f651d1ce1b2d42ab9d0c59ae5a0cd17ddb6a.camel@perches.com>
 <avi54hgKgovNHfKy@devuan>
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
In-Reply-To: <avi54hgKgovNHfKy@devuan>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 14, 2026 at 08:49:21PM +0100, Alejandro Colomar wrote:

[...]

> > And these are all candidates for converted uses to
> > whatever is the function name or steq:
> > 
> > $ git grep -P '[^w]strncmp\s*\(\s*[\w\.\-\>\s]*,\s*\"\w*"\s*,\s*\d+\s*\)' -- '*.[ch]' | wc -l
> > 946
> 
> Looking at those, I've seen a bug in BCM47XX, introduced in 2224de9d152b
> (2013-10-29; "MIPS: BCM47XX: Fix clock detection for BCM5354 with 200MHz
>  clock").
> 
> Look at this line of code:
> 
> 	$ grep strncmp arch/mips/bcm47xx/time.c
> 			if (len >= 0 && !strncmp(buf, "200", 4))
> 
> That strncmp(3) call is wrong, as it's really behaving as strcmp(3),
> since the 4 is off-by-one.  I'd like to know what was the intention.
> Was it meant to be !strncmp(buf, "200", 3)?  Or was it meant to be just
> !strcmp(buf, "200")?

When in doubts, preserve current behaviour over refactoring.

-- 
With Best Regards,
Andy Shevchenko


