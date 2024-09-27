Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3B142621
	for <linux-hardening@vger.kernel.org>; Fri, 27 Sep 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727454191; cv=none; b=jCThO9gzkiWWZDwYs02ptiC80dzlcccNL4laq8ffAv+J2rNCcr6LkVM298grDWzSNwZ4BzHBnTm1vfY2yOuiLtBrdBDZo6pyaind1AcHhzNtmuauzwvnSabYrouRGSUGKkNNcnFm6FeuvG6OMkUGtQXODYB/lVT/IoXwfBrmJlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727454191; c=relaxed/simple;
	bh=6marIh19WZrGCdY2BxGmhnNoJn18ZK94qKIiudktIY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mawP+gQp/thEUfs61PqDiz3X/8I/dudFgUaB/D+JWt4yW/7yGL/fE0kNEmUQpt1bOtANUYj4uyha/gF0ECWe/PafGEVgInHY5Ziuz6Oe6cAIb+sTMRSkfucvG270PuhluhPiVJR0YIc30by4O1Hk5Lhx22BsAJSykHt1uIFv8GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daG2UQ+e; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daG2UQ+e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727454190; x=1758990190;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6marIh19WZrGCdY2BxGmhnNoJn18ZK94qKIiudktIY4=;
  b=daG2UQ+eUMlbQfcCHGw4oGqvtWr5BXihYM5ulq+QV4OqARImLtLLNeVi
   uqt9X04oeIEvxaiV0GfWiabfR8j6NSEABFu2kh51z3sumC1mhialwJhNP
   Wga06TU2byxVQlxii46xhzulpqP8X4p1a24Y74PRQUd4a46G0En7CWEBy
   +yrDbKvaotlY3IOlaiBhtWxNylL+CmLXnjxloME4sBWm4qKSxDXbLKsX1
   BIp+DSv4jswqvCB+lHFv8LghF+jnYcNH7UI7DtdV7pyaH8LTvcEN6TEON
   6mQs9UOWa9L6GYrcf3BStUzMB+q+OOB3sxSIwFMkTIgqHrxvoxPAfdbuU
   Q==;
X-CSE-ConnectionGUID: 161Pb5/5RZy+wbV/pMPiOQ==
X-CSE-MsgGUID: +Atgdx86QWSAIdvhRDbqGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="26736838"
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="26736838"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 09:23:09 -0700
X-CSE-ConnectionGUID: Y+kw/ZaJSjGo3nvgQRBnuA==
X-CSE-MsgGUID: HgsZ1cA2TqOWddKonwDzFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="110069715"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.33]) ([10.125.108.33])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 09:23:09 -0700
Message-ID: <527f8aca-7703-419c-bfa8-1cfdf65e0fd3@intel.com>
Date: Fri, 27 Sep 2024 09:23:08 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [djiang:cxl/fwctl 13/25] drivers/cxl/cxlmem.h:798:44: error:
 'counted_by' argument must be a simple declaration reference
To: Nathan Chancellor <nathan@kernel.org>, kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
References: <202409270908.NJPL38kw-lkp@intel.com>
 <20240927134116.GA3695247@thelio-3990X>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240927134116.GA3695247@thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/27/24 6:41 AM, Nathan Chancellor wrote:
> On Fri, Sep 27, 2024 at 09:39:54AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git cxl/fwctl
>> head:   b4f2900f53c72de8fc639b62e44763c6a9695d3b
>> commit: 5a0496c19151d83cd0d926f8a1488eeaab27509b [13/25] cxl: Add Get Supported Features command for kernel usage
>> config: arm-randconfig-004-20240927 (https://download.01.org/0day-ci/archive/20240927/202409270908.NJPL38kw-lkp@intel.com/config)
>> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240927/202409270908.NJPL38kw-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202409270908.NJPL38kw-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>    In file included from drivers/cxl/port.c:7:
>>    In file included from drivers/cxl/cxlmem.h:6:
>>    In file included from include/linux/pci.h:1646:
>>    In file included from include/linux/dmapool.h:14:
>>    In file included from include/linux/scatterlist.h:8:
>>    In file included from include/linux/mm.h:2232:
>>    include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>>      517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>>          |                               ~~~~~~~~~~~ ^ ~~~
>>    In file included from drivers/cxl/port.c:7:
>>>> drivers/cxl/cxlmem.h:798:44: error: 'counted_by' argument must be a simple declaration reference
>>      798 |         struct cxl_feat_entry ents[] __counted_by(le32_to_cpu(supported_feats));
>>          |                                      ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> It seems like this should likely use the __counted_by_le() macro so that
> it is only used for tracking on little endian targets?

Thank you! That helped address the issue.

> 
>>    include/linux/byteorder/generic.h:89:21: note: expanded from macro 'le32_to_cpu'
>>       89 | #define le32_to_cpu __le32_to_cpu
>>          |                     ^
>>    include/uapi/linux/byteorder/little_endian.h:35:26: note: expanded from macro '__le32_to_cpu'
>>       35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>>          |                          ^
>>    include/linux/compiler_attributes.h:105:62: note: expanded from macro '__counted_by'
>>      105 | # define __counted_by(member)           __attribute__((__counted_by__(member)))
>>          |                                                                       ^~~~~~
>>    1 warning and 1 error generated.
>>
>>
>> vim +/counted_by +798 drivers/cxl/cxlmem.h
>>
>>    793	
>>    794	struct cxl_mbox_get_sup_feats_out {
>>    795		__le16 num_entries;
>>    796		__le16 supported_feats;
>>    797		u8 reserved[4];
>>  > 798		struct cxl_feat_entry ents[] __counted_by(le32_to_cpu(supported_feats));
>>    799	} __packed;
>>    800	
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
>>

