Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921811172A
	for <linux-hardening@vger.kernel.org>; Tue, 22 Apr 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318057; cv=none; b=gHkKHZYTJ1rPb/yRKIcje5FkXLDFWJoyl2ayvapTZaofHAp+/ogVRwp18S3oNqyS+ANfVy61HlEGEETvFQaY6HO+MRTS/CmIRMS4sBsZJx27Ny+i8sT6FvLEe+uQKeiCtBtNDJ6W1ZG/bX5xc+G8z80okKRZcfINHSCv4OynoXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318057; c=relaxed/simple;
	bh=oeCuHoVz5QUTWJzf2zOJgkEhUJmKe2UCcI6Vt+o8aK8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PzC0M6col8P026GDhfO2lcRGPAsx2LaqQmsSSbro1+NsRXqjjp2yanu3u0lJjjk9I0cFK7Vx2zA5Y9DVEaA/6LcLYxwo3KB6oHH0L1hcPuMaybm9257hitQ0IQr+sfnj9rMN5cDt+5ZxFxxFyHGB9lo2+Bqg6XEw0yT80dJBXTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sgn8vt5j; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sgn8vt5j"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745318042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rjl1f5mubJGO7Tab81fhPjfe8rsa8zROJO6KvjoTdq4=;
	b=sgn8vt5j/cfrLu/IXAzWpmCM/LfzuCXQQ9/2B67LwujPDHaENOPRYqmctAzJjeFY/bVASo
	d0IoLn6amLaNwVzrl8hv/624m4H92s39XXDrJ/JMciLAFh8RCMBtuf6F0YOyoqtRyzkkKj
	U0xfqlFRtrQwsWEh9AwhGwQQd4Dh3Ys=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH] MIPS: BCM63XX: Replace strcpy() with strscpy() in
 board_prom_init()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <aAdsvNKuPd-qPuE4@smile.fi.intel.com>
Date: Tue, 22 Apr 2025 12:33:48 +0200
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 linux-hardening@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9FB72AC0-3FD6-4D9E-AE26-3EDC39A3025E@linux.dev>
References: <20250422074257.544016-2-thorsten.blum@linux.dev>
 <aAdNVAzu0rmIfGGC@smile.fi.intel.com>
 <86E5AC5D-11BC-4B4E-B08E-845F59AACF6C@linux.dev>
 <aAdsvNKuPd-qPuE4@smile.fi.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

On 22. Apr 2025, at 12:17, Andy Shevchenko wrote:
> On Tue, Apr 22, 2025 at 10:27:33AM +0200, Thorsten Blum wrote:
>> On 22. Apr 2025, at 10:03, Andy Shevchenko wrote:
>>> Can you use --cc OR put this line...
>> 
>> Yes, will do next time.
>> 
>>> Have you compiled this with `make W=1` with recent GCCs?
>> 
>> Yes, I compile-tested it with W=1 and mips64-linux-gnu-gcc 14.2.1.
> 
> Cool, no warnings?

No warnings, at least none related to my change or compiling
board_bcm963xx.c

Best,
Thorsten

