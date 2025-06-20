Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1F32550B3
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409476; cv=none; b=WVf3v6yIZwym3T235y/IWkiYx+3M2lqnDCQUbJgBE1qXngUBrqQ75tr0rTS931giYm8J7EITZkjhV5aYRjSIKXt20jTvVnaJey8OPAmRyNWA/yjkGf6YkmSdkETfZYKIsAo3pSWwjpUvMgR1I0yXUC8ngLKfXPp7EnE3evNyYZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409476; c=relaxed/simple;
	bh=41+NV6wm7M4BUwGUu5BfX6Y/1mglDykUJq2/D+L+bV0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=muOWgVMoTKDeMCEZWp13sIigNzhzluCQy+fofFu0Hbw9jQ7FarJxOp2HLOOycF4S5wbmtQoRM+n6yYKD2baeQP1dc6htpX7pg6Jq/WIODnZ5VcdcApdf2mhg3jwj9bi6zbJDSCg7ORseWuW+3GIgye95DOnV4ncJC6m9LRbKl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=eElRhdTF; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="eElRhdTF"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6077d0b9bbeso2574046a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 01:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750409472; x=1751014272; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQs46cNDxNcEM2859ny72mW8pcAVQ7BIEu+RAnGt+Uk=;
        b=eElRhdTFqyfet3zX6SJ1DemBoJg/QYIVepXir4utb5zKu3ZxnIQpSDe8Wb4f2IeYlv
         c6YoNmHPjPVqMTBfMpoup5C3PIFs+jAuldaiJy5wWPS/o9WohoWF5sUO/2aRQPS4lgky
         JxhAlYByweTDsfqvJ8OGmK+gNOvF48TvrdZVnH58kMiaVh4njA3jXSfF2AunQzjQ5jKq
         COLm+FZQSG4PMPsfsxeCNYl6mbsKwLSBCVrU5ms9jJKSiFYiMm1fBJbYLNhBA8yZeGXJ
         wIiMp7w4tAcggmF3uxO1ArOmUCHu8FHJSIyhKJnYGXi1XZ6cbfh9mWnlJlxunJ/kqXr8
         3KSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750409472; x=1751014272;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tQs46cNDxNcEM2859ny72mW8pcAVQ7BIEu+RAnGt+Uk=;
        b=MvqXssetR3NHGDTRrKqHCiOuhpY7+AgbOCLKijXqDXQMB54I2gLxNzHffKNAwlOGkX
         CCQo1xATMTLq5lfRa3vTayhNZzlG35qpJ08t30oAMP2Va3px94q18M69RUeLc6LMCCZf
         5HWGNzW7Rk8KLuLlY4YDi0qmEjypnxj2aQkoj+MOF756T8arWx+snlxq2aQX8bTI1nPl
         6Fl9eqxSHHxbwR6v82u3m4SrfUmMJzL8UsxAvkQsOk0yL5WI5xixIDz5BTDpn+4fwWkw
         twvpcUdQu815dJcPAJPMSCgE7lxDCEFTAzVUd5V6PxPXz2I+6PjsW3UnSzoyuTjAVKdp
         vT1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2z82O6MwYq+zw72BmBGlD4rEAH2veSeA0xHsanXT8t/xTSCQToTZOcLsmDBgK6JWTCtNaSDdcoc/Zl3M11Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJfV9cx2/wSYq+2Z4XUr9np2VwzQIDh9xkdMsYIWCfJh33YwF
	40UVupuvtmhy3Rg0HpHmJA9nfNeArm4YEXdCE7T1lR8w3DbPPohZPRovhAtuBbjEyug=
X-Gm-Gg: ASbGnctp1IOuKH8gUqEB15uECLIzI0eNLjw+Pj27amGkgTp6XA8HecwnEi565pX9Fp7
	/qjeVSJ/LCkmhgskEl62nyCakHJuMBwzHHI2htcr1qqK0I8ecJ5kdv6Hqs52IFOorH5uKgEsPzD
	GqUj/iIzxdBUX+dpMdj9wOD8gyJ5kPY9O1s90+WBWXBkmDdB+dYFejuwAtYMnO1vM+HIkZZwTBx
	aGxaGAL3NN0toJOJRkJRfpE5JvBVsqa+P6eGGbA1DtFvAlte8KHzsNlrAt6t9IQpXBOAJk/pp/Y
	ZHMeQf6MsESxeZcSgJraUSg1vGcRYWkHrM7R9dfYN3h/2ayrVgsWjaO1hig6rdTNJrx7sYqNZ5y
	VHqfaSKCFQQBeQ7tFNTI9mcjNZ6IL6C4=
X-Google-Smtp-Source: AGHT+IEmFiflCY72gns8BJi7+wHzY3UkumCt6vc+CYitRi/cG7BsMF02qzVY1w31/s9Tg+2mrG6kaA==
X-Received: by 2002:a17:907:f1c2:b0:ae0:635c:a400 with SMTP id a640c23a62f3a-ae0635cad5cmr13076866b.51.1750409471648;
        Fri, 20 Jun 2025 01:51:11 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541bc9a0sm128495266b.146.2025.06.20.01.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 01:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 10:51:10 +0200
Message-Id: <DAR8DDUQ8HM7.3IKL9TCT7SJM3@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Casey Connolly" <casey.connolly@linaro.org>, "Sebastian Reichel"
 <sre@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Kees Cook" <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 04/11] power: supply: pmi8998_charger: rename to
 qcom_smbx
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-4-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-4-ac5dec51b6e1@linaro.org>

On Thu Jun 19, 2025 at 4:55 PM CEST, Casey Connolly wrote:
> Prepare to add smb5 support by making variables and the file name more
> generic. Also take the opportunity to remove the "_charger" suffix since
> smb2 always refers to a charger.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/power/supply/Makefile                      |   2 +-
>  .../supply/{qcom_pmi8998_charger.c =3D> qcom_smbx.c} | 148 ++++++++++---=
--------
>  2 files changed, 75 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefil=
e
> index 4f5f8e3507f80da02812f0d08c2d81ddff0a272f..f943c9150b326d41ff241f826=
10f70298635eb08 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -119,6 +119,6 @@ obj-$(CONFIG_RN5T618_POWER)	+=3D rn5t618_power.o
>  obj-$(CONFIG_BATTERY_ACER_A500)	+=3D acer_a500_battery.o
>  obj-$(CONFIG_BATTERY_SURFACE)	+=3D surface_battery.o
>  obj-$(CONFIG_CHARGER_SURFACE)	+=3D surface_charger.o
>  obj-$(CONFIG_BATTERY_UG3105)	+=3D ug3105_battery.o
> -obj-$(CONFIG_CHARGER_QCOM_SMB2)	+=3D qcom_pmi8998_charger.o
> +obj-$(CONFIG_CHARGER_QCOM_SMB2)	+=3D qcom_smbx.o

While you may want to keep the CONFIG_ name the same, the description
should be updated, at least in the SMB5 commit.

  =E2=94=82 Say Y here to enable the Qualcomm PMIC Charger driver. This
  =E2=94=82 adds support for the SMB2 switch mode battery charger found
  =E2=94=82 in PMI8998 and related PMICs.

Regards
Luca
