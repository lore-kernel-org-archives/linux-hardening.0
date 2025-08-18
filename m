Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B0D24DCE2
	for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533891; cv=none; b=Xxj7VM1ckABIgRn9S7CqOqA0/NfQZtgiKGiOQG+jspyC/CxMNWBLabSPOxYP2hicfxAj2W8JFR7KvEd5K3cw6ymnFQPz9MWgW7yy/AXS2N6wpYVAc/9+0age/MJkNt5IFFIwWszX8oCi+CvWiit/vzD7+vuaikTt93/x1qngSQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533891; c=relaxed/simple;
	bh=PdOuDtGhAf176yTG7bO3k8fjbVMpdEjfYrDODLaCBC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMUTaiHFuFN88imQP8at0bZ37KgCqoXEEbnwrlLjyB6C/lUUFM34Y8fUxu+ngs1P0SbvqeEM4pZj1LX/sPGw0iOaw1PkVL9TKarXlCwEZt6JT+9JydwOHkm0g6AqVoYxqoM7olnDS95f9RAsDX/ZjpNL2Vt/DDtgkfbprO386rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h+s19oof; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h+s19oof"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2ebe86ecso4933362b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755533884; x=1756138684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSyqJhkRW/MDWE6bia3ikOdWhAKQSCvYd+GVVssfN+c=;
        b=h+s19ooftNZg9xhcMsBv0r7f2MqZwQhuJMWkP5bX7KF4p60dUpGAm1+sBvXjE3QWzI
         lYUnq+pAuml6UIsFGKHMBLng1r+Fv8eTZ8abLiYI/vlhc4xFVP9KtUhu2BKsknEyfF6g
         l/7+gNOr5CQi0nuQPDNvf9Gzw+0D3Jio/Ko+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755533884; x=1756138684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSyqJhkRW/MDWE6bia3ikOdWhAKQSCvYd+GVVssfN+c=;
        b=lQFBMrPbMtbWO8qLVkPE+uGRrJLZpLyuXp3Orq3TyP8MYIoVcFdLcv2NCvCAr0d4Gf
         IwMxTgeiBjhq/q1nmzr50NsF5fd73eLuu7WSE7RqhJa13NmaA5MujtuhWHBdNhuF5oNM
         6hXKdWez5R18SevlqU2jjn45r/H7qLuGeaQnqanO6nhecCO9CaJyPHIqhSCbYYP76DeS
         o47gjzvZchbgFIeZUEog2CHjlZGTm1Ryn0Cy4MyiNJaU0tTwcRFdcZwAy8XSHUuZZcEl
         8klclDUtR7XnWFMLGpHCV6EZyKfWMK9l8EFM4uGbuDa5VXiZBEFxYZ/vcc2iZi6Fq8hm
         E6lA==
X-Forwarded-Encrypted: i=1; AJvYcCUJk5PLudu7El/jLbgkzRGIIwdM0+wCb7pi1SHhjlaCgmGoMIhdfHDCjlUWFslGhGGrdmDh+2DRzFMHVTJdiUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTuS4FbKFt1WDkBFENJAGcJOcBnKSTsR+bmkLM3TQHu55Qv0ke
	SzoSRqd10tWVQEGFPJIHSEYABJMc00qRpiXDTV+vv/TJrjvH84h57Oh44qnp10qzXosqDcumXKN
	kxwA=
X-Gm-Gg: ASbGncvPGQuEbH/WpAMGiVKBu3TAeXkddo6z7WLek5TsR4czLKTcdpOLOuNS8558NFV
	BHnNJq85+TcxPAqUnwwuDcEDlK1LUl9GPHu8XeZm93/ztPaySTgxehvGCZbKWxLO+zkC/nCaq86
	8QVXgvhsoG2+3I2AKQ1vwXPXidkHjPrS6ZwiCt/T4dfWIyC7drMZAoNLh6MQVVAFKei2O/st1Tx
	CKRb4xyVkGXWIeDiWFjEcMafbCLzctjQ4PTfEhr5PAZzMXRXHVNZWHE+IvMgA7iNeYJpxNWyvOF
	i4jxiSBmfSWNVf9kjBeBdDYlyq3/1gT6J+gupzi5NqK3VjZfxeH3CPr4pTYpPW5GXVMnA5on2ca
	694HJ0IO1QqOWijxO4NKqB2XtDSjmOcH+JWKNAypatuyINDvlzmLF4KvG61AdklPHDw==
X-Google-Smtp-Source: AGHT+IHWRfscBFkpIaE9ukd0c/QNnfLDa1+3jePJkka3bkdkOWfwnW/00KBGZr6eWTAKaqlHgNtGMQ==
X-Received: by 2002:a05:6a20:3ca2:b0:238:351a:6442 with SMTP id adf61e73a8af0-240d301be61mr19185109637.45.1755533884567;
        Mon, 18 Aug 2025 09:18:04 -0700 (PDT)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com. [209.85.214.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7ccfa8d1sm92242b3a.0.2025.08.18.09.18.00
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 09:18:04 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2445806c2ddso36986425ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 09:18:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbRvyYMYZEmEVg7TJ7SFq/JGZaRGZxeQNUcMNjdhprR8R9xGNVWelgwM+/8KdJnAqotV9HeQZCsdqIaRPt/sE=@vger.kernel.org
X-Received: by 2002:a17:903:b87:b0:240:80f:228e with SMTP id
 d9443c01a7336-2446d93d8dbmr168541425ad.52.1755533879674; Mon, 18 Aug 2025
 09:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213725.348363-2-thorsten.blum@linux.dev>
 <CAD=FV=W1tgwvajXD6mcggHKy=Q7EN8wLx4nSJgy0NJBzHLBnSg@mail.gmail.com> <A627E42A-1F2C-4807-B2AD-089D94FCB210@linux.dev>
In-Reply-To: <A627E42A-1F2C-4807-B2AD-089D94FCB210@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Aug 2025 09:17:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WtB7BB0vo9FDncgCraCwLMZyYZHYKhs5BprzDcHYQFWQ@mail.gmail.com>
X-Gm-Features: Ac12FXyuTFomjGqpD0gstTADqywrtRi3JiXkcPd3XuZbN_O76LE11WCVw65yoBs
Message-ID: <CAD=FV=WtB7BB0vo9FDncgCraCwLMZyYZHYKhs5BprzDcHYQFWQ@mail.gmail.com>
Subject: Re: [PATCH] kdb: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhang Heng <zhangheng@kylinos.cn>, 
	linux-hardening@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 18, 2025 at 4:03=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Hi Doug,
>
> On 19. Jul 2025, at 00:48, Doug Anderson wrote:
> > On Fri, Jul 18, 2025 at 2:40=E2=80=AFPM Thorsten Blum wrote:
> >>
> >> strcpy() is deprecated; use strscpy() instead.
> >>
> >> Link: https://github.com/KSPP/linux/issues/88
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> >> ---
> >> kernel/debug/kdb/kdb_support.c | 4 +++-
> >> 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > nit: Since this only covers things in the file `kdb_support.c` and not
> > everything in kernel/debug/kdb, perhaps that should be in the subject
> > line? Maybe "kdb: Replace deprecated strcpy() with strscpy() in
> > kdb_strdup()"?
> >
> > Other than that, this looks fine to me.
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I'm preparing a patch series for Daniel with my kdb changes.
>
> For this one here, I initially used:
>
>         strscpy(s, str, n);
>         return s;
>
> to replace 'return strcpy(s, str);', but now prefer:
>
>         memcpy(s, str, n);
>         return s;
>
> because we already know the string length 'n'.
>
> Can I keep your Reviewed-by: tag when making this change and submitting
> it as part of a patch series?

Sure.
