Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5F03DDDC2
	for <linux-hardening@vger.kernel.org>; Wed, 15 Apr 2026 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267072; cv=none; b=JNx9Xb2N51h7iwbDgTFVdWQOeZa/5Vy3SpwdJNu7wquAzNRyCFRdCDltxtvlc3W7+9X8oRQjetV6mYwbpZfjeI0NVHRxOkOxr6z3GATPyI3TecMFkNMYFNCIBEZmSxoy9Y0YwoHBxiGFzJCtnvdeOALAHlK5VVrM3PYUBcjUX4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267072; c=relaxed/simple;
	bh=/1jglM6bOxQ2rUQVEw59z5VTadjxe9OsfHvAHvc38Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+Pt1J3NqkCa+2/tnRh4CzDtF7ohXN6CT6ZxawogzzX4+B74xgQyGUkbW28zjXqudgZRBlFrOBLKFD5HDE3c/GFx8uK5yluwg85E01O27+hSFQhC2rLM0bZ+OEisq4HfO0ElSqkKOteGKhuvWs1WXqTbS6JPzL0epvDe6LC3Vfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DvhHHlJM; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DvhHHlJM"
Date: Wed, 15 Apr 2026 17:30:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776267058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bNUCTwftTyZmhQuj6BrQe6gjkbhAAHH4cDkk0uKCoPU=;
	b=DvhHHlJMMsW/Rmo4HIKMCTCBo6YD0jW51NribO/aONpTd1JqLYy4zQYG0td8HTuVAy1ELd
	DOKnY5BbrfUJsKSYsHBcuoQaBuicFjspn2MNShmpHxEADRWorfp0pAYo6ZZZT1Ev/epm3t
	/0UDHxGt8g3W7fRfe0QuakPlsHHGWNk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/string_helpers: drop redundant allocation in
 kasprintf_strarray
Message-ID: <ad-vKhbh4KNV87gu@linux.dev>
References: <20260415122542.370926-4-thorsten.blum@linux.dev>
 <ad-j4eGpltrb-WQj@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad-j4eGpltrb-WQj@ashevche-desk.local>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 15, 2026 at 05:42:41PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 15, 2026 at 02:25:43PM +0200, Thorsten Blum wrote:
> > kasprintf_strarray() returns an array of N strings and kfree_strarray()
> > also frees N entries.  However, kasprintf_strarray() currently allocates
> > N+1 char pointers.  Allocate exactly N pointers instead of N+1.
> > 
> > Also update the kernel-doc for @n.
> 
> Have you checked all current users that they do not rely on the NULL terminated
> array?

Yes, I've checked all call sites, and none of them rely on the NULL
terminator. Specifically, I checked:

  drivers/gpio/gpio-mockup.c

which uses PROPERTY_ENTRY_STRING_ARRAY_LEN(), and

  drivers/pinctrl/bcm/pinctrl-bcm4908.c
  drivers/pinctrl/intel/pinctrl-intel-platform.c
  drivers/pinctrl/meson/pinctrl-amlogic-a4.c
  drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
  drivers/pinctrl/pinctrl-at91.c
  drivers/pinctrl/pinctrl-rockchip.c
  drivers/pinctrl/pinctrl-st.c

all of which use the size N to iterate over the returned array.

Also, kfree_strarray() explicitly takes the number of entries N,
indicating that callers are expected to keep track of it.

> Note, that was done on purpose that once allocated it can allow user
> to drop the track of the number of strings and rely on NULL terminator.
> I.o.w.  the number of strings may be just a local variable somewhere
> where kasprintf_strarray() is called.
> 
> I tend to NAK this change, rather you can update kernel-doc to explain
> why it's done this way (see above).
