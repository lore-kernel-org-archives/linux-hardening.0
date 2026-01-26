Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6217A3446B5
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445804; cv=none; b=IjaPrKlYlAdcs+1r9jslpHNhNpWktEbBEHmdYgwTYGd73MvKDRckP4QtOCuWJwBPEbkk6tR06k6n8rQXBMKrV9MvM0sv/8N+uJMctNX6HKh7o3OPBCFA0kQNvrJsdCQBEDzaZMNzg6ecDJT43d7i/aX6YuLv0WVuURrBnGIxUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445804; c=relaxed/simple;
	bh=GUsMEMIjhwBIluEhrMVnINC5P4MrYW3VrpZeQd6F+aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxFMlWd5qygY5j6ertkzbzKanTf4/VA0guMM3ZQJq0x/Aq8g7vvneGVzt5JkIeGfokoPd42JX+xkzITkhNuHBCBIt7t8od1Zu7xacBpLIgAkIFL04OxAfP0Po5WF+EprkanLiLMA5KpBQ1oYzIqK2xzhWtaFv9mZlZ60vYsPLwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DsFSyQmQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DsFSyQmQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769445801; x=1800981801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GUsMEMIjhwBIluEhrMVnINC5P4MrYW3VrpZeQd6F+aY=;
  b=DsFSyQmQNxToAwhAamHqchlCuh/a4oUYnfTwm211TQOg+Z6rt8EkT7JT
   OP/9gNxL146/jjaYEVq2Bis0wLvlQBqbkWrnmFS6Sru0Fwki3ESb2QLYL
   Hm0Y7ZfdieCKOilD1oY9YnTb4W0xnkJhDWwDY2pyHEn0AjoGrQRSKw1E4
   oUFqSW/10nKAuXXiCF8Q7xnZfElxU1wgkfKukqLU0jLRgZD/ICS/NuZ80
   RRnClrH81ZJxJ3wgjxDyTnO0Vm3XC6mjM+X4he+g+WyZSd97mIIvB31Vd
   tBBMzO6rdbOvpuKpTHTdbLdMOt1MSKQlRB2tsZ4W0OMnLhj7RoMOXrf6F
   g==;
X-CSE-ConnectionGUID: np1i786cQAiaefGQNQkTKA==
X-CSE-MsgGUID: plVENGBjRlOEIkgVhYesjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70718230"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="70718230"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 08:43:20 -0800
X-CSE-ConnectionGUID: h43U2JSRQ9ahjdKxsxql+w==
X-CSE-MsgGUID: V4OKkKtxSQ2caamsTYZUhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="207745354"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 08:43:17 -0800
Date: Mon, 26 Jan 2026 18:43:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/3] lib and lib/cmdline enhancements
Message-ID: <aXeZo2PJlXEuPjIZ@smile.fi.intel.com>
References: <20260126162059.357467-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126162059.357467-1-dmantipov@yandex.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 07:20:56PM +0300, Dmitry Antipov wrote:
> Adjust '_parse_integer_limit()' to not ignore overflows, add KUnit-based
> test for 'memparse()' and fix kernel-doc glitches found in lib/cmdline.c.

Shouldn't we also add test cases to lib/test-kstrtox.c?

-- 
With Best Regards,
Andy Shevchenko


