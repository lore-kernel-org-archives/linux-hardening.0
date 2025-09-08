Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F93147C9B;
	Mon,  8 Sep 2025 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335441; cv=none; b=KAaqFVcyqqqtU9NMXaeRMcUW7WaQdlboaDemyi31Q1GUXKMw3SkXNX+oEB/AEwVFTTp9SgRea+ZHzpG2k+3fSG8AvHaA48WRUSMPdnt8rBxRHtUFaV+FbQx0mRWuefcgotf2/W6SRE4xfPHGQaGR0yKCqSWXQUeFYKVgFtvgptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335441; c=relaxed/simple;
	bh=w83WVjdsSpxuD8gScr0VDwouKP5uJ/QoPOHGCH8nxJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ABEUXnHV8Xd8HItzZvh8u7Xs420XHNb3xHUS3YY4v9Bql93aVBH0VxAwHDjR1Apttuieh3cQNamhMyWEdaLivi8rJP8CqlqO8+SU3CLgkxgQsv6ryXiMnbQsitJgknmMJe+eaa60KXBnFzSit+7K/4GClMJkyM8K9dJ7wkGqnS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmztIUA0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmztIUA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757335440; x=1788871440;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=w83WVjdsSpxuD8gScr0VDwouKP5uJ/QoPOHGCH8nxJc=;
  b=jmztIUA0zVVHvsmIMEPIv/o7S00vHc+kj2CMFvKkrDMLr38tt28+qtda
   KEDNfvhTfWA4k4CvKTcGwft0KilkbLjSfObkkq70BPx126LqTPzsueqxI
   kLOY6FGWg1jNPm4Lwc34LKnsGpCnatByS6KBL3+gOoe5Y1yIN6V2y6bmH
   fkfl8iSiHqZndILEykCvc1xl75jabiH1Fr5ndKyEVp3Ieo/RBOoZpQNpV
   JEQs8kgg3uEVpzoQQCjGZFpNRRX/APkV6Z5emN6guQcjVhMwenF+1S22N
   XmNYeDtEk/9mK0QEFLi+RqLDCqe+WXWRiXGeVOjk308kDD3XGerK/4VYg
   g==;
X-CSE-ConnectionGUID: ma/Rhl0uQ+WAb3pKtorrTg==
X-CSE-MsgGUID: ETYIlkTTRWSGFHmHOv5xQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="85033403"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="85033403"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 05:43:59 -0700
X-CSE-ConnectionGUID: kz/L9M0dSPSgPXsRVrCfIg==
X-CSE-MsgGUID: T6gKGMO/R+qglbI7tLRsFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="176836358"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.204])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 05:43:56 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-hardening@vger.kernel.org, Jouni
 =?utf-8?Q?H=C3=B6gander?=
 <jouni.hogander@intel.com>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 3/3] overflow: add range_overflows() and
 range_end_overflows()
In-Reply-To: <202509040927.30BEE17@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250829174601.2163064-1-jani.nikula@intel.com>
 <20250829174601.2163064-3-jani.nikula@intel.com>
 <202509031942.A1669D10F@keescook>
 <eb4a61f86330afe95e232cc515f117ed602e108d@intel.com>
 <202509040927.30BEE17@keescook>
Date: Mon, 08 Sep 2025 15:43:52 +0300
Message-ID: <f73e233395bbc25f77f8345fde99b3b84c092823@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 04 Sep 2025, Kees Cook <kees@kernel.org> wrote:
> On Thu, Sep 04, 2025 at 10:34:04AM +0300, Jani Nikula wrote:
>> On Wed, 03 Sep 2025, Kees Cook <kees@kernel.org> wrote:
>> > On Fri, Aug 29, 2025 at 08:46:01PM +0300, Jani Nikula wrote:
>> >> Move the range_overflows() and range_end_overflows() along with the _t
>> >> variants over from drm/i915 and drm/buddy to overflow.h.
>> >> 
>> >> Cc: Kees Cook <kees@kernel.org>
>> >> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
>> >> Cc: linux-hardening@vger.kernel.org
>> >> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> >
>> > Looks good to me! :)
>> >
>> > Reviewed-by: Kees Cook <kees@kernel.org>
>> 
>> Cool, thanks! How do you want to handle merging this?
>
> Since it's touching drm, feel free to take it there. I'm not worried
> about conflict resolution in overflow.h.

Thanks a lot, series merged to drm-intel-next with Jouni's r-b and
Thomas' IRC ack.

BR,
Jani.


-- 
Jani Nikula, Intel
