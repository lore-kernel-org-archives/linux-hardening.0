Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1018299AB3;
	Thu, 12 Feb 2026 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903463; cv=none; b=r+9yxYz7A3hoycFBfEMT9dMnpnu2xiktMxL289pfEglkClRguzeTAyhu64i/q/PW4zt85ABcGxIt0qgG9FE8WhPMBix9/4KCja9Elg3SED5sKu+G6tmDnz4vYcIOXOFRi0TPq1jRPvAULvqNw+mPah5e4rG/U7Lj8lWrO+R86L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903463; c=relaxed/simple;
	bh=BaKpnSDXkUi45l5qJcXfhcx4Znc0gt6BPBn9C4wtF+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG0Zwwzsubwq/xQijLy/OSu63VzTkNSNtD1Tg6ewiZUN+hKbLjBoqRP9EV/9CUxgwL66jOlWt25YJjzwR5q0P4SHlUwfVeu23Snwj3rFa7PxaYUNK2o9S+43IFKeozMwOX4PXBvJ2G/PBmma6ACL8cZ9kj/7izUQVMmKMZRTQ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJdnMNAv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJdnMNAv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770903461; x=1802439461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BaKpnSDXkUi45l5qJcXfhcx4Znc0gt6BPBn9C4wtF+I=;
  b=bJdnMNAvaY1LrekfASmhiKc4sUd99vpcTQ+zGBPaq9KEpPqFE74cgD9L
   uyWaUSk+K1MkVGbXgI7AfksXBJSvhDl98WaZpEsePsulJ5VvvmfIym28Z
   6K0/QpU+BfgQ2puJzM8/9ykClHtScZ1itBLO1aRbjkF85dx1BPOPwqFSb
   O4Mz9qAyFR3FoP/xTpXqXOjLadCN1AJM1nQSOXX8FvxLMPvgytwkZqGed
   DPqJt0sg/Tkg2Tb65GoSiXWXmPW/QzpBwrNTFsFRaZD4lBeuml7PnUErD
   qMHPdTrwK7T09QSwylsRL/pLu/KhT0xN53uAjbLebrTGRzIgR59MbF31m
   Q==;
X-CSE-ConnectionGUID: CrD8pbBMTSGDoQcmOvp4DQ==
X-CSE-MsgGUID: LziclrBnQ8CgXwfvpe8q5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71977163"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="71977163"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:37:41 -0800
X-CSE-ConnectionGUID: EeUvvlRCTxCo6nzCqpntsQ==
X-CSE-MsgGUID: 5+Fc/G5ITimznGeRYUEFUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="212705549"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.145])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:37:40 -0800
Date: Thu, 12 Feb 2026 15:37:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, djwong@kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/5] lib: fix _parse_integer_limit() to handle overflow
Message-ID: <aY3XocBvh_pCSLYZ@smile.fi.intel.com>
References: <20260209164757.433932-1-dmantipov@yandex.ru>
 <20260209164757.433932-2-dmantipov@yandex.ru>
 <aYrgASJXAyoholbF@smile.fi.intel.com>
 <14e1e0ac3b2622f762c8f369afc9b1e9a84ca66b.camel@yandex.ru>
 <20260212120030.2f15caaa@pumpkin>
 <20260212132517.1ac5de44@pumpkin>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212132517.1ac5de44@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 12, 2026 at 01:25:17PM +0000, David Laight wrote:
> On Thu, 12 Feb 2026 12:00:30 +0000
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> Re-send with "..." removed from one of the addresses so my MUA (claws) won't
> escape the second one and the list-servers fail to accept the mail.

There is a v7, perhaps you can reply there?


-- 
With Best Regards,
Andy Shevchenko


