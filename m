Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDE3128C6;
	Tue, 17 Mar 2026 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735579; cv=none; b=qP4QwBwuobLJfS5Xybqiew+f9WjRQ7oC0h0kTNiJafa854YJ6RL/oo6vTEIxL2VxVvvruM6L2sDPLWQF07cnhhlirkZj28XwvVUNSt/Og9bw0/jdaBmoVKesn9cljGcGc6E4uDHfwcWkKPVCNuOajPWly+/dktX3OfQMaVygKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735579; c=relaxed/simple;
	bh=4zxW/y8+0BseAWAVbxgacfSF7arDZHvKNlG+OSnZUpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CS6y1dP+nRYLnO51/Ont6msXJCRtqq0VotUM5Z2ygHhSoEKC1/dbIst5odTjIB8uNWytFuz3kwjqIEHc0WgNT10dntFlywAS4RGBh2EZadHKZaBE9mnzwW7qHHes8EF2oBsPEJHE6UpjQHy+avTP3jQ6olC/FLuTfSK4qDjXN9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLYxb/GR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLYxb/GR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773735577; x=1805271577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4zxW/y8+0BseAWAVbxgacfSF7arDZHvKNlG+OSnZUpU=;
  b=iLYxb/GRmV3C2ZmagT16vO4lGzSzYYWz/Or8O857XWVxbuiA72jeA9y/
   pdVAi94QgDlv0ObAkvbiamZmEc752kc8vRSsoNZ4f/FJDSiVwhWzYvOyI
   5LNQMajd4GBv8H5AO8fTGtHnvtMSCyz1uv4EbPqGZ8W/z7xsQSlTzMUG9
   z8PYlLx8DZRXRAo4/ksvdaw5SvHERet/XhsFEBFEcehBBxnTmLb240vnY
   gH/WEjwLNe5jGJdTMn7wEwg+afOOLJwGwjlHZWjTHnYfCLhG5uv974abN
   NOm0gcYocGKM3r5vQobIY2jEyi09U3G3jg42eoA+tBuQQqAnLn3BjLQ9a
   A==;
X-CSE-ConnectionGUID: g2oG2HPAT0+3cV87Ac0x2Q==
X-CSE-MsgGUID: vVPX85HSQHifq2vL/QOcPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86237915"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86237915"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 01:18:57 -0700
X-CSE-ConnectionGUID: z8pTn0a8TyWlNjErDp7EcQ==
X-CSE-MsgGUID: cOv6ih4ATCatuq9cxA5/lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222139121"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa009.jf.intel.com with ESMTP; 17 Mar 2026 01:18:55 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2Pdc-000000004OX-1YAu;
	Tue, 17 Mar 2026 08:18:52 +0000
Date: Tue, 17 Mar 2026 09:17:56 +0100
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Len Brown <lenb@kernel.org>,
	Josh Law <objecting@objecting.org>, kees@kernel.org,
	linux-hardening@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ACPI: processor: idle: Replace strlcat() with
 better alternative
Message-ID: <202603170957.D9ZQ5sVR-lkp@intel.com>
References: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v7.0-rc4 next-20260316]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ACPI-processor-idle-Replace-strlcat-with-better-alternative/20260317-014800
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260316170158.1596857-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] ACPI: processor: idle: Replace strlcat() with better alternative
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260317/202603170957.D9ZQ5sVR-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260317/202603170957.D9ZQ5sVR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603170957.D9ZQ5sVR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/processor_idle.c: In function 'flatten_lpi_states':
>> drivers/acpi/processor_idle.c:1013:56: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
    1013 |         snprintf(result->desc, ACPI_CX_DESC_LEN, "%s+%s", local->desc, parent->desc);
         |                                                        ^
   In function 'combine_lpi_states',
       inlined from 'flatten_lpi_states' at drivers/acpi/processor_idle.c:1059:8:
   drivers/acpi/processor_idle.c:1013:9: note: 'snprintf' output 2 or more bytes (assuming 33) into a destination of size 32
    1013 |         snprintf(result->desc, ACPI_CX_DESC_LEN, "%s+%s", local->desc, parent->desc);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/snprintf +1013 drivers/acpi/processor_idle.c

   984	
   985	/**
   986	 * combine_lpi_states - combine local and parent LPI states to form a composite LPI state
   987	 *
   988	 * @local: local LPI state
   989	 * @parent: parent LPI state
   990	 * @result: composite LPI state
   991	 */
   992	static bool combine_lpi_states(struct acpi_lpi_state *local,
   993				       struct acpi_lpi_state *parent,
   994				       struct acpi_lpi_state *result)
   995	{
   996		if (parent->entry_method == ACPI_CSTATE_INTEGER) {
   997			if (!parent->address) /* 0 means autopromotable */
   998				return false;
   999			result->address = local->address + parent->address;
  1000		} else {
  1001			result->address = parent->address;
  1002		}
  1003	
  1004		result->min_residency = max(local->min_residency, parent->min_residency);
  1005		result->wake_latency = local->wake_latency + parent->wake_latency;
  1006		result->enable_parent_state = parent->enable_parent_state;
  1007		result->entry_method = local->entry_method;
  1008	
  1009		result->flags = parent->flags;
  1010		result->arch_flags = parent->arch_flags;
  1011		result->index = parent->index;
  1012	
> 1013		snprintf(result->desc, ACPI_CX_DESC_LEN, "%s+%s", local->desc, parent->desc);
  1014		return true;
  1015	}
  1016	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
