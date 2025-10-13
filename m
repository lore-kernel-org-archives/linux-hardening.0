Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B2255F2C
	for <linux-hardening@vger.kernel.org>; Mon, 13 Oct 2025 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760354591; cv=none; b=JpWuwXdwcnG9md+P1sF4Qc+5b5w3ZeTSnLFYRHM3SlwK9Sfbkkt+HA+89VNfazHcM9YSK5WEYyajO6SnIWZVRG68Wz4VvAAR7DX9igqAecOGzFcEgvOwB8HD9ZhheBRwrS1dEW6YpOFbxTx+DORnCJJ+w+gL5XvNc0WqMakZbzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760354591; c=relaxed/simple;
	bh=bhuJegvTvAcQT0dEuoeIfFInmqmjZ1Q+isoUdA/Q6xA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bS+mrNhTxMjaeo43iYHraJCTOO1vNPhoOHDVT+WpNsqSfLkzA9RZOHGDXQ2FTFFuDoByiAOEbDztXcCl3nLAMGaDWlbKpOlaYePkq/xgUcBrMfa9m17cDCt0vJEnFK70s3hmwH2WHfEwGp5Qh7ePCdi5b/C9A3iGgRGPAPuFKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iu7JmbDX; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iu7JmbDX"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760354586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg/q8gaLEXsqld9FivxIEfM5ipjG9i1m/rctrdOvWIE=;
	b=iu7JmbDXS09ExiGoWBahy4+AbAU0q26cy0aGZUaC2VqCGiyu4+l+zkCpzaz4vICmLPDqhi
	G9tafSk2uhs4kuSbF1JHpNTRTPpEtrcY4pPU9a2Y0JVor6puVfJq61dL9cWJWumsA1Hbni
	7+dfViMzAyWk/xY4KMCmqKn3RCa2TKY=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] drivers/xen/xenbus: Replace deprecated strcpy in
 xenbus_transaction_end
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <2cce7bee-af02-4850-b1a8-b7f2cf3f1efb@suse.com>
Date: Mon, 13 Oct 2025 13:23:00 +0200
Cc: Jan Beulich <jbeulich@suse.com>,
 linux-hardening@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jason Andryuk <jason.andryuk@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EC8DD2E1-61F3-4882-8266-3F828377DA35@linux.dev>
References: <20251012195514.39003-2-thorsten.blum@linux.dev>
 <ebee3406-d515-4e29-9d7c-f54bdb143080@suse.com>
 <65bad926-22fc-41da-b9c4-5857a002b377@suse.com>
 <13cbd826-540e-4352-8e0d-ae0c9fbd2faa@suse.com>
 <2cce7bee-af02-4850-b1a8-b7f2cf3f1efb@suse.com>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
X-Migadu-Flow: FLOW_OUT

On 13. Oct 2025, at 11:24, J=C3=BCrgen Gro=C3=9F wrote:
> On 13.10.25 10:22, Jan Beulich wrote:
>> On 13.10.2025 09:36, J=C3=BCrgen Gro=C3=9F wrote:
>>> I would even go further and drop abortstr[] completely:
>>>=20
>>> diff --git a/drivers/xen/xenbus/xenbus_xs.c =
b/drivers/xen/xenbus/xenbus_xs.c
>>> index 528682bf0c7f..c891af7165f5 100644
>>> --- a/drivers/xen/xenbus/xenbus_xs.c
>>> +++ b/drivers/xen/xenbus/xenbus_xs.c
>>> @@ -550,14 +550,8 @@ EXPORT_SYMBOL_GPL(xenbus_transaction_start);
>>>    */
>>>   int xenbus_transaction_end(struct xenbus_transaction t, int abort)
>>>   {
>>> -       char abortstr[2];
>>> -
>>> -       if (abort)
>>> -               strcpy(abortstr, "F");
>>> -       else
>>> -               strcpy(abortstr, "T");
>>> -
>>> -       return xs_error(xs_single(t, XS_TRANSACTION_END, abortstr, =
NULL));
>>> +       return xs_error(xs_single(t, XS_TRANSACTION_END, abort ? "F" =
: "T",
>>> +                       NULL));
>>>   }
>>>   EXPORT_SYMBOL_GPL(xenbus_transaction_end);
>> Hmm, which xs_single() indeed takes a const char *, it then casts =
away const-
>> ness before handing to xs_talkv().
>=20
> Yes, the cast is needed as xs_talkv() can handle reads and writes. No =
problem in
> this case, as the string is only read by xs_talkv() (write type =
operation).

I'll submit a v2.

Thanks,
Thorsten

