Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBCE4B95D5;
	Thu, 17 Sep 2026 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639012; cv=none; b=By31QLO4ik5lvp3tcA9E2wID3b/mP+Ws+qzXjy5rqNfmAg3Sx2/87Zutp2R+8Yb2IBGsUZHgNBY1rVkRkKkH5aJfi5E8vNErDEVEfkyNdSSUFYJz0Png834DYjVtn8sX7FOb2QOa9baDNlMgVXic2ZjOW8PL3FdjI0MR8JwPWVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639012; c=relaxed/simple;
	bh=l7qw9IOPLpwHI9wAjjOanBaum9edjV7LwdFJbVP+EhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmEp26ScJ2waKTrg5KulEMP0lBIY2eTUSslBCjiFwarQP3yolfV4vC1DQh5G3pcBWB1B+RnYfAUQgcGYmtONUtprpPg4vefNiLmGAcXuIVZon/E/2r6hEgQryBjBh1gBp/fE4iEI0gzqXDkyaX85d7g7mBIL8WxBKO/HHUYssLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: andriy.shevchenko@intel.com
X-PTX-Original-Recipient: kees@kernel.org
X-PTX-Original-Recipient: andy@kernel.org
X-PTX-Original-Recipient: akpm@linux-foundation.org
X-PTX-Original-Recipient: linux-hardening@vger.kernel.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: kernel@pengutronix.de
Received: from [0.0.0.0] (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: jre@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2275E2020F4;
	Thu, 17 Sep 2026 11:56:33 +0200 (CEST)
Message-ID: <1b101eed-29b3-43ee-9cf8-cfc38a5df05d@pengutronix.de>
Date: Thu, 17 Sep 2026 11:56:32 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] lib/tests: string_helpers: introduce
 test_string_unescape_one
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
 <20260916-string_unescape-v1-3-7f8bd986fa33@pengutronix.de>
 <aquVCG4NwM1ezLLm@ashevche-desk.local>
 <7ad3889a-d9f9-426c-916f-3900d2c4ab8a@pengutronix.de>
 <aquuHKFFN7tGKbCf@ashevche-desk.local>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <aquuHKFFN7tGKbCf@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-09-17 11:08, Andy Shevchenko wrote:
> On Thu, Sep 17, 2026 at 10:58:27AM +0200, Jonas Rebmann wrote:
>> On 2026-09-17 09:21, Andy Shevchenko wrote:
>>> On Wed, Sep 16, 2026 at 07:38:08PM +0200, Jonas Rebmann wrote:
>>>> The existing test_string_unescape() function follows a complex procedure
>>>> where it, given a set of UNESCAPE flags, appends multiple test fragments
>>>> and predicts their unescape result for the chosen set of flags. Rename
>>>> test_string_unescape() to a more descriptive
>>>> test_string_unescape_combined
>>>>
>>>> In preparation to add simple regression tests, introduce
>>>> test_string_unescape_one() which asserts on exactly one call to
>>>> string_unescape.
>>>>
>>>> Add some tests for corner cases which already pass.
>>>
>>> So, this is two-in-one patch change. Needs a split, but I'm not sure why
>>> we even need this. Can't your case be incorporated into the existing
>>> "combined" variant?
>>
>> They can not be incorporated into the combined variant because that
>> makes it impossible to control the size of the destination buffer. This
>> can not be fixed because the idea of the combined test is that all test
>> strings are combined into one buffer. The bugs fixed in this series only
>> occur when the destination buffer is limited.
> 
> We may modify the loop to provide the length of the destination buffer to be
> exactly what we expect, no?

The problem with test_string_unescape_combined is this array crudely
named "strings":

static const struct test_string strings[] = {
	{
		.in = "\\f\\ \\n\\r\\t\\v",
		.out = "\f\\ \n\r\t\v",
		.flags = UNESCAPE_SPACE,
	},

	...

it is not as one may expect a list of the individual tests which
string_unescape is subjected to.

Instead all of the in strings are concatenated and then string_unescape
is called on that for each possible set of flags:

string_unescape(\f\ \n\r\t\v\40\1\387\0064\05\040\8a\110\777\xv\xa\x2c\xD\x6f2\h\\\"\a\e\, out_real, 256, flags)

So there is no way how extending "strings" could test the code paths I
want to test.

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
