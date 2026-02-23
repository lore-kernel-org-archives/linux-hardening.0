Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F721F4168;
	Mon, 23 Feb 2026 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854431; cv=none; b=tqJO5AkPGawidW6VY39x8XgywYTVUJAkAD2QagW2WkUuaDY9pQKqfHymwy8wEcc9g+8C7Re4Tb9cLgoqBGNrEs75DJ5b2deddqjtFOG5yy3ADDmgSQC1JSqD6hu+QYRyFBEOTP1YVz/PddzB9HipqqnZ1K32oW01bwGDnbTejBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854431; c=relaxed/simple;
	bh=ydmdhEGM/O41rgUA/G7JvzJvk3KxbBzvvuzH7eImK34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k/VoQTYw8potIPUIR5v/NCznulO228GGVuQBNyem0J3eX5EpR0kGPheR9yRtk+hSmaxAtZbsrnJqsH/jf3W6cv4By35m3iywf8SPcXkmF+QYNwPB4Q60IsGWG9QVDOPL87z7XjZZvRXoRMrprmmx8HrU/+K/aj8CRaqllpPm15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VW6zsY06; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VW6zsY06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771854429; x=1803390429;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ydmdhEGM/O41rgUA/G7JvzJvk3KxbBzvvuzH7eImK34=;
  b=VW6zsY06sAfcNAvKJWHscJ64vXxvEeKcaVZlOfLrkM+hM7lsQXrvesiq
   pr3SEdJpszneKIzb69UK/XLs9Ehl9kHECZmu81ue8uW6XqMc7bY7Mh52W
   lR3kgIIN2AppERlvRcPOhclAskuO3AU9XK5IX8B/c5vZSJy/LBKWgHZAd
   3EQf79t1MCDfIfqJMrj9FbIyVOyM8hC/mb2jwLWIYW3730sjVSAk3uD5O
   sCO9DsSFwQ+NnnxMImulw3b4uxKLaBrB5TKyQa3zGkUP2vzQlBjEMu+Eg
   tk0YA/oXRe+kW+6NbEZE0ONr9aQ1+lWRFQdnIp1F3vEKcgBL/0+nbeuEV
   Q==;
X-CSE-ConnectionGUID: MA+KWGozT9SQqzOOrCK+rQ==
X-CSE-MsgGUID: GXkOsBnVQUSbKYQ3oocZ5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72756781"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72756781"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 05:47:08 -0800
X-CSE-ConnectionGUID: 1v88AsnGQx+5D12EpgNwKg==
X-CSE-MsgGUID: mmVGelq+SZamc1NuWYyuZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="219682264"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.249])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 05:47:03 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jonathan Corbet <corbet@lwn.net>, Kees
 Cook <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 00/38] docs: several improvements to kernel-doc
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
Date: Mon, 23 Feb 2026 15:47:00 +0200
Message-ID: <33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 18 Feb 2026, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> As anyone that worked before with kernel-doc are aware, using regex to
> handle C input is not great. Instead, we need something closer to how
> C statements and declarations are handled.
>
> Yet, to avoid breaking  docs, I avoided touching the regex-based algorithms
> inside it with one exception: struct_group logic was using very complex
> regexes that are incompatible with Python internal "re" module.
>
> So, I came up with a different approach: NestedMatch. The logic inside
> it is meant to properly handle brackets, square brackets and parenthesis,
> which is closer to what C lexical parser does. On that time, I added
> a TODO about the need to extend that.

There's always the question, if you're putting a lot of effort into
making kernel-doc closer to an actual C parser, why not put all that
effort into using and adapting to, you know, an actual C parser?


BR,
Jani.

-- 
Jani Nikula, Intel
