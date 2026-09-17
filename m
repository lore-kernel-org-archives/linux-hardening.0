Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A749A3B7;
	Thu, 17 Sep 2026 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636038; cv=none; b=cPNzXUAZpV17R32th34bn1Bpzmt8XYsbhKc220qvzshphFuLJdaO6dwqbKFm14ltHAD8eAqQjRrMdPc+q3i6Dx9luQMHUT+899YQ/2C46FubAMYNGoIoaMPuR6KV37svPOtI3qMbF/Th0nJ2B5JGpKPazBzkPQh1/wTKtxw0e68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636038; c=relaxed/simple;
	bh=c54EqJlJKwaoXHX5X993VNVQif7lqZcOZhP+4w+10Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOWBC4UN+opyfrJ+Cjfd0mflB55GoyyireoM4+29pd2xRUjUq+R7SDoZr+Vue5JmFmWu1F2HruL84PeqPmzR+9ovLuOfnwZBEixazX59q8+BIXO1JePiwK0krIEkbbMc6imqebMXRB11wM8zpqOwMcIzxHOmCWEITjNL6+HR9qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GH0kgvwM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GH0kgvwM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789636037; x=1821172037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c54EqJlJKwaoXHX5X993VNVQif7lqZcOZhP+4w+10Sc=;
  b=GH0kgvwMiUdZo5rEyTjNHnCzS/NN2mhUmXYAsejJyPNIZ7TLVkY+MGRG
   oeC7/Y3TvsMd/fe83ayLf54Hnk3UcPB5qtKPxFRyHc2N2SIEVDHDwDu77
   oK0JugzYbfqadHG1tEZ2sIRVnKn4cShMnj1QdzruuMsGWzg96lAS7FcCn
   pxFwDhftv3vpbWZr9RJB9l2j4LS3p2oZt1W1gS1iTYP1Fv9C9ONyF7SsZ
   I6z4JsC1ejfS+Z6yt1TETkDydsMuL9zV2wtGln63ERZrTgfhon4BMo+BJ
   HEGENPoKFYTUNC26YN9Rnd6BtupHaFv04yXEy1ZdG70nWK2gnghoWfsbq
   Q==;
X-CSE-ConnectionGUID: tXVAzw5STai7ymWV+6uCfQ==
X-CSE-MsgGUID: lAGQcHD/Tp67RSd2YMUNnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93863983"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93863983"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:07:16 -0700
X-CSE-ConnectionGUID: /E/SqFoxRy+IC72t3nwkfA==
X-CSE-MsgGUID: CXqqsYohQY+pdCi37Dn9fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297156925"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:07:14 -0700
Date: Thu, 17 Sep 2026 12:07:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 1/5] lib/tests: string_helpers: check null terminator too
Message-ID: <aqutv8qJcoF14IRz@ashevche-desk.local>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
 <20260916-string_unescape-v1-1-7f8bd986fa33@pengutronix.de>
 <aquTPXq3d2CoW7Am@ashevche-desk.local>
 <8f85aad8-060d-4809-bd81-56d7279e5cd2@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f85aad8-060d-4809-bd81-56d7279e5cd2@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 17, 2026 at 10:58:10AM +0200, Jonas Rebmann wrote:
> On 2026-09-17 09:14, Andy Shevchenko wrote:
> > On Wed, Sep 16, 2026 at 07:38:06PM +0200, Jonas Rebmann wrote:
> > > string_unescape() returns the number of character written to dst, not
> > > counting the null terminator which is always written.
> > > 
> > > Ensure string_unescape has included the null terminator by adding a
> > > separate check.

...

> > > -	KUNIT_ASSERT_EQ_MSG(test, q_real, q_test, "name:%s", name);
> > > +	KUNIT_EXPECT_EQ_MSG(test, q_real, q_test, "name:%s", name);
> > >   				  char *out_test, size_t q_test)
> > 
> > The commit message doesn't explain why it's safe to continue the test if the
> > first assertion fails. Care to elaborate?
> 
> It is safe against out of bounds access because both buffers are
> allocated by the callers, not by the function under test, and the
> comparison is done for the number of bytes expected, not whatever the
> function under test indicates was written.

Yes, but assertion aborts the test, while expect just fail the certain
condition and moves on.

> I would add this explanation to the v2 commit message

Thank you!

-- 
With Best Regards,
Andy Shevchenko


