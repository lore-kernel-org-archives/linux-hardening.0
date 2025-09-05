Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54612874FB
	for <linux-hardening@vger.kernel.org>; Fri,  5 Sep 2025 06:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757052915; cv=none; b=RmLc5IInG9f9s/EDpnZqpn+MruuNrVdiBrjOnM3Je8aIt4zW1ZZG0apvGUmLWiOYUvM4NSwNEZmCCZ16tIoh2stpkqN0a8ajgrnrlRix6Hq0Wzh0z8Fe8iPn9PuPft6wCMJdHmiggcm19Jg5uNZtM2kHQE02rM2rMCsa0wN5QnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757052915; c=relaxed/simple;
	bh=4QB78LNQwxKAsA68SulDE/sw/iH3uDbwsF2AQjDBOCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBn+NvYiZrKKvTyGvLsFAQ0taqYArS2Y2MRzhijSawE8+NBXx0VQ/hRwYO+CimVV++tvj4C6ezUYlz25s1EQt7pGJa0K4FVkW6hUaK/fQkHsTQVnyrHAN1q728vFU/iCNkrC35gV1zuNPnzwnmk3uuOxrhT/CXo688SwxVyMLLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WCewLAdo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WCewLAdo"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61ea08e565bso251574a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 04 Sep 2025 23:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1757052912; x=1757657712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67Fan9f0fhfdCk8yqG4XmOKNFNUAhVKb3cVNbIqGl/s=;
        b=WCewLAdoKtdo8jkGFbffWFrZVuD9nvvpv6EPBWGIrbZwEUUWtItcvNcQoYoaszr4PW
         y4Ajw2DZSXyGk9schrUGWnCguNtZQtN1dG7XbbcPJZ9bQ3O4VCeN9fjFcs3Z3zs/a828
         OR7sHZAUQlRZ/CbaPvFsjDiKUBjIt+MHCW6nDu/ZRZrA5JDsIMQfqw89/bFpupSTMTDZ
         QpO7dkLYfykfvD7j3J08M1LWT9FlZZ+/Zp0PNfCOYFSi576Z+970F4Thxi8F4fMMcpOk
         4WVSkGmKZztk8QAvnBqQuNd/Wc0qXrZdxSRlKGXeYKHtsHDgxfqWkxj3lnNuo7vGUxiK
         CS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757052912; x=1757657712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67Fan9f0fhfdCk8yqG4XmOKNFNUAhVKb3cVNbIqGl/s=;
        b=NBqTN/mNtuNu3LMO1DEbEmljKNCkgui2ylm0IMfFtAHX+oZ+19HxQ/B12/QM5SSuMd
         CQMWKai2vHlkRiTIpGBXtz8/zND2OAFz8ESF2uEbrMSvVtgEgABFVKdfeb40LQ5wKpoz
         n7VnL/VFZQXJZBgMhrRRhLTI6UXBHago+UXenGcIbD7kw+4XgUFiz1QdDb0HyQOPpJU5
         7bQKcgte3NSZFBeYtcFOkwiBnJdFNf3ZDqnqynXZfkCdDrGAqYcGh1B2MvIhA1zCT069
         p4YiI5FOuTL1wAoh9oOvdsfSjhkDS0S16Ed7O/PylBDu6/3Nb8OHWERxcCWPlCKMunE0
         fqtA==
X-Forwarded-Encrypted: i=1; AJvYcCWQTa2j0Y1ZZIXZKxW9Hw4F2LP4FqPktTP6aH8kD/W7HiP7yL1uG+Ri2s+I41dffV6HuCKK3POFJRnJ1hNHNsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/j2ejt5uH0lRdq9XYi1lQZra4Y8scGfvIJ/4VrVblR2V8wBRR
	7toCsEsTSLeDT/sGaclS5G2Up4RbAAHTqSu5mHgAtKSQOidiXwzv05+uNIdZ28X0llGTkGHZ6mh
	2e2sE2K5wDsABc94UBNvwu2QM7FYRMYnkSEY9JmLQrQ==
X-Gm-Gg: ASbGncuMDwSX1206Br3FeK47MzKVsfzGF9LRTHDrq3RnIpsJOVdqB5JsIAg6HEOZ7Mb
	C8Hz1VLdttdVNSQwOBNA3FBfkxtfxl2sUUGMc1KTqhsa7ET8CDjtb0LirPdBXGq2hKTb021UKLf
	QlIIW/rtN5e1uhrfWJo4+bq0Mzm545Of6X9f7C6bB0vzqhlEXC0q1jsSHteCnPlR/VJcEGgBOsQ
	dmYTwl7
X-Google-Smtp-Source: AGHT+IGQxtNMXZdvajLZ7J8QVJRCMBGrRVcTSOlLx1yX827VXeUjk0Y0uoYjfJG3Qk/GwD1+mtNnIEotbRORPtK5gAk=
X-Received: by 2002:a05:6402:430b:b0:620:bf3a:f6dc with SMTP id
 4fb4d7f45d1cf-620bf3afabamr1472744a12.4.1757052911908; Thu, 04 Sep 2025
 23:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aLmoE8CznVPres5r@kspp>
In-Reply-To: <aLmoE8CznVPres5r@kspp>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Fri, 5 Sep 2025 08:15:02 +0200
X-Gm-Features: Ac12FXzLRYvr9qxSpOLdM_cu9n8ZpiBkps4v2s9lawoV77lRbVRWUjzUv-Bi5yo
Message-ID: <CAMGffE=4KUt2y_-C32YaVtJVFiyU+1T=gnu1D0m+MxXs=X05kQ@mail.gmail.com>
Subject: Re: [PATCH v2][next] scsi: pm80xx: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 4:54=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Remove unused field residual_count in a couple of structures,
> and with this, fix the following -Wflex-array-member-not-at-end
> warnings:
>
> drivers/scsi/pm8001/pm8001_hwi.h:342:33: warning: structure containing a =
flexible array member is not at the end of another structure [-Wflex-array-=
member-not-at-end]
> drivers/scsi/pm8001/pm80xx_hwi.h:561:32: warning: structure containing a =
flexible array member is not at the end of another structure [-Wflex-array-=
member-not-at-end]
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
oh, indeed, v1 is wrong, and v2 is right fix.
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
> Changes in v2:
>  - Remove unused field residual_count. (James)
>
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/aLiMoNzLs1_bu4eJ@kspp/
>
>  drivers/scsi/pm8001/pm8001_hwi.h | 3 ++-
>  drivers/scsi/pm8001/pm80xx_hwi.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.h b/drivers/scsi/pm8001/pm800=
1_hwi.h
> index fc2127dcb58d..170853dbf952 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.h
> +++ b/drivers/scsi/pm8001/pm8001_hwi.h
> @@ -339,8 +339,9 @@ struct ssp_completion_resp {
>         __le32  status;
>         __le32  param;
>         __le32  ssptag_rescv_rescpad;
> +
> +       /* Must be last --ends in a flexible-array member. */
>         struct ssp_response_iu  ssp_resp_iu;
> -       __le32  residual_count;
>  } __attribute__((packed, aligned(4)));
>
>
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80x=
x_hwi.h
> index eb8fd37b2066..b13d42701b1b 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.h
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.h
> @@ -558,8 +558,9 @@ struct ssp_completion_resp {
>         __le32  status;
>         __le32  param;
>         __le32  ssptag_rescv_rescpad;
> +
> +       /* Must be last --ends in a flexible-array member. */
>         struct ssp_response_iu ssp_resp_iu;
> -       __le32  residual_count;
>  } __attribute__((packed, aligned(4)));
>
>  #define SSP_RESCV_BIT  0x00010000
> --
> 2.43.0
>
