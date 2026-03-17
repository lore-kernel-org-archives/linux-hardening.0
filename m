Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C69A332604;
	Tue, 17 Mar 2026 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767075; cv=none; b=m8F8dPLNQNLbI7gyb8YyLzMccCL96T5J0FPWduFJmWkh0XeE9XgQUREKDVn2U7rP9OlLv21xANEHVJQVJsZOQesIiXZPBsszprwNx7AQ+jCraOuZ0+S02Tu7WmBeLweDI5TudKS5dMULYiGG4LX45+KT6TDX5YbTAgyw/LJLS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767075; c=relaxed/simple;
	bh=c+0YSnv2KSaPKhBhuNn5Nsv7+iNbPMkHgdfEK2nXqzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ohzo47RDuAnUWUWlHah6bhdfTNekS11YuDqZGPk776oFCJrrfYOhck1J6ms9z2Iu+yHCq+voK2sxTjGWEU24vEK2CfzRwAfhKEK5uWXOwgJs+YfooE0A+JQkBa4cwCFEONUxAxj0VzDRweN8P9X02/pMh7oZfnizDxmwmeuxJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nPuWPgrm; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nPuWPgrm"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D1FB140C7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1773767074; bh=A1p0ysFsiwBSG1TTkK/fu/2Q+uxxTN0BSEwpkRmQZHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nPuWPgrmnB9yRhtaQR8reDbjZR3S1trW15MIQ/FmU27sqlWNpcpVJnf3K6s60hvJC
	 AjupysjCMAIt4hWN1S0vug0niKo3NVyrSP3ZWsyemOnaMtzWeDfX+IU7QXTY5FSRyz
	 mmSapcOpnq2yF46ft2So8Fu1e6gBfRIwVNnIntaEM8+hd5vS9JgpPF3BlkZ/v+mVtO
	 dPfgmhTXIgFya8ahQ1mA0SlNgx7k+gmfGcq/bsbg1vtvcPfkBaPNgcusyKKAE2ADM+
	 iOxsXZb0WruF+h1v50AzTcI1q2Bno5nEEXHtRd1Q+hMkHpbPAShWv27Sbs3VMrAKKu
	 G1A/rmNAP/ARQ==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D1FB140C7C;
	Tue, 17 Mar 2026 17:04:33 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v2 05/28] docs: kdoc_re: add a C tokenizer
In-Reply-To: <20260317092153.11f2b10d@foz.lan>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
 <8541ffa469647db1a7154f274fb2d55b4c127dcb.1773326442.git.mchehab+huawei@kernel.org>
 <177370220974.1754131.9642805524574261129.b4-review@b4>
 <c53a3638-7a72-472c-81e8-86a6c235b598@infradead.org>
 <87ldfrfimx.fsf@trenco.lwn.net> <20260317092153.11f2b10d@foz.lan>
Date: Tue, 17 Mar 2026 11:04:32 -0600
Message-ID: <87y0jq9ylb.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

>> > tools/lib/python/kdoc/kdoc_re.py | 234 +++++++++++++++++++++++++++++++
>> >  1 file changed, 234 insertions(+)
>> > 
>> > diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
>> > index 085b89a4547c..7bed4e9a8810 100644
>> > --- a/tools/lib/python/kdoc/kdoc_re.py
>> > +++ b/tools/lib/python/kdoc/kdoc_re.py
>> > @@ -141,6 +141,240 @@ class KernRe:
>> > 
>> > 	 return self.last_match.groups()
>> > 
>> > +class TokType():
>> > +
>> > +    @staticmethod
>> > +    def __str__(val):
>> > +        ""Return the name of an enum value""
>> > +        return TokType._name_by_val.get(val, f"UNKNOWN({val})")  
>> 
>> What is this class supposed to do?
>
> This __str__() method ensures that, when printing a CToken object,
> the name will be displayed, instead of a number. This is really
> useful when debugging.

I was talking about the TokType class, though, not CToken.  This class
doesn't appear to be used anywhere.  Indeed, I notice now that when you
relocate CToken in patch 7, TokType is silently removed.  So perhaps
it's better not to introduce it in the first place :)

jon
