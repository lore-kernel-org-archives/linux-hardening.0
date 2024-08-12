Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9535F1917D0;
	Mon, 12 Aug 2024 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723492172; cv=none; b=euCsWPc1FEEv8MxmtqBS2oTHfE1mY9VF57AgjWQT6UWm39WQwPGrxphtWdbfaoKb601yPsVderMFHi+eWfHtEXGX5ia3ZWRb1nasbSLy2Pt904P3wMV5B82EbtfH4iZs16m0iW9PeFw6ppnqKJNWAzDBOhiOn0cDCBu9WZYJ9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723492172; c=relaxed/simple;
	bh=rEkC2p3/hDYrdI2cqSHQc6pq99mJv0GMpnWt8CrxSzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlhhA8P60vTtWD6p/XZsTp25JIvKK0odmTVJYPEMgr8mMcNN7U27m4qwTr2IZAOA3qFxwuXgDK51TsoGERBZCxqbb2TCEgiLJMfjk26gJjx5sZi6JkujRp3MEcc1fl3npQj0lpNRW5oY6Ipatp7iJup5S8IdmrUbfazrPFVBVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: n3Wf+aoYQWmAV5Nv2pqtrg==
X-CSE-MsgGUID: +IPjiDHBSeWc6VpepDDfMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="12968499"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="12968499"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 12:49:30 -0700
X-CSE-ConnectionGUID: knuB3U8nTuWCZguycpF7VA==
X-CSE-MsgGUID: jmIeVavnQxOPUiPIpAaUgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="58031053"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 12:49:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sdb2k-0000000ETiB-2qxg;
	Mon, 12 Aug 2024 22:49:26 +0300
Date: Mon, 12 Aug 2024 22:49:26 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] string_choices: Add wrapper for str_down_up()
Message-ID: <ZrpnRgdCaXFM1sju@smile.fi.intel.com>
References: <20240812182939.work.424-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812182939.work.424-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 12, 2024 at 11:29:40AM -0700, Kees Cook wrote:
> The string choice functions which are not clearly true/false synonyms
> also have inverted wrappers. Add this for str_down_up() as well.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


