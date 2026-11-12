Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446299;
	b=JoujmoVIN/H9bMTfq/t2jqwpwviRa7olBM3eT/PV9VWJ2faW2rK0EgDb9B9hUZod/3kt
	 /Dm8nv6wwCpv8djQHowqIqGSgwKaNbNxNxjs9GOFs3iOWfjF8zPcBAZaw8l5npx5Jcy52
	 /Z4ZnyyXb9nUyTgqNsHfEaQS3d+djrirgacdKIeWDqvr2M4R4wqt0v3veLREiknk94Def
	 wR9UOVeP4z5Bz1Z8w2HpOEwDip7DD6wzQjxcHRN4JJ0IwGHtYWgNfU7OSKR6d3YPERo7j
	 GOIKBR5eJOJevM+gHOgKUiqeCmJgxdndwnIOlminuKcnJPkAZysmBgq8cbUb06JuRnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446299;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=EZx5k7geWUkka50W6MOHS2J6Xnk3P46GguPiHBvqeNY=;
	b=WqxZg4WQJxR89NG5LGePk2U4gthdJ6Lj2UzcuFtC8fxysWNioylNaXqWFFpCxaTWMy5h
	 5EjZhWcOEG/2IEXVZNgFCVRra1gviTGi14eJlNKictZWa5DY/PZtthvUItjLxZBI9OzeZ
	 p2QW0NSonkrV/g/+VN0wf5Ilofpx1SFpkSMSXXogSvCVKSzOCRzf1Qnnyp8aeQhHlY3Pl
	 SjoGzAoLBDBvzwP2Ow0A+mPHVMisW+hqkWSb1Ko4qDaVEv3TsCYmrjIXIUAqdvuRfhIix
	 dU+KFYEyKnKLKeywFcEb/81xkFXgxoJc8bgihIQfJ4tz8kagxevqU0z74dPBJQGb7wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nuGSld8Z;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D0606A326;
	Thu, 12 Nov 2026 01:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A4D0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nuGSld8Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794446299; x=1825982299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XzhoicYFHQtaBduXxA9DHIFJWU3DL3AA6BxXunzhRj0=;
  b=nuGSld8ZsZpo0Y+Ugusc4Rh+F1YnQoi5YNlluAaoW/DHX0D7YebokUxU
   6jVCWetraiPKCMpTifIStZe28d8cujnSS/sou/Ztku9Ho3MRg2bwbKCsH
   K3qDRgTffMci3rr8rniyclID4vXH1qCy7jTYK2tJc22K/ZfG7HnHZbtoQ
   2tD9PMm9aZbEIEuQdZsLMTnVvEHKXl0/AnAH1VxPKcAkj4fsyeOGgZNC1
   MpSuBCXqxCKa8/wVI2pjLqPPwrY3XRbszKPIB3e/TDiWZySVr0spDkkgk
   5gNSSBe/DmQaVaABpoc4VWtCiCFVe8fAG2LCFUPm2c07Vt6jm8i2MTB0x
   Q==;
X-CSE-ConnectionGUID: W1/wcG+HQtiFaaJdz3qLjQ==
X-CSE-MsgGUID: ZWz6a5QHSwO8u6CanAf+hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3119586"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3119586"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 17:18:18 -0800
X-CSE-ConnectionGUID: n4YdawboSm6iGZUYGgGZtw==
X-CSE-MsgGUID: UwrUxPsZQfilm24D64xW6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8412277"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 11 Nov 2026 17:18:13 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRJS5-000000010AJ-3GPI;
	Thu, 12 Nov 2026 01:18:09 +0000
Date: Thu, 12 Nov 2026 09:17:17 +0800
From: kernel test robot <lkp@intel.com>
To: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Alejandro Colomar <alx@kernel.org>,
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
Message-ID: <202611120923.khG1i6jO-lkp@intel.com>
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
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20261112/202611120923.khG1i6jO-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261112/202611120923.khG1i6jO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611120923.khG1i6jO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/uuid.h:11,
                    from include/linux/device-id/hv_vmbus.h:6,
                    from include/linux/mod_devicetable.h:31,
                    from scripts/mod/devicetable-offsets.c:4:
   include/linux/string.h: In function 'str_has_prefix':
>> include/linux/string.h:575:9: error: implicit declaration of function 'WARN_ON_ONCE' [-Wimplicit-function-declaration]
     575 |         WARN_ON_ONCE(len == 0);
         |         ^~~~~~~~~~~~
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
