Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446962;
	b=IydhJoJvq6Bg+rGjpgAim8nX1l7uMD08kx87P9zR2fhrsiaTc4MkRbwetx0146BNBYDS
	 HNhtxDfnHXDSW3+M/7dxQIAs6OLlOg6os/lfDWpnlDuXEAmNzk6rYvQ5cNPtK1p7F7qlE
	 LMBP4gQaefcsZkCwFb+08TUsJCEqNYYmYAB4WyVnYAcL1EKGkduXdo6ocXTDWOjvWWULH
	 QrzQk0I94wunJcRuqV3t6DymvSNbJcqstO8OEN7a4JU1agqutPSdrWh4xj4gKNiJ/ZyY2
	 bXLNa2U644c7pbIvTmi7ch38eMFCsZ+ZD+rH5OHgRqP4aeL6i6h11G9qU+ou6ubr+dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446962;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=naeHT3lsD43WVFFXOIg9/UkqxmnGM41dLQc0bv16TWs=;
	b=gRv5iFoGWI3xHznqkrdlmSdG6eX8JZ5hkDuOILogqEZZYGacn3kYs0qGX+//eONGCO/T
	 Ifjnpw/bd3hKbtm2xsUE7JNdxd+ohe/lVYvCVSAM7HiaKmHaooMFQYyeQPVO4NbGkjLYP
	 iqckuUehxg6BpSy8FeICOAIvW71z4TSBl0PRy1iT2dsGXARxmIULquYnkVN+8R0lLBbuv
	 ruiRYmShMHRN0UcrRn9847Q29dxHqJNju5B2iKC8hCTJdrZZ7gpJ8xLyBTAelOQ3UKh9z
	 TJ+frvLotA8LCn3riC+hNPkA4JG43iw8h86h5oHO614Tg9OykX6KOskOvQgsJnJ9nfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dR+4nUqB;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588666070228;
	Thu, 12 Nov 2026 01:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 588666070228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dR+4nUqB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794446961; x=1825982961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=drwpAsrOFw4B/qCkDMxl8Rzegtt/n6DW8SOYJld6ACA=;
  b=dR+4nUqBg1xP5hLwWGCi48LPh3R4Z1e+9HVF2DiAxa7vIuqzFzs5+cEK
   dANeswCa4jq/MwJLiRYwr/0HCp1iV3EQPYPalLgNQ3Iv2YEeCmQnvqq6F
   SLoiLNo3H9LawT65jaCBZGLOUMPHJWgUMYN/17xSY7H3O2uldga4R2MRu
   1MrHAn+n6djSYIwAEYYc6Y1jLHw6i/1oiBpDToboA7+lcAR3ejJPNMQME
   XhjJQcDFxBsS5y3JOKfz532lZFemDySb0t4xxJa+7Oq8o4wJ2Msg0RrqW
   aQcKL22n6RuXXJ8fEPgf4G+deuSx+LUJZt83aZ7gxWLJYXx7OXGGKqSyz
   w==;
X-CSE-ConnectionGUID: z6iaWYs6Sdyk7hKAW7KkjQ==
X-CSE-MsgGUID: uYM3Prp+RXKTG44qjaS7BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3306724"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3306724"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 17:29:20 -0800
X-CSE-ConnectionGUID: wXIAkD9OSb+cGo57KrKyqA==
X-CSE-MsgGUID: KnBwmaLHRL28S7SM9UOKBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="10415943"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa013.fm.intel.com with ESMTP; 11 Nov 2026 17:29:14 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRJcl-000000010BX-15iQ;
	Thu, 12 Nov 2026 01:29:11 +0000
Date: Thu, 12 Nov 2026 09:28:40 +0800
From: kernel test robot <lkp@intel.com>
To: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alejandro Colomar <alx@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Len Brown <lenb@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/6] string: Warn if the prefix is the empty string
Message-ID: <202611120922.GqXZB0lH-lkp@intel.com>
References: <cd09427148a0c4718b46029c9e806f9dc1622f9b.1794425425.git.alx@kernel.org>
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
In-Reply-To: <cd09427148a0c4718b46029c9e806f9dc1622f9b.1794425425.git.alx@kernel.org>

Hi Alejandro,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/hardening]
[also build test ERROR on driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus kees/for-next/pstore kees/for-next/kspp linus/master v7.4-rc2 next-20261110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alejandro-Colomar/string-Add-strprefix-and-deprecate-str_has_prefix/20261111-205515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/cd09427148a0c4718b46029c9e806f9dc1622f9b.1794425425.git.alx%40kernel.org
patch subject: [PATCH v4 2/6] string: Warn if the prefix is the empty string
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20261112/202611120922.GqXZB0lH-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project c628d639fc66f8e6d8ab1f0cc6b1df38f974e020)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261112/202611120922.GqXZB0lH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611120922.GqXZB0lH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from scripts/mod/devicetable-offsets.c:4:
   In file included from include/linux/mod_devicetable.h:31:
   In file included from include/linux/device-id/hv_vmbus.h:6:
   In file included from include/linux/uuid.h:11:
>> include/linux/string.h:575:2: error: call to undeclared function 'WARN_ON_ONCE'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     575 |         WARN_ON_ONCE(len == 0);
         |         ^
   1 error generated.
   make[3]: *** [scripts/Makefile.build:185: scripts/mod/devicetable-offsets.s] Error 1
   make[3]: Target 'scripts/mod/' not remade because of errors.
   make[2]: *** [Makefile:1424: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/WARN_ON_ONCE +575 include/linux/string.h

   555	
   556	/**
   557	 * str_has_prefix - Test if a string has a given prefix
   558	 * @str: The string to test
   559	 * @prefix: The string to see if @str starts with
   560	 *
   561	 * This is similar to strprefix(), but returns an offset instead of
   562	 * a pointer.
   563	 *
   564	 * Unlike for strprefix(), if the prefix is an empty string, the
   565	 * behavior is undefined.  If you need to support arbitrary prefixes,
   566	 * use strprefix().
   567	 *
   568	 * Returns:
   569	 * * strlen(@prefix) if @str starts with @prefix
   570	 * * 0 if @str does not start with @prefix
   571	 */
   572	static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
   573	{
   574		size_t len = strlen(prefix);
 > 575		WARN_ON_ONCE(len == 0);
   576		return strncmp(str, prefix, len) == 0 ? len : 0;
   577	}
   578	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
