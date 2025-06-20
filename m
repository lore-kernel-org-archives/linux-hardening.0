Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215C926E6F9
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408817; cv=none; b=RhcfzdCjhzVZXFqzePJP6nMLyHOADOmbdT6Zb9ru59wj3yjSkR74arJm/YfESQWlbekp02GrB0pBrqGD6kUOmDugTzV6LQ4eiPUWT6d8eXJR0bEv1df31ZOCIEi0TOzhbShr0iJU5zAU4yjFOIkZo8MxyWDRojM2QgyrrPvRrC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408817; c=relaxed/simple;
	bh=a3mQToStIF6B1IdwttoHX1nYEJ1tyZcwTnGtOMKW35Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CXo/oJ5xOu8faS+/DR8na8mycCcXLcrQkjUiB+FkDvcPQQ/+MI6BqP4x2Sysg0Zj1k/p87yyj/v2blP2/UfuAGxEo5C4FmcX81ogHNi1cI572m0keP4FoF6YW65RQeX0jmv7qcnStr551pVkUVKaWslA1uQ9/ybsJsXbNTw6wBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=OzsPiecT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="OzsPiecT"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso3439928a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750408813; x=1751013613; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xb6LSPnM0jp92EEKrNM76UM1fccTcugFDTVrUIjKDq8=;
        b=OzsPiecTJAWEDjY3lZVKGcTxZo1IjiJb6A2krnBK+QO63UFoy2xb0TJC7c+x27xhqC
         K8WPcXa8R5ILdCCXOBByLgtcytWRNtmsOZ9/JG/zthzGETQq/2fYFtvwclG094H+UI+0
         nIz53UkqIJZt+ICtDSDObVG9OvQ9ORUvlDGym3Rx80kk+BY9BrFKR3rrtR/BriuTB9/k
         M/9Nc9ti9da3+kBYbgfP9Wv4qci+5XbGRDaxp6aALp25RvhqKygC2Ard7nq2Fz63Xxum
         zc4keaPBkwSVzswBkmkNS+1zSyoieN9aWB+bkf3FQ4vcVozl3HdC9lkHMHw+qMQ/jObH
         8r3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750408813; x=1751013613;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xb6LSPnM0jp92EEKrNM76UM1fccTcugFDTVrUIjKDq8=;
        b=jolSJlmrXYfk4mbpIIN+ShrdyUapBBpcP3eHIEGhquivHelzG4x51QCExhbY4hRo7G
         GOYDiALBODRE/kUauqYEbH079GDtGr86mYq1sHBX92YnwXm+y/rAUwoLd/7RNa6Aj7LB
         vG328Y8rNjHT02lXCrN/bBhhyA9pv8m2kZ1LDYgOQcmoWo7vR7G+A0kIba0UuEF9GyoD
         idPxWAWtxZ/uMcPNOqpOsO7NEJ8d83i1ZsFSixzra3TkLo+Y68/3m/ZHk6LbJ7lprXGp
         KB2y3vFBjkwNOvMxCcy4xT0Q+hmrmeXakZsgIEJZpYrLFuyX+wTqzmLFQbLxffYu64dQ
         5oRA==
X-Forwarded-Encrypted: i=1; AJvYcCXOg4nDXgWNUyvwGHH55juG5D/ynOXCWJMXVz4nTAy6ytxTFea+rfSa/YDicIeaMKznRBIZkfCQV1BQ8N8pRXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyr2TSYb5RBo9n1cTk8mkH0Sj+1R+vY9/xXRC9jCfuYO6dBHok
	IgqS7dyhDPa5MK0IIPUhj2BllhsEj2iXl4I8fj2AdxzICtc37ifDgRbbO4xdY497XD0=
X-Gm-Gg: ASbGncu5kLBwD7etK37++qXwu+XsiX02vawi6V+9qXu1+LwB+phkTYW1sPsjeGnT7xX
	yuvyKiqeuws4d9r6ScogbagEDu3wCHUqJzlwckAEvz/dKWgKCPP04OxJM61QTSk46WgCElevAur
	E1gc2CtvPbPvCxhXCkxhNh0TYuvpTqMUL4+jDgYxXrH3pNt1GSFNIeo9ccu4UAs1AA2+poya8ww
	J4wKb4zgCXAfu4H885iUkgRblWP0Z2Vh+/zOomnlps1AGppPzb/tpcNRSd06WGwivbscg+rHG95
	IIiITtzBkT8BFLQVisv3sljnX+0+u0psYdHfPbTTQaExvd7HIDIWXfyhidDzSx6TlqdTxc1MH77
	xPUlePjjLawp5omZ1aUsGivICpg+TjtA=
X-Google-Smtp-Source: AGHT+IHSanY7BYLP4aWQy8kFVBDTWraG5UXAI4rv0kvSKzHjiyN5FBJKlVrNJSNccFlJIgG0wJH/Gg==
X-Received: by 2002:a05:6402:35d3:b0:606:bd9d:a772 with SMTP id 4fb4d7f45d1cf-60a1d18ee41mr1852590a12.24.1750408813427;
        Fri, 20 Jun 2025 01:40:13 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a1854362csm1084336a12.20.2025.06.20.01.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 01:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 10:40:12 +0200
Message-Id: <DAR84ZHFZOJI.3CRLDTISWFUEQ@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 10/11] MAINTAINERS: add myself as smbx charger driver
 maintainer
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Casey Connolly" <casey.connolly@linaro.org>, "Sebastian Reichel"
 <sre@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Kees Cook" <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-10-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-10-ac5dec51b6e1@linaro.org>

Hi Casey,

On Thu Jun 19, 2025 at 4:55 PM CEST, Casey Connolly wrote:
> Missed when this originally went upstream, add myself to the MAINTAINERS
> file for this driver.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2b570ed5f2f28341a3bcb7b699cbb250ffa2a88..a32e53d89c29cacf6e456258c=
4c7c0206cf8abf2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20565,8 +20565,15 @@ L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
>  F:	drivers/mtd/nand/raw/qcom_nandc.c
> =20
> +QUALCOMM SMB2 CHARGER DRIVER

SMB2/SMB5 or SMBX probably?

Regards
Luca

> +M:	Casey Connolly <casey.connolly@linaro.org>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.y=
aml
> +F:	drivers/power/supply/qcom_smbx_charger.c
> +
>  QUALCOMM QSEECOM DRIVER
>  M:	Maximilian Luz <luzmaximilian@gmail.com>
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained

