Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425A6186E5A
	for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724419392; cv=none; b=NOq4RlFTN/WBVqDPd0Jrjzy5mLrECg70dwzPv+iqdIJ4bgPhIibnesQ98izV7kyu0W9Eltm7JevAQJPtTfby4dkykOdZgTw3BFWWwJhSlE6jOqC7/uxO845f20EvfMbUQW+qkWorMB6B9uFDqcl5/lL7vTMUqNzOlVDpGQv5pkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724419392; c=relaxed/simple;
	bh=G68pP7poO8UUcT3gFTDxE4bYBPQUpzdr5Sd4qRM0BaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIIu/RJVP3W+DINe7P1LMMW24W/lFqvbVaUsArds6PvaiGqsYef0jin9o3JZlaRAKFH3IykLn8pOeMvsYcMwrhHfH++nBUF+sWGpcBiDUbrDrtTp5dDasDI7sFYmMsni5ndADL7FYDH7XbQ1h68IeUr8o8bj7JNgF5P0YX2Gt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtzQDRFe; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtzQDRFe"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f3f68dd44bso22812981fa.3
        for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724419389; x=1725024189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G68pP7poO8UUcT3gFTDxE4bYBPQUpzdr5Sd4qRM0BaA=;
        b=BtzQDRFeIv+ZiJ+Pw+vmfff1HrQhQqyp4JyeFDDJ4gVNSGDOHgnVMKU3147z5VcBVZ
         oNksMYWjggmy6SvhLloZDm/o7E99dExoHhmv1dyHtk2u2jdKDRDz6JqPbxJ6n8NFrLtY
         71/Ej+L18JuDCLY76JQ0KBnd6EiMCeKDNFZPKEHdBg/VQvcSUuTPi4XFh/44o/FsWgP0
         rqtaeIi397zvvFbxG3RObcrG0gyJR1h5OSp3S7pn0edKIFBr3J+K0tZnxjrSCqwTXrYD
         nJHExXP3WQoz76wLoXH5nvD68AdmY+Jg+tx2IfXUzDOxe+P//yRt9zlIs/QaWf1ybUhy
         ifTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724419389; x=1725024189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G68pP7poO8UUcT3gFTDxE4bYBPQUpzdr5Sd4qRM0BaA=;
        b=s7ePhkj7qEmW5UtIaeMJ/t437iF69slBqWeltTzACIltvRxlZ/ebksmjhOdrp9mqx0
         YFSCD36RTc9gwSObm645hyYkBqag+jx37fBTkIuodaLCtthaT5/eCKpzFZh+DzprTYN0
         ifTiAUOh0jNteuSXCBuLMVWc9Fi6Ttx8gahyoUUrf2meVFXiNl9BlLUI0sxl7FhXT2cF
         L8msFDEXcRJR51myH9BSOAyVyUP5eO63OC8t30ZW8vq9j/MN0AEgkMDvcCuRjkVU4cr8
         +x6C4wFtL14X/CO3oeUHSvMjVXMxAVFIjaViWbokrpKPLlgGaQT3sygMIvUHUMYnZMSL
         E9hA==
X-Forwarded-Encrypted: i=1; AJvYcCXVan3GYT+JKJMLhIU748cQQjp7xr4y2+u0zdHfLBqCNuBSnqdFN2IFdxawpkod+e+5affHlj946Yl0Bw8Xna8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVliwZvrHWBSbeBEwCGJgCh1Db94JRKfK8R6uy0pEHTnmkTba
	bGPaphsOXfa5tHl8jPYbk+PU10Ua6gP+fLrF5Sq9HFX5vndy6DDX0SBJ+EMFNkQ3PEidFBEFZ1I
	m4Wc9jl5gJDaezOjKWNqWsNzaU2k=
X-Google-Smtp-Source: AGHT+IGZb58uZJN27rp/ud8fNh3RV3o67BkHKUuFHZ9Kz3A+PzWA96T21XU3lpd+ECMTMdnquUvlBkj6NEVq/Xx1wVY=
X-Received: by 2002:a2e:b894:0:b0:2f3:f193:d2d0 with SMTP id
 38308e7fff4ca-2f4f4937908mr18252461fa.33.1724419389081; Fri, 23 Aug 2024
 06:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823062046.3323694-1-lihongbo22@huawei.com>
In-Reply-To: <20240823062046.3323694-1-lihongbo22@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Aug 2024 16:22:32 +0300
Message-ID: <CAHp75VdYbG32auRF3KgP15wA-5bDgTMTO24itTu1tdjdW3CqXQ@mail.gmail.com>
Subject: Re: [PATCH -next 0/2] Add str_true_false()/str_false_true() helper
To: Hongbo Li <lihongbo22@huawei.com>
Cc: kees@kernel.org, andy@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 9:13=E2=80=AFAM Hongbo Li <lihongbo22@huawei.com> w=
rote:
>
> Add str_true_false()/str_false_true() helper to "true" or "false"
> string literal. And we found more than 10 cases currently exist
> in the tree. So these helpers can be used for these cases.

Squash them into a single patch. There is no need to split these.

--=20
With Best Regards,
Andy Shevchenko
