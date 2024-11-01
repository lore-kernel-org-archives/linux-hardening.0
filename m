Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA18487BE
	for <linux-hardening@vger.kernel.org>; Fri,  1 Nov 2024 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497381; cv=none; b=euK00RHO7/GDJz12pWrhaaFi2QkmjQZl+3asuCMVfKKFWUuybCPM2Kzxh/V5B/RDC/9EsXjct2Qmk5IMQNeo1uZJlND1UbNkoziFkDLMlZiha5RUi7b0FY2phH/yEnrsqfzqSYtUz4kgMwUYrxrqfa3fUJhptYG81CT8v64lfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497381; c=relaxed/simple;
	bh=/ZgM+DthZuf8tZlOitoakk/860/05c98LB7mxNSZshs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uI3vaUn65DGV2mGuMvi1yqcrnUY4Jr1mWHRDR7IG3m/m5PkmIcmaMBUhQgThYRDlP8WCd7WcDxJ0a2DYsbr5oOTV0kYV6Jhbw58XB5LVcobQPVxopBZV/pj7jWyXx1T83wzZYdv2Nj7qkBgKOkDJKH56bbanMw+y/yWZXESVecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=gsgk7/D5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="gsgk7/D5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43152fa76aaso2648625e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 01 Nov 2024 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1730497378; x=1731102178; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZgM+DthZuf8tZlOitoakk/860/05c98LB7mxNSZshs=;
        b=gsgk7/D53SvZmOhZVyxvXCwUIPrnGx888dRgAm+sp9e7biD+/ajo64u0wcZiDNtRpO
         4ywBiOocrq7lZ+UBgwFFp//d6epq4fndPTotIw5RVuviMWvdmvHT4KmNk8+epWM+bSJQ
         FfTNkqx0D9UHoDpOHtEET/DC7kF+Zo05GVfvYr13dF0ARVxYUbBp+I45a3gQCxUxQtF2
         jEeQEjsRq+bjvWeEW80tVY8w7OhhaKIY7YBjEe2TGau9AQWehkFcVJ2FUQn8QDKzNZoG
         bhVvtOhoYw9YZhXv3iQ92vyVaG0lcjeR0rKkJ/xJ+XKlde752f25aQQnY69ryTzLwzKU
         i7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730497378; x=1731102178;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZgM+DthZuf8tZlOitoakk/860/05c98LB7mxNSZshs=;
        b=WVaUJvqS4RMJtaXJ8DBqJo49A1PfKrdJE49KRYRADOHmAantk6F3HhstQODBsOGyQe
         uzvQazz9mBIfBvfl0KobXGpjznajdIGS8IaxnBY6LXGW5kLJMb15JSv8bAEH3BBRmfui
         oxSLvYMebTn4dJPZTNp/WMay7VMu+KN0KFd9PC/7jv1KKn2v2qvnCJ9PLTDH8XYv/Pmt
         jgb0DoruK5NDM0o/NnsLiMiI6F07IBr1aUOS8YWGx41oRznYvUJeBNe2flz1KAfMGvIW
         w/w+/gOxuWuOuSOqtqIEBZ3MSLJ3m5AJvvKBmuCA8F8lKunKf+kQBfRQZ1c3pH6COGng
         k3tA==
X-Forwarded-Encrypted: i=1; AJvYcCX3dF3Qefg+sYmwK5FsZ/DOFvjn4UJWmNfIB4fxibnuCrWCZDkNB5GNf0RNwstsi0NQ6Zz6qsArnGt081HwCi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1xRk5Dqn/Tkl2Vjl6MeBRyRhT8+gh9Mfk3O9DrQHehniXHeDp
	31q2jPgkQPjjcxtZKtLsY/6+pODONn01XMy2lQdpoJmUXXHOpIudapJRWivxvQU=
X-Google-Smtp-Source: AGHT+IFLzBdexP8pqlR0nmX/00xf7SVomBe7J6FB0aM0mI5tvdjCnjz1DnH/K8jss5nUXrvUcNS6ew==
X-Received: by 2002:a05:600c:1c91:b0:42c:aeee:80a with SMTP id 5b1f17b1804b1-4319ad40b45mr97057145e9.7.1730497377649;
        Fri, 01 Nov 2024 14:42:57 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a4f:301:15ba:84ae:1181:c3ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116a781sm6283185f8f.96.2024.11.01.14.42.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2024 14:42:57 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2] params: Annotate struct module_param_attrs with
 __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <ZyTI3NoFY7uGfTWo@smile.fi.intel.com>
Date: Fri, 1 Nov 2024 22:42:46 +0100
Cc: kees@kernel.org,
 gustavoars@kernel.org,
 mcgrof@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B4C6889-9AAC-4AF6-A2CB-9FCC0E479D2A@toblux.com>
References: <20240823145931.107964-3-thorsten.blum@toblux.com>
 <ZyTI3NoFY7uGfTWo@smile.fi.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

On 1. Nov 2024, at 13:26, Andy Shevchenko wrote:
> On Fri, Aug 23, 2024 at 04:59:33PM +0200, Thorsten Blum wrote:
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
> What is / was the resolution on this change? It seems it either fell =
in cracks
> or being abandoned.

There was a false-positive Clang issue with this patch [1] (and other
__counted_by() patches) that was mostly discussed here [2]. Clang has
since made some changes and there is a patch for the kernel [3].

I'll probably resend this patch once [3] has been merged.

Best,
Thorsten

[1] https://lore.kernel.org/r/20240913164630.GA4091534@thelio-3990X/
[2] https://lore.kernel.org/r/ZvV6X5FPBBW7CO1f@archlinux/
[3] https://lore.kernel.org/r/20241029140036.577804-1-kernel@jfarr.cc/=
