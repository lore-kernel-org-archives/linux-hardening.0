Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919EB13247C
	for <linux-hardening@vger.kernel.org>; Thu, 15 Feb 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011445; cv=none; b=i0pcICRLPWXdWiR03LRqjIhDlj7lU7AXa8N11V5UQCHjWxF9b0+HcEvkB5eVvSADPw3k+xw540vlOdYPDB9hlqEdCyIDPGOpZM2GdAx3QolGLckcHwn/1LoHLHpxJ+6y9ImdEYyOqwpkeDj7A6bnwhtVV4jgbFp+wqM505Rv86g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011445; c=relaxed/simple;
	bh=Gx5p0fWYmdUodg/TGzbmAgGrtowMyBxg6aeEh7YYsvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QowTj2wumOTe4jyRg67TeGNxwxsjNbZBJVC672Hy3jJcZt8oaKmTFC+UtWyr4UmBTKpQut72yFc5yB//rcI6rs3PecvVP13VIjatV8hMEXQz6ep+Iqek/aEl5yLp0UQDDNvDoVLoEpNOlOhIdT3VWZV+eOTRccLjMZUOULEOMlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QX1KGYxm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QX1KGYxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708011442; x=1739547442;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Gx5p0fWYmdUodg/TGzbmAgGrtowMyBxg6aeEh7YYsvk=;
  b=QX1KGYxmn2ARSBaGyouHtJay6IGDFJ+NeN2zjetGyySAl2OfbC+yIpha
   VGNtIwnaGCzdTdCGvqtAH9/OjFGUEPQwXbvjJKc4aPC1k1NiceYObmqpi
   Ymn98GZhla3iAKJEPeueEP2ClHLbncviGpYzPOym/pFzBWgudzVI6JFb/
   9n8qr8C1sDy+MpZH/YhHsAopdRZyedwBsigyL+tcspmt3X61K+3C3jUWU
   SrdNYSuaroBD+xZSXkm86AnrTH9jTO1l4lYMgragjJNq2xror823qHOFA
   83Q8d5CreGF46pELdXzXuAUpU5d4PbzwhaKFaaYZ+xKtBgVhqy1ufzr4m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2230889"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2230889"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 07:37:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912181606"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912181606"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga002.fm.intel.com with ESMTP; 15 Feb 2024 07:37:20 -0800
Received: from [10.249.139.11] (mwajdecz-MOBL.ger.corp.intel.com [10.249.139.11])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3996A27BDC;
	Thu, 15 Feb 2024 15:37:19 +0000 (GMT)
Message-ID: <fc1b25a8-6381-47c2-831c-ab6b8201a82b@intel.com>
Date: Thu, 15 Feb 2024 16:37:18 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/string_choices: Add str_plural() helper
Content-Language: en-US
To: Jani Nikula <jani.nikula@intel.com>, Kees Cook <keescook@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-hardening@vger.kernel.org
References: <20240214165015.1656-1-michal.wajdeczko@intel.com>
 <Zc0BkKXZfIkwnvRs@smile.fi.intel.com> <Zc0Bz5hUHWgHu9UQ@smile.fi.intel.com>
 <87y1bm6gpu.fsf@intel.com> <Zc0LQ8YAWBwNptBF@smile.fi.intel.com>
 <202402141104.642F85D@keescook> <874je969g6.fsf@intel.com>
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <874je969g6.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15.02.2024 16:20, Jani Nikula wrote:
> On Wed, 14 Feb 2024, Kees Cook <keescook@chromium.org> wrote:
>> On Wed, Feb 14, 2024 at 08:49:39PM +0200, Andy Shevchenko wrote:
>>> On Wed, Feb 14, 2024 at 08:30:53PM +0200, Jani Nikula wrote:
>>>> On Wed, 14 Feb 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>>>> On Wed, Feb 14, 2024 at 08:08:16PM +0200, Andy Shevchenko wrote:
>>>>>> On Wed, Feb 14, 2024 at 05:50:15PM +0100, Michal Wajdeczko wrote:
>>>>>>> Add str_plural() helper to replace existing open implementations
>>>>>>> used by many drivers and help improve future user facing messages.
>>>>>>
>>>>>> Any user of this, please?
>>>>
>>>> git grep "\"\" *: *\"s\""
>>>
>>> You know what I meant.
>>> Second patch in the series that shows usefulness of the first patch.
>>
>> Or a Coccinelle script that could do some rewrites? But, yes, if you can
>> include some examples, that would be nice. I think the helper is fine to
>> add.

please find below requested Coccinelle script:

virtual patch
virtual context
virtual report

@depends on patch@
expression E;
@@
(
-	E == 1 ? "" : "s"
+	str_plural(E)
|
-	(E == 1) ? "" : "s"
+	str_plural(E)
|
-	E > 1 ? "s" : ""
+	str_plural(E)
|
-	(E > 1) ? "s" : ""
+	str_plural(E)
)

@r depends on !patch exists@
expression E;
position P;
@@
(
*	E@P == 1 ? "" : "s"
|
*	(E@P == 1) ? "" : "s"
|
*	E@P > 1 ? "s" : ""
|
*	(E@P > 1) ? "s" : ""
)

@script:python depends on report@
p << r.P;
e << r.E;
@@

coccilib.report.print_report(p[0], "opportunity for str_plural(%s)" % e)


> 
> In all kindness, I think it's actually better to get the inevitable
> bikeshedding rounds done first. It's trivial to add users after
> that. And for simple things like this it should really be obvious to
> everyone what the usage would be like.
> 
> My first attempt at adding a plural helper seems to date back to
> 2019. 

true, I do recall that, hence your invite

> Yes, really. Personally, I honestly can no longer be bothered to
> put in the extra effort before there's some indication of
> acceptance. (Like there's here now, thanks!)
> 
>>>>>>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>>>>>>
>>>>>>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>>>> Cc: Jani Nikula <jani.nikula@intel.com>
>>>>>>
>>>>>> Move these Cc to the after '---' line.
>>>>
>>>> Why?
>>>
>>> At bare minimum to reduce noise in the commit message.
>>> If going further, to be environment friendly (no jokes).
>>
>> I learned the above-the-line CC habit from akpm. But in looking through
>> recent commit history, this does appear to be the exception now. I'll
>> need to adjust my own workflow for this too...
> 
> It just depends on where in the kernel you look, every subsystem is
> subtly different. In the drm subsystem if you added the Cc's below
> "---", you might be asked to move them above.
> 
> Trivial for whoever applies the patches to do whatever they please with
> the trailers, impossible for the contributor. It's like The Trial. :p
> 
> BR,
> Jani.
> 
> 
