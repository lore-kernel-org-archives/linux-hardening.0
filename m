Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B01A5B9D
	for <linux-hardening@vger.kernel.org>; Thu,  4 Sep 2025 05:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756963653; cv=none; b=hm33M6L8kAwAn/QxK/ZWE796mE4VTagY6PqvbOFhZNT6aJJazgKkHsiQzzTwBtTtVthf8nVpUJPoNVvu0TOBXLEsoExyv72iOZhiL1jpP8BNO9akeWDuKhnBaa2DWXcwYburzQsTaLWgxlQulJkC3R6VjP+qd3hXf344ZedY650=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756963653; c=relaxed/simple;
	bh=k/Cl0xpHXpkVh0NkQiCfWcYKbfEJ6p6jvQnYvAV2tVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3bFOLUYQg1AALsjGdevyLXv+w5BpZYycwWOj634xLmJrgZ45jM/1Mq4ZhgUYCXXWUT4zY6V/w6a7mJMhObw3vdtU3ColSipTAIwCpYizG4dSNmmFXAiAO/7xO+h7tOXJbZ3qzCeCvbhs9k+igTgWemt8Bkdg56DR+rl4Lr5aeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hS9FFr2T; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hS9FFr2T"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61c78dc8b12so118568a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 03 Sep 2025 22:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756963650; x=1757568450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL6cim7lJmQ6AxtssWEC3Fz/DOLV8WOPsE/+05ZC+Rs=;
        b=hS9FFr2T40d4GuxcGRPFdHSpa/8tvzpyKcur3szu8eSPobVvjjY5pzUcpoMiqaRiMM
         8y92GGUyElHBq8cH0IBN231gkHa32VEDQrPGlNsQn4a5wa6zRLLC0QojcI6bPot5mZpL
         mqM2j6KfksKfgiIJUz8hPdxUyDgcDCS1V0YHUNe+G/m/2jRUXqK4QGvkq0kYO0Sw0hZj
         37b4xGES+x6YyS7xXZumUw138mqNT0jL65yaxsb6FKloYdhK6gQ6biABO96J7Jw2xvSC
         Z4m64vuKwc9pg03OWmR2g3O2h2PV5SfExu4reqKx2a4Nf+eZqYmQhaJO/UKQhFrFCxT3
         JknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756963650; x=1757568450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL6cim7lJmQ6AxtssWEC3Fz/DOLV8WOPsE/+05ZC+Rs=;
        b=TUC7dA+YI7WO1E7oBw3SBjGbV3F4ZPOqF/dW5hzl92CutYS8S9WeR6dilMlCH5plMP
         wpKzUA/24egWyxHSjsfU3XegDiyJirrSdfMhvNfr0YA+gmGYKf6m3ws3o5yWt/gukKea
         jrEgoU4TIJXx2ih9hGb5HNCw6wt6leI1fTayBpM27UkUxVJ4GLBNytWcK+TJ6QV6v9qN
         qxjlUArNcZjJUcRItFp/qb/BDBlw7e0/lE+wCrsFpFKJBrMgGw091QRBGQMRnFuDYb3q
         P5AcUnGGIhxKxkz6R32r0ApbNvJLca4xnVrpiqe9FL5K8/TlukZwKHURIbcwavpDnSGu
         vqcg==
X-Forwarded-Encrypted: i=1; AJvYcCVjyHoemjcIkF+VROpJ4IkBY+AN6NS6SykG3gjruF0CFFPuCEDXnB5JdFKVmA60yAcDluWQWnAC+sUUrKzK5vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuk01lda53sTcBKMwY4emvr1NQKElKliUY1oae1Spb2bhDXCXH
	h6kq1XQOfSmP+ZL6++f6685Oc9xAt2Xdun5I5Fhh2T2QQa+YbW0FtIthU4sZkvzfToCRKTHkKKf
	IEsmGsAlNhUYMiwbsBSVGosaRHMdqI20diw40MTTiWw==
X-Gm-Gg: ASbGnct7CFvz+N8rQYjvVQ2N4fg2IlMbPQ5i199LxU33fAvhBmNpLmPq/QfSy2Em3Wl
	mYhLP+Ncb+0mx49+ToU7dMkEc6X/reHgX7pkRViyzg0MyiP0xZVgDN3umpEttf6yB7eBJviOMQv
	m/oRjYQwln2ZnyhPre/PrDTjkTLd3+Ro1to/yn435+/yuOyusaCc0ro5b3buCkQmGBdEg64l2zN
	/s6QmKYMNncgF+K3s8=
X-Google-Smtp-Source: AGHT+IEDfQsuz75secdp8RUnbsBImr6NlNozZ+P8Ogn3tTt67Al7ENn2T1IBsCum3ICV+3M4BaQv0iuqv4AzHGhSAp4=
X-Received: by 2002:a05:6402:34c5:b0:61c:bc96:7164 with SMTP id
 4fb4d7f45d1cf-61d0d5e36d2mr9471320a12.5.1756963650114; Wed, 03 Sep 2025
 22:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aLiMoNzLs1_bu4eJ@kspp>
In-Reply-To: <aLiMoNzLs1_bu4eJ@kspp>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 4 Sep 2025 07:27:19 +0200
X-Gm-Features: Ac12FXwu88MhUiHzrW45DiyG81OffV4ff8_lVgIAGwt2ZAc5wUFldikSYJ2mD8s
Message-ID: <CAMGffEkaWqURTV=7mmcH=Hce_8Ra2ch7Bs3koP8+NjgGAVm9aQ@mail.gmail.com>
Subject: Re: [PATCH][next] scsi: pm80xx: Avoid -Wflex-array-member-not-at-end warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 8:44=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
>
> Move the conflicting declarations to the end of the corresponding
> structures. Notice that `struct ssp_response_iu` is a flexible
> structure, this is a structure that contains a flexible-array member.
>
> With these changes fix the following warnings:
>
> drivers/scsi/pm8001/pm8001_hwi.h:342:33: warning: structure containing a =
flexible array member is not at the end of another structure [-Wflex-array-=
member-not-at-end]
> drivers/scsi/pm8001/pm80xx_hwi.h:561:32: warning: structure containing a =
flexible array member is not at the end of another structure [-Wflex-array-=
member-not-at-end]
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_hwi.h | 4 +++-
>  drivers/scsi/pm8001/pm80xx_hwi.h | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.h b/drivers/scsi/pm8001/pm800=
1_hwi.h
> index fc2127dcb58d..7dc7870a8f86 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.h
> +++ b/drivers/scsi/pm8001/pm8001_hwi.h
> @@ -339,8 +339,10 @@ struct ssp_completion_resp {
>         __le32  status;
>         __le32  param;
>         __le32  ssptag_rescv_rescpad;
> -       struct ssp_response_iu  ssp_resp_iu;
>         __le32  residual_count;
> +
> +       /* Must be last --ends in a flexible-array member. */
> +       struct ssp_response_iu  ssp_resp_iu;
>  } __attribute__((packed, aligned(4)));
>
>
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80x=
x_hwi.h
> index eb8fd37b2066..21afc28d9875 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.h
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.h
> @@ -558,8 +558,10 @@ struct ssp_completion_resp {
>         __le32  status;
>         __le32  param;
>         __le32  ssptag_rescv_rescpad;
> -       struct ssp_response_iu ssp_resp_iu;
>         __le32  residual_count;
> +
> +       /* Must be last --ends in a flexible-array member. */
> +       struct ssp_response_iu ssp_resp_iu;
>  } __attribute__((packed, aligned(4)));
>
>  #define SSP_RESCV_BIT  0x00010000
> --
> 2.43.0
>
