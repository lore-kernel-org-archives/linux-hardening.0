Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ABD1A08A3
	for <linux-hardening@vger.kernel.org>; Mon, 13 Oct 2025 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760314794; cv=none; b=m3gkALWAcki7c4QEp58znuGaTByzwX1mkMmMQUc2Snwidr7CyDQFY9QUuNm0IAEWp/NOXxGUbelRqXOADjbco5XmbdrQ7KR3b8gT/D2/rh08cARYMoKM7ChlWqAnqCNHxg0dnbjHrKb3SxFfXdhikpj/eIcJqTklYepckZbwfKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760314794; c=relaxed/simple;
	bh=SV+DunIzUVTWBJ78hxKCfUSi2AinILUQvteKhxogjfQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tyvIZh21yel3yTv2c0h73RbhzAHrNQYa/pmIRMp5DPHZ8EnJQ0D1ye9XWI4aq/KZEe2CDWhkE1TYMrfyAghvglA7t36CIoC1cyqMR2dTy4gQQBGZQlhwRl4pu2pa4CDhqZfBmlnVP/bJZ8Zl4NmqfMPIfaOoo7LTAY5MK/m8rts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IjRSj86W; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjRSj86W"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2699ef1b4e3so8053765ad.0
        for <linux-hardening@vger.kernel.org>; Sun, 12 Oct 2025 17:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760314792; x=1760919592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ6yp3ug3gp30Xy0Uek/d5n0xvfYuEykldX/ZWgCn2g=;
        b=IjRSj86WJBpp4yAV/Aujhr9g+cZU4jJvPIFSW+zrT+1pBzXknK4Y7xhdQmsAJped5f
         LWFseisKttrkoGxvYmGQd5i68oZZFGPuo9A0uBUsXVDd37FQMumuLphFkqSBpp0cTG6R
         uueUJ9A4MuB7zVk8/WjJ74Z/Q2XcvKujRrwfPVulXgb+3Vxdk522Qkw32qTBYA6HDNz0
         ixCN4Fbq/Ngn8c/rvcVM1Fql8RFTImbSObKosx8wCVfaSzo6bscRDF24SaEoNb/6nf1u
         APUsv4JeNaeeNDVJ/OE0QmiprRDu6WtgLOnSAHU4df9FpIIb/B7OJiaPAc2kU1o8zRpt
         jJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760314792; x=1760919592;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ6yp3ug3gp30Xy0Uek/d5n0xvfYuEykldX/ZWgCn2g=;
        b=sZCDhEspgX0VyYn/nkKEKDXtPonPj7sRfJRwEcyzPnwGg/X7JyY2j0C8K+FyTQ+52W
         2RmIxJMZMBgl0D0qb4mYXnTE+z3cC+6REvanzCU4b4v1WBRcew+U/pHeLQNeVX90jJPl
         vOVt7WQM/JxbFMdxpO+LOQNgOxLNZBsVEsDL8oQCYy7a0b5AP2p3XJ04ZV7ughaBNgdO
         5nFPM017MSBUeJB+BpZFlo2nF5RnerKqgRid/PWmveUQ8JprWsdLVBD2LtqxGmDhemAE
         sQTSZECNFnYpSLdhC6KIKqPo4OFq1jTqshVnSfnSWVIeNYwrocZV1XPP/EIH/dBwdWpo
         SWGw==
X-Gm-Message-State: AOJu0YxcsH9Kh1CIEoKsYappHsUariBtxSNpAvUmY9BOzYC9nbTHisNi
	Az8QG4fdByiJCmKHtX+Ufn6IUJvF42DISyIMoqmB2i0mir+0zVvJHf1EM6GjnSzhFxY=
X-Gm-Gg: ASbGncvKi+8bpk2EtSrNenzq0Eux1W1IC+s0uYYjpd7EXtWoVyR0bD8PAincuKXYeij
	9qA34iod1Utwk2KIik3xJhhezCtxfaX/MRHlyyJgtemUzmv6cyjXqoIZZFjXvhvsa1k14/qjWIs
	Gby7LAI22NY1tOrIbpvM0jGGovvxrTmrzkk6JjYGQOvHnsnm74RlJKdi/so1fU+j7/FbZoKSbdH
	+axLsBaYWcS8PxnprXipdR187pWXjku/IA4qZzzhueAlDvPGnjdzxtI6uz60/9ybMbtNnt9sEIO
	O5o4k5jmBo/jBLJ0FUoOHyDnJ2uCyls/mfYq+6RWF4GOizwQl5lpjVlaw+3mSrjn9t8quNhemdG
	8pFSEgOWNlAIXHIF/3KJ0/P7l3VLOvZcGFQmRNO1TcQuCpfpoZa2aKoO4YXMy
X-Google-Smtp-Source: AGHT+IGjjx1VNGnCpiP5A3vgujtOdzuqPcwtN4vHp0jbvJabv/xK4Ctc4Ykk0OUHsRtI9e0/wZ3Nig==
X-Received: by 2002:a17:90b:1c0d:b0:330:7a07:edb5 with SMTP id 98e67ed59e1d1-33b511172b2mr13409830a91.2.1760314791938;
        Sun, 12 Oct 2025 17:19:51 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b62645851sm9679057a91.9.2025.10.12.17.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 17:19:51 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, zhangheng <zhangheng@kylinos.cn>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251009174519.393898-1-thorsten.blum@linux.dev>
References: <20251009174519.393898-1-thorsten.blum@linux.dev>
Subject: Re: [PATCH] w1: ds28e17: Replace deprecated strcpy + strcat in
 w1_f19_add_slave
Message-Id: <176031478797.9069.13007324007524782504.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 02:19:47 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 09 Oct 2025 19:45:12 +0200, Thorsten Blum wrote:
> strcpy() is deprecated and using strcat() is discouraged. Replace them with
> scnprintf().  No functional changes.
> 
> 

Applied, thanks!

[1/1] w1: ds28e17: Replace deprecated strcpy + strcat in w1_f19_add_slave
      https://git.kernel.org/krzk/linux-w1/c/f3c6353d801a9826e234ad477af08b09a98d888b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

