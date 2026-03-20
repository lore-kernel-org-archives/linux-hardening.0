Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E14234D3B1;
	Fri, 20 Mar 2026 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034749; cv=none; b=ZP/Xuh8zwwQ4x+91L33oMHbmA/PnAE0WwTqspbKc6GOtRdbT6L73m2Z7p4xUvorrH30aRqhgturahifS5PCzvHkmGk3HNegb8M5l9jEAqjfZATYRs/tQDUrW7vUZf1TneEX5nBaSpfz+pa1MuohFSQy5b3y2ANS04RkNP3fcaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034749; c=relaxed/simple;
	bh=L857L4O3g5jYU2fVL3AY7LwznGZ+hzG25ayifwG2TdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqNLgOVkrZlqTZonXtUIM3tXmk/Lrvlf4bOHXLgvJsUIxJJQqKLWWdzmUzvLPk05Te5QPRd39MKLa4X+UU9RnebzVJMxO8ag6VoqiMcr9EXB2QfBfOv+VRj/dvRdOcX+a0jch2GDV9GucbJKbwRauYdA1iWGGr896zP3fHFW1fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0kaL6oR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0kaL6oR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774034747; x=1805570747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L857L4O3g5jYU2fVL3AY7LwznGZ+hzG25ayifwG2TdA=;
  b=O0kaL6oRaPuubHEnNjhxKKio5MhKCgh3/NqYO5UcGN50bU4UNxzR/occ
   8CotObIYwwgCrdHfj1hbOryR59Krt9kE/pm8mTqDj/hfq36aSbqTe2Gdp
   5FsB8VT+s337GJ3TFMEEnIlI+y2MTZdbwSGOLiZTNE4qb+GRWEzhSIzeb
   WtYEcb0yf50igSQJopB0O7FaWSuqwbxtemWLasE25FcD3HyTaA4iiCL9d
   zHYbpSFLItNp8QoRwHhJHwQ3dYUyUqd8nH/mR0y9vj/VJ7pR4VWhKOpgk
   Z4vlFQkON63VhHoMCkqDH1SlbtdFZjkBwp+8aysZiNCeA81EDn1RKBoSY
   w==;
X-CSE-ConnectionGUID: zDYlUytUR6yKF9XSbHqncA==
X-CSE-MsgGUID: wKjGarAhT4ykxrtD5ECvaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="79034938"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="79034938"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:25:46 -0700
X-CSE-ConnectionGUID: LrO+/xwrTemh/vxP4UNt2A==
X-CSE-MsgGUID: eQA6KdUlRg6MvunakH8LTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223596708"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:25:43 -0700
Date: Fri, 20 Mar 2026 21:25:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Josh Law <objecting@objecting.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ACPI: processor: idle: Replace strlcat() with
 better alternative
Message-ID: <ab2fNTeawayVvjZv@ashevche-desk.local>
References: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com>
 <202603201216.3CD33C4@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202603201216.3CD33C4@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 12:17:54PM -0700, Kees Cook wrote:
> On Mon, Mar 16, 2026 at 06:01:58PM +0100, Andy Shevchenko wrote:
> > strlcpy() and strlcat() are confusing APIs and the former one already gone
> > from the kernel. In preparation to kill strlcat() replace it with the better
> > alternative.
> 
> Yes please. There are a few places I looked at in the past that might
> benefit from being changed to seq_buf or similar (where snprintf doesn't
> cut it), but otherwise the removal of strlcat should be straight forward
> and would be well appreciated. :)

Thank you for confirming, this is basically the message to Josh to find
users and start converting them and kill strlcat() eventually. Josh, as
you see it will be well appreciated!

> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Kees Cook <kees@kernel.org>

Thanks! There was a v2 which Rafael already accepted where scnprintf() is used
due to GCC complains about snprintf() potential string cuts.

-- 
With Best Regards,
Andy Shevchenko


