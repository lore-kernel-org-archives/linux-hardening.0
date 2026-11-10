Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339296;
	b=nIHleGVyNOd55ofe7n5EbTRJcG2WiFgEWL1wR+Q/6ZFWfPRDO/clCZznU+XY/Kv0mSI9
	 OS7ovsedrCJkQKDbemsecuYD6TJIkGsRVR9RU5uo6l4XOMc1PRnjZFk9BlbkUgjx33G34
	 xDFqrooxaPvp8gwDmrDkVwySRT3TxCspuiibl1zeSxU3LHMh1eLfy8M/1vrGYyUDGn2J9
	 q4YvOfOw3RKM8RaE90fA6JWSudnGkKHzezwxAtf82clkJA4ib8Vws3cJWTq14g5MpOeha
	 qRcIMay9616nQ+Ir0qK7Sf2zWAnZeuoPeUNt35IC7N0c1XES81QI9uQxt8WWB0c5q/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339296;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=3ZSENFEc3eIcuXVoI9zHGQ+rzZxvwPSON5ssOp8KIHo=;
	b=F2/Wr5OH2r84cmyCOplhunpKk6BJuVzl5m1G2iMxFebolm3TW8DOGO8qGJl7EkG3mMR4
	 CjnQHQdpgSUaF7kwNox43lDaNjjTa1CH7kOcwgOrBLAmZ33CHzsxee80XuOThJA0lHgka
	 0S/GH7cFn7i/st8/g/bd3lYNp5qXHBJzUyIiLGfbz46jeGyh7gqiHOAgInbgPrWYFi9qu
	 ucqwIx/2AWRGohsOOHNOAKPAKH9PI+FmNSVYU4l0ip+35mX+43Kzwta3Zlw7aQIZ7U9Dh
	 i72Eb544OAw+ln98M8D4jLF253Q96XN0pNkaEhirA9nbjanI7HGbmxzJhECl8I44lew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YVCUiEOT;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F2A606A339;
	Tue, 10 Nov 2026 19:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2F2A606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YVCUiEOT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794339295; x=1825875295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sjB+zsnMOJDzo2CfLJwmzu4Ueqp8O8B5KJleeMwmvA0=;
  b=YVCUiEOTaDbgPD1gK5kdjKg2POzQtY7RSO6gaGjOsr8+Oyye854iwNHc
   RB16OlfXWIZ/wpXV5WaqA7+5lkLyP2lsP8MSHa1OS0vtm0lsHOK43zn2e
   1KHkVIApeXQ9gBw8l4tGcOwNxIknAz+oL+sdsuC40pHW/xTTmwg9X4w0h
   hosFmTSRY0DXBEkqC5bXgWfmcFWCczaIrvI6fS1oupmDWCAMpZQX8xCwk
   s/VJlMZujkYxjwSL2RxdoajbLn4jxPb9ZovBzD4fhtyxdvEaZqXzgcMQQ
   lHVnGgIT7+z5oubcjE8L+r09vvWGliUrpz9mczLFHsnZqKi1CCHiTLXMW
   w==;
X-CSE-ConnectionGUID: +ddBn+XsRkmcvylqvDy0Ug==
X-CSE-MsgGUID: qIal+L8mR5u5h7ZLCCnS3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3132123"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3132123"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 11:34:54 -0800
X-CSE-ConnectionGUID: nEvNZvVjTAKq72ubdGwSLw==
X-CSE-MsgGUID: VN0K3RINS1C6xbRirXEc0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="10111810"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 11:34:51 -0800
Date: Tue, 10 Nov 2026 21:34:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-hardening@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>, jorge.lopez2@hp.com,
	Hans de Goede <hansg@kernel.org>,
	Muhammad Bilal <meatuni001@gmail.com>,
	platform-driver-x86@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v1 1/1] string: Export strnchrnul()
Message-ID: <avNx2RwiaCQMkw1S@ashevche-desk.local>
References: <20261110164222.698745-1-andriy.shevchenko@linux.intel.com>
 <cec3aee0-a075-bec2-b487-2e28991f2d23@linux.intel.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cec3aee0-a075-bec2-b487-2e28991f2d23@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 08:29:58PM +0200, Ilpo Järvinen wrote:
> On Tue, 10 Nov 2026, Andy Shevchenko wrote:
> 
> > Export strnchrnul() for users that may be compiled as modules.
> > 
> > Reported-by: Armin Wolf <W_Armin@gmx.de>
> > Closes: https://lore.kernel.org/r/1969fb5a-38ef-4b4b-9d2f-cb9a4348b968@gmx.de
> > Fixes: 0bee0cece2a6 ("lib/string: add strnchrnul()")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > 
> > Assumed to go via PDx86 where the first (wow!) module user wants to use it.
> 
> Thanks guys,
> 
> I'm so surprised by this, sashiko did warn about this so I even checked 
> myself and saw an export after the closing brace so thought sashiko was 
> just wrong... Maybe I was looking that the strrchr's export, can't think 
> of anything else to explain it.

The strchrnul is exported, I believe you missed 'n' which may explain the
course of what happened. Compare:

 EXPORT_SYMBOL(strchrnul);
 EXPORT_SYMBOL(strnchrnul);

If you don't stare on this, you won't notice the difference at a glance.
(I caught myself on the same, but it was after this report, so I spend
 a few more seconds to get it.)

-- 
With Best Regards,
Andy Shevchenko


