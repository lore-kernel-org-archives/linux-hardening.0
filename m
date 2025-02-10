Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F833219E0
	for <linux-hardening@vger.kernel.org>; Mon, 10 Feb 2025 04:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739160958; cv=none; b=cEX167pw4JASKyXNpj4oHLq0c0s6Qr3lBptLJhpEy8wajUSOoX3n5kfePWrgzH7cGMtyYhlqWzvR+xMBfxrWnKStpJEq4fv2/oa7+1qhw06vvaggINVzNau9Cb95tMqC39pACOYc4BzpONaAXYwalWvFrVgik8XY2jwmePQAaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739160958; c=relaxed/simple;
	bh=3M3JyY4rOW2vOrZgnCjRD0TpnM5NeMnBRPZBQbfP9n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjim1GCikmzuUn/glhOJwMjhqE7CLnL+4M7NUYRj0sgiqoT+exEiSfNqUDMhqaRt48xe1P2DPpmBsm+2p/GOAg2Q+fq5DmxCr1ZIDTb+dvYSALEIV7k74aVbhyMF75onjsv9BXsyUtxSRHJ99DBGbGcbxpo7MkzSehnZZCN9wY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CiolQDvO; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CiolQDvO"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30613802a6bso42649351fa.1
        for <linux-hardening@vger.kernel.org>; Sun, 09 Feb 2025 20:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739160954; x=1739765754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QwzLE0GCgihiIk+dFJwQ0ALU3Kl1sVby5kLip594Ikg=;
        b=CiolQDvONIg+PolEVXKtBwAlZ4I5Cd9irO1OWkOynd3YVO0lJyxI8G7deLCODdab1O
         iwKbMtl2oA5VmMrFojHXK2pt06YJA5YMOGeQTLwQ5XH2wBhlzH8QXMgBZeOE+ypa0qtc
         KlirMFbEaHtcZNar2af/4VaIjrZN/SWUATVMNBoGFEBCaRab482xdawa0B+GkkQo5yKH
         tmuDrqIqN0ki1LFh+yA1ykSbC/IcB57Unb54rcnTqPOEWeLUa1MIQsZ6+UyQNaqp9Rop
         CksYJpEWmhj2Sk/SdAD89z/+Fiu5ZtzI997dPk6KddlzOyNqFaaTDcck5GA3ptr6Uf0x
         K/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739160954; x=1739765754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwzLE0GCgihiIk+dFJwQ0ALU3Kl1sVby5kLip594Ikg=;
        b=ALb3n4BCI2V80UnewY389DFIlP/EI5KWl1vgHnHT5dOQlOD4Ixo1Z5ensnquVs01Vt
         xfXTDc2EYojVtWJM4wPZrTGtdMKM8Cz5MHCfYmFU24oTkPi4gEtm/4GR/Z8XCADqGm43
         iSEa0EsRUK0IzrhrKAdZ1WiRhxr8xh2NRS/ProzMgETE0Dv7cMCOltEizsM+HWeVk1CZ
         YLbDte9nfrr6Ot94jzMD+7b/P5nM6lOLVywSkjHSsSV6s/SaCko+y2+MlAxnD0rratxy
         5oq7MVC8P4qU6epTEhaT6Da02F6n/k/zU6fWouoz6EXEmsjz2UzQjDmlcqhW7Pd84/Pv
         qczA==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZsNAkn1rBG3/Wfn2OjyJ2t+cw8e2fYpXutO14Ltw+s9Uk50pCvEIMlzKiK7VRFflIeRgTpPD1Ci2YjMh/FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjfOVdHaRIWF806rcEnYMH53DZ1oDCRu5zz1PI8WNE1NVtGLBn
	19t0YkXwz3MjE6cE5d3hrx4D978CFOKlq0qUqNqeBXHb42iGsP00PeLaxjvruZ0=
X-Gm-Gg: ASbGncvvfQPjMAtRakUzy9Cgh72qWeceY7F/onqwksMEfHSLS/sV0x7F1ia+7SfFg0p
	8AHMspTCM1ZjzUv1mueyYk//AuC6yz9PHqkXQnztWNoqP9xBNY9P3T5D+jSaQXlmNtN2gRRjgC6
	3q4FrKOFAKrU4jfm/ra45o/5YgBlSQAttbWDV8ANDXQavjXsonjbDrjrRkSG00mCDhdqfsrIKqg
	RLbOWN3FTY5WmhLFcm0tHQDL8SiExH+5Lyw6fG7JqAyk8XRsv48Wylr5wemxqsPcGX3nrTSgxzR
	g9a1kZUvWpIIHA/C3F0dYAiDa71CWsnKB4He3YM1i+idCH7rFArgujvCSJp2dMjjC5R2oVY=
X-Google-Smtp-Source: AGHT+IF5U6ArPZ8cE6ddrQjBGFIlwz3f3qJFMYvqashpqs6GvurvVMofzsRTGb31NHrx7zoqyP9jzQ==
X-Received: by 2002:a2e:3502:0:b0:308:e54d:6195 with SMTP id 38308e7fff4ca-308e54d63b4mr13706111fa.24.1739160954311;
        Sun, 09 Feb 2025 20:15:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de190915sm11354891fa.40.2025.02.09.20.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 20:15:53 -0800 (PST)
Date: Mon, 10 Feb 2025 06:15:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: Fix uninitialized variable
Message-ID: <koye2ppygjsns56xxpdirz5s64kblqjhw264rmfqzlxsx5mzwo@u5t7m2vktfag>
References: <20250209-dpu-v2-1-114dfd4ebefd@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209-dpu-v2-1-114dfd4ebefd@ethancedwards.com>

On Sun, Feb 09, 2025 at 10:51:54PM -0500, Ethan Carter Edwards wrote:
> There is a possibility for an uninitialized *ret* variable to be
> returned in some code paths.
> 
> Fix this by initializing *ret* to 0.
> 
> Addresses-Coverity-ID: 1642546 ("Uninitialized scalar variable")
> Fixes: 774bcfb731765d ("drm/msm/dpu: add support for virtual planes")
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
> Changes in v2:
> - Return explicit 0 when no error occurs
> - Add hardening mailing lists
> - Link to v1: https://lore.kernel.org/r/20250209-dpu-v1-1-0db666884f70@ethancedwards.com
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
