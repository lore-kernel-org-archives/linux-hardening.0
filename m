Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2D370D57
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772777980; cv=pass; b=jVdSvIVkotX/JzI2aGSyyx0LBmEOvUWddiBE13XRU2mdhDIDwQAzuIgflrn49uGzxgzik8bJHzZY2ZxPuinfl3GmPD9Shx4qQmrrYVGezRZTuVUBoS5YPl9cOx5nxxbsZJbbiu5BUop3EIZ3iqB0FfBQo73A/nCQQM6qT0Fjueg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772777980; c=relaxed/simple;
	bh=P0VGWiHF08Hb/LHLPzScyeOvbLZVakbt6uUzSBkPJkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkgyJ0GrCnD1DyBpFcD0oSLmvGe7w4Fbi0cywlPQaq6+/ElArzYAAg+q4cClh/Yk12iReuyA9YmAj7n3kQSmEJ5pNGB8ujHxuZYNHpVwERmjt8iX+vuFvVm1DtGs3ULybkJf3MJBj/KdxU4ZB8kvtMT+lzNDpgC83QdV/gOgF98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wk+XzgGT; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wk+XzgGT"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b935b8dcab7so1396994666b.1
        for <linux-hardening@vger.kernel.org>; Thu, 05 Mar 2026 22:19:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772777978; cv=none;
        d=google.com; s=arc-20240605;
        b=TDBh/MF0p+zxeonoX/YEwYavq1RDyPFVWPJ9LNA7elJIOYpXSq7PbtN3F8iyayBMmh
         pfZCOHVp/ArJ6irTJjvn5sIqk0DFf1ChWV89TKsORyIdhXkEzraP/OtR/oW0S4POwQCx
         dUbDDCtZAdkNcZ1kjJ4i84W9zsq2CVQXbmtUFJExJIHKPjouy9Z8bHhl54za0yn4HgmM
         lOdTEqPkP3acDAMHCItgXMGDqD8gV4cFqcdRp+3cYs2Vmrhvw7ZkmgPkihbCsh10oMus
         T2vbywQqckimEln6LVniIiOP6mPbHw6K+RZb6iWFsZVKWOHTiqayNN70JAgs8jMu56nQ
         5rsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P0VGWiHF08Hb/LHLPzScyeOvbLZVakbt6uUzSBkPJkk=;
        fh=R20R998mW2gpbREzk43uLOFsRmw76xEyGLjT4wSXkV4=;
        b=EkhmKnMsIpqLn/eSL23FFdZRPMmbevQlP6axTNXGPeuNDPyq3XWn788JoXnuVeTsHS
         sbOEMr4+HhHRd1H0/XNN/J1a4LG7Vsf+l4U+irrK7zRGi0gu+Py23EN7ryO4SodgsxGQ
         n3WaCYuMP2Jajwc/ofHUuGLZbyKr8pBwhUxdCra8bvLMcERurEn4yP6IadyCct28kGaC
         hB8COhSdfHijrWJWh97AC3m6IGAAF/xJDtCm6iFJdmR7TnPqRmgkdv5FUUCb6p2kroOP
         TnQrOp69MNdTwb2JW7KzUqywTUPQY1ySXfReZBttZEmpzN/yGOGoT3ilPHXZFxsOmIFv
         9JOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772777978; x=1773382778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0VGWiHF08Hb/LHLPzScyeOvbLZVakbt6uUzSBkPJkk=;
        b=Wk+XzgGT0L6XZ8jL8ce7A/Rjr9z8scgkIA5Eg04VppfqVky6hpibzKxqwlDMdFkHJh
         lBBPERs4VjeiN3+G0sVE0FO9m/+1BZIzai9xIfGAYwTYHnExOq4+vdPPSKPz9qQrZdGm
         lJ25jrRKEiGVLtVxpOy/vwwdqgqoPqQFILfnro6ZyRvxA0c+6x2twqqcEze1FjdjLXp4
         wIx/oM9QW///v9oZK8CIM5C5n2uS8t4+XgWjGbz5pHY6e6Ay5zBTMDc4m/cActPvIn/X
         uzZN/TCKL4YQfcLsO7wI0TOnYztkVycCEDZYc32gZ2uQc0sB9R/9Ovyprrx/TA7QaKbY
         mioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772777978; x=1773382778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P0VGWiHF08Hb/LHLPzScyeOvbLZVakbt6uUzSBkPJkk=;
        b=bNbz1cvs9bIFpZnEeKncU1lc9yjmue1XHppbTt/NJKPVXsIkvAa8j4tFYLLW+Z3TqR
         1CXfSD+LLXEQNLjsLzS4pSJOf03JtcOtc6PIHx9CUoyMBNRDHx/HMlagsxiwaKVC9hW3
         PIlu6aWfCEMg5VgBnKJ5QkV/+mMFaBb/T6TBPOu8Ep/QQoxUvPekWxRSHxg9Ny9UbxTN
         19Vn/MvF7ucyX56A+hc7CJSzkXDHVb4QKCL/6LuKUzYGGxxTLZ0YE8pTyuJp8j5b/RyA
         rmK7Pf3XRY0zn5Gt1Ee7odooJbZ8Ze8xYB/D2RPi+lxl2KStME/fqhMcO/PA8Y//H226
         NWzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP1Ak/38d7QU39HQUqP27t2exP0OWOSaLVo8KqSbccRcTofd11RDDiSc3uipwYj1f0J5b16nP6xVg9VhYY3yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyngVLhPu/o1YVEkMMjZE8T765WgcLHh23QsaBBRC449GZEbVBM
	m5ywqRADHm0OzeVrYi/8V07v2PrUYsimrjRg9I6gNCLcDV8qt4BPpBG4S5XKudJyQMhMYRUNb5z
	OSm4AuKqoGXEmfRJCY+whpO1155hpXUc=
X-Gm-Gg: ATEYQzwvu7N+k7sXJ75CsoA0pZyrDiSqGI2Gp3r77VLEjKyN+XvdewxrfiuLHMcsUgi
	Glr33u4L1q/HQxvV/Sgb6gSf7ILqC7/GnhQE7+AoUGWKyM4S6U4JujC2X13p1vheUKKzd0LS570
	OrNH16VUVaTikdfWFcTvjUKZ28bCzwJK3CoL+iZU/QWR+jYrbjaHhyYiVQntLc8onjQD59Txp11
	Jg7nelc3ugjZaVnxgcFcGpKbGWzO/INMZzRSeUbCyFSlx5chDH1kgtuNcycRCnwv/2LmOavQM1j
	7VuQWJ7vTG0Ij44ZtZqmskSOsHING2JT5+k49squPN43HjOb9/B1PuMlTdqNT5LvpuGJ+MMWoKY
	N52ovMA==
X-Received: by 2002:a17:906:f5a5:b0:b94:244b:2ba8 with SMTP id
 a640c23a62f3a-b942df74e45mr44939766b.29.1772777977596; Thu, 05 Mar 2026
 22:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306044536.149204-1-rosenp@gmail.com> <aapiBcnPHa3eDLN5@lizhi-Precision-Tower-5810>
In-Reply-To: <aapiBcnPHa3eDLN5@lizhi-Precision-Tower-5810>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 5 Mar 2026 22:19:26 -0800
X-Gm-Features: AaiRm50x7YMCKK1F6zYGE3uuqGNee--50j1jpnmhfHu0gWe_LApncHVHg97bcLc
Message-ID: <CAKxU2N9TyRe_o6zj5pNRdTR65BgZZ6brsgRuq0Oi1EFvQSCiVQ@mail.gmail.com>
Subject: Re: [PATCH] media: nxp: imx8-isi: remove kzalloc_objs
To: Frank Li <Frank.li@nxp.com>
Cc: linux-media@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-hardening@vger.kernel.org, 
	gustavoars@kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 9:11=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Thu, Mar 05, 2026 at 08:45:36PM -0800, Rosen Penev wrote:
>
> Subjest: use flexible array to fix memory leak
>
> > Use a flexible arraay member to combine allocations.
>
> typo array
Will fix.
> >
> > It looks like pipes never gets freed anywhere. Meaning this effectively
> > fixes a memory leak.
>
> Remove "It looks like". The pipes never ...
>
> Because fix memory leak, need fixes tag here.
Since its inception. Lovely.

That had no struct_size AFAIK.
>
> Frank
> >
