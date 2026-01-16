Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2C2D8364
	for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 23:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606523; cv=pass; b=AuoPtwExPiiZyESQatEFXRuhvMptRdIgtDHdrx6yZptq+7edZriY7Gm2U0KsdK9zEyAvRCir8+pxjXzTFRm3jBwRCxjepZ/xIQBhbXtciyIurOesaNBVWcbjXW/4ujaMK95DlFCdyOIH8iqvy0DGxGDhY40ppYc7+1ixWPY7JOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606523; c=relaxed/simple;
	bh=x8FFDlF/fesOWEb5mpSebQwC7vWTQTshDMbtChx063o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSi/CrJhx3AR8Ac89H47Ut+o3gncuO0m2aZB288wvlwKGPnTdbd7BtCPa+FN5mLXNEAEgHBJ7NJQphfwzP9XDlQ49p4uJzKDT6kT3iliTIOYIayvy5M9qhtKKZv13VChYgF/NFhMVsmo+h08E/v+fvFySkmjxAKG2vY2fh8IiCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78fb6c7874cso28175227b3.0
        for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 15:35:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768606518; cv=none;
        d=google.com; s=arc-20240605;
        b=QC+SM/kwurNj9alN58WfnAchmIHD5FwxPhrJqnU82shFHeIqtD4txBGXOyArBEW+su
         XUp9ijd3q4od7b3v7CdbM+uPVYQOWZEnnCHgSCO67yyTNrNGR+XQ/9BLVeWXePmWFZXV
         E3HXCrcfd8J42i+QEKE3WGepTq20U6jJXsU9vsklIyBV2y4Ro5JeqTajoVNhpdPcOfi4
         Ap5wbPdi7oyvQFrMR4rMsvFNRLJqraYz7pbcKm31nyhXTPYxOn/GAWkDlCNGYxrvZqiA
         9tgIl0blX5AUO5ce4ISeZs2j24RwxtwK72hA+i7FYs4CcRF/q7FhozOwT339VXA3heSm
         wwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=nVvMcHxFKWpFeIwQX6rcqpoxp4jR1OruPjaEq0/Db20=;
        fh=rKAqUM65bM51WpWKavT06vSbEc3KBe1YBzmV0+EviGg=;
        b=OB9dNPQAK90Q1ms8bqL8G9dl+cisASXgbFXAZvLfBNBTC4Nnacsxi7l1Y6XVJlabXZ
         BiBrh9r5DFFBvsMy2IzMJWzSjZrsFPaP1CgspRJpvalJRRqg1dZnLHkBIGuY4hXZzPm3
         PyZk4uq/HB2kMV0bW5uI9C0glEqtu+jtTpKjtdYB9EO4GPRSRRjo1wQfuyMWl3U7x9A2
         6mGr1fLfBv8R1araTf1BaRk9QuWbH8UuRK0qvI/QFb9MK0q5+AjXDWr7MCxEe2R0nRoF
         uViH+kTT9/ff8TOM0VOKRR28SXhxOXc6YNH+gwBQifzEmVmYTzhTaDJve+B7awLEBwBZ
         jVlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606518; x=1769211318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nVvMcHxFKWpFeIwQX6rcqpoxp4jR1OruPjaEq0/Db20=;
        b=eETarQubH3EHarFRL2vjlm0unaqdY3N5N1vVXA6/mdlyb5NARnwwzwwh7lX8ZZQT+Q
         +c6DZDMjX1ZND8PDBAAhnw6dBf1vHCSTS0LmnNP3aGGr4r4JrDOcBKr5xFGEWAQyLi94
         AHulTzKk7NxTdaEj1fDnkW3txgp3IG1RYMEZI3ca0D4bmYXVVp/ARy77uOME9eZc6sBb
         B6LQlGr7KMACyCpqhxe4/tEhnwgzCSR1goR3qvjgowLSDXs3de4VpvciTj89k5ArEQ/+
         SYs3K15UUUjU4O4zGdbCE8ax6s5IJUpope62LLrRXmhx0iFz61Fwt3jYO9LfEPlN2p96
         p7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUlDRqsXIpXdXgzxxQItV0IpZQcw4eCO7ImFlYkbKyfBdu6/NoMDRTTC+UD33kD7U3/Lukx970VSXNksBGyJ/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/YK80vOhBS1XqELxAgBVtXdaARv02X81bFnetfYRKCcPUm7y
	Huf7OK1cCvE6OSD5mvI+4rACQlgTLHlpoYt7somh2LCDlgy/+pZbNmj0EaPh22u5F5NReABG6Rg
	Vx79PCZsfD4C+n2FRhHgUsmhUfABH7/V4WHk+nVvqwg==
X-Gm-Gg: AY/fxX6OEzVdeoVk6TSzLboG77TTFUOwhMNQxapt3lJoRHwT7eHXfnEIhRyLaDOjqHd
	EQpGr6Ufb7W6PcbBiV0qxkgXcdr+iu4AtIiuKvwJVTnJh8pEzmqiX5FXrjHa8Chy2Aph4dfAWaO
	isMwneqOkJcQ5klFEF0dXVPMURiaXd5e3S0qnY0lz7FWtrRIbI4QTcgjzy6EQzkVI+Z3GZbHLuq
	pOt4E/Y11BXNH0LA2uhuzYtcajZ1MA92mqMptkvk8NqLNXINyxdftQWE+YBiqKcNaXpFmYzWoip
	t4QnFMQHrNdmAVZ3ewwn5Fg4EpfkGZEIZW741TEZad2SGu/iOdT9+vac0Q==
X-Received: by 2002:a05:690c:ed3:b0:78c:10d6:1e8b with SMTP id
 00721157ae682-793c66fed4cmr36954647b3.26.1768606517669; Fri, 16 Jan 2026
 15:35:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010030348.it.784-kees@kernel.org> <20251010030610.3032147-3-kees@kernel.org>
 <47a2f0c7-c25f-4734-840b-fdefc2f3c4a9@kernel.org> <aUVIlvOSvobrdrKV@stanley.mountain>
 <bf5b9a62-a120-421e-908d-1404c42e0b60@kernel.org>
In-Reply-To: <bf5b9a62-a120-421e-908d-1404c42e0b60@kernel.org>
From: Chris Li <sparse@chrisli.org>
Date: Fri, 16 Jan 2026 15:35:06 -0800
X-Gm-Features: AZwV_Qi7IfV4loLjy6_M4Wg9pj-bZgstydRyU-pSfKvInieL_J8lQ-37srUWiOQ
Message-ID: <CACePvbU5Pqo=bw_j8arOq16o1JBOSwPtuMZBVozy4FV7YsSLGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] module: Add compile-time check for embedded NUL characters
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Kees Cook <kees@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Malcolm Priestley <tvboxspy@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 6:59=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Dan, Daniel
>
> On 19/12/2025 13:44, Dan Carpenter wrote:
> > On Fri, Dec 19, 2025 at 01:29:21PM +0100, Matthieu Baerts wrote:
> >> net/mptcp/crypto_test.c:72:1: error: bad integer constant expression
> >> net/mptcp/crypto_test.c:72:1: error: static assertion failed: "MODULE_=
INFO(license, ...) contains embedded NUL byte"
> >> net/mptcp/crypto_test.c:73:1: error: bad integer constant expression
> >> net/mptcp/crypto_test.c:73:1: error: static assertion failed: "MODULE_=
INFO(description, ...) contains embedded NUL byte"
> >
> > There was a fix for that posted.  Let me ping them to see if anyone is
> > planning to send an actual patch.

Should I wait for the actual patch for sparse?

> >
> > https://lore.kernel.org/all/20251211175101.GA3405942@google.com/
>
> Thank you both for your reply! I didn't think about looking at the v1.
>
> I confirm that Sami's patch silences the errors on my side. Thanks!

Thanks for the report.

Chris
