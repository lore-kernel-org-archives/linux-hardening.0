Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F2386C31
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143434; cv=pass; b=CmqPtumAR5A4jt6Cqi1exSsrRyj80ppYOjpFZXsRyY6s1cvEY2mKIMj4Q9fUHqK+rMpeuH3FhurZUq9HwxKEjNlpjf35ZA1YbL3Szs7JBAAK2zYx2ZABokZhT9PXdTRVlDJKx5vzqH+dsLN3EGCjzngl0Dd/33EITxIhEMrGpLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143434; c=relaxed/simple;
	bh=V7ma49FkYJcCWGCL389vm+sTxnEVG3lw3+caRpcBK4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c24YARGtoeQJo2oDt3qee3/8V6cVKf9ZxGVQYRmJcgzGUzKCCLX0/VEQ6QOs2VBbGN4m+TeMs5cjkGUfpSZX4BYt8FnGeKYA/97a5xWEUFQ/6c7Ebnz4QWM6H6wuuB6z40I0n8WCZRTW3Za4Llvb9uDxjg7Hql44RZnWy6JIlTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnU3BZ+A; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnU3BZ+A"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67c2b4809baso978535a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 01:43:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778143426; cv=none;
        d=google.com; s=arc-20240605;
        b=jXLwHUWy/PZXwhN9xuqTSt1eB/YdB5bosCseTpJxadxsJuIMQkMQewn9v6sEnPzYsD
         scWRuLMYRfTj9UODJAJY60w2jcC7grmG3QN5ba/itpumREOqnre1DBoXtSJwBQyrQJg0
         VlPQeELvq0I22cl059KHd8Fjdyzmc27MQLmfRS0695bTHp6ejvKWGdXkRTpINCuSXPcL
         MqvSU/o2UhRQySbZG1/8JhXSI1N9gNj/be9ZwiOGb/8D4sgnfNbRuzwBAv+Clj2Q11lW
         tFwDEWpZMD6YXaKEJ00h7xZG2BeVcE4g02LNzcHEGSD/8jLcOjW8XoSeKNcoA5EaUvXe
         BlXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cPfGi80pkrEIBYkOE6vfVIEYDa38ruK3NtL9UiWIuzo=;
        fh=bhwndtBEh0NEQ0ZpsZTIiPh7Uy3DolBswLk2CEO16fg=;
        b=RTkIvY3mQg4kkXixvLtEsYy+xUamJH96M0uQfo8s4QcocEiq2YTRBzP/3+r1fXN7rT
         wmynUTTFa4nBp0Hy0P7gxJrQtV21sGLfcpwyo14Y2i40/K9T+LYhhBOfxvvLoOUWRL7C
         jL4QDReAuIuf9iyTh7DGN/JuViuI1BNwR1LTVItwDH4rYaP6ItqYgXzuIZIB/5p6sqXx
         l+siT7ZVrr9VI7L8D9rAUp5SJkdK3mZjUqW1+58n5VJPI6mn/bDn4IaN5hEx/FnZwgzk
         YzZSnvRfvbFATnIutJ24cDXOEIoZ6Sb+OmEyhXFSlItGCYY4Piflyk6g4wVYB4uUXl0/
         CtYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778143426; x=1778748226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPfGi80pkrEIBYkOE6vfVIEYDa38ruK3NtL9UiWIuzo=;
        b=qnU3BZ+AMX+fCls92OZ1QIqmpkgCoeLR8FZI5pZw/63xbzg/rFqfpn4Ax6wr4urz9u
         DQc0j6hDGLS/anviRyUln31c0i0IU/+LOl8sGHa0wOO/MZ1LZQyuJCui7vDW+sPCiyer
         maIch84YbySfjwkFo40QXbylPQYopknaN54/WwPFHvVKH/sPUBYYTbPp85oh9naofQZA
         pCN4zdUk+n2yT7X2v9p061a2AbHVN5QAdt/C31j7PAJfW2eLHYlIEcafSn4R65IYGPyV
         YdmesX/7Lw7vL/CowFX/llMZ2v+W9EYW2bO+6p1iDOI0Z1FzZ8ipNvopmS8Rpr5v2jTQ
         D2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778143426; x=1778748226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cPfGi80pkrEIBYkOE6vfVIEYDa38ruK3NtL9UiWIuzo=;
        b=T4ZdX1AVfbxWshkGrbZBvwfvEHX/2DGu/1VAjS/yoXjlXWQZ0NXgbpC9BGlf6aSQ8V
         iW4BF/RRZSe45NL6oCQ9AD1NrJuy87fIJZ9uM3fT55rKyoQ/oWqYDcNvr16/OONzdd+s
         5N9R9QVOa70Sts5V6KUb/Kdf3iozXuLFibd71FtVo/q1wwKWyY4Oc7LPJLxrdX4ffgQc
         +SdevKvySPlsI/fFEvTNaIn11tOrWFw0/n1F0ccxwcVncwVejCem1uzqMebU7qJtgzHI
         yvOY8rzmD3yPOPuu0ZitlkOt+uPXITaJBgDL+iY9Vdu8uOXnNjUpnOb4yEyjRne4lZye
         MPug==
X-Forwarded-Encrypted: i=1; AFNElJ/1nKkr52JPGLFYY+8y2tV6KVvj3WCYOleMM/c+82OpnOzyJwF8lXYHSHyXhqVxvHHcYMPNUSontAGjuHAhDjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlWMWBRcDEiE/30CC4R+ql9peOS0YUuUgfYqO9XLAcyiuitltp
	eSMIqOo+EGKCfUF1eCFYYHzan3b7XitkVGRJ5wqCXxEFXoGEeqLjbDY8lOfH9agr8pHhRUucgzK
	JkU6OkJ5lytrImPGNlM9uttt5f6+PoS0=
X-Gm-Gg: AeBDietsjvjVUlCRSKKfVyJuLbCcw4bjKZXC48Ue+o10PBpGu0QNoOUoF04OETXIE8P
	u1HndopI0Bp3F2l3ULU2CjdeKHiAi/Eq9mPC9P+b2L2Vp2fkaGwhoVsaMxMOUgZt+8gMQC90w49
	AfFsNjRJ4MFHwMmf+nxVox/JiGPxPFcjwVwOxGC7D0FRV9AKOLRSWGRPp5SuOIxF37o+yo3fuUh
	+gQaVyx+zHpmpc3/GoEmJUohv5xZ+LrAvjp5nBCwy6MYwKVS31gHIGksr9WufkRDsQxmPJ677Sp
	ieWyIVqaFDMF9npyzYMIjL+LdlDQkp1ZZ5K8ppMKJD1PyU28SuqvlsoVqd7Ho70QtdcCqsDYBKg
	YvkQAxJwk3PIM4murqKL5X9Ob/oomWlegflPUwbv0KNiQd72s7P7jIQBrjvpm0OZIgi5j
X-Received: by 2002:a05:6402:540c:b0:66e:43ef:2951 with SMTP id
 4fb4d7f45d1cf-67d638ae7d5mr3725735a12.4.1778143426001; Thu, 07 May 2026
 01:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506233833.178357-1-rosenp@gmail.com> <4c57b107-e1eb-4eef-ad77-021d9669900d@linaro.org>
In-Reply-To: <4c57b107-e1eb-4eef-ad77-021d9669900d@linaro.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 7 May 2026 01:43:33 -0700
X-Gm-Features: AVHnY4JM2dxCd6zuxzhCeNAz9P3fP-g5qTDGdrW5tuHIZgkThcJR8iARdOQf4HY
Message-ID: <CAKxU2N-kx+rOibE1uc=gAOSFPkMvv1w6nZ9nkPutY-Lq3zEQKA@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] clk: samsung: use kzalloc_flex
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-clk@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:SAMSUNG SOC CLOCK DRIVERS" <linux-samsung-soc@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 1:33=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
> Hi!
>
> On 5/7/26 2:38 AM, Rosen Penev wrote:
> > Switch three structs to flexible array members to combine allocations.
> >
>
> What's changed in v2?
Fixed compilation by adding back samsung_clk_alloc_reg_dump as it's
used elsewhere.
>
> Cheers,
> ta
> > Rosen Penev (3):
> >   v2: fix compilation and reword descriptions
> >   clk: samsung: use kzalloc_flex
> >   clk: samsung: cpu: use kzalloc_flex
> >   clk: samsung: pll: use kzalloc_flex
> >
> >  drivers/clk/samsung/clk-cpu.c | 34 +++++++++------------
> >  drivers/clk/samsung/clk-pll.c | 56 ++++++++++++++++-------------------
> >  drivers/clk/samsung/clk.c     | 11 +++----
> >  drivers/clk/samsung/clk.h     |  2 +-
> >  4 files changed, 47 insertions(+), 56 deletions(-)
> >
>
