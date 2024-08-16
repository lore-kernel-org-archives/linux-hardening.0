Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716401BDAA0
	for <linux-hardening@vger.kernel.org>; Fri, 16 Aug 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823015; cv=none; b=vBhVmin93sxXLb01IRPHIHG4Cq9hotIGNV05rVb+DNUPNtpZhm2W8pITZ4D4qljxgE4yR3qXI0uyJwSBtB5pmXrSG0x9pOrG6AVmjwh4E8eCb8m5GJxEgmkTScVjAWM8p6SNuciXYqviEwjvX5fC0qlMGrby3PKyH6HDPw1EGI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823015; c=relaxed/simple;
	bh=pWnA4rKRv7A9eDyJbt5XgrzYXaqLw2bvWJWpy3/gW7c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AOoe0jYuL1u2Ke5k4LEgeNyaxn9P1E06nUMNDhf38m2TBigY6eirU65IuzVmT3pYIM5rq0pDCp9E3uy7dE7W+1488l2u6zDd4wBLeboruxK29kCkpKAo342bhiyzXDK4QJ4WGR9svfn57NAu/Or5bAP5o/O6d4jsKW4bPQ7nYQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=EFLgELMs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="EFLgELMs"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428e3129851so15666275e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 16 Aug 2024 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723823012; x=1724427812; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWnA4rKRv7A9eDyJbt5XgrzYXaqLw2bvWJWpy3/gW7c=;
        b=EFLgELMs9vcUmfHh9TVhjCMUT4A4hGp94NhODVj7HQEdI+MvK62FhO94tFacVIHrVS
         4VcTAwdRqD+dT6nLVJgPeBN0Lp+fqDD/hww1JpEmaZEiKB/LPRYDMkg7G6l8chbU95RJ
         Vx7VkzvVDCMLiJY6sioTZE6PMmNhvP5kTl5gm7vux1ussdKGmLiKClS5e/bJg8fenRCj
         Rdp6QhgKsIecyYd7ahG3CrNKT5X+G8O+gs440a5e2Riwun3WpZllwDt6IJydAEVxh2rH
         RwYbxriKPmg3tjkl18N9ZnJi/ECI1lO1m4MABq4u04m9ft7dG15y/Xfgv+EQA6tTD6Av
         kqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723823012; x=1724427812;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWnA4rKRv7A9eDyJbt5XgrzYXaqLw2bvWJWpy3/gW7c=;
        b=G7pkjgG6zwXEMEip3YHt3Ntbl2sXi5x0a5nNiivPvDmQkKW2g6Cyc4gGFtWLrSq+Dm
         Fan6ai23lhLNxnl4Dk9VBA5n6ibVEsUkT/CdcMXl5gQjmMv0LYmXOheVAvTxJ1WP4o/8
         KfylKW60+OiA8X4wBHp7rzE1YGHYLd1RFCUMvgE7I1HR1keQ3+nXScbdp/wNfSxZ5JaB
         rYYc7eOfB2YNtfS1PLAf2IN9WtecY5wvuKOf6LVUPj1NaPPcWfyzQzCEdKOdmNHXqxSk
         N+m0CpnzPr1SCahxnGPdf/FEvXks6ux5djoiKNpOHntGnaGNp0sThiJH0i4c0pBezvnY
         REsA==
X-Forwarded-Encrypted: i=1; AJvYcCUGfCvARJtY1xHt8/ftFLXCpAdBZOT6JA60tsm3Mz0zQ19l+7W0gp78BEfNsMDxar+3QuNhbryiv0kWrcItw2ylSQjTOuQDLYF1cn6d2BXy
X-Gm-Message-State: AOJu0YyP6lL5mNFNo17K+yH5nt7aldsXW7hz0Ms8XexhTze3DhEPpRIm
	BtDk/nF92fk7dwghBdAfz/XNbzlPvEzhYBu1EnRPIL/YjRRPPqJSJcPfS3UMYNQ=
X-Google-Smtp-Source: AGHT+IEWrDQ7zS3/HmWzMARm5qp6trTqqVuoUXFSQmyy325duwBHbjSLMCNRXyhO0Yr6+AZbILp2Aw==
X-Received: by 2002:a05:600c:5125:b0:426:6551:3174 with SMTP id 5b1f17b1804b1-429ed7e41admr26278525e9.29.1723823011508;
        Fri, 16 Aug 2024 08:43:31 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a92:ee01:29b1:1427:611b:84f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded19670sm79684695e9.9.2024.08.16.08.43.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 08:43:31 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] ksmbd: Replace one-element arrays with flexible-array
 members
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <f94ee92b-90e5-4af8-81a7-998040dac7b1@embeddedor.com>
Date: Fri, 16 Aug 2024 17:43:19 +0200
Cc: linkinjeon@kernel.org,
 sfrench@samba.org,
 senozhatsky@chromium.org,
 tom@talpey.com,
 linux-cifs@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A49BDDF5-CEB6-4A66-9B9E-0A506ED7071A@toblux.com>
References: <20240816135823.87543-1-thorsten.blum@toblux.com>
 <f94ee92b-90e5-4af8-81a7-998040dac7b1@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailer: Apple Mail (2.3776.700.51)

On 16. Aug 2024, at 16:55, Gustavo A. R. Silva <gustavo@embeddedor.com> =
wrote:
> On 16/08/24 07:58, Thorsten Blum wrote:
>> Replace the deprecated one-element arrays with flexible-array members
>> in the structs filesystem_attribute_info and filesystem_device_info.
>=20
> Notice that this also affects the size of the involved structs.
>=20
> I encourage you to study some of the patches that have previously
> addressed similar issues.

Thanks. I'll take a look and submit a v2.
