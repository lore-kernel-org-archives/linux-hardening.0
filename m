Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811A34A78F
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016524; cv=none; b=hxMrmF8m7Q6Erkb+lSYgkySsumDUfJ75I1YczZ0+v0vM4sfIZNhEugBNgRCwZ/wvyNQ0hAd7JScJ8cJEw7X9dR7RDJ9T4Y/I/q3MUGwTCGk7iyIHwitlpHoBuQWsbDVWpugJq76f151+hLL8vn9LzudvKx2i0zx76pnaN6iu+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016524; c=relaxed/simple;
	bh=91M7+RHOfJutGnS6ezebTu/LMAPUCMXCn4h7r5lGAtg=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Nz6213mm9vd/Zr8yOkomAl2e+kt6DZgRcrXpnKdAqw7A6M9aR0T6bpnx9sa/tRc1CprLdyo2PIpFdsQmiUxwvIvf9jrU3eUqFB78pSvY5A2QiR+ka4E87hahBNPYogYCuWAsTDo1DbFsVPtJ2oapbgZr6WE1KAsYqfe6I4GX068=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RJTBrHAD; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RJTBrHAD"
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7e6cfdc92bfso2027214a34.2
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 07:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016520; x=1781621320;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdgCBltfiFlh10Nms4T7wj3+rz/0jCZ0BoMlOBU5Q10=;
        b=kzsdO14dBd3WWJjUiz2MUUdbFIol/TDCsvxOvY+a85+UZu5Z6/wAFA1jGhx6E1VS0B
         ig07y/TjSmFNqltk3FkdruMCkezqGIAEVvIZC/6KpUermixmQ6Xu0iF5BDiOdekUxUzf
         /J96SfPsYwSbB64M6yy1kp0O+RgA1iHvmX9Cf0gifWcvjeYAkMakeT+QF48xCBXRUTYT
         c6LRLnfF2KkPr0GeBE+V8HmBLVeffxBw146I4PhbH8uFzF4UDRcrK6BNSGzmExQBJfbd
         fk8eRHk6cEhf6RNXNPB/95nUX4UXRJ0fRpYPbCRYjv9cBiAVLgDWiu03yiDI1sSSs67S
         FHpg==
X-Forwarded-Encrypted: i=1; AFNElJ+dJJ6Cj9vu18+HWAt+nipInTkicUpCGHAubHPsml5YKLcG5mTzgs9PFpmkp5Q1rSbJMBiEn9b9KS0V2aTCfz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfwP4vks9CXrPLI0TUmDB8mXz7ROgzgVSmdLXzevDsVyLL9/+5
	H+qWw7z6bGhDvRWUGd+/2BazdrftpjoEiTAON1iKCW/0t0d4rMV7iozcmMhHzY6EkI30riXc+os
	wFiUGMHPz7Zx8fZC/ydpHrFJIVvqfEwsUV9ET7QV4/+WNeypWAmk9EX9gVgAoRnpzUkD79IOZLg
	NxMkfL3O6h1nvu+BlESmlkDWDooiaX27b3FX08s3lP8q+GF85vjUoecxYdqGN60ZfdAufex27Hi
	uaztRnjgCtxkRH2h94cmRJPFCn5aw==
X-Gm-Gg: Acq92OEHTraFqFHIIgsUOyUu/y+8T2bxOjwz2zsKbViFcPsF5zV0mx6mCKxv20R3/Uf
	uJcW8RDI7ZEESuFxSpBXhpGZBIiISWFMot1viHIDAGcuwUJMMFkU6pD+z/LgF56jHBEHQW2jaJF
	eHF5sV8VkgYkupoF5plbgK88VVpl/ARCkDEadXkM7UaDLEiI3K63kXItp0I1EH6zAePoAf0OsQJ
	3ft10fxWzw8Gfz8wTsz0cC9c1nOmfx6mhllCdwscXs/LsIbqy8gPQ6kWtgz9Y8noGsTr0Lqkq6u
	XufoGEmW/12+8SlW6oRvg9kEwX3lr0fXSj48ViK+zyYQTnzBRajwgFJc5JG20sTWY7UAFRFWfnO
	FMMsQPNVQTVERFnHRCQ4/JQ3o+LcbZ6OoYTe/HCifiyeV3cwFWXR97UYlxFShPwnI6LosAvyDeg
	BuR8tXaQrH2mvXCDTjgBA=
X-Received: by 2002:a05:6820:83d8:10b0:69b:5486:e85 with SMTP id 006d021491bc7-69e68c19e38mr8390040eaf.36.1781016520177;
        Tue, 09 Jun 2026 07:48:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-440d7e114a1sm1848676fac.5.2026.06.09.07.48.39
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 07:48:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-68bc68bc910so6439415a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781016518; x=1781621318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdgCBltfiFlh10Nms4T7wj3+rz/0jCZ0BoMlOBU5Q10=;
        b=RJTBrHAD27D5IXWZupJdngWivGlV0BWHMNKa+AntE4bzvoVvFjnCnyt7/C0Lw+lPg4
         cF9jdwAEfoFgRhV+Zf9I00zJb7vpAqP0MlE1qJo4mmRqMOnLnRBIqUBiMPEkGBUV2MZ4
         myEDGUgfSKxnMFsQtIgSXTCmU03gzAKNc6lrM=
X-Forwarded-Encrypted: i=1; AFNElJ/H5XNyzSky5VAuPekDFfD2UbBUIpHZPuAeD5XkopJK/CyYwqU5hzGO/VsTsfF1HygsEcAJ5RvDCU61yjV1tJk=@vger.kernel.org
X-Received: by 2002:aa7:c041:0:b0:691:957a:bd61 with SMTP id 4fb4d7f45d1cf-691957abe39mr3347466a12.7.1781016518340;
        Tue, 09 Jun 2026 07:48:38 -0700 (PDT)
X-Received: by 2002:aa7:c041:0:b0:691:957a:bd61 with SMTP id 4fb4d7f45d1cf-691957abe39mr3347450a12.7.1781016517755;
        Tue, 09 Jun 2026 07:48:37 -0700 (PDT)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65027662sm8944678a12.11.2026.06.09.07.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 07:48:37 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Rosen Penev <rosenp@gmail.com>, <linux-wireless@vger.kernel.org>
CC: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Date: Tue, 09 Jun 2026 16:48:36 +0200
Message-ID: <19eacdb55a0.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20260608051102.6698-1-rosenp@gmail.com>
References: <20260608051102.6698-1-rosenp@gmail.com>
User-Agent: AquaMail/1.59.0 (build: 105900627)
Subject: Re: [PATCH wireless-next] wifi: brcmfmac: flowring: simplify flow allocation
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Op 8 juni 2026 07:11:22 schreef Rosen Penev <rosenp@gmail.com>:

> Use a flexible array member and kzalloc_flex to combine allocations.
> Simplifies code slightly.
>
> Add __counted_by for extra runtime analysis.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
> .../wireless/broadcom/brcm80211/brcmfmac/flowring.c    | 10 ++--------
> .../wireless/broadcom/brcm80211/brcmfmac/flowring.h    |  2 +-
> 2 files changed, 3 insertions(+), 9 deletions(-)



