Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750DE383C74
	for <linux-hardening@vger.kernel.org>; Mon, 20 Apr 2026 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667828; cv=pass; b=KFOXTmW36szoPw+2z1hkfSJqdq0SYLICKLcjO6XvsNBya++AtcQBoPuTpjqFgW/SAdssYDxHMvLvE5i2vMdHRE+ztAvEvEhUqXHXzWYVYPTsgA+Y/BEOjbztgG5/xvZQZenJg44zdl9QM4rD2cvGYfT7+OjISJrW67Gja2n5muA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667828; c=relaxed/simple;
	bh=MsnKeJmQAtc/gZyPzJxnW3mK4tSSagZHSdASGcv5jLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPxp4mhyzY83R3pRMhqStank2w/zU/yCzDGXoEKYgDr5keNbZKFdUOEVqYHZkPOZaGO1PIaVgH+onzFkNWrt2sGoLU71/FG/4spLurvEd8rEffJ1o/Yumvsz/z0TvNWhpwecUvk3OT5jdArf9GZ1WaQBev4x7pYnPjaOyUS3/Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAPI9oSO; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAPI9oSO"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso3639963a12.1
        for <linux-hardening@vger.kernel.org>; Sun, 19 Apr 2026 23:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776667824; cv=none;
        d=google.com; s=arc-20240605;
        b=Bk1YAM/N10WD2G/8At6v3egvc8b38wJ6WFr65ImtchDOyW+EF6Nd3Z/zG6INqKmNhB
         ERHEIlyWVcYXBdhCS6fX0XRIRrXyyHR/UzHL5oyX+7cishfP0FLSd0zOusn7z1uaNLHr
         J4eVGvzqugHpoqKbDNOd2khYnP5g6MmPKRnIzdFVYMBFsRMwPRMFYkKcwtV3YojLMTGt
         rR2gWx9+ctlI6KU9UtZu4rB0RuUIvWRENBKi4qsKP9+Z3ZB8hSDCRRSnZbo+SPgE8zet
         9kR4g3QnK3W/OqzPwg2czMSKN2NQ4xRkempYTmmVxCyXxBGO9v1sSwY28Mynpunof5qy
         wG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MsnKeJmQAtc/gZyPzJxnW3mK4tSSagZHSdASGcv5jLk=;
        fh=jRPyuIO1SjpLoUMgeFzbzi5KzJc8EX0hCDs88tcYjFo=;
        b=J9Z2hJQsDmMtgtpbVzGAlQb+esfCYYHs2nbQQoIZB1ibNveFtrGAXAanydnEcjBM8l
         /mXSKu0QefPKCcmkrXx5EwUkUgEYu85gw88KBWpR4QihkdqM3vxnjBGMS9OnAw4JHtOn
         9ImGRdAY7vBY1A8R5EUX/wncvzwxkMnehvCBwpKLPNeVESwNSeeI3prCwM0ntqXP9lU6
         gEHuBAIkkdLqQ6piyNXTosdv96EwvdZVwSPmCPflylOeRLPxQzjjFlWTUoGh8wAtynaw
         igKPRxRALKUkMQsHWOdq38/UzXM7OyPUEnks+rcFE/fLl1ma2AaMZGNNmQucqTNknsNB
         rUCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776667824; x=1777272624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsnKeJmQAtc/gZyPzJxnW3mK4tSSagZHSdASGcv5jLk=;
        b=NAPI9oSO89Byk1C5X/QrUxvUEBqcLvjAwMWUDwl2m9d7Qy9D37qlwhaKqjPeR6xLv/
         l8oIK/o4P2xdvyin72ZptJrSi25SSpPKWRdP3BxCyfO7vYWkEl51fAqAqJIF/IQe1Qhf
         vcXH1MRmobEzhHzQkYRSFuVA9YzMqv2o0L1XNso4/PcmnBInNVpcIpmpWqAOM/GB0KWI
         GR5RzUW8GebD2jACCkVH4y/Y6FvhlYYA2bZKi19Yez42KmhEMEAOANzillEwX+I4+Txf
         knh8oGHHWdFTwwHckPk752g+BtIyVZl8iq2bmDPMFXSOmOY7jp6wc1gotqHLRRNmMnkr
         bh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776667824; x=1777272624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MsnKeJmQAtc/gZyPzJxnW3mK4tSSagZHSdASGcv5jLk=;
        b=FKepvnc+fKrjUfK68Rfw6mOpJW6LLsvJJfNrA9CnOeUOvlLoxAXUpJ6DqSlSk/UMam
         58DByilIC5yyYOTFiz27tMqN6mQPWLBLhriKCeht0mTWk9Fj9IizXDVEtxofOvnxgslG
         jMtYUiGyFQPkdC6S/yhfpzAMB2i8W7Kwcl7wRwBzDO0kBhtDVqvSyxX/iSxdtEzXWAaK
         /dNrXwoRo5iRLkJVqkuZrqIwySYOHZlr7O6BdsfZwUEDvWKEAl3yx8cc+kemK/2WJU+Y
         zoxlbxxLD9IFZ5JLnGyHY5EE9fgs/1K5sPzYA7FsWr1RjBm+mbvXwbzIL0LgVQ+WLQtj
         mE6w==
X-Forwarded-Encrypted: i=1; AFNElJ/OHwFSIfz0xU27GhcCAFvKXJCiA+tvrac4zO7ShwnzFtyhD5nCzvsiP/PcaWtv3KsFv5igBLIN4r38qATc0A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcM7dpnASOpCu0gbjjRwYP7n9zWFX+W14BIuMEX7nuKx3A3lLK
	ONslrPywdlaudvjBeMxDTb0y/OL1ES46kmt1LLRO3uuKMtRIMdRQ+UPpqkPDjB8RkvweI6gWysB
	99PwqOtikN6LAv0Rka+SZk4uVDFCfaFQ=
X-Gm-Gg: AeBDieuZfsjyvALn7ijZh07BIvlvVnlk5kVGb7EU6W0CyTttWI4gFevo80COGEO7xA1
	0jEZk1fsn9XMi6c9evSjkBkek8fZpw8jv1ewYBmi1WCu2Tq1Egrla2CGeOIn8EAb1A/9O4tDsgE
	rufj2WYNGh+Uj9Opyb+V/wSVkUe0Dwy8Iy9syxrWi9Q7w6kIgQMR/Br8U83LKCL+6ksaR814S0T
	wzDwM7K7JkxptdpM++Zl1hvJ7zv+QdmmF/E1CxY14O9UxQ80AM7txl6Ksjh7+ybNehRgyY088Xs
	zybfrdVGY5x5tBCHcKOgKPQ/issobLfwjft9O/M3SgDIE/oWfS1IEZjMXGhh/8XIgXHE/RpiQ8O
	5UveYruDKe0uZJV78nQ==
X-Received: by 2002:a17:907:3cca:b0:ba6:a05c:ac26 with SMTP id
 a640c23a62f3a-ba6a05cb61fmr199462466b.7.1776667824307; Sun, 19 Apr 2026
 23:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415032753.6006-1-rosenp@gmail.com> <aeXEIDgjTExt_hgs@lizhi-Precision-Tower-5810>
In-Reply-To: <aeXEIDgjTExt_hgs@lizhi-Precision-Tower-5810>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 20 Apr 2026 09:49:48 +0300
X-Gm-Features: AQROBzDSwLSrzY12rpd5iHavmMuIpIkb5vhZemtYJ92PlxSc_wMPr-lqUREJf54
Message-ID: <CAHp75Vfp=Wvtq5EFM2vOZUfkGDcq_m_zpK_px0BKTFiiR8EwwA@mail.gmail.com>
Subject: Re: [PATCHv4] dmaengine: hsu: use kzalloc_flex()
To: Frank Li <Frank.li@nxp.com>
Cc: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 9:14=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> Subject
>
> dmaengine: hsu: use kzalloc_flex() to simplify code

Not really. The main point is to have source fortification being enabled.


--=20
With Best Regards,
Andy Shevchenko
