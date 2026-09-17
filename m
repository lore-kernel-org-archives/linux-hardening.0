Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181AC390230;
	Thu, 17 Sep 2026 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660066; cv=none; b=sgbGaCSXdBEkRNB3pA5UdE1IN3UXXnBD6ZTlS0WmBqVh/ZfeTvh77LQM+SLDE21QbPh8GDPbHnc8z4UbWjvNqRRz8EZXcY/18kece/ynhedSPfy3Yh59sThTK/AUngr8MrmxMIseWH/fv5PVkRhmoT1Ow73W+Ax+ME8M0FTn10M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660066; c=relaxed/simple;
	bh=2sYd83Cqjr/Gy3/2AYcV//kRGIW7ee0ETtGnXzuY354=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dml/TddQirqRtrLD+bL9+b4qNBQ6Td5+ejgMQz9RaeBU6TAl1qOR1fg+9Q7kc4/LhUUwpgKi78PHr/z2sob2wZy88uK8QlAlKgvbpJpIdeAfPbRXdKuyxIeaVLFbOIO0MXlP5IPOK+2EDxHkn9jsCW9nDbTN0FSCLvu6ArdLNG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from [0.0.0.0] (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: jre@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 86A2A200455;
	Thu, 17 Sep 2026 17:47:30 +0200 (CEST)
Message-ID: <ecabfbfd-ead5-49a5-841b-eb532dbaab6f@pengutronix.de>
Date: Thu, 17 Sep 2026 17:47:30 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] lib/string_helpers: use full destination buffer in
 string_unescape()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
 <20260916-string_unescape-v1-4-7f8bd986fa33@pengutronix.de>
 <aquahuZKdB1haZrN@ashevche-desk.local>
 <ae3d04de-b12b-454d-93f7-31ce912f6f8c@pengutronix.de>
 <aqvdyIsM_TV4OC4W@ashevche-desk.local>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <aqvdyIsM_TV4OC4W@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-17 14:32, Andy Shevchenko wrote:
> On Thu, Sep 17, 2026 at 11:02:52AM +0200, Jonas Rebmann wrote:
>> On 2026-09-17 09:45, Andy Shevchenko wrote:
>>> On Wed, Sep 16, 2026 at 07:38:09PM +0200, Jonas Rebmann wrote:
> 
> ...
> 
>>>> +	test_string_unescape_one(test, "short buffer", UNESCAPE_HEX, "\\x41\\x41B", 4, "AAB", 3);
>>>> +	test_string_unescape_one(test, "unrecognized escape at end", UNESCAPE_HEX, "B\\qX", 4, "B\\q", 3);
>>>
>>> Still wondering if we can incorporate this into the "combined" loop?
>>
>> Both these tests really only fail without my fixes because the
>> destination buffer is short, barely fitting the result.
>>
>> With a buffer length of 4 it yields "A\", for 5 "AA" and for 6 "AAB",
>> a bug because "AAB" would fit the 4 byte buffer too.
> 
> So, we need to extend the current loop to pass the buffer length like -5, -4,
> -3, -2, -1, 0, +1 from the expected length and check that it's cut correctly
> along with no garbage at the end. It will help all test cases, and not just
> a single one or a couple.

I suppose I could for v2 rewrite test_string_unescape_combined() to test
each case individually instead of concatenating all strings. So we'd be
invoking string_unescape() once per possible flag combination and repeat
that for the inplace test.

struct test_string gets the extra field regarding destination buffer
size. However we'd need to skip the inplace test in the 'short buffer'
scenarios. Therefore I suppose we just pass the destination buffer size,
not an offset. If that size field is zero than the test can run either
inplace or with any large enough destination buffer. For nonzero values,
inplace tests are skipped.

Regards,
Jonas

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
