Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8993955F6;
	Thu, 17 Sep 2026 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635497; cv=none; b=ZBD8xy7psSE5tceuCC82jrBdr9cxjn1T1jAuXoRdi36U9Jtytyv+ZycQUTBF/bTprgRnVOH+hs9RrPnClvDUI/S6s8zbYxb5qWj6OPREsuCi7y0qiBNZBhGfMNAY45koKlbvcJH5sYcUsJ3YVndlwOjdD2yxgf3moBq7uy9PiFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635497; c=relaxed/simple;
	bh=1OhrZnBzZ0nAxpdHUgjsoW31W68d9nELbU2q61wPWic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSSacxHzHrTokbqECjuV4MNLG47EC0WzBwEnFWBmNd0rqnQN46PRr86knYLn9I+vUPsPYIUS2bOIhpgT4XXDsSYrXSh0HNORbsPi4vPPRPdfZZEvQ55ON61RlekSoFxhsOfpvbEKFki8fyspkMACvfLyZgDPj9WdXrcqtwk9k7I=
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
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5C427202591;
	Thu, 17 Sep 2026 10:58:11 +0200 (CEST)
Message-ID: <8f85aad8-060d-4809-bd81-56d7279e5cd2@pengutronix.de>
Date: Thu, 17 Sep 2026 10:58:10 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] lib/tests: string_helpers: check null terminator too
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
 <20260916-string_unescape-v1-1-7f8bd986fa33@pengutronix.de>
 <aquTPXq3d2CoW7Am@ashevche-desk.local>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <aquTPXq3d2CoW7Am@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2026-09-17 09:14, Andy Shevchenko wrote:
> On Wed, Sep 16, 2026 at 07:38:06PM +0200, Jonas Rebmann wrote:
>> string_unescape() returns the number of character written to dst, not
>> counting the null terminator which is always written.
>>
>> Ensure string_unescape has included the null terminator by adding a
>> separate check.
> 
> ...
> 
>> -	KUNIT_ASSERT_EQ_MSG(test, q_real, q_test, "name:%s", name);
>> +	KUNIT_EXPECT_EQ_MSG(test, q_real, q_test, "name:%s", name);
>>   				  char *out_test, size_t q_test)
> 
> The commit message doesn't explain why it's safe to continue the test if the
> first assertion fails. Care to elaborate?
> 

It is safe against out of bounds access because both buffers are
allocated by the callers, not by the function under test, and the
comparison is done for the number of bytes expected, not whatever the
function under test indicates was written.

I would add this explanation to the v2 commit message

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
