Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69C13956B
	for <linux-hardening@vger.kernel.org>; Thu, 15 Feb 2024 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016151; cv=none; b=EKp/pvJC/ns1f8+Oq+PvWuDq5FTseXmg/Q0Yilblbp7AiJ/aU8imp8LV2gk+29rvAzlfNENq2oY2uaNsHTNvH+d9aYoGu2Yc6uSeDLtISM8rR8ZbvXg7OXjglCwuZzoP5G/CSQCesXxMsfV0fxVgajMmMYMmMTR0O2I36GTBNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016151; c=relaxed/simple;
	bh=lyUTK7QRWcJugudMT5SRoPbX8sePObVGoNRm65sf338=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hmmu0jU0JEx4X+6SX4IX1ULuZsCSr/acKd9tfy7wa9+N1ZPn/hHNqssSZFBkGo0HVYssNWbHUDbQq3kNocF0pvPn4v02O/9pbxBW91spqKkEsbPrZUFmWVrKgGh3Ib2rQhyynVfQPPGuuzWTJzdhYZEeTpUgvZohz4MfWnwjcCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PGQxrUnD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PGQxrUnD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708016150; x=1739552150;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lyUTK7QRWcJugudMT5SRoPbX8sePObVGoNRm65sf338=;
  b=PGQxrUnDaOxlbhSWbaHEYz1+UAkhvL+CK9Z+PbUgcUH4Octdjped/Hgv
   FZcZzHA4PNbGSqNZrRPhSplfDtyr2Im7XkMVeViZnoY8ukwhjsHWjPFY7
   x6nMczlk8DR1iivDFq3BmIAE0gXuqIch6sWkHJ8kEOJNDf18LqndZb0Ue
   Y5VAJK/1H9blC03XhkQLDnItX7y/29WFPffehiAAAiNyuUKlcBhp7CCAw
   8brmW7EtdZPFEC/OwOzYdbbtbRsjT+Vkscra2IipQJPN2+fDWJu62m5Sk
   qhZolWiCWwTnBmoWdnpZR9KAVE7RB1SDm3O7HmuySmnrQ9Sr3tW+fwxMU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="19633111"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="19633111"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 08:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="8232716"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 15 Feb 2024 08:55:45 -0800
Received: from [10.249.139.11] (mwajdecz-MOBL.ger.corp.intel.com [10.249.139.11])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2927227BDC;
	Thu, 15 Feb 2024 16:55:44 +0000 (GMT)
Message-ID: <c5c13073-d543-4f80-a8b7-cc080cf04cbf@intel.com>
Date: Thu, 15 Feb 2024 17:55:43 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/string_choices: Add str_plural() helper
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>, Kees Cook <keescook@chromium.org>,
 linux-hardening@vger.kernel.org
References: <20240214165015.1656-1-michal.wajdeczko@intel.com>
 <Zc0BkKXZfIkwnvRs@smile.fi.intel.com> <Zc0Bz5hUHWgHu9UQ@smile.fi.intel.com>
 <87y1bm6gpu.fsf@intel.com> <Zc0LQ8YAWBwNptBF@smile.fi.intel.com>
 <202402141104.642F85D@keescook> <874je969g6.fsf@intel.com>
 <fc1b25a8-6381-47c2-831c-ab6b8201a82b@intel.com>
 <Zc43ojO9aymdzVo7@smile.fi.intel.com>
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <Zc43ojO9aymdzVo7@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15.02.2024 17:11, Andy Shevchenko wrote:
> On Thu, Feb 15, 2024 at 04:37:18PM +0100, Michal Wajdeczko wrote:
>> On 15.02.2024 16:20, Jani Nikula wrote:
>>> On Wed, 14 Feb 2024, Kees Cook <keescook@chromium.org> wrote:
>>>> On Wed, Feb 14, 2024 at 08:49:39PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
>>>> Or a Coccinelle script that could do some rewrites? But, yes, if you can
>>>> include some examples, that would be nice. I think the helper is fine to
>>>> add.
>>
>> please find below requested Coccinelle script:
> 
> Thanks!
> 
> Btw, what to do with 0?
> 

code is based on this rule:

"With countable nouns, zero is always followed by plural nouns."

