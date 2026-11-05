Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864114;
	b=wrpkggXx/RwXKVixhtIGnoNUQUTxQX8fet54nzMjOtSQ9Ft2kedxkTzsN62HEGbBSB87
	 x7tEbQXPSxaS8D/DgAUQlEgl7Sveq3A7C0VGruVHpqiaZbtZ/EMqtHg1aH9UVjRkecEj2
	 sGUkIbBgC4MrV8+X0LXVTMsibHyKuXy0D8MAIU3K4egEksw3C6DTNxmK+joD4jP2tIFKr
	 snh6tzB7AhUSHct4xqW4vX14r+wcTh0SOH4RlXhiWY4k71FlFma/jZqg2db0LUgV161x/
	 QeBqPB1JNgbGVr1cZ9YXd+EwoqRp7amLVt1udLOWy7yzxV8vdYr4nzKwfPfryyeLhhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864114;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fJrSMcznO+jXm0R/Gb4sVutzbYoC421vKFMchCji1M8=;
	b=nOMjhQG7+Xl53SlePzTUsHgirbUX2lrMSEdnD8N+VFmfDGTxKvcyn24meoOKbMBnuUfk
	 N0DFtwTv33vKk8RBjp/JpxUKdBJ5G2Bo6wNVrzidCxanjVZH7jvwsEHVTgTX3U3fJF9RS
	 zAyurmhyCNmYpFYnzjuzO7UVggkMQht3L7ppsTlDwzk1W6ew+aIl1Lr+m/5fDMiOgrTTF
	 1NrBmUVOKO7OBG6XJuLaE5uH08saYg97oNik5idrF5f6lQN9HaY/r7TfldB49/2rlM2lY
	 Zt68f/IqeiSqV1W4VwLvsKHRAEBzDuCmvlxiblbtkVSP9MbCZ/oa9ArAeY13V+zjLHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mMdqqgJ1;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C20B606A31B;
	Thu,  5 Nov 2026 07:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C20B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mMdqqgJ1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793864114; x=1825400114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/FfPBMUOPLe/QDkESDBHjFZFt+ydwEnQtH3CnagBhAQ=;
  b=mMdqqgJ17Hm4OBGhcDS3oX0BE+t49VRKfRoSoxzEcrCj2+ipynCXUZP3
   RqAvVn/RGtMCEd8PqEY3k0DsqJECn1V1XBKAStUiqgOLPHxVLEIfgnIaq
   NQILUriG4m6tvyORDaLf4VLirbUV97TZqLgWsAYH9vxqkjDSV1r23fouW
   rIhwSTptTaryYC/pOQ/r+NSQq0koQLYdl0VsswLAz1b5iu74V9aY6+wSN
   tZ6XqEfN3CYBQZMDAZYhgnO+77WRl1kSuiXVZwo5UaldqWiRthERRzs/m
   gQb9BEZa9D6EERHXB1ikRvmMGd74QdRMD/ud8jJlao7NduurDoPAKIRm1
   g==;
X-CSE-ConnectionGUID: A+V4Cj2fRFetiQEJHa9wuw==
X-CSE-MsgGUID: MfjE4yDySxuYxO7KnmX/3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2676547"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2676547"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 23:35:13 -0800
X-CSE-ConnectionGUID: tLiMaRPcTziaRantES99tA==
X-CSE-MsgGUID: o10u2ZxSSZmlxdEUbRPtDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7099548"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 04 Nov 2026 23:35:06 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOs00-00000000lrT-0h1L;
	Thu, 05 Nov 2026 07:35:04 +0000
Date: Thu, 5 Nov 2026 15:34:13 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Kees Cook <kees@kernel.org>, Len Brown <lenb@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 9/9] gpio: shared: generalize most code to firmware nodes
Message-ID: <202611051523.HtiYeAbK-lkp@intel.com>
References: <20261104-fwnode-for-each-prop-v1-9-6e28fe1c72c4@oss.qualcomm.com>
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
In-Reply-To: <20261104-fwnode-for-each-prop-v1-9-6e28fe1c72c4@oss.qualcomm.com>

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/device-property-fix-fwnode_name_eq-for-empty-node-names/20261104-150343
base:   6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
patch link:    https://lore.kernel.org/r/20261104-fwnode-for-each-prop-v1-9-6e28fe1c72c4%40oss.qualcomm.com
patch subject: [PATCH 9/9] gpio: shared: generalize most code to firmware nodes
config: sh-randconfig-1001-20261105 (https://download.01.org/0day-ci/archive/20261105/202611051523.HtiYeAbK-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611051523.HtiYeAbK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611051523.HtiYeAbK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpiolib-shared.c:300:12: warning: 'gpio_shared_fwnode_traverse' defined but not used [-Wunused-function]
     300 | static int gpio_shared_fwnode_traverse(struct fwnode_handle *curr)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   Assembler messages:
   {standard input}:165: Error: offset to unaligned destination
   {standard input}:477: Error: offset to unaligned destination


vim +/gpio_shared_fwnode_traverse +300 drivers/gpio/gpiolib-shared.c

   299	
 > 300	static int gpio_shared_fwnode_traverse(struct fwnode_handle *curr)
   301	{
   302		int ret;
   303	
   304		if (gpio_shared_fwnode_ignore(curr))
   305			return 0;
   306	
   307		ret = gpio_shared_fwnode_scan_properties(curr);
   308		if (ret)
   309			return ret;
   310	
   311		fwnode_for_each_child_node_scoped(curr, child) {
   312			ret = gpio_shared_fwnode_traverse(child);
   313			if (ret)
   314				return ret;
   315		}
   316	
   317		return 0;
   318	}
   319	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
