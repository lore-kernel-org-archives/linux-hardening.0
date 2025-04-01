Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05D79C0;
	Tue,  1 Apr 2025 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497173; cv=none; b=m+YXS5v5FlbxpXrh3CMndGdBN1Ha5bUh89i7R6HK0EysVKzsdCKVtyUrm55TzbE2YHgOwBDyXtFuR3kqMGQTx+fnsYCxkz9ebgcttNt9gSk+WPvFBN55Racy0M39Q7LeVfmnn8DSsyYR3Xqq1eX6JcTZSABHEzZ21Bm6522IwJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497173; c=relaxed/simple;
	bh=Q7VbP+OM6RZM51VIVzDa4IreTwBZkx3kkLxPIuuKwFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sDj9eENiDmhKxR2QpcAmKbHNX00XZNx3P4/bCHip4e8xRhvcFHk0HQG0McgkZkycZyquJ1ITPD0tFoacMXCI7YxIFFs+VO04HzZfePXt808m6cDJtFkHNxz7Xzg88lr2Ga3CFce/olTgcpWvWDJMyp3PxdUB76Qj8wMcLw/0gG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bw0KTHDR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bw0KTHDR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743497171; x=1775033171;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Q7VbP+OM6RZM51VIVzDa4IreTwBZkx3kkLxPIuuKwFQ=;
  b=bw0KTHDRjZI4px6LZ/Q5jH6K8VSHQCCtkbL1UkWi3aEmupaIlLXIfcfJ
   FEJ5ZFEo4N5nALCTIUQyp2aJKC6BpBrz2GkEoP4Y05TaeunmWDxAw2WqG
   UW9cS0tRSVwU0adBbITpUiAKgdAmwXtKTEUT17tJFB7+YmuTci9i6E6eh
   sweBoaXa6XVDFwVnIiH0AloJyonLaFysWBSiCbQGGnB/bhH2Tp0fDwqr2
   OwxyVNwUjgR3dNExaU9YEyA7q9EmU2UaH4YaelO21dV27SIqMn1NmYpii
   WjfLSIIkMp2IdeubMjHsLUdnwARmU1yn/REqatTQiUZtR9ygBnDaKShhM
   Q==;
X-CSE-ConnectionGUID: 5kNcc7TXSo+pPKkxkoBwtw==
X-CSE-MsgGUID: cC6UWv1uTnSDozo4zf0/zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44718592"
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="44718592"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 01:46:10 -0700
X-CSE-ConnectionGUID: qTj9HiagTA6x9dSJxwZcIw==
X-CSE-MsgGUID: LSxATFcBRZWdu+Owe3rvZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="131041277"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.7])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 01:46:06 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thorsten Leemhuis <linux@leemhuis.info>, Kees Cook <kees@kernel.org>,
 Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Zhi Wang <zhi.wang.linux@gmail.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Justin
 Forbes <jforbes@redhat.com>, Nicolas Chauvet <kwizart@gmail.com>
Subject: Re: [PATCH] drm/i915/gvt: Add __nonstring annotations for
 unterminated strings
In-Reply-To: <37e1da82-736f-44a4-af51-036f9e3182f4@leemhuis.info>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250310222355.work.417-kees@kernel.org>
 <37e1da82-736f-44a4-af51-036f9e3182f4@leemhuis.info>
Date: Tue, 01 Apr 2025 11:46:03 +0300
Message-ID: <87ecyc46d0.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 31 Mar 2025, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> On 10.03.25 23:23, Kees Cook wrote:
>> When a character array without a terminating NUL character has a static
>> initializer, GCC 15's -Wunterminated-string-initialization will only
>> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
>> with __nonstring to and correctly identify the char array as "not a C
>> string" and thereby eliminate the warning.
>> 
>> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
>> [...]
>> Signed-off-by: Kees Cook <kees@kernel.org>
>
> To provide another small data point:
>
> Tested-by: Thorsten Leemhuis <linux@leemhuis.info>
>
> A "Compile-Tested-by", to be precise: after a handful similar patches
> reached mainline recently this is the only one I still need to compile
> the pretty broad Fedora rawhide config on rawhide using the GCC 15
> pre-release it currently includes. The latter or the final will
> hopefully soon also reach Fedora 42 beta as well and bring the "[1]"
> mentioned in the patch description above to F42 -- which will be
> released in a few weeks, so I guess it would be nice to have this patch
> mainlined rather sooner that later to avoid more people running into this.

Thanks for testing, though I've merged [1] instead.

BR,
Jani.



[1] https://lore.kernel.org/r/20250327124739.2609656-1-jani.nikula@intel.com


-- 
Jani Nikula, Intel
