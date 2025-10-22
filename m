Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC03446A6
	for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137658; cv=none; b=U5P4OzEqTtuBKkWou5TSZ4UczbeUVUrSzhAqH1N5MC4enJ7QMuzYcqkeXTzi5VtJldZw6ybp4DhKP4Bq0uxinoQXg0d49sUi4Bvr7TKYL5VACUKXdTRflbQUQ5i0zVHKn+E3Zc6AMeKpMZyJ8LQ6zFexJ4q3Ynb6M9XZtu9bVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137658; c=relaxed/simple;
	bh=LIQ1I3bwkPK9HSkT2gM9nT1KlwVBVcZ8fBylRSbbmjI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PajJuIJ9/UKM3VHjAYe2hrHTxIJhimz3aQkqVanXum+90z+hHcSn++3Sr4sxJItOZ4pzlWJCplN9FSFHbbQ8CufT85Olk/rqopce3nq4PWU8ObPiWhL++TXVK1Aa48JUQWBb1Bpvlp01y6C8djxlsllqU/+Zm4Gmb+qBWpcdkUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XlMhUPTa; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XlMhUPTa"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761137644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozlYXauUK0iPLj+FjL8XWy7Vz7jZGyn6q4O9waPn9ws=;
	b=XlMhUPTacwxCkfXYFqc6K6bjMtrSuFnkUzwNU5oza4Bp4g/TvQZbGeMGWm/CGutAxb4CMp
	LJ12wzvvZ4WYZgaZLsbI49POPtRPU96/VbK6sWBTxfxD0zaYZsu+Oa3oOkFNfP3R6eLXfG
	VjW5aH2sn9007PPLX6gKzXzetk++H/c=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 3/8] sparc: floppy: Replace deprecated strcpy with strscpy
 in sun_floppy_init
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <aPPsx9cHwkF8MC1l@ashevche-desk.local>
Date: Wed, 22 Oct 2025 14:54:00 +0200
Cc: "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Helge Deller <deller@gmx.de>,
 Jens Axboe <axboe@kernel.dk>,
 linux-hardening@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <40C3F1D4-8276-4AC2-B1D2-CCC3E1D9433D@linux.dev>
References: <aPPsx9cHwkF8MC1l@ashevche-desk.local>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

Hi Andy,

On 18. Oct 2025, at 21:38, Andy Shevchenko wrote:
> On Mon, Sep 22, 2025 at 11:03:52PM +0200, Thorsten Blum wrote:
>> strcpy() is deprecated; use strscpy() instead.
>> 
>> No functional changes intended.
> 
> Is this the only one place in floppy (arch) code?
> 
> The change itself LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for the review. The whole series is already in master and removed
all strcpy() calls from arch/sparc. I'm not sure about other floppy code
elsewhere.

Best,
Thorsten

