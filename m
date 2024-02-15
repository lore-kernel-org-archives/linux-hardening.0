Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF612E1C7
	for <linux-hardening@vger.kernel.org>; Thu, 15 Feb 2024 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017282; cv=none; b=H0+eWyl8j1rbIrOYQR/Ltqr/lIDP3zj3xFLESsU6gfGUzuujpaxes1Ar1qnVnOfy/e8ZEQvdMPKoFv/qJ34HQxPT78aiSA8ggMaQOPv/xXm31lEmHdZtjUjoWW3vfp2Fqnb2owMIM9c7bB6aaFFvtVRXtA97reMHooeYPjYifCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017282; c=relaxed/simple;
	bh=Y1Nv/tR8qYbOwenwkMV37N41a8MMTLtYO3S56faIHHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVDnCMi8PkfdckEUXePjUDh4gcsItL2nmLWzd2R26L+J7eChMK+mli32VyQpNtTQgNl3/WFK6cLQ390Y/55tojw4GEVKsann/43m7k8nOQ7Gj8i8pyZss2Pgr0naaLFUEvVDn3NHPVVbQ0Pwi1D8i/SKbenwX48sjShZDEOEg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdtaqLxf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdtaqLxf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708017281; x=1739553281;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y1Nv/tR8qYbOwenwkMV37N41a8MMTLtYO3S56faIHHA=;
  b=UdtaqLxfZLnAi1eZr+budY3gGxmYvLZqZE1c88Os/WokfscnoRwdpXrR
   Nn3313HptjSJemE9BvrVwbUgbkc3uAkhb+4fXXA/rl7L6EJnGz2MdLlu2
   NrPNdIlyd6kYImyfgGsTjgVCr8aPySHKpxEeldFpjCsA9YZHYH3iRlLRj
   LKyybx81Ignc+Bp7MWxlZ3DkFrvjQd2z0Ss8sMx1MRN9VEye8qSPRRS3b
   RUCX+Om5q0f6Y5EeoKCf0ltRNco4H+33nTmKD+XWBMkZUFH5VMnfHllhk
   66qZLhYGh5/TTdyeNQu1mKzsFhIQOvmljCIpTp2VJ4OenFOd+tOa/5Tmo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="13221942"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="13221942"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:14:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="3575198"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa010.fm.intel.com with ESMTP; 15 Feb 2024 09:14:37 -0800
Received: from [10.249.139.11] (mwajdecz-MOBL.ger.corp.intel.com [10.249.139.11])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 46BA728180;
	Thu, 15 Feb 2024 17:14:36 +0000 (GMT)
Message-ID: <93abcadb-591f-45dc-a07d-f67745eddcd6@intel.com>
Date: Thu, 15 Feb 2024 18:14:34 +0100
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
 <c5c13073-d543-4f80-a8b7-cc080cf04cbf@intel.com>
 <Zc5EQhQC0DaHZIgO@smile.fi.intel.com>
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <Zc5EQhQC0DaHZIgO@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15.02.2024 18:05, Andy Shevchenko wrote:
> On Thu, Feb 15, 2024 at 05:55:43PM +0100, Michal Wajdeczko wrote:
>> On 15.02.2024 17:11, Andy Shevchenko wrote:
>>> On Thu, Feb 15, 2024 at 04:37:18PM +0100, Michal Wajdeczko wrote:
>>>> On 15.02.2024 16:20, Jani Nikula wrote:
>>>>> On Wed, 14 Feb 2024, Kees Cook <keescook@chromium.org> wrote:
>>>>>> On Wed, Feb 14, 2024 at 08:49:39PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
>>>>>> Or a Coccinelle script that could do some rewrites? But, yes, if you can
>>>>>> include some examples, that would be nice. I think the helper is fine to
>>>>>> add.
>>>>
>>>> please find below requested Coccinelle script:
>>>
>>> Thanks!
>>>
>>> Btw, what to do with 0?
>>
>> code is based on this rule:
>>
>> "With countable nouns, zero is always followed by plural nouns."
> 
> If it's not documented / commented, please add one.

but this is a rule of the English language, no ?
do we really have to repeat it in the code ?

