Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870251EF096
	for <linux-hardening@vger.kernel.org>; Tue, 11 Feb 2025 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739279916; cv=none; b=AAD7pGtUQs2sfUdbRqAWqX7o3E2hEDAJZnKlmcQM2NCxkGXT1JliIJMbvtJpeHCC2S9G8SbQKjBzS895h/yo/0hzTEx/NaiGGJjquPw1+SRk2ynHTvRBlFVp1lCKwr/lIkWvdVI5dQmbrVpZ83zp7gNWrFvYgg6PNobClIJQHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739279916; c=relaxed/simple;
	bh=sOdzvUj4MMT9zxUfUJkqXakEoGQ9CVufcBrdC+1LLqU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aLZHz5KbCKUKo58IMpufKjVM1gFHreeb8W6WseCHCUzodRAC3SovtbWazk2Wj6Xgz9GJ1ITh2i0TbRRCDvwAbbQdIYxqQH3Y17dKsGXlbqINnZ2/Gijdo2y3MwKiLpncW6/U8Nlx1TTPni2fbpYkuWp7kdUo4q8bWsMKJLAEY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lRypKdS+; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lRypKdS+"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739279902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOdzvUj4MMT9zxUfUJkqXakEoGQ9CVufcBrdC+1LLqU=;
	b=lRypKdS+Lu1mAGTHjlzCKz74VYgItBEALnpxTr1eNGBc5adKk+eKPE78HfVPwqFKBW7V9/
	ffFVFNYiBPAp0uxRDJesf599D5HU03DU70wKc/s54XPTzoRsujoGZPTPWCBS6E7Ny4UHuG
	KiZNZK4L8n89HHDkEgI/7ZGmkF327pw=
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
In-Reply-To: <CBE23F82-A597-4DC5-A297-26F8DEFA07B0@linux.dev>
Date: Tue, 11 Feb 2025 14:18:08 +0100
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF59E5FB-5998-4BD8-9E51-6B52198638CA@linux.dev>
References: <20250114214956.915982-2-thorsten.blum@linux.dev>
 <CBE23F82-A597-4DC5-A297-26F8DEFA07B0@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 4. Feb 2025, at 17:44, Thorsten Blum wrote:
> On 14. Jan 2025, at 22:49, Thorsten Blum wrote:
>> Add the __counted_by compiler attribute to the flexible array member
>> attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>>=20
>> Increment num before adding a new param_attribute to the attrs array =
and
>> adjust the array index accordingly. Increment num immediately after =
the
>> first reallocation such that the reallocation for the NULL terminator
>> only needs to add 1 (instead of 2) to mk->mp->num.
>>=20
>> Use struct_size() instead of manually calculating the size for the
>> reallocation.
>>=20
>> Use krealloc_array() for the additional NULL terminator.
>=20
> Hi, could someone please take another look at this?
>=20
> It was already applied to modules-next in August 2024, but dropped
> shortly after because of a Clang issue:
>=20
> https://lore.kernel.org/all/20241029140036.577804-1-kernel@jfarr.cc
>=20
> The Clang issue has been fixed for a while and this patch could be
> applied again.

Hi Luis,

you already applied this to modules-next in September of last year [1].
Could you apply it again now that the Clang issue has been fixed?

Thanks,
Thorsten

[1] =
https://lore.kernel.org/linux-kernel/ZuHaiiMV6ESS8p7z@bombadil.infradead.o=
rg/=
