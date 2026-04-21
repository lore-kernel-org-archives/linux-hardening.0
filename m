Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776283806DD
	for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813159; cv=pass; b=HlxS8lUSJESIuZQ6IIzK+DwutrmGwQXLyHsl73A/pHHncW4xwREKLr9+Xr1Bc6HMeypzjE4yGnmzauj4uoXfgyRqtB6jH2UMqS5jwxm1AigpCQr0A7Bzi1cbnm+nWStw4UhOqfeRZg26kyrJZw6wX8vOXyamPomnLqRy2GGjcEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813159; c=relaxed/simple;
	bh=kEqeOOMJL0MyuLpaUxwclHIgWXv9VRMqv4q5M1RKiok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1gy0GAZKWWJ4vMJwOkGdS9nzG0c6eGWtYDr/xeZLtyppbhav2PQd7zzrW9wLLgKjFXp6FaXPRIi9bonrRT7llx4zutXyftCPrHwSAc9H+JrG6IiDUO8Si2bvbpP1W35oaTMxIlN0H5MPYbCpPCft2f+sHnj/n7zel37yr8gIkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWlr6zMq; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWlr6zMq"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso628461966b.1
        for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 16:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776813157; cv=none;
        d=google.com; s=arc-20240605;
        b=ir3GbqV+047G9OhbWWDBkB4HAB3/xkoRCoOnKtSzl0Gkrt6Lg74v+r2O/3hC6wjHSL
         e5UAlu4uTkrrHUrkgJHXm/zvzOYknjkYm4CqVoN+Vwq1QHG32JkNjEt/zn4uO1NuJIZo
         K239THBTzREduw79GZKldBDqvzdLDHRcnW3nM4Pyg1LnNWGQ7xS8fzC71mJgmyzkqg9+
         r50cUgjIeOkJXGqivnajUYKVMupEQIAKGuXqOSS9OdckViA9gurWtYbFEstzHjLvYT8Z
         2wuFr0ugqUYidOOrIj1OPNfB4ZQuaZ66ivkRBDr/mw6BP97OCSd79sJocl1uSZa6lUKM
         6T6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kEqeOOMJL0MyuLpaUxwclHIgWXv9VRMqv4q5M1RKiok=;
        fh=1kIVaRkcpnIQQWnswCnnWuEmzwUjvI0BQ4a2FD+Xmw0=;
        b=AYTd3KTLHNo1ojX31EKwVe+IjJ7mAYFYKgHyUPtyCffY0R7mW1Twih74ZSoJ+1of8c
         ecwC6+K/ZhFQn/5R3VontS97UjdfFIqwmITDnJlilqbP9RBsQSOz8gztRSLpAmYUJ8jY
         ixRyqy2tQJkRPa88YK7+QxLMSxaippnca4pk8hjnuao7hXZB5WQuML0PD7PTp1QHFvKH
         W7CNB4bbAapZWxZMkGa2eAGnXtL3xooH+ADHta+BGC4rcpFD7ia/QHY0BsiYzT87i3Xv
         IsNNTa0lTANvSIbai50Gf2vGGwhHkwSqTOgKe+GMXRfGsEwL6errTE9oE/Xv7yCBEbWk
         NSfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776813157; x=1777417957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEqeOOMJL0MyuLpaUxwclHIgWXv9VRMqv4q5M1RKiok=;
        b=YWlr6zMqeGj0Caw8FxwX9Htw3VYPgUrscs6b5bHq0fdKoca3ogRO0SvAfyZAZ0Ic77
         b3rltOI2tU842gMqO3q456usKvVPDl7xXyvHf+dQQD+iYuqZXhvq1aJaaxzAD02FJh0Z
         QVfhrVE3Iy+Ek6zyWdUQgrQFQJuTY3HZMWABiPlWZ0+xt64AOnyPlzPCzcmIcgdTso9j
         PxBDwEMtlXJ9DFJtDfli6CWWFRlO7RVp3c38bzT3ff3L6+6s5YYPE9QNlivg8cNp/0MH
         JIg9+UU71y1ubgeSpivxU6ury5CuEUkQGLzMragZ6uLQEszxPUuqdRWiVvAV8b6pe8Lx
         OnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813157; x=1777417957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kEqeOOMJL0MyuLpaUxwclHIgWXv9VRMqv4q5M1RKiok=;
        b=l/hID+RJawjASoMcyLniHWLBF5T7tGukjH56esfpWsOMDBpePoIvp7FiUHhYd0Yjc2
         GWbhZzaXZknUCsXtkHNVN4Ms5kqMBBWm54o5dshri7GPeVGjwrcH08KDEk05IkVbV2N8
         wvIrGoqOARgVQdKP3Df+pq94o0CtddT4tlrF73q6KJTXABPp7PWawvZWLCWSyqWDU/gu
         QWbRCx8+V/mQtY9qju1NOQtwCyWVuULsi+/0CVouhQJtGvgwHq7LV4eC4TBRntrO2utf
         lcX+LqY8Nr/Edf/FupFsNsSWwodlE93ZYQAbf04YIh34aRWlpe5i3e/DJLy09eA55skt
         iJkg==
X-Forwarded-Encrypted: i=1; AFNElJ9iEYR0rHhHQrLPlDpaLJyf87fWyKiydRayDL5E6lJRNuae3ONu3wvL+g/sngfylGg+GblzR0839vh4fDY/JwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jTPz5hM8Ohs2ej5FN89WCSxUqQ7+MVEGQryMPs4DE7rr4D5w
	Qd+3rTjZpVvBojz2mqdf5TsTGtO9irZflvqq9WJxCmiwizWJQpWTXMrC/coQtXxwRgA07A/Vf4/
	fTQuT4SXkpRNqG2iThrLvbqBYmr27s0aOkg==
X-Gm-Gg: AeBDieuG1DMmaUBz//Vpd2LDIEZFoZtmQCjlgGnxGeVkbt3ZhbjIPfyxZ0q5HQEiLMX
	uqRU4VlQ3ROE8WoeloboODhKdCgZLHa1QoMOjWls6XIDhx7UxAsdw/pwpguMAC75s+hfqz0BKlv
	yGtkQnK8PFwrekhPAwCS23ajxYL9f+24Pzn8CPEppnyblWettnWvEZj5u/Ou6SiSeHcrbKy3dyU
	z36+m0xBLQIATvA4bKiFOWKOfZLHWfdeDP633YPFMTkGKpSCOa/qrjVYRxgKIeIUGhiGUaWEs/u
	Wft70VH6xsMW8rfkq8e8ni2CSQGzsnVhuq49OZpRTsfBUuTMio3svvxw/+ISfCbpVmz2Li6npXQ
	UI1GRPGzQ7vIDEIyJrw0cdmf7Hgef0u7bSWj4N8RShpVEOmnR
X-Received: by 2002:a17:907:3f16:b0:b9d:6d06:b78a with SMTP id
 a640c23a62f3a-ba418985765mr855604466b.17.1776813156675; Tue, 21 Apr 2026
 16:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313001608.118294-1-rosenp@gmail.com> <ebca61af-7873-4a6a-aae7-151e81b328e5@oss.qualcomm.com>
In-Reply-To: <ebca61af-7873-4a6a-aae7-151e81b328e5@oss.qualcomm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 21 Apr 2026 16:12:25 -0700
X-Gm-Features: AQROBzBcYSBBxPxgApn-xQFzTqpKuD71x22LJW6s29Kys3ic7Z6oH4hLyooD4wY
Message-ID: <CAKxU2N--N9psvqkoHetoz+o49ipBxfTT_gP23zA5Wd4p=+nDhw@mail.gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: use kzalloc_flex
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER" <ath11k@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 4:03=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 3/12/2026 5:16 PM, Rosen Penev wrote:
> > Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> >
> > Add __counted_by to get extra runtime analysis. Move counting variable
> > assignment immediately after allocation as required by __counted_by.
>
> can you update this like you did for the ath12k patch?
Done.
>
