Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC4F12FB1F
	for <linux-hardening@vger.kernel.org>; Thu,  1 Feb 2024 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810511; cv=none; b=m2TZna1C/0iZC+5W1X5hXxvK2F9pzBBxCmjdYKSHK0nyIalpHsqeTDRgNWt6fLRY8PhUX/0bhbOH/f7CMNRqO7jiSqJZgehEcF9FxfFKKOySDQBJkITVwno8tNRUbghHP+UZjFbUhSzh/EUk/F/Fr5DehUDKFrETbCmqLGyUW6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810511; c=relaxed/simple;
	bh=lGh59MfVylmNJEGVvQ0EBkn4B6EIgcQ61xdm18F4Fys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtfYHjbMBd7TwY60tTzr+hsHjwd5HmHpnp2eHHRZ6KaHDdNBIGGDUAxCpii0GwMktwbwSGg+zcVFgCRxcf8Q04x4vHUFLus8zs0vT1kSeAi35p3ejiP5Z5Vs6TnHoCvqpvyZ8BEZv0CJKz+P62QsPyiMWV6BvOmCOOuBDxT1c60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T/Q91HsV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T/Q91HsV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d91397bd22so10056855ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 01 Feb 2024 10:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706810509; x=1707415309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS2urDeY3yGH+J/524IZcRsKebTe7YWaRCtbmg74Jjw=;
        b=T/Q91HsVmxZ7uXs/d2UN/b3ogBFv1JTvgD5LpwgmjR6xA/0+LxpKxKyUVwmdXJNtzb
         CJZIFQNP35dEo3tXNGdwb7bSaG+IDsm6nhCzyx7Xkr3KWMQ7Yx9cmGAUoiJK8+XpDgXj
         dAqoIF0HIFjDknSI8hYI7WlpdwSEhtH2qXbe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810509; x=1707415309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS2urDeY3yGH+J/524IZcRsKebTe7YWaRCtbmg74Jjw=;
        b=MZAO/35tAv5ySKoIzJS/M0eEsKNSM5wY49XDwVGK10I1UZS8OhE90q+d1fg+HU02pE
         o9YQvQQEw1rdLMtWMCAzqk+DxDEGH9vYSZ6XsBKgJ3Dz8pZyogNRyt1QDYxDoXee/8Eo
         kzin2gUBjSueZG3iU6Xv7LavU9MfPyRQNKilxMMLNVRK/Q5Dh+Nt3+/bLrHkS9EmQEir
         8srDbGwAkdzs3OfDMj0sglac6+ECd0HKn/DY9AkCyl5+37nfTLh2AJYAjgkbNn24u5w2
         9Uk7u57SXzDpir+lUNIT4UzxfPg+wM8fFBBLHGqc8dMlrQLj1oM0AVgfOpp3N8XSndmE
         qCwg==
X-Gm-Message-State: AOJu0YzCj6ZBI6LM1P9eAJYqfLkvH0PDtMl6KpU58bqQ25IX37zKrKOF
	fC0MMglt/O/+QkAIdCVzIXiYlW4hrhKl4FGGaDBqt8zlt8/OUKN0SKDoOqM8lg==
X-Google-Smtp-Source: AGHT+IFrMi8un4yA/RB5XIxDPRPbr3qEhaVRF2m0ZWl7C9B1LoGB224WZOLPdvfeKqLRKv67Y3yVuw==
X-Received: by 2002:a17:902:c642:b0:1d4:4e13:6b59 with SMTP id s2-20020a170902c64200b001d44e136b59mr4532236pls.45.1706810509602;
        Thu, 01 Feb 2024 10:01:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWXfkTtzGwoAf3TrNQWvF1aZ2QvtuWxNJk4qXF+HlVBnAkqli8aiM5GhnLYrEHOl3kRz9JhGKzr/SclXG/dYq2QnprZqSuSQCND8+P6VdibDFGyRE/YGUDm8o4a7+QfnE0mffc+RVlaDMhRLu8HlaoEeETmBVKqb7/7mezAEQ3Nlz76T2JwWB8GUXd6RH5UwgaH4YUQYkjICH3qSk0gkefqDr7o3m5YqGLIXCcz7eC0sOF8GlPmsMWpQ6q3EYSQ7Rc=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jd11-20020a170903260b00b001d91b80876dsm89986plb.245.2024.02.01.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:01:49 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: ardb@kernel.org,
	linux-efi@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <keescook@chromium.org>,
	tony.luck@intel.com,
	linux-hardening@vger.kernel.org,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com
Subject: Re: [PATCH] efi: pstore: Allow dynamic initialization based on module parameter
Date: Thu,  1 Feb 2024 10:01:46 -0800
Message-Id: <170681050420.3736595.3520971124875660694.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103184053.226203-1-gpiccoli@igalia.com>
References: <20240103184053.226203-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 03 Jan 2024 15:40:32 -0300, Guilherme G. Piccoli wrote:
> The efi-pstore module parameter "pstore_disable" warrants that users
> are able to deactivate such backend. There is also a Kconfig option
> for the default value of this parameter. It was originally added due
> to some bad UEFI FW implementations that could break with many variables
> written.
> 
> Some distros (such as Arch Linux) set this in their config file still
> nowadays. And once it is set, even being a writable module parameter,
> there is effectively no way to make use of efi-pstore anymore.
> If "pstore_disable" is set to true, the init function of the module exits
> early and is never called again after the initcall processing.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] efi: pstore: Allow dynamic initialization based on module parameter
      https://git.kernel.org/kees/c/c3f849caf81b

Take care,

-- 
Kees Cook

