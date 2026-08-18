Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031646E013
	for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056004; cv=pass; b=dVEjcc26u9EE/ZiTmhV4jYJ89m8HGEJRtIDpNfHpKVlbJJxi2kvPLC6/QTYUgM44BAKOZXL5mYEr9sc4IB5NUOvJEdNW2pmcOG/tZsDU6EHp9klHJcRC7ZeI7nYLYb5NsG9pBuFumth2MU+4O+WrwnjKSPfPvWG5A2UNo/nbKcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056004; c=relaxed/simple;
	bh=kLjG4blPBMdpWzPmKacj4BuVzm/7SEdFKQgIAE8kGpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pB9gNUEYRw6s3UJVjS08AKafv5qHZJEf4u5pm7nsSI/8MMKpulDabT7QOZrfzqJ6vQYxgxSIU7qdTxMfyGajVDegWuCiwF8qkEjgH2jYvOMKvdvWlxh4st/9YmtPlofn0hW47Hr9Lm5ccBGy2RDqhfG1CcqabRt5hWt862W6Fw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hAO6Yveg; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hAO6Yveg"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c2cce930cso44529111cf.0
        for <linux-hardening@vger.kernel.org>; Tue, 18 Aug 2026 05:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787055999; cv=none;
        d=google.com; s=arc-20260327;
        b=MsJAOKdjwRHwELp1PPKMmPZdnOXlRGBh0xLWOJ8BzGYxXiMC1GthmMAotLDyokdACw
         /Q8MVB4BSaNMGgcSiqax1etYYBvPpExY5SiWxOpypvcOXmC4NajF1JPJk0xgbhrtrQkl
         Aw4med9Ah+SNu0ATvJZ6e0+tkqQcnXbobR9lREKuaYWMzfqsrzQYsw7ScOncKf6sam1W
         qipFIYchrlwqRImrnXge6F3z3PiHo//OUGTjwUmHZA2VcIjnFLa9MUpgfjW4U9pQ1K7H
         9S3iOmGjX/XzFSDFbOUKaDphYvtU01XgMwRoz2aZLXblxi76LNZWXQvaiUVM2LsbHIgh
         tR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kLjG4blPBMdpWzPmKacj4BuVzm/7SEdFKQgIAE8kGpU=;
        fh=vDdDqPnIU1d/OFxiph/9+ORLQQG8HroQLe/gB/ppOMU=;
        b=h8BXfdrx7IrUOJKZR8Jc5v2SqxqC9gxd4oCOUGS9AkyMenOJwqm5SLrEN3wO+dXvAk
         4U5U9gVadiO5pwAehdQJ3aiDH8E+nSF8WAN79yLKtR1BfETHNFG2rs6E2/dqR/+Ba0oa
         932qeJ1pLu/QSetYrkPt0gsQiws8Ui4mmFg6LrYr1ePMR98lB96wov2O5y8+HY6BiCga
         YWgOCZPKma0lXDLwt0q2Vc9jhroeRwFzQbB8u38HEfZfVnEHQYnhc7u5W7CAd7eS1url
         6JbAfQH/LMVAJ1uskn+sBLe6MHEcArFDjjyrmEoM/TheHcIsMe8jW4aEVXhHnzF4Hc1C
         AIzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787055999; x=1787660799; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLjG4blPBMdpWzPmKacj4BuVzm/7SEdFKQgIAE8kGpU=;
        b=hAO6Yvegps5JeYzrpC9uPHPEH2Ywo3nBGbtX3pin+bfKYDrOdMtPv0TEpa5FTNDZFT
         P/VF1xaXHE3XWqyIf7MnO1UmVBWkikmN8MELOC950gL71aVtxTRN5i9yMchFMo7i6Lhg
         6pl0lxK32wFElvLmOmu0YEJhduBkI/yfOkiWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787055999; x=1787660799;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kLjG4blPBMdpWzPmKacj4BuVzm/7SEdFKQgIAE8kGpU=;
        b=gUl+aCH2Rns4zBphdLxoRLwO2YE3afzvbkS8RDyEDNqIRYVZ6QNiLoEXLZ0LalGN8j
         4X/t+xA64jMXd/MXDtSmyojHoPaymlpiUGwhEwbp3D23RXlNJ+ZSnxni/xeWubF30j6v
         Sw1uke8VeMiFmF/KVEviFS/1bTpbKsD8DaFn321CD3nmUiHwKr0hiziX4p+rGJ8n/8HV
         CotdI3IxGMpIz5pQ9QvdGfpJ5PVX/ttB1O9xwnto+r76+5eivc+knNSeERWQJt5VlmFO
         2proRDC2v3crejozfW7/cornnGqXTO4VSQL/4FM8XIkUh1A0BPBmvYyGGy6p47vXhd86
         a1Iw==
X-Forwarded-Encrypted: i=1; AHgh+RooUvyBIDrCYYxysqmiDnDiHesXVZNzMSHzzpGSJiuDT3z41Ehydat03EQCkq+IBctSUaL7uWEloWXDvlSobYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEFprs4gd2fAkxjFzYHk0Wh9Rzrq/AtsXeEg0w+tmnAeLPAlkY
	wb1dpmX4JP+VRtvUZgklbZzoxaaQYlQW/hduARNfTtxP6ePzfK6eRvJrNjWY/UHxBDIW4HNYCkr
	WdJ2Uz7RxtWoJSM2TJfXp+PfyhQMua31RHn4JpcLdEQ==
X-Gm-Gg: AR+sD10E9jvXcAacVKw6YXlFYMlXNZSs5BVflYj5TB4C602LXTb7cT+ErZfEhybRo0A
	6r6QRcCQUddCu9PRxIs8+8UrdwjO4d5YkNhkX3LzO4ZBBqoab9tlzpbwkAG6MDMlL9AZ5J56fLG
	drUXiz7kYOSxphjU60CsvPG8E8j+mPHANiTI/lQb4+rAvQM/ssPmh6zd5wIXyyuQRd3vKKTfI5g
	2HuBLOXLnB4niMZMw5x9z/B9PGEpgQRVLrbbd60OJZFJ1cVP4nlxwQWLKZQ9vL7s7ytSpaFttiN
	0iZOMHsQmNsExQHG9rc8nYCq0ZheNUS5gAe7afz8bHiKcm7dxt6SStbnnbhGH1iEQ3SD2u1XEZZ
	o
X-Received: by 2002:ac8:5949:0:b0:51c:fc4:a144 with SMTP id
 d75a77b69052e-52d8530ddcfmr335928241cf.4.1787055999194; Tue, 18 Aug 2026
 05:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727233706.218446-1-xmei5@asu.edu>
In-Reply-To: <20260727233706.218446-1-xmei5@asu.edu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Aug 2026 14:26:26 +0200
X-Gm-Features: AcwNN1X3TurRVqh3drsMqsffCnxzux841IzZnvq7PDJVAO37SPootEXFLrLLa-g
Message-ID: <CAJfpegv_cfPAiS29SBR9Jb0BdcGT6ZqP0ajN4nEKF_Dbz6ifiQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] fuse: copy request headers via a stack buffer for io-uring
To: Xiang Mei <xmei5@asu.edu>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Baokun Li <libaokun@linux.alibaba.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jul 2026 at 01:37, Xiang Mei <xmei5@asu.edu> wrote:

> Bounce both headers through an on-stack copy so the usercopy touches
> stack memory, not the slab object.

Applied, thanks.

Miklos
