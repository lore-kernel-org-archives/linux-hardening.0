Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC9028399
	for <linux-hardening@vger.kernel.org>; Tue,  4 Feb 2025 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687517; cv=none; b=bGIv2oBOPjbcES6npMi0jH0mLVOPm+uQzbjN6ZxUusAwTqCE8hP/cMb0ZQ+cbsQba6qZi12mgXd8BRtuCgeEKuiWU+KSPNalUq0S/GaoGDLMv6zgb4SYAIJ8o8JhndzDG+EQqKm0dead80fy7gsoDZuS6SkEdpgQ8avWS5y87gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687517; c=relaxed/simple;
	bh=nwmDxd2uSaPokJjA3sJT5MmKYDY9FRk+jRoqk8Y6Jtk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cFtzGYKT7NYNdaxgk1r2wf5mUtDQYTH+WEy+7LG5NDpGQ5UjOw74NePEr7kXA0c70zNNitSK2PokqRRR37HpOeLwMB00jISlwFYrSBgLzf1VjCnX1J8EOyOa1H/smXo+gKoe5qBtgNkYbXAEDYf0A8LdzF8ZMy1sOITOnZmhGvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tqYvYvRj; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tqYvYvRj"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738687508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPj2aPmzXzjw2UjtRCGDrvhA0v4l8hdBVukLvYb8lf4=;
	b=tqYvYvRjhm9iCJ6+rvNHX2CjirPwR5Hy+bbyFMge2S9D8/X/nHz7R3gaGuD7R3kdRC589L
	d0wgTZ+zfd8Wtb2nJjaRl6khR7OIjMAM3TC+mJHru9JYmPaEmviSXGPSXj18qdFj2FhGif
	qmBaIJA3whpgvv8c8fRJUnxZ0sCe16c=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs with
 __counted_by()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250114214956.915982-2-thorsten.blum@linux.dev>
Date: Tue, 4 Feb 2025 17:44:55 +0100
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CBE23F82-A597-4DC5-A297-26F8DEFA07B0@linux.dev>
References: <20250114214956.915982-2-thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 14. Jan 2025, at 22:49, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Increment num before adding a new param_attribute to the attrs array and
> adjust the array index accordingly. Increment num immediately after the
> first reallocation such that the reallocation for the NULL terminator
> only needs to add 1 (instead of 2) to mk->mp->num.
> 
> Use struct_size() instead of manually calculating the size for the
> reallocation.
> 
> Use krealloc_array() for the additional NULL terminator.

Hi, could someone please take another look at this?

It was already applied to modules-next in August 2024, but dropped
shortly after because of a Clang issue:

https://lore.kernel.org/all/20241029140036.577804-1-kernel@jfarr.cc

The Clang issue has been fixed for a while and this patch could be
applied again.

Thanks,
Thorsten
