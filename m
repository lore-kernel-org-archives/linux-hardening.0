Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACCE29B764;
	Sat,  2 May 2026 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777711034; cv=none; b=NwpQi+vu3oMPe889yo7ay+63b0i1qeO0MhgZxDIHT8b+EQFYcCPuThdhn+ZZ470M9lSliSsUs4mRuUnyr8WwrQmeM3XrD4jOYo6YhfeMi40KnjR8EpNeCOAAu+mrM0ZYhw3y1wIWGF4XHe5meVDdsRS/M1bA03U/RjlHjuaaETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777711034; c=relaxed/simple;
	bh=m3jk/8aKsJIldr2l0y48AsbjtZQaGzZ7YJl5axPshfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg+SSqDI/F9VNIsXrgqCF7Ko+z9LLo31b7md0CdD9SpdSpJ3C7T2RXhy7MqPv1hh0gLSun5/pgJOxxa+HxfhKAkvbOSywXo+1T7KJhWVTJOU1+kfqSq2MDzHn3yePp+/dHCgYmNFpJoAII6Ae1V6XNTdiQvDDGZj6o6ctpaD7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+1NTjF6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+1NTjF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777711033; x=1809247033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m3jk/8aKsJIldr2l0y48AsbjtZQaGzZ7YJl5axPshfQ=;
  b=Q+1NTjF6BQxHYlH3klCZmS0qyh2JyLk8oYgWnd5ALZzwZxS7HhRULeOJ
   enAs+L8thNpithO+IV718M3osj6QvPNN1ENwW708G7I7u+Ar31q+KVD9c
   /8oAx20YLSsnliwN+UWVLwAOjNgVJr8BffVQVzQ102z8U7ekKANEKOGd3
   S6nwcxF4HVnEq4jRAl29WhWMlsyWmSZ18bQNdtpRcjX0aJh2f0e3UK2dC
   EPnHomH/zAZlHZN07iQZnjZEd8eor/7x7b1imLLxnInvbQPf8plJcBMV2
   PJE/j1+Lay91xDjvVvzdE/aaWtsQ/OqDwVn5cLjHBQsonoFG2vG/EEwl3
   g==;
X-CSE-ConnectionGUID: JBDFyMp1QyCGewdNU4u7sw==
X-CSE-MsgGUID: SeZ0HiQmTGutpgW7xroCNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11773"; a="90118381"
X-IronPort-AV: E=Sophos;i="6.23,211,1770624000"; 
   d="scan'208";a="90118381"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 01:37:13 -0700
X-CSE-ConnectionGUID: 9Y6hzCB5RROrotJB0RQLSQ==
X-CSE-MsgGUID: DRUHnz3bT96mo/VAa1w0Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,211,1770624000"; 
   d="scan'208";a="273164313"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.18])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 01:37:11 -0700
Date: Sat, 2 May 2026 11:37:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] string: use strnlen in strlcat
Message-ID: <afW3tJH4XfeX_OXG@ashevche-desk.local>
References: <20260430205050.400822-4-thorsten.blum@linux.dev>
 <CAHp75Vd10OdNQfhb-hOAapJ4=uhZ+t26vp_WMAoeCska6NCyOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd10OdNQfhb-hOAapJ4=uhZ+t26vp_WMAoeCska6NCyOA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 01, 2026 at 11:55:33AM +0300, Andy Shevchenko wrote:
> On Thu, Apr 30, 2026 at 11:53 PM Thorsten Blum <thorsten.blum@linux.dev> wrote:
> >
> > Use strnlen() to limit the destination scan to the provided buffer size.
> > Remove the redundant comment.
> 
> Please, do not spend time on amending strlcat(). This function must
> die. Instead, convert current users to use alternative ways.

Note, there is a patch by Kees to address this in partitions framework
(vast of the users of strlcat() in the kernel). Not sure if it's already
pending in Linux Next or not yet.

I have done a simple one in ACPI recently (in upstream already I believe).
So, you can use those two examples and continue killing strlcat().

-- 
With Best Regards,
Andy Shevchenko


