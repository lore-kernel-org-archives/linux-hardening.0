Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387108;
	b=MICvr2dfUcS52WcDXhqy50cRNz4v9D31HpgBR5yf2bO+J+D7bVBCOdp+xB1hxXnyzplM
	 PLovZf7i/GjFY7W+hNXspIcgjg/UFXE2v9f1me5F+bMQy8CiF7AU+ntJoKlVVP4gqKxQk
	 GFZ4+km2G3HkpmHrSQzCk9d35MpI17XgAbQjtfb61ieGB/vrkPpmoW/exF9lx99qOygOz
	 ADT4WHxrbI+NzURbhHssNF2Sb29AjHKgUF/Aj2vpigycXGRv9TYjS3Vvi6jdbCjeGtFtn
	 pDBnGcvvt4KBdG6FDop77GkjeeERTLbResetxTqu07w05G42NuPlN+BKZ+yTYrqf6ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387108;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=gd5ljs4/qKYUBgu8GzfErIA54VXrKMWLrbXEO+MFhGA=;
	b=tZ/P+uEZV4hprnuQpcFtkUOSfwU0w3sKE6ZkyXXeZD/IdQ+NRme4UFSTFGPgkI6rszwn
	 8+R4U2omdGjyDkkCWdI8iFRz0yTbtGWl15cYmMRZmJ6grYYYus07H4+lH3xo+ePA4DWNk
	 yy8jbqhTrclIPTgXEKzWLtkWWxcaWyKIECLdz8N1NHKNX5UJhSSYiyLS03RAk1IsYO/9u
	 J4BriewntmNOCbLOjK0XwR1caSqycmGiq9RpqMT6zCKxzJY0wGePzNVQK0lcfSRu6DE+i
	 4/Etm34ejTiN7mpDRrurqoYE92DEiWXZ3MCWeS6YuUgnCsmf+8TW6Bc9itP3Gtudfkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="oAF/pjci";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D60606A321;
	Wed, 11 Nov 2026 08:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D60606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oAF/pjci
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794387108; x=1825923108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hL6MDknBFZ9siaHf0BWsE0tS4TqOjUvSfsHROpvn8kQ=;
  b=oAF/pjciHP5JyeF+UzEgOIUXJh613gI69oW3nNhLkHaeT/VcMLWZ+r62
   ww/c3hYRMXvvN1lBytYRRatFCdrAmDc1t3dQTkuhS4q6kxa6zzqQKyBrY
   rQ5Ar9MHniE+z5mK3T0lHpsstR7YqnrNR6MRqZLBRKD+oHqbCIfEophWs
   UkW4n8eMHa8zFuYw+x6Hnj8JAd7NTRW1q68nZYjuIi71sJqQj0/teGbRG
   JRHK0vLnW2AbdxxJITR6rXaKs2QLPwOJ9pUcyf1lz5kXLt06wacQl/LyR
   0YC/E6NtA72Svce97oSBfxcTwX5nY3+SKf24aWzVAv4tdFui/jr19c+Xu
   g==;
X-CSE-ConnectionGUID: dGSx5VVKTzmrq4BE//sAYA==
X-CSE-MsgGUID: jxE2tvMMQ8iPYoKtoezdXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3039781"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3039781"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 00:51:48 -0800
X-CSE-ConnectionGUID: tnDZWFXtRh606hfDYPwhAA==
X-CSE-MsgGUID: Py318lLCSSC4pgkoGZ4cbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8684010"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 00:51:46 -0800
Date: Wed, 11 Nov 2026 10:51:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	Alejandro Colomar <alx+linux-hardening@kernel.org>,
	Alejandro Colomar <alx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <avQsnSkg7Zx5zz5Y@ashevche-desk.local>
References: <20261104033110.out.418-kees@kernel.org>
 <ausWlN1oWc0Utnxb@devuan>
 <20261110220716.37bfac-kees@kernel.org>
 <avOp9udFzahnsmN_@devuan>
 <84CE5129-3519-4B33-856A-5304C17596F2@kernel.org>
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
In-Reply-To: <84CE5129-3519-4B33-856A-5304C17596F2@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 10:16:35PM -0800, Kees Cook wrote:
> On November 10, 2026 3:35:30 PM PST, Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:
> >> Date: 2026-11-10 14:07:24-0800
> >> From: Kees Cook <kees@kernel.org>
> >> On Wed, Nov 04, 2026 at 12:28:27PM +0100, Alejandro Colomar wrote:

> >> > Please include:
> >> >
> >> > Cc: Alejandro Colomar <alx@kernel.org>
> >> > (or perhaps a second Reported-by.)
> >> 
> >> You were Cc'd. :)
> >
> >Yup; what I meant is please store my name in the patch body, since
> >I want to be CCd if anyone looks at this patch in the future.  :)
> 
> Ah! In that case, you might want to look at using lei to deliver arbitrary
> queries to your inbox, which doesn't require depending on inducing other
> people's email clients to send to you (which even that goes awry when
> get_maintainers isn't used or git history is ignored, etc).

Indeed, this is even better than rely on `b4 trailers` functionality.

> https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started


-- 
With Best Regards,
Andy Shevchenko


