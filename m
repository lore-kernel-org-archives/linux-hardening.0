Received: from sender-of-o53.zoho.eu (sender-of-o53.zoho.eu [136.143.169.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CA3DEFF6;
	Mon, 16 Mar 2026 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686981; cv=pass; b=GD8He4k+ueC5L0MXUFdQzvscffFfRZMoApzyv61DXXfzouOchqzrLlqNYrnMksz1IvgjPhhaHM5ElHD4TFkohukqS2qeD0pt/cQBy1N4KojCMmdVUV/XNQb0B7DnocHgQg/NwXK885kupMstIM1Vls2bYDiHOeIahq0hbhMPDOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686981; c=relaxed/simple;
	bh=CUPnx6YjmYlcg/ZHhlIfpCAWDXFSkuqCQ0GwXMBty/s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=i+PCSTCVpw19Ttfn2aNZwYg0uuNChRxchHZiZDL+isrTrt3pkcxuK6xR2SUT/7KhGCn8KTFhXEBaajDJKhUaoE6q2uIb4pVRZdnGsuz342luT5Nr8ICDBts1QmraJROYZi14rwHIGFDPMVLzjIX7CpqJAxiWTx9BPYLLY7amtGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=KihGCFGs; arc=pass smtp.client-ip=136.143.169.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="KihGCFGs"
ARC-Seal: i=1; a=rsa-sha256; t=1773686965; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Oli64R/8r9bR/lZZyJSVawm2pNvCRwcC4Rib+Wp8+OD23NCjCDDR1g+lu8K1NoFqZlgstvdlYoPia3wi8sx1LpHu16J7/HtYAHeHFf4LTXG2h4MRpM7jL+EEV1eAYpMVuzn9P9c3hpdhJdKm7FeJmetkMqRPOyqGctfWlWSD/2g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773686965; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CUPnx6YjmYlcg/ZHhlIfpCAWDXFSkuqCQ0GwXMBty/s=; 
	b=ThAi7Wc8i2zIPSBrxZqiy/EQnHgSfwrtq4lfLkIPTgZC042LEhhf1ATCDDilyiOcrIDQGCV1Exzy3Ltd4NZ/T6NTwDvOnfUQvqoUOcPknX2pOmBYI2gkvnMQ0eFf5TImXO2ZUoftTkUhi74/NFknGcWmXEhBllRZrDezr0KijNA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773686965;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=CUPnx6YjmYlcg/ZHhlIfpCAWDXFSkuqCQ0GwXMBty/s=;
	b=KihGCFGs0r14Yd8Ow4BO6B7kDShHej+KpOcbQ2Hz7AdqtOghyTy1qsIPqYW7S+Re
	0FtiD2M0M9cGsVukJI7EcfcucZOK6VfzevlzIOKygAOG73fYbWCXuh2m38qfBWw1hN1
	imshLZwn6PlNZRwj0PMPFek5/wHZqP2LVquoq9Gg=
Received: by mx.zoho.eu with SMTPS id 1773686963164110.55584815753389;
	Mon, 16 Mar 2026 19:49:23 +0100 (CET)
Date: Mon, 16 Mar 2026 18:49:23 +0000
From: Josh Law <objecting@objecting.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, kees@kernel.org,
 linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/1=5D_ACPI=3A_processor=3A_idle=3A?=
 =?US-ASCII?Q?_Replace_strlcat=28=29_with_better_alternative?=
User-Agent: Thunderbird for Android
In-Reply-To: <abhQURnuNUPwiy_6@ashevche-desk.local>
References: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com> <4FC4DDD1-E170-46A9-888A-41D2CD6D97F3@objecting.org> <abhQURnuNUPwiy_6@ashevche-desk.local>
Message-ID: <590CA4EE-3510-482D-B768-91B3CFC73164@objecting.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



On 16 March 2026 18:47:45 GMT, Andy Shevchenko <andriy=2Eshevchenko@linux=
=2Eintel=2Ecom> wrote:
>On Mon, Mar 16, 2026 at 06:43:58PM +0000, Josh Law wrote:
>> On 16 March 2026 17:01:58 GMT, Andy Shevchenko <andriy=2Eshevchenko@lin=
ux=2Eintel=2Ecom> wrote:
>> >strlcpy() and strlcat() are confusing APIs and the former one already =
gone
>> >from the kernel=2E In preparation to kill strlcat() replace it with th=
e better
>> >alternative=2E
>>=20
>> Is this patch in relation to my string=2Ec patch?
>
>Yes=2E
>
>> You would have to do this for about 120~ files=2E
>
>Not me, just showing you what to do=2E
>
>Btw, what kind of assistance do you use for the patches?
>
>



None

I use grep to find all the files calling the functions (took a while!)


And if I did those patches, I can't guarantee all of them will be ACKed=2E

V/R


Josh Law
