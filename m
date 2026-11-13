Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580424;
	b=yjy7CB7MfzzeZWoStdXg1OfeltLfOci/aJB9p+tzU5K+fC+CrGX8eCaqSrfX6AWnoOFz
	 GyJeLlVXm8iPRljQV5BBY3k1Jre1XA3g1CFfMdcuPioHUKm2JjUCu56czBPs30htCgE9X
	 Fa7cHKAYx55ff1m3yuL0aDJbizxAC2vh1N/iDN3RTCCt5xsMQWsg4t241K83KgxMrPjtK
	 bdHz0hcA6V4KnvEANcvxOhoZn5wTzTiWE6bMpv8V1WtQDIPSyzMm9o4kyzPiO1RuTGQgf
	 U7mD60+WSEWFX+cmOgvibVF4V5lQGfI1dLjtHw5J2qcxMJGn6jwCoslEqfAAbQkBBqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580424;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=oF05r2gLDpP1hVCaMdikfunskSzqkU4N8lTkjjhVRpw=;
	b=TaXVPGDHIPdB7f7LJ4MFIwe3achRRwyTxtF55o7TbmYyYDUnr/jUyDfFvoR1sdoklVXh
	 3/FoD00oeoFYqkqoJeVFQIJkIRduQEY26MDYL7hTdlhi4FRzjo43wXOiWIhFg0/gYlOmZ
	 cpSu4sR8qvZ/42IwmzCW+Q/Mx+Zyjg827f7d26XzpWX1oPckW7d5h7DoDzX4IBoATCyyV
	 7v6EdgwWUeSlZ+1jGjFr6gD4Ip6a2J2ZojgCJqY8rNuYdG01lYB9Gfww1QHxydNWwq9Hj
	 V2sxi+qw+huHyzxgtzEHwabfIoxikW2oa6gesenEMTQJC9ctVVLMcpleqP0gNVMPagw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P15X2YJC;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB4860A261D;
	Fri, 13 Nov 2026 14:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EB4860A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P15X2YJC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794580424; x=1826116424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3q908pnAG5D1NxhTnjaCLWJTSR5VAD4uS9kgBibyPTI=;
  b=P15X2YJCMTPnO4gtI8GThaHRUJ751XmN/SSiL+t/sYTkJxkdML9gC+ci
   VGAbnE+Gy6TTzOQlRZ/eMZj7GawYZPau4sEr1AVP7hU/g0ozK+KtCNi+M
   GXfiwfVKlORvz4vUOV32Lp7nc1D1ycjpHjg7a1T0zU/EMqy6QJambCfTX
   z9U6iML/9vATRTdwLa0rIK7awumzYy+usoElClHuFT+oLAyek1k41fv05
   uy2oeIaJ7adQza57WmAO1T4CR/ZNCVVWnft5uXQxvzDiTIo/HCjoDCTO8
   jpJg7kunUk4mZCAdD08mjUKedCvdDnHQaMPKfk1XlpiCQS2Q2u6em6wSD
   A==;
X-CSE-ConnectionGUID: ixnkyp0sS8S7Q+RmGF48Dg==
X-CSE-MsgGUID: RIKlkIygT2GZqddzlo4Lxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3481798"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3481798"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 06:33:38 -0800
X-CSE-ConnectionGUID: ugQoK6AzSEivYqC/ncfyrw==
X-CSE-MsgGUID: BPVpGyXAQzqkEgyt1NMoSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="10716636"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 06:33:31 -0800
Date: Fri, 13 Nov 2026 16:33:28 +0200
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
Message-ID: <avcfuBAbNkBrk6uy@ashevche-desk.local>
References: <cover.1794574496.git.alx@kernel.org>
 <f25bf43d7f18c99019a52b9ba9a1e46fa68174c7.1794574496.git.alx@kernel.org>
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
In-Reply-To: <f25bf43d7f18c99019a52b9ba9a1e46fa68174c7.1794574496.git.alx@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 02:10:29PM +0100, Alejandro Colomar wrote:
> As Bartosz reported, str_has_prefix() has a bug: it can't differentiate
> between an empty prefix matching an empty string from a non-matching
> prefix.  This is a fundamental design flaw in this API, and not
> something that can be fixed.
> 
> As always, this is a consequence of choosing sizes instead of pointers.
> Sizes are often the wrong choice.  In this specific case, pointers are
> more capable of differentiating these cases, as NULL is a special
> sentinel value that doesn't need to overload a valid value.
> 
> Let's implement strprefix(), a function that returns a pointer
> right after the prefix if found, and a null pointer if not found.
> 
> We'll slowly migrate existing code from str_has_prefix() to strprefix().
> 
> Move the description from str_has_prefix(), and describe
> str_has_prefix() by comparing it to strprefix().
> 
> Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/

It's unreferred Link tag, spurious? Please, refer to it in the commit message
to understand why it's here. Use Link: $URL [1] and use [1] in the text.

> Cc: Andy Shevchenko <andy@kernel.org>

No need to put my name explicitly in Cc list, I'm a designated reviewer for
string library, you should get it via `b4` or `get_maintainer.pl`. And in
general is better to just move the Cc after the '---' line.

-- 
With Best Regards,
Andy Shevchenko


