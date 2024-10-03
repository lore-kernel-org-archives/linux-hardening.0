Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C5C1A00F4
	for <linux-hardening@vger.kernel.org>; Thu,  3 Oct 2024 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967743; cv=none; b=YBbEpECYDtjeOC0q0WwSynwtXOfSsao3jr0N1gdsUdNC8r9y+HC1rQmq/yPj5aIxvToTRF2Z2nwIL3UHruI3ZgZ7r6v6NoXi1Jq7xF2IlMnvx6ZUM4aszyk1hOqfM7997Y35uF679uYFVjhxgUkNZg9laL04dM4UHdLE2SPJE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967743; c=relaxed/simple;
	bh=0o4zGq1l8dC78VSp0hLET3Oej+NTqvrr3gSjrM5DOQA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sLXPK6kVCES2FsRaZNNuLukD8sUI2K4+DIx/WEPHxiTSQlO7ia4fZxusfquxSDNhtWK/L4NjFXAQlOjKZK0Com5IkwtoOE1Va8q2/OiBnFDuHRrYEd8crhSYIolZzleBDMJVo+TWPmKLygXBs+aXgLvdLAU/NT46lIXX68PVJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=PPnUN4Qe; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="PPnUN4Qe"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cddc969daso1568595e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 03 Oct 2024 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1727967740; x=1728572540; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0o4zGq1l8dC78VSp0hLET3Oej+NTqvrr3gSjrM5DOQA=;
        b=PPnUN4Qez86O089vD7a8sJNhsX9tMJH7zcGs+TYQBoItiEL+5wwcnzr2fvEjGEMNBE
         uX4pev5xIaR0JeBLwTP5efirmXrcBRTWh5tCRGx8ija5Xd0ATN4wzH4k821y62RYPWFI
         S6h9Q1r+6LTjLKIjABIidSs+71sO6elHTRqvOG7GV3tBf3SQBUbktaabnetybQxbrV/Y
         m6AMrPv7Q/W1JS4hysnmxETfjg9I6p5+DebN/c/P4ELnuEzgw5Au6al7iBw3/upvOLQg
         pULPc+LxpujHEeHc866jZFOKdseyJjxsECI/7GIhjmEvAzMbxJjDdXOhMx335MiH3Miq
         33uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727967740; x=1728572540;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0o4zGq1l8dC78VSp0hLET3Oej+NTqvrr3gSjrM5DOQA=;
        b=nrGT/DlZQmDEYUGyxvKdqzT+kXMigYDJ/EvVf2keVAGXX3OqO2fdLxzOwnztSLzPc2
         Rq7cbWETHvR28dW8TEwsFlANMXSd9/d7kQjZ3Jy4TVb7XkK86VxijfjYjIolH/kO6Cpp
         +ejXXWT9arKS5+v9Q0G1MU5Wh6WqKGF6cg331QFM9CQjjlkJtdauoPwqbvsgFzyNDpNT
         9TOqwvJ0wtNWU7WpREyUYhaBT+iL5n4eFrDoUP9bLTqK+XsLH5/CuoYIfw/MUVYEU/6d
         cEkHatCf0svO47rLDQakmesSBI+BMcWs3oEQ0PePoJXmFp2iOB3lGOHbFfDSFVb09FFv
         8QGw==
X-Forwarded-Encrypted: i=1; AJvYcCUGHaROtIwBi5lXmTGIXzpiVdj3jQbA2z2/KP1hwCohnNLKCdswd7S6suPj8U1z5ZsMJ3bpXXsLEfB3WGB7B/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvc3VVp/iTI2rgR6UFSyEtaClf9PcuddNyLe/TCZzS1bIl01qR
	1xXscBtT/lyKf9jZqezQ77jNUCxkJ9lllk3OVkNO+MurqjEgmpnwWO6x4exsiwc=
X-Google-Smtp-Source: AGHT+IFkImjjIUquq+gA7uxKoSKuU17rdWrRxPkQdJ+pAAJ+j4djTiCNVLXTTtRJsnFkETuOUvqxoA==
X-Received: by 2002:a05:600c:358f:b0:425:6dfa:c005 with SMTP id 5b1f17b1804b1-42f777af26amr26043395e9.2.1727967740138;
        Thu, 03 Oct 2024 08:02:20 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a4f:301:1558:85f1:4dd0:3ea9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79ead1absm46665475e9.17.2024.10.03.08.02.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2024 08:02:18 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [REGRESSION][BISECTED] erroneous buffer overflow detected in
 bch2_xattr_validate
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <Zv6YInHiwjLeBC3D@archlinux>
Date: Thu, 3 Oct 2024 17:02:07 +0200
Cc: Kees Cook <kees@kernel.org>,
 kent.overstreet@linux.dev,
 regressions@lists.linux.dev,
 linux-bcachefs@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 ardb@kernel.org,
 morbo@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <63D4756D-31B7-4EA9-A92F-181A680206EF@toblux.com>
References: <ZvV6X5FPBBW7CO1f@archlinux>
 <3E304FB2-799D-478F-889A-CDFC1A52DCD8@toblux.com>
 <A499F119-5F0C-43FC-9058-7AB92057F9B3@toblux.com>
 <Zvg-mDsvvOueGpzs@archlinux> <202409281331.1F04259@keescook>
 <21D2A2BB-F442-480D-8B66-229E8C4A63D3@toblux.com>
 <Zv6BEO-1Y0oJ3krr@archlinux>
 <E8E64A72-3C1C-40D2-9F07-415F6B8F476E@toblux.com>
 <Zv6YInHiwjLeBC3D@archlinux>
To: Jan Hendrik Farr <kernel@jfarr.cc>
X-Mailer: Apple Mail (2.3776.700.51)

On 3. Oct 2024, at 15:12, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
> On 03 15:07:52, Thorsten Blum wrote:
>> On 3. Oct 2024, at 13:33, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>>>> [...]
>>>=20
>>> This issue is now fixed on the llvm main branch:
>>> =
https://github.com/llvm/llvm-project/commit/882457a2eedbe6d53161b2f78fcf76=
9fc9a93e8a
>>=20
>> Thanks!
>>=20
>> Do you know if it also fixes the different sizes here:
>> https://godbolt.org/z/vvK9PE1Yq
>=20
> Unfortunately this still prints 36.

I just realized that the counted_by attribute itself causes the 4 bytes
difference. When you remove the attribute, the sizes are equal again.

>> I ran out of disk space when compiling llvm :0
>>=20
>>> So presumably this will go into 19.1.2, not sure what this means for
>>> distros that ship clang 18. Will they have to be notified to =
backport
>>> this?
>>>=20
>>> Best Regards
>>> Jan
