Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B49943C7A4;
	Thu, 17 Sep 2026 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635777; cv=none; b=fdSQ/FgGjD4fCS+zFVzs684c+N2L/2m0MdL0Wk/aQSHGjk6mHyjTyKziyp1seJvfnQfYAxyM0K8+nb+LnixpZMh9/LtB67363fnA1RKVToM7+pIzTchz0lcX/kf5Qrkwn0QBY2qzkfiqcDj+owgYf0tJfVLx+DyD/oAPZpGahDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635777; c=relaxed/simple;
	bh=mqNK9tXH7XCK1DFahQMaObbcuPam3HTVphlBFJLU8iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9CpIUdkiRIcikruB2P/Wp0Asdcuimt1S63NiTfvZ9tta5mfsEMqM/i/IoSv/r35k9FO4EVOdBURvHLMx3CN8KLQsNYScpCkjh/hmr3BdtxUlaNPyaHSUHZYcaIArKttPhTlkWVcI6H5XxlvzZHLFGnlc0Kg4YXKphDdjnTqrmk=
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
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E15362020F4;
	Thu, 17 Sep 2026 11:02:52 +0200 (CEST)
Message-ID: <ae3d04de-b12b-454d-93f7-31ce912f6f8c@pengutronix.de>
Date: Thu, 17 Sep 2026 11:02:52 +0200
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
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <aquahuZKdB1haZrN@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-17 09:45, Andy Shevchenko wrote:
> On Wed, Sep 16, 2026 at 07:38:09PM +0200, Jonas Rebmann wrote:
>> Although all of the available sequences expand to exactly one byte, the
>> current implementation decrements the remaining bytes in the destination
>> buffer twice, effectively shortening it by one byte per each unescaped
>> character.
>>
>> The extra decrement is only needed in the one case where a single loop
>> iteration produces two output bytes: when the sequence turns out not to
>> be a valid escape sequence, the previously skipped backslash has to be
>> emitted before the character is copied verbatim.
>>
>> Add a kunit regression-test that unescapes into a barely long enough 3
>> buffer.
> 
> Can you add a simple example here with the hexdump to show the point?
> Yes, reading the code helps, but the above commit message is a bit
> unclear (at least to me).
> 

My idea was that the regression tests below would serve as examples
here.

Maybe I could mention that "short buffer" without my patch yields "A\"
instead of "AAB"...

I'll add that to the commit messages

And I'll add the kunit outputs to the cover letter:

      # test_unescape: EXPECTATION FAILED at lib/tests/string_helpers_kunit.c:24
      Expected q_real == q_test, but
          q_real == 2 (0x2)
          q_test == 3 (0x3)
  name:short buffer
      # test_unescape: EXPECTATION FAILED at lib/tests/string_helpers_kunit.c:25
      Expected out_test == out_real, but
          out_test ==
           41 <41><42>
          out_real ==
           41 <5c><00>
  name:short buffer
      # test_unescape: EXPECTATION FAILED at lib/tests/string_helpers_kunit.c:25
      Expected out_test == out_real, but
          out_test ==
           42 <41>
          out_real ==
           42 <5c>
  name:end of buffer

>> Fixes: 16c7fa05829e ("lib/string_helpers: introduce generic string_unescape")
>> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> 
> ...
> 
>> +	test_string_unescape_one(test, "short buffer", UNESCAPE_HEX, "\\x41\\x41B", 4, "AAB", 3);
>> +	test_string_unescape_one(test, "unrecognized escape at end", UNESCAPE_HEX, "B\\qX", 4, "B\\q", 3);
> 
> Still wondering if we can incorporate this into the "combined" loop?

Both these tests really only fail without my fixes because the
destination buffer is short, barely fitting the result.

With a buffer length of 4 it yields "A\", for 5 "AA" and for 6 "AAB",
a bug because "AAB" would fit the 4 byte buffer too.

-- 
Pengutronix e.K.                           | Jonas Rebmann               |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
