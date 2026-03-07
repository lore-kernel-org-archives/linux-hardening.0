Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD8B34676F
	for <linux-hardening@vger.kernel.org>; Sat,  7 Mar 2026 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772870094; cv=pass; b=GxTJi/aUnFtCStZkhHwyhuXB306xckVyfFuH8cPKbD72lZ8zgqcbtbkAbmF9j3AlQcoSttJ/qezIcETTLHp6LEG2v3MzxffTmwDBTdGZdDS3XaS7eKvK3JKxiB2vYDWNGYO5r9O2/jdgY7jNeeYeDXt+ItH0eGaEV8hub9F71+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772870094; c=relaxed/simple;
	bh=QVnyD7hsnhP8n753bAsP3+qmoUZRR9RXleuCSQsSxKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxbSZ4bIMwgVFU+XLiSkesO0AL8u9+Mnx/xc3fpp+ASpztq5LU+7zhygOL3Z5vheFYILWlL/Ix/2O9LWSvbcplsXrLL8F5JM4BJRsHcpskyNNSseBAp+SSze6c6JOpSIdsUiZyh8Bdg/SxU4GkNGQsrfmyFP1cxSN2MDEf+xKWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFq4FHo2; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFq4FHo2"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b95c0fc928bso36739366b.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Mar 2026 23:54:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772870091; cv=none;
        d=google.com; s=arc-20240605;
        b=KrzAWRdBTRW1mJfBZrru/NBKj1o1sMEDRAqNUPVuwLa5zO645r8Qn//mVagrUSQcgC
         VP0ZkJOJzz+NDeWUsIt37qyU7umKSBbL3vSvpByp6FESNWkZYbVGzx8X7XYm9HJBELDm
         P6GuHyhzV2AjWtfAPIEPzyZOc+u8IWgrU2HwwZL3eOEhiTY4rrAa/XHwnHHNPgWArhv/
         kpQFOX/Qd5l4xBTMdlSds37C0vccGnzhX5RZgHMo8MoyFHsPbbfC9RXIKEdiuB1FAydv
         ldgFvJD9AmpzYeff1U5kn6jrQ2mA2aDadReYd1yNwVLXOnv6vF6+qMqxiT8fn4CQdp4S
         tx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QVnyD7hsnhP8n753bAsP3+qmoUZRR9RXleuCSQsSxKY=;
        fh=c0iH8y6ewd8eEBjFen0reST5+lfNBmY9W/Kh5CWzJeQ=;
        b=CdrTt/F8I5kPjAda/9eSQJF5U456Sq1IBK23vC+vg4Mb6XYXkez47dOsEyNLTxAcrw
         pG0UEMF7iZwCMFTsO4e2dE8Q1YclmIyoYvjTYooqu5RDzQfwexq411qa3eJqF+BGkApO
         XMSQHK5XH7dQqnuERo6UKgLjgEnT73oqbSm+9Fbmbf7ht8ZMXpnqie+ywUNP0bItDMxW
         xo8Jk1cUIPyRHidqf81XLRGqumdWH/xDfaHI2FMwgc3wf9pSwBBOKP2khfip/ypSorZ+
         HlwA0MPQNw1qX2qJA7CWG+Oj0+ykoGmOvxwwQiQxMU+7SeG+m6yEmQkReitAT6nBzVwV
         A5KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772870091; x=1773474891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVnyD7hsnhP8n753bAsP3+qmoUZRR9RXleuCSQsSxKY=;
        b=SFq4FHo2ONkjWPOn8LhIuP+UTXfYiCVEAjO6SIiOopsN2+Lvctu+hK+JtKSoGwOlaZ
         AH/Xz9BBf/N6Hs2fIJaqvwAsee8PffhfB6OjKHEd2Sqn8icWc9i1IJcyMPwHkk1yN7EV
         /MdzV/4OE623b8Yr9QT9x1nDt6D4ABFlRRkLc0K+vUqhmziN1flDGVmvHcxq80vaVJT+
         Z4XlnjLDvazLrzSBmTujIodvvCMVVVTymPr2NWq62xgsj5BZ3hMyqdLf8PnNxy8HjvYr
         GJOJ+n/9qTjUt4qiAK+0rYdXZvnr+2ANypNiFBzcAKG7iKOm8KDfKtlPkmOyDDQeIj60
         6FNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772870091; x=1773474891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVnyD7hsnhP8n753bAsP3+qmoUZRR9RXleuCSQsSxKY=;
        b=rMDgGz//60nyY0FJb7EZ/JqoQDslFlp/1Ke3KN6yxI+ERAWZ7tXIMF5+ao5eKZMsUL
         xql0t25XzS5Zrk2MTa+jZQRp0ynH1RAp8ENK34SSLUbjV16Dw96HwjUI5s5a03K4b9ah
         AViiw4NAj7vjvwF2TVJHZYub59/i/uN9vRdfMhOc7VtmhRDkHTt7QDEqeBb0trMFhDNj
         xvg97GkFyF6mSUxDb5gqdmtLcyXVA0UWj9hMJfm0W2NbWUrNRuF336v3x2th+3h21xrj
         UZ0bZnZCYC0YAEmmAUoSwrTDOBg2eIGMuCI0SQy1aePpCTTxj5C7rj9nUG6VGIvTpy3m
         0WgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOmzpIKJq0PhcwmjKaxY+IDZRyNtPYqIjb3KKB9gLCYLZFyPboNJK7visO9szQKJCAfB53GLNBJ6UN3aVsrwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKTx8XxPiv7I6mT8Z0nRdISqOVb+U7pcjU54woPSPPQHTBXqM0
	kLtgVbAUBD0bg3N/4gZAJVWZRPg6hH2gORTgDHyZMTOlXSHFF2nOCbxrUQWtrpMyU8Na8tiy5Rw
	u4VOHmyYvE+WTTim5H42aIKTN27xjbz4=
X-Gm-Gg: ATEYQzy1tRgzMdswcHRZsdi9+DsTRAUMMU6ZAgcQvvh2BNF0EAOFn4HM12QbWtavlCd
	dQe/MQK//ynfmu83ZbxO2vgUQG5LM6ZvI/l41fLUBUAxhHb7DZVLLtDWRhrA7HEqtBLhm5+iNqr
	0uU2kMGEPHVY02XR5MW/dVuWKJx93pHXEuHi9ahBdOfvbmkN4v3KxeuJydEqoGh+hovYAWwA2jq
	5hH6TEV39ZK0EDTTtmWkK5go7YqfDs5SgJWJ6BnXvCSw905DNJnyNmovzOnvvITQFGksPTAT0kR
	UlR/vUQUjmCyKDPRiKcSvUCvMZCsSCxDzZJyUT0jHoPA/A+GK6xyE8/5AUvywkIffXvi
X-Received: by 2002:a17:907:3c96:b0:b8f:abff:9cf2 with SMTP id
 a640c23a62f3a-b942dbce946mr291841866b.4.1772870091056; Fri, 06 Mar 2026
 23:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306222148.8200-1-rosenp@gmail.com> <2026030739-uninstall-blustery-a91f@gregkh>
In-Reply-To: <2026030739-uninstall-blustery-a91f@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 6 Mar 2026 23:54:40 -0800
X-Gm-Features: AaiRm51Yiq9XvlRO7Dr2WzRwUYi6IebGYs75nvZ3r4roy3Tw5wJoxXYuLTPNolk
Message-ID: <CAKxU2N85iE2_zWS0zLa=UcYBvOorqNRAqiwUvur1Q_qKT390NQ@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: qcom-pmic-typec: simplify allocation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:QUALCOMM TYPEC PORT MANAGER DRIVER" <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 11:21=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 06, 2026 at 02:21:48PM -0800, Rosen Penev wrote:
> > Change kzalloc + kcalloc to just kzalloc with a flexible array member.
> >
> > Add __counted_by for extra runtime analysis when requested.
> >
> > Shuffle some code in probe to provide a clearer picture.
>
> That's a lot of different things all at once, please do not do that.
> Remember, kernel changes need to be "one patch per logical thing".
Maybe I overstated it. It's not a huge change. By shuffle I mean move
assignments up, which is partially a requirement of __counted_by
>
> thanks,
>
> greg k-h
