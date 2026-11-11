Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387005;
	b=0x1CfUHxrIHbQIKlYDgob48Y2tveucZy9pTuv4Smth33oSbOzh9kDwpNu4t/+4u9JmM0
	 IvwuIvzCDcpZG9xVZkqvcDOfnZW/v0tRI+oE9MZDL/y8jhqGJJdQUbC0DWn/xkWK4ZFkO
	 RgzkXyNV7hF5E4Ibn89fAMDjiwHNzYSvyjvP5TqUSNcmSGavphcv0Cb3oNtS7bTeAFQ/Z
	 ifsYlqPr6usQV53CKIjO8CZixK5zxiclb1tqX7qFeRffHOp9slPtBPL0GIC7NxBVJaT74
	 UinJ6KtkFwhDW2sr0ttdJUMaNViBqlmy17n5ZGOOl1IAY/LL8M01yBnTdqy3Gn+Q5+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387005;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=WqJxo8Of1F9UuOZMBd2PbZ8yNbZD6Kq3D32TSR8Sblw=;
	b=2lfJU8rcH8VhF58FU9EYW1E2gvXSRb6uzHqnt5q2G9p0THa+9di8vx5Ev0Ber3qZM0ot
	 pqBBmGHEz3O+5KTnkGM5RiZPYdCoTReDqAwprql8IOaGb4g4AS92Bh7/OVk1Qm4wRlyFh
	 zgF6WSWV+4e+83n3kXzMrYTxRo8THnWpboNLhgov9uHG1u1VMCnqJ3AWGHTVDEC0LjUxD
	 xr9bcKcGPpIv8SRwVF5z6MyAffqvqqTs6GjL3xieG8nNE/eA5vMWyXpLkjT/FzcDoF5S/
	 G2qT0u6nzOnGr0RwnUupw2Wgy3WuwWOR3DavZFICVNyx1/XaJw1FtTmZr6aRRxWEnrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JFu2eQqh;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019160A2618;
	Wed, 11 Nov 2026 08:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B019160A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JFu2eQqh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794387005; x=1825923005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LLfxza/Dng6DDXARwFRmFBWhM1Z+hUK6stlckfjyXOs=;
  b=JFu2eQqh4if7d8HqJtAS93G/7Xi2k7IQcpwKNKEWrx9aKy6ao14BNYCq
   ax3aA1yD47t3BgZbGRz0sLURRgO/0S7MPNp+PxqPbOKbtqiDVQnw3CzMo
   UJwTgJZQRYgvL6k9IqivHWfFReDiPROcfVSZqnRfAzVykjRVn+Yfgrjeh
   277xksOEfZQpPpgg6Ih+zX0UyxOKFUq8p63nqPxZ+RxPoqCTiBs4IxxLl
   +KwFEkI04FlpF3nMdrfhRQi5e3Oq7ZwUim1vkftuUsA4c0qc4rwv6ct9+
   jxCXcWKPNpcxxLMcHL75j6T2cMHBmSl491isUuIWhx/U+bh2BcAV0bHUW
   A==;
X-CSE-ConnectionGUID: Vt6ylQbZRWa4Rg4Gmohw7Q==
X-CSE-MsgGUID: AjEGYMF4S/aFAxEbnCsO2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3188000"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3188000"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 00:50:04 -0800
X-CSE-ConnectionGUID: OwfYI8opTMaZYOQYd8do8Q==
X-CSE-MsgGUID: S4tx2lNDQb2VjurEJ5POpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8294973"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 00:50:01 -0800
Date: Wed, 11 Nov 2026 10:49:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Alejandro Colomar <alx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <avQsNwYvySgLM8A-@ashevche-desk.local>
References: <20261104033110.out.418-kees@kernel.org>
 <ausWlN1oWc0Utnxb@devuan>
 <20261110220716.37bfac-kees@kernel.org>
 <avOp9udFzahnsmN_@devuan>
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
In-Reply-To: <avOp9udFzahnsmN_@devuan>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 11, 2026 at 12:35:30AM +0100, Alejandro Colomar wrote:
> Hi Kees,
> 
> > Date: 2026-11-10 14:07:24-0800
> > From: Kees Cook <kees@kernel.org>
> >
> > On Wed, Nov 04, 2026 at 12:28:27PM +0100, Alejandro Colomar wrote:
> > > Please include:
> > >
> > > Cc: Alejandro Colomar <alx@kernel.org>
> > > (or perhaps a second Reported-by.)
> > 
> > You were Cc'd. :)
> 
> Yup; what I meant is please store my name in the patch body, since
> I want to be CCd if anyone looks at this patch in the future.  :)

This can be done via `b4 trailers`. What is important in that case is to have
a Link tag.

Again, we have new tools, it will be nice to embrace them.

> > I try to avoid explicitly listing CCs in patch bodies,
> > though I don't always manage to wrangle "git send-email" correctly.
> 
> Then a second Reported-by might be better there.

This will work.

-- 
With Best Regards,
Andy Shevchenko


