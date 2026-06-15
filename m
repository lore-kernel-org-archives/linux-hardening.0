Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378E840BCB4
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jun 2026 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541227; cv=none; b=m3GnBWxx8AV131hrZ2GYuVN0TSn5YiwrK94iLmS9xQk2uBddnW+BQMx7xcbK3AQyPDwPAGqWu2KHM6wsuFn5JgiZMfMH7dSg8KjZXeypq3vWTwPqpiUCIc6LK/nb1TqBrHxtGIw26X7arIcBgAo+C1f1tOj2M2b1Pkitkp1EPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541227; c=relaxed/simple;
	bh=2yIRGmGTIWoauMOGJ2GnvGu9kyAbF/MYkxPnOl3/1cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=l0ERKXxxM9I60l80zZ9c6AgznR4Y5I/5RxWz6FXhqIEr0rlXz0+Q7UdbIUyi5A/TNLaP0IcotxIuMiEKqRgb4ErCVAvAor4q9NRqu8lz+XOZnLrSpIAdbmINO/tP68d5sAJgyCzK3eqT3EtHGittioEdxPnlGnO5cu1H8YgkhD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=if3Yubh7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="if3Yubh7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781541225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g5YgGUo7AEVnCVHtnVu0jF1gu1Ki+WZj6PX4S9DZv+0=;
	b=if3Yubh7kcX6FMXddTaobSPoywyP+PJSuwNRKHa0B4Ho0JGdcU2C87U4AoSIiPVTXbMNzX
	UvvV8GjaT5I4EsjmGPXO4MrJBXECuk6GV+6F3t/Ur5SpGbLQZVyKJwrFzkWPgw4dQDQeoY
	muMK5vVZr3LTwhGmpoEyQCtaEMGobJg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-HsP55w0WN1G3EoXj05zp-w-1; Mon, 15 Jun 2026 12:33:44 -0400
X-MC-Unique: HsP55w0WN1G3EoXj05zp-w-1
X-Mimecast-MFC-AGG-ID: HsP55w0WN1G3EoXj05zp-w_1781541224
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-517e0cdf99fso99125591cf.2
        for <linux-hardening@vger.kernel.org>; Mon, 15 Jun 2026 09:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781541224; x=1782146024;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g5YgGUo7AEVnCVHtnVu0jF1gu1Ki+WZj6PX4S9DZv+0=;
        b=GgGUwoT4qUDKAyP3uCg/d3DNRym2v6MhE3s0u2E1HGbHOnhdR6dIpfd8LjQe8EqsCj
         AE/kCRCDT0PBYsroJRM0ACydSyeXIlT/BJFg6mKhMTj9ac8EVhxG+ZO58uSozvVH6yUX
         fhKc4Y8OxRX/L5L6X7ZZ04QiwEKDEgoXahCl6ujlkWSt1MGE8kgyTSXGe1kwQ5qfjgy1
         aTZvR1zJyVVb6Dxv7RkF6ROlkgMinY9NVnCuToH2l/Eh8y6QgB2hMIU1XDBpA8cCI9nH
         B8obMbwZLPnVxTt9bbtddfJKfgkgjAbSFoEDt85Jf+BBo/lXnPsW9ywD+pjmlYuyc2F1
         fjag==
X-Forwarded-Encrypted: i=1; AFNElJ8X8IsvGt6SM3Jilfkj2cpFdPDj2wceyImDoWLJD3U+GKItfTSLNZ63g7e+vXg/SEyze/Wqmkzh4Eh1X4+QjDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh7jpPd/iNryIFgZLzty33v2/hQWvHrHWbCbFgpLV2LJPOXXaS
	uqcCB4hq8qKUjop2E1b9gMmiUSbMnb/Lluk20YQyT6jbPaZXYyrg5BgD+4skGEt/P1ugb/EFjTm
	2MnUpph3qiB2wxvxzv0Fh9lhFu3X4yQolntD21mCx4S5S8KdCWU3yb6e6hqPJVdEv0qPZKg==
X-Gm-Gg: Acq92OFB2b2B9czBS8nV/50i36wGlQLszXAL9Cz3HaeETb9fHAzhmpX9Mq1O6rx2IK1
	3qj8sah6o1NTUrMXzi83GsBGEtD3ZugrJOLahUSApHGTm71yO02YxgppS+riqCnfJubVHyuEUJ4
	GkUfAYW33VVe4PRM4cwV56NUpzg5oo2fZ2ttmX+cq8ZNe7hPt521i1IA7zHu3E78fr2S5A8qGkv
	7AiHhXyrMqFK4H/oIDCWV3PpeZMWnt14iujERf/z8YAkEN9JRFdqcWJb/sKVOiLpUhhHYg5cVVD
	FTcWCGC379OYXDe4cp4Jvn8PBkY1QgHxPwo9jDT1ofb5TSeettHK5mPw/SIS4df2HGWzTFR4P1E
	1t2sDyhov/8KeGmUPufqG0xDvd1HKJPNhteZX93PcNLJdlICeITT90wYK
X-Received: by 2002:ac8:5892:0:b0:517:8c0b:66cc with SMTP id d75a77b69052e-519533bc447mr171342301cf.25.1781541223415;
        Mon, 15 Jun 2026 09:33:43 -0700 (PDT)
X-Received: by 2002:ac8:5892:0:b0:517:8c0b:66cc with SMTP id d75a77b69052e-519533bc447mr171341671cf.25.1781541222849;
        Mon, 15 Jun 2026 09:33:42 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb64202asm113536721cf.9.2026.06.15.09.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:33:42 -0700 (PDT)
Date: Mon, 15 Jun 2026 12:33:32 -0400
From: Brian Masney <bmasney@redhat.com>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH next] drivers/clk/clk_test: Use strscpy() to copy the
 test description
Message-ID: <ajApXH11zz2ZhN3G@redhat.com>
References: <20260606202633.5018-35-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260606202633.5018-35-david.laight.linux@gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kTFuXxiK8hDwnibdMSuiViR2W60KIJfIf-LFvkV5xqI_1781541224
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 06, 2026 at 09:26:29PM +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> The buffer length is known to be KUNIT_PARAM_DESC_SIZE
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

