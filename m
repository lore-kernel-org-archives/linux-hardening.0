Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A3238166;
	Mon, 16 Mar 2026 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690724; cv=pass; b=cHKX7g/spL5YGX4DFo52k3XW+49LnKUls4DWYmTA/SSDKUbLGXHbE/VfMc4yj7KPnvau3uG3DlyTy54HVBHGbOJHxlKLLLNBbFe4iVYTJhp+aD9vCkFegxFktIsCEC2jTVNPJVU1v0yo8aJfWNr9tEPyqDWMOQ5tWRJ7KxPDp60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690724; c=relaxed/simple;
	bh=woxrqfuOK2l5rwr0PcDsn2aR15FsUjuCq5WscYSE1J8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=k2MygDfO832kf6100OMN+5ZVUqfuZ6FhHzrpfPysvhdvMXSdQtWQ/r3SHAFRCxx3NTFwbNSZsg+rxKDAjwQFB4hikHv3+vhGEX3BsW9o+TwyMaY/oHocE+SGmXUkN5KAgZ80TrNHgMtWzXj8ebBnWilUXXhAzJi4ofmiBGZeZ6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=PAD1Pu7t; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="PAD1Pu7t"
ARC-Seal: i=1; a=rsa-sha256; t=1773690708; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=grLGA5qenamoJXYGRRfu2s10ZY+tepWXUhLCq0sTXapSx1EkZpJZ8eApVnUJg7fdOEDKju0so7ZzvlMpVZVFcrdmiypE6pMpEfowpSbHjdPY490TzDf3+QISI3C1cXKcr2TaTUspOWrMaBh3fcU6Zk55uvw1IatM1b9VxaiI+mU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773690708; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=woxrqfuOK2l5rwr0PcDsn2aR15FsUjuCq5WscYSE1J8=; 
	b=X31geVmaAufTHFCpljtHKhtMepRnYCfq3TQqLQ6YTLLJaaafXyGYefIdonH478+c+a9vZYuK9mA3hVryT5QPccKmAtJ4Y7lBTDaBGfZuWAhcxlCpFeBLCOLurbQl1NM8LOM3fnIcapsMERDICndtYg48Bs6NATbNwqv77dLGi1E=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773690708;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=woxrqfuOK2l5rwr0PcDsn2aR15FsUjuCq5WscYSE1J8=;
	b=PAD1Pu7tRPiGqor/QoPVD9uGdtJ+beRjXVV/bNz9dS8fhbOsOm4OB5+IvipHtsvc
	Sy7tIcUh6i75914cPnxSEGB8M9juGEuTLh8I2cJxdExYbHDa4ygTM6EUdpjLiDy80iE
	6d3T74zdRH6SdHoPlBCUTrsnHix1X/luQNqJjSzg=
Received: by mx.zoho.eu with SMTPS id 1773690705299114.16088586915873;
	Mon, 16 Mar 2026 20:51:45 +0100 (CET)
Date: Mon, 16 Mar 2026 19:51:45 +0000
From: Josh Law <objecting@objecting.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, kees@kernel.org,
 linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/1=5D_ACPI=3A_processor=3A_idle=3A?=
 =?US-ASCII?Q?_Replace_strlcat=28=29_with_better_alternative?=
User-Agent: Thunderbird for Android
In-Reply-To: <abhdOes2GSRZdWh3@ashevche-desk.local>
References: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com> <4FC4DDD1-E170-46A9-888A-41D2CD6D97F3@objecting.org> <abhQURnuNUPwiy_6@ashevche-desk.local> <590CA4EE-3510-482D-B768-91B3CFC73164@objecting.org> <abhdOes2GSRZdWh3@ashevche-desk.local>
Message-ID: <55C5EA55-8723-4242-8105-867DE284C7C5@objecting.org>
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



On 16 March 2026 19:42:49 GMT, Andy Shevchenko <andriy=2Eshevchenko@linux=
=2Eintel=2Ecom> wrote:
>On Mon, Mar 16, 2026 at 06:49:23PM +0000, Josh Law wrote:
>> On 16 March 2026 18:47:45 GMT, Andy Shevchenko <andriy=2Eshevchenko@lin=
ux=2Eintel=2Ecom> wrote:
>> >On Mon, Mar 16, 2026 at 06:43:58PM +0000, Josh Law wrote:
>> >> On 16 March 2026 17:01:58 GMT, Andy Shevchenko <andriy=2Eshevchenko@=
linux=2Eintel=2Ecom> wrote:
>> >> >strlcpy() and strlcat() are confusing APIs and the former one alrea=
dy gone
>> >> >from the kernel=2E In preparation to kill strlcat() replace it with=
 the better
>> >> >alternative=2E
>> >>=20
>> >> Is this patch in relation to my string=2Ec patch?
>> >
>> >Yes=2E
>> >
>> >> You would have to do this for about 120~ files=2E
>> >
>> >Not me, just showing you what to do=2E
>> >
>> >Btw, what kind of assistance do you use for the patches?
>>=20
>> None
>
>Hmm=2E=2E=2E Many patches that are generated require quite a lot of time =
investment
>and understanding the code=2E It's unbelievable that a person can do that=
 without
>an assistance=2E
>
>> I use grep to find all the files calling the functions (took a while!)
>
>No, that's not what I was asking about=2E
>
>> And if I did those patches, I can't guarantee all of them will be ACKed=
=2E
>
>Interesting way of saying the obvious=2E And if you didn't?=2E=2E
>


I understand your suspicion, my commit descriptions are written by a LLM, =
but the actual code itself is mine, the reason why I do commit descriptions=
 with AI, is because I'm not the "sharpest tool in the shed" with writing d=
escriptions for anything! If I add a feature, I can't do much writing about=
 it, and I worry that if I can't explain a feature well, it won't get merge=
d=2E I'm sorry for all the confusion, also=2E The reason I do high volume o=
f patches is quite simple=2E

I love lib/ basically, it's my favourite directory to work on, For various=
 reasons, and I have quite high work energy for my "passions", sorry if you=
 think I use assistance for everything (I don't, only for commit descriptio=
ns), I will slow down from now on with the patches=2E

And from now on I will try to manually write descriptions (even though I'm=
 not the best at writing anything, even if I understand it heavily)
=20

V/R


Josh Law
