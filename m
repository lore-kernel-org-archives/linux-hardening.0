Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E45427E04D
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410085; cv=none; b=FwTEpcbjj7DmU+ncVOe6eKYDHaN7bFDKetrKsdmRdk33vGj2QrPdydtbqkyhQk2EpIHEDSUV/Xl6lpXYIZUV9WlWlbLk1Gbl8RG1XuCGDqnMvVVJ4wisjFNcPWyBPMCf4LUfVJzZ32TPBqV2WFufiQUweTVg26qrXvk7uZ4ZCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410085; c=relaxed/simple;
	bh=YrP2gC6yzF7+01sD+adEWpkCL/eUCTLHQ55D7CZnBEA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tjQu4hnKOEJ8Oz1XVSMPHnUJCe1v98DMG5KllSYh2VmOtijncg9NguoB9lr626Q1y4vEfN7aUPHevOeW4oj/lYacbVBgTpjV9Zr31uJhdsrcWkJjP7wkZcFt2XB8wX/2XVVhDiH/hmXjcGjjXUBK0XC3a0WHQq4kk2nDaBb8Boo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=LGsGSgIV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="LGsGSgIV"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae04ce9153aso207806566b.0
        for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750410082; x=1751014882; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSgGeI6RPkNX/6Nx7o+CdwyAntQHm7sGCCxVWOem2w8=;
        b=LGsGSgIV1QOsEbm4P8phGCqfn54CXCS2MA4qCKXCKvy1D+ysntkeA6eUfd6A/5Ub0J
         SiS5GSq1elwhdOwPPSRAF3l74NdM2iq/v7t5LfHzhP6SoZGQ8QgcGTwPF84dCmeqCoVh
         arvmepCP86SAv3phx/hBcXy9RFKLBqRRGU8MKAKjIXlUljB+UO/riQ+7H1xOLMItb4/f
         VDdgI/qCaVpKvVKlhQav5bscnPapHoX+LMfLG4yddlLknU1YY4sOswuZbgDmRmNROqi5
         ZYMvN6XvaZakG5yNZt8q7f2chKhrp4LENsWJcj56Evi0nj3vIJmBQlO6tQkoiYNKn0ro
         MM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750410082; x=1751014882;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BSgGeI6RPkNX/6Nx7o+CdwyAntQHm7sGCCxVWOem2w8=;
        b=j+qUG/B/AHu5eyCYlrowaTLcHFA9peWn3QnXwq2GnsuGqvVEHwS/LwJi762jy1Qlnq
         w7eXwPPPj9PJumYjbK8SqdiwaIijMyGyS2k1KE5SofTTf14Q9yiU8tnla/0UrcLZoXSM
         THW1A5bAAMytaqHrIYa5sfva8wzkZ8ji6BOalWmjnIxKQoTR4Rdt/n0AIdJ4Hyke06dT
         0Sy24TYm8l/rwyUjXqrf7lbI3aaZT/WAjb7OFh8/899vxfNP/zMQR9r87Cnvsa/BXhy3
         iAa06CprLq+YNiRf2s9I84u/5cyPILd8foZ70Hg+7RaJF4dNSbXhYpxXnPU41IWKv+Qt
         x2Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVoVUESOnX0m+dmuKuNjmE7jBVX+/ufsY5Yd4Dvlk5/sn+bM6cNGAL1WmpnBv/d6X/Q/e7YTCBKn6olhQD2ApY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLxzKXPGtTQ9rC7DrXm5sZyFOVOgV9G5V/5+E3+Ca1qmkK5D9w
	lXh0qC0MU0CLEEKvWOjrLqcccJemZIPVio0M71wVG7gk8mX3KyRn48g6rmkhhdYpuks=
X-Gm-Gg: ASbGncvfC9C6/mSorifHorXaI5RMDM42fw/gw8vzz0axhIsyX9gwKTJiG7JyNuxulHM
	FqYLwn/F2xOOwvo7IrWu2DnDhiP5qbtZ5Fh4p9HDDUIx1ERpudjkvV3CMERv+dJtYxAheAdnFDT
	+W3SiQz5IajHK51vGfNPSKM5M4oxJmq6gM/P4y1xODCVsI22V0T8/nc/vbC65S0+jYD68Zxi33y
	wpV6c4pGtaKeOH+lhgaU3diMLH3dRLmO2QtXEjqjJDmZeEj+GT8nm2EQ+TNnoDsqyQ+RnXMWdM9
	ytEnoB6SZlBTSZO0kC/RuK9+3juYeU1qrKLQllK2tBt9R6zqjkqiIgHCSPMiCeMDIrNg5VAUlca
	epByB13n6kixvwV+GtYe4mZYkKUgsLGIv9aQmbv9XQQ==
X-Google-Smtp-Source: AGHT+IEhyS+3Hkk2TlhfDWZUPUo2xBTpBDeJOyfp0vYr2FDqO4tGaGom5OMtaz2UPfLrKxD1kEZb1Q==
X-Received: by 2002:a17:907:3d16:b0:ad8:959c:c567 with SMTP id a640c23a62f3a-ae05ae211a0mr151097266b.10.1750410082254;
        Fri, 20 Jun 2025 02:01:22 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae05408300dsm129887466b.95.2025.06.20.02.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 02:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 11:01:21 +0200
Message-Id: <DAR8L6C8LIOH.A6EGWUZJ2NN4@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 09/11] power: supply: qcom_smbx: add smb5 support
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Casey Connolly" <casey.connolly@linaro.org>, "Sebastian Reichel"
 <sre@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Kees Cook" <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-9-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-9-ac5dec51b6e1@linaro.org>

On Thu Jun 19, 2025 at 4:55 PM CEST, Casey Connolly wrote:
> Introduce support for the SMB5 charger found on pm8150b and other more
> modern Qualcomm SoCs.
>
> SMB5 is largely similar to SMB2, with a few register differences. The
> main difference is the new Type-C hardware block which some registers
> are moved to.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---

<snip>

> +static int smb_get_prop_health(struct smb_chip *chip, int *val)
> +{
> +	switch (chip->gen) {
> +	case SMB2:
> +		return smb2_get_prop_health(chip, val);
> +	case SMB5:
> +		return smb5_get_prop_health(chip, val);
> +	}
> +}

This doesn't compile for me:

drivers/power/supply/qcom_smbx.c: In function 'smb_get_prop_health':
drivers/power/supply/qcom_smbx.c:588:1: error: control reaches end of non-v=
oid function [-Werror=3Dreturn-type]
  588 | }
      | ^

Regards
Luca
