Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB1D14B08A;
	Mon, 13 Jan 2025 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783361; cv=none; b=NV4vUZV8ZsySRexPZ5a9dhYLdRomUQBVnW1qgNHC+o9WsRHR7NSuF5vNCUFQnvIv/G6gpFsvpByS978BKeJAQN9tbMN9sxMCcyHc8juXFyKk2OC5+haKCZVKnZlVFM2sv5z3bEKscmxEiaTkbTyW1l480G1OAtGr3nzB8qBKIsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783361; c=relaxed/simple;
	bh=XNy4aqYrPMuncn/cL8epbThbf0Nyp3GSzVg/62zj1hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siJdS2H6MaQT86zWR6UmZ2QUcK/26xrGgBIhwrmNU98FgQjDA5necEMc8vyzGFqnh+yPWFdQVjrp1TFLczatm/iZdKQliOdg2JJE/HRYyYoCpIRsnt9gI3xve95j7npyWaDfjzuIIMb2/IskEKcQGtYU+sgzzb7xdHCTLAsGjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: NTPTCI6VS/SoXJetjcQfeg==
X-CSE-MsgGUID: EOC+7JIrSryYDFZ+imTKpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48436081"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48436081"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 07:49:20 -0800
X-CSE-ConnectionGUID: HUqvrslyQj24xa4u58Digw==
X-CSE-MsgGUID: 5ZDFVU4uSruKcKhu6EFeqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105391725"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 07:49:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tXMgm-00000000W8i-2Tqm;
	Mon, 13 Jan 2025 17:49:16 +0200
Date: Mon, 13 Jan 2025 17:49:16 +0200
From: Andy Shevchenko <andy@kernel.org>
To: R Sundar <prosunofficial@gmail.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 linux-next 0/2] lib/string_choices: Sorting function
 order
Message-ID: <Z4U1_Gnh4DcZ15O5@smile.fi.intel.com>
References: <20241119021719.7659-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119021719.7659-1-prosunofficial@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 19, 2024 at 07:47:17AM +0530, R Sundar wrote:
> This patch series rearrange misplaced functions in sorted order and add 
> str_locked_unlocked() helper.

Kees, anything preventing us to apply the first patch from the series?

-- 
With Best Regards,
Andy Shevchenko


