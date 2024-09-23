Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8F1EADA
	for <linux-hardening@vger.kernel.org>; Mon, 23 Sep 2024 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727087061; cv=none; b=JcQMfsKuiDQ5jYrgoXM8HH6Eg5tDwgS44bL/giopx0My9EAe8hOD0mYbz0zD5bAIkcdYuQJ0A/M/O5pZJjItHC4ay8jCdWfe6qhhvPG2fld2+6dPydI2kHxQgFvUk6G21DcTXePGaqw3QLYByjR4Hn10sYoLK8wkiEFMc8MNWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727087061; c=relaxed/simple;
	bh=G1eykD/A/bjUIxFVkNomjyzkD9uvdztJXn6elYywFSw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Ak9OfELRyHG6gtk8Lybj4ZljT9Yfb2z4bU4FZT82UKEYg+A0f8ti//XeRje0Wj7XCWm/bo5Dqr/xnMULL4uFYDSwGVBpbqrvBf3QWU9QAOhR+qvw8sjbNgaL+BiKyck1RsxZN21n1vyHHt425t+GY4ubYTG+hy1hbj12HwLpdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=pd1fP9iO; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="pd1fP9iO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=eCqZtdhlcRZ8xLnf2ph2giJflGfOVbFtfE5ydremUs4=;
  b=pd1fP9iOxBlcKQKGmugnh1XeebHfaG8FvGASPSyrMbnjEKy6uWSDfeRm
   BsDb+hFydqmGbyKeUflhz0o6mGUJAx6lGxXV3WXmwwDIrQRUFZNoC38h5
   LyhzWyqQ5PVjADVxgUD0Q1FdTS+kTd2S6t26vpC8CtawNiVXKaPjXsIK/
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.10,251,1719871200"; 
   d="scan'208";a="184550478"
Received: from 56.66.136.77.rev.sfr.net (HELO smtpclient.apple) ([77.136.66.56])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 12:24:15 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next v3 01/10] coccinelle: Add rules to find str_true_false() replacements
Date: Mon, 23 Sep 2024 12:24:04 +0200
Message-Id: <466D6A21-0E18-4FC3-9A92-6B3EA58C273D@inria.fr>
References: <952c42aa-001f-42f0-8ec5-eb7e592b2629@huawei.com>
Cc: kees@kernel.org, andy@kernel.org, nicolas.palix@imag.fr,
 linux-hardening@vger.kernel.org, cocci@inria.fr
In-Reply-To: <952c42aa-001f-42f0-8ec5-eb7e592b2629@huawei.com>
To: Hongbo Li <lihongbo22@huawei.com>
X-Mailer: iPhone Mail (21E236)

Thanks for testing it. I will see if there is some other way to improve the p=
erformance.
Sent from my iPhone

> On 23 Sep 2024, at 09:01, Hongbo Li <lihongbo22@huawei.com> wrote:
>=20
> =EF=BB=BF
>=20
>> On 2024/9/19 14:25, Julia Lawall wrote:
>>> On Wed, 11 Sep 2024, Hongbo Li wrote:
>>> After str_true_false() has been introduced in the tree,
>>> we can add rules for finding places where str_true_false()
>>> can be used. A simple test can find over 10 locations.
>>>=20
>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>> ---
>>>  scripts/coccinelle/api/string_choices.cocci | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>=20
>>> diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/cocci=
nelle/api/string_choices.cocci
>>> index 5e729f187f22..6942ad7c4224 100644
>>> --- a/scripts/coccinelle/api/string_choices.cocci
>>> +++ b/scripts/coccinelle/api/string_choices.cocci
>>> @@ -85,3 +85,22 @@ e << str_down_up_r.E;
>>>  @@
>>>=20
>>>  coccilib.report.print_report(p[0], "opportunity for str_down_up(%s)" % e=
)
>>> +
>>> +@str_true_false depends on patch@
>>> +expression E;
>>> +@@
>>> +-      ((E) ? "true" : "false")
>>> ++      str_true_false(E)
>>> +
>>> +@str_true_false_r depends on !patch exists@
>>> +expression E;
>>> +position P;
>>> +@@
>>> +*      ((E@P) ? "true" : "false")
>> Hello,
>> The semantic patch is quite slow.  Actually it tests a large number of
>> cases, eg where the parentheses are present and where they are not.
>> A small optimization is possible in the non-patch case.  The outer
>> parentheses are not needed, because you will already get the same
>> information whether they are there or not.
>> In contrast, for the patch case, the outer parentheses are needed, becaus=
e
>> if they are there we want to remove them, since they are not needed for
>> the function call.
>> Could you update the depends on !patch cases to remove the outer
>> parentheses?
>=20
> You mean in non-patch case, we could just write like the following?:
>=20
> +@str_true_false_r depends on !patch exists@
> +expression E;
> +position P;
> +@@
> +*      (E@P) ? "true" : "false"
>=20
> I have tested in my machine. The impact of this parenthesis on performance=
 is very minimal.
>=20
> With parentheses, the time on driver/ costs:
>=20
> real    1m41.696s
> user    85m24.069s
> sys    1m8.891s
>=20
> Without parentheses, the time on driver/ costs:
>=20
> real    1m40.438s
> user    85m53.987s
> sys    1m7.981s
>=20
>=20
> Thanks,
> Hongbo
>=20
>> Also, just one patch would be fine.  There are many changes, but they are=

>> all sort of the same, so it would be easier just to see them all at once.=

>> thanks,
>> julia
>>> +
>>> +@script:python depends on report@
>>> +p << str_true_false_r.P;
>>> +e << str_true_false_r.E;
>>> +@@
>>> +
>>> +coccilib.report.print_report(p[0], "opportunity for str_true_false(%s)"=
 % e)
>>> --
>>> 2.34.1
>>>=20
>>>=20

