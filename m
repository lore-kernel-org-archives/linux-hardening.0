Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5337BE99;
	Thu, 17 Sep 2026 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635512; cv=none; b=AoarRXKS/8Aq2/+yLy98EWimXKSSLmDIgD2E2WGtFj5T+0onjj35dI6dN0koBeikUEC6qqLEVKZRx9y1ytxN/gcBUO7Do/nmvbhAcqKfv7OAI40flIYqaRA1W7CdmeWnDHMumrabwwIejSdJcLaCbgUpPJ8dZDdCHLrixq5utdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635512; c=relaxed/simple;
	bh=+n6fZ+G9W1QUrU4Ah11+hE5GJDijNAISFkHP0a3DC7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwnLvkPoVv70SZb70M7V37BindInu8xaK/6WWHeXm833r/ZsazS1ELGuI3WwLkKktzVW3z+zAnEyDxsiXPYwze3TtCYgn9tunrvka6jjpb5If6GuPFb6gB5d+OuK6x6sAZbBlYLTeGh0mdtVmolZGPyovAr/W6rp6yb8ffhuP9U=
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
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 994B1201A8D;
	Thu, 17 Sep 2026 10:58:27 +0200 (CEST)
Message-ID: <7ad3889a-d9f9-426c-916f-3900d2c4ab8a@pengutronix.de>
Date: Thu, 17 Sep 2026 10:58:27 +0200
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
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <aquVCG4NwM1ezLLm@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-17 09:21, Andy Shevchenko wrote:
> On Wed, Sep 16, 2026 at 07:38:08PM +0200, Jonas Rebmann wrote:
>> The existing test_string_unescape() function follows a complex procedure
>> where it, given a set of UNESCAPE flags, appends multiple test fragments
>> and predicts their unescape result for the chosen set of flags. Rename
>> test_string_unescape() to a more descriptive
>> test_string_unescape_combined
>>
>> In preparation to add simple regression tests, introduce
>> test_string_unescape_one() which asserts on exactly one call to
>> string_unescape.
>>
>> Add some tests for corner cases which already pass.
> 
> So, this is two-in-one patch change. Needs a split, but I'm not sure why
> we even need this. Can't your case be incorporated into the existing
> "combined" variant?

They can not be incorporated into the combined variant because that
makes it impossible to control the size of the destination buffer. This
can not be fixed because the idea of the combined test is that all test
strings are combined into one buffer. The bugs fixed in this series only
occur when the destination buffer is limited.

Furthermore, for the regression tests, I want each test tailored for a
specific case and when it fails, to show me which one failed.

I'll update the commit message and split the commit.

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
