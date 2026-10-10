Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0129D28E0
	for <linux-hardening@vger.kernel.org>; Sat, 10 Oct 2026 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791590538; cv=pass; b=mc3dvAzjSX+5Uj/sAup9Ku0TGfSfUARKjX6dfBYTdvkSWliW1uc6Mwj/Ahjewie7b1fdMTJ+cL9jZOS7BaxJFcxzoFmEJh1RnfToj7Xz+ax2TW9b/17v/2VQcJvcCZszqEUieNFku0tFZFPEdwgsrNoto2WzqkQiMSTbFa/6wkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791590538; c=relaxed/simple;
	bh=hXTeWRoHLQjJuetkdFQnlbxkl4pZIcomCQcGCLyZ9N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtFqjw1QvFfL+PVdmb0Ebgj1cLwEDch7Vf1hltVPfcTsDCWFY1ORh8VS3Yp9eaLQZf4ik2NVVWF3RFs+JbetpUWIPRWkOgh4/P6MHD28xu2yx0i7VUzWBpvdCqAz5ltLMYunH1x2ABYtax9BFwhpbyAaUimICtwRIQneKIH2d+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ2IcHlC; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ2IcHlC"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6768ced47aeso208870d50.1
        for <linux-hardening@vger.kernel.org>; Fri, 09 Oct 2026 17:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791590535; cv=none;
        d=google.com; s=arc-20260327;
        b=dX6OihvfZkSymXPMgFK7x/jX1fzysDcmxYch1UYo8dcBz3/JvQ8o3JdyfiBg8LSHTC
         lF57+6KjaIrKtUVd9juKp3T/yZZRAytGcexLvmQQSJfAENdeOJ6SXfibD2lPkqo4I/8f
         89+jj0eT1KgbStDXTS5+RrwObPtEqEZovVGvEpOvgIXIC/j7kK02h7Q/DgQ+ZnkWhvlo
         4xikJYm+IaOBvJkGXZoqX2wtCvy/ZuhFDMzzprdgt5iCDxCojGznQhRMJdGzHJZo9KkM
         5JQV+UES9QFV3VYQyGakVM5g3gKM0dwxB/2TFPLG7eamRpqSQnrr7e81X4v2CgERAa0o
         Bu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I99AZGsC3feH3Hx+ZXc5ABTbclG1gdclkr+/K7Qjuzk=;
        fh=2K2TF4rRXf3e4rv2Wn5b/Lm+LSwYTfSniwM2cjzwxO0=;
        b=CNXnm3TcEtWYvQXIMrTgpRQrwbZ5mhGVQr+ZtrCzGC0+GyXgekvaRdccg7pZyIqtGA
         9SKc7suGEzYRb/TS2xgB+ikxjIfMFZx6a6x7CnyW0BN+i5Y6x2MPAq0012gYAZvKBcf2
         mC2YHlODD11gNs2rRyzfz9zKdul8GvwKlx+J0Hww/TP3ACTDGWclrU4fKZ+AoC44lDI9
         LWBonCJD0sOyIQN3PbE47RRXTdRAEZi3ERRvUAf18A/BjVx/n+tw700tv1dLenhioZPM
         XUKkL4rpoj/Z+dDFmhyeOUtvBTP+5bONI/3/0le9aM0KsW0fOB+5H6HvlW3HIR15lk0W
         0Hkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791590535; x=1792195335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I99AZGsC3feH3Hx+ZXc5ABTbclG1gdclkr+/K7Qjuzk=;
        b=XQ2IcHlCzUGoI+aHVwATlYqWC22g/E16vEgE9jVggPlosc1/WaKPU3aBwcaInbIyLe
         oEH+JXWYHoV75gE0ebBQIqTLKM1dd9H0Lm3eHuJS9OREGh2WOFarYHFqhvJemf9+12/a
         EOxXe++WPW6R8R1kttzjJoIYLYUOoFCLYgwEqxW0y7CBuPaL74tO87GtNkEjNOvFTrpr
         KmqpO2pwarlXyh14MC+6ptPvBfbEI4GI85ccVRkemDszgqyUhVoz6tlicEUVOx44xH/L
         N2e9UhUSep6ru55kk8F8LQs7LZLL6qbuUmr/2bSRWzlIek53QzgihMji/Oi/no+8o1TF
         zPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791590535; x=1792195335;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I99AZGsC3feH3Hx+ZXc5ABTbclG1gdclkr+/K7Qjuzk=;
        b=yhfRl5yQCBP0Kg/pl/ggbSH3rxTzrRbR3za3OOxWtgB3QZziAFWyjN9c4pXyaWXBbA
         V8uTonp9h7jH1kFh63rqzaGXD90NiwdPiNSz5a1ea6XRewQnu9ZeWeM8UeuQYZZammCC
         rozYuD9YBKix2wQRLt8JybB0XVLo/DSJXeeRBFHuoXEBedreYNO8nhbf9GFaVMDI3OAx
         1htaIxx5e10ODx+ah1d8dHTgT/ne/WIoEcZq1GV9aWmvTH2JxMGeatYY1fhQZV365Wcu
         pRuB2dQPnhbT2mq/FSlshwdprc0dXuv89JZawbVLsoU7/z3UBD312vYn4mvMhaVPL453
         LSrA==
X-Forwarded-Encrypted: i=1; AKwUvBzkONtyWxSAP52xuOt+wbthNS8jlz7Jgiatz3LPcY22z+tbrBWVQA6Kkb/XR04Gnx9AKUrRUmCkIS8eXhjbmqo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvcYyBxPmOHlq+LutVG1KGan+LYyrxqnUv9VEWqFEJq4U/t8As
	dz610d8v05oqfL/uAnv3GSLfeW1lDz5VNRUlpON3zQvuKuGMRXqm51FVVCbnOg8zRo7XbshXA9l
	eqvqkErNTM0UPmym/Ez53/afT5cM7jB4=
X-Gm-Gg: AYBFou05YsgbV2iDOOJBv/wdRy5iMdge9VJqiqPAEEMk9rrUrygEml5LD+PBZuzwpUy
	+p/mWAu8jNot4A3G/twtWSiKNXclDbrpKcg12E5acYveFiDWWFkySgaod7Icgq8sZ0IZvMJXbV2
	EBTmGOzkeLwOUil8KnzFzJznIOj/gvu7cDpDiKWwTm5Ta2//i/X4WKXNIB/8Wkx4MhAYzncQGtv
	PsbjdM49udyfkaKlqVoRsafMCWpHQs5LMDcoad44+a0kgKrAbBySKWOOLEbm/2oK30G0crsyqVH
	ClMpwxC5vb5YljKlW8z8XSMQVy7sLDC98QUu3rTi9jjTURZtKSA7FFH+EybCi/CY1bb+ZE7AXwf
	VVOrqoiZU
X-Received: by 2002:a05:690e:bc9:b0:677:c43e:c81b with SMTP id
 956f58d0204a3-67936059eeamr1294555d50.59.1791590534633; Fri, 09 Oct 2026
 17:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
 <CAKwvOd=nPgEm=AZbEu12Eb90GtRUThY6YAjSiHHuNVHP8TZHwg@mail.gmail.com>
 <66usntltyie7ii2rrqajy3izxrvwubwf2vqnery552v3akhwo2@xwb4t76d37wx>
 <CAKwvOd=E7wgGPf+kgOY8sGi0xO-cFMAJK4PMBFknoEupJi1CXw@mail.gmail.com>
 <20261009204554.GA778522@ax162> <EF8E7F67-39BF-4382-AB18-98E9D6111CA5@kernel.org>
In-Reply-To: <EF8E7F67-39BF-4382-AB18-98E9D6111CA5@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 9 Oct 2026 20:02:02 -0400
X-Gm-Features: AclHuK8tNFqb0iNpuhNaBpJsUFdnB_vd8X2cSDcjR__CA8pNTmkEAbFNAUmPMiA
Message-ID: <CAJJ9bXzLgzZG+836_2+pUVOWzndSFNoOh8Xu8Pw++_i1RMJzOg@mail.gmail.com>
Subject: Re: [PATCH] landlock: Move the domain layer counter out of the
 anonymous union
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Bill Wendling <morbo@google.com>, 
	Tingmao Wang <m@maowtm.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 7:52=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> I'm still catching up from travel, so apologies if this already got check=
ed, but has this been verified against GCC as well? Is it only a Clang prob=
lem?
>
> Regardless, if counted_by is not working for a given compiler version we'=
ll need to exclude its use by version. :(

It is only clang, not gcc.  See my comparison between gcc 15 and clang
21.1.8 output in [1].  I didn't test clang
 20 or 23 like Abel did, but it seems like we can't gate on any
available clang version.

[1] https://github.com/llvm/llvm-project/pull/228309#issuecomment-608047508=
6

Thanks,
Mike
