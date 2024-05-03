Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83815884C
	for <linux-hardening@vger.kernel.org>; Fri,  3 May 2024 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764971; cv=none; b=ApjZiwWKVbD312QW4Yv42y2sW5Tp+2T4gANOM6Dya/UMCP7NJpOoBSrVhXmjZ81aipOe8kNuI7bv7L6neXSaIdzaP12p9xAJ3jAGUW6DM8miF9kN6Saoy7LiXksemqbefhHjUtCjweGCcU48JgTMJHKFuRKZynNYHhuZX4Dgc5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764971; c=relaxed/simple;
	bh=hBfweb+GcZYEr5/bxAzp1k3NSgb+RSkSW+CIbLIqrbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvR64jdgyY0RTK3DwvaVpMlAfTkUPY9M6EImUnwnEn3KGrI/anWMDJDpVIXnNbF5cQy8k9UF0xWtX8c5zBn/KmN1V/gvB1RchFVFymKt+1fqPQUOJUPJsQh1SrlXorp66T1+e9qPfnfCLmFnGyBvYIbfZaLtxGUAXYKMEcpltsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YSSv8KLx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YSSv8KLx"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so174905ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 03 May 2024 12:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714764970; x=1715369770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS9YtwqoetoZnr/s/Q6BCYI3bgLi2hYXmlOhnf91tPw=;
        b=YSSv8KLxJoK47DH/msAbivGhhocXB4IyR2/7CFlwZ7W4/ft8u66iShjjWVki8/Mbxl
         tj6zLjb0YlrIVPHvnQ3HtFpySbQHdzmE0AfbG3uLeQAcBaJodQEEQd7+xo8PwBYIJdjN
         nvppszCDSVo+RvJpIVbJiWV20IF6wknylCNQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764970; x=1715369770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NS9YtwqoetoZnr/s/Q6BCYI3bgLi2hYXmlOhnf91tPw=;
        b=H4BWB534FozHuzmZoMnnpkBO1QrY1h/2WqgQxwesOjXrccrhihdYpqNB4r5h5jJhvy
         ZrK1nMe1Z91WQpIqx95fQ3Ur6/xLunBfCAUuGbM4OeAKyfRpgVURXzxDjtl8uXkaln9C
         9ZZ+d/BiIhZba66UK9Uw+pYGcmmQHAjHc1JyTF9B4SNg+x4I5G+HJ3eJAyQpV5T9NSCW
         UB1B51y2dGQ+dFiOnfRYnwikhkTAkcg+5XV0w+pF2HoOE1RlZjE7tR5AejoKyMk3efS9
         OMAHt82QDZcQkTPmB2NGX0vW8Mfo1oo1mApOjzvMpSvJAVg4MTWW0JiTZs0B9j17Vwfk
         x1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCU9GiU0X04R+x++8l/teW/5aN91OQsqjxcqts159vU4tNHijgSyairU23u+gcNgAP7/2tKQlEXQ0r2HaZ/mi/mtyVR3DjpOujwF2UL1SS1I
X-Gm-Message-State: AOJu0YwqbZtx99l2rwxpvCk8yjIZXALISqIO6gBR58jYO8gRyShL7fNN
	dlyg2A6VuVDmulCiE+Hig8fDt6Z9Tsc0whBIoI7XThIaEEuyGvWlOCbSJcZzIg==
X-Google-Smtp-Source: AGHT+IFC/8F9Ovu7bGHhulDN2Zn/p+vJxATDZ0By1DvhsuyQKNVhwpT8z16+LTSxWkjHZvQ2PNzCfg==
X-Received: by 2002:a17:902:f70d:b0:1e2:81c1:b35e with SMTP id h13-20020a170902f70d00b001e281c1b35emr4853176plo.54.1714764969845;
        Fri, 03 May 2024 12:36:09 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001e2c8bc6bebsm3716248plb.81.2024.05.03.12.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:36:09 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Alexander Popov <alex.popov@linux.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH] stackleak: don't modify ctl_table argument
Date: Fri,  3 May 2024 12:35:48 -0700
Message-Id: <171476494554.2457276.4385338995352491886.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net>
References: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 03 May 2024 15:44:09 +0200, Thomas Weißschuh wrote:
> Sysctl handlers are not supposed to modify the ctl_table passed to them.
> Adapt the logic to work with a temporary
> variable, similar to how it is done in other parts of the kernel.
> 
> This is also a prerequisite to enforce the immutability of the argument
> through the callbacks prototy.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] stackleak: don't modify ctl_table argument
      https://git.kernel.org/kees/c/0e148d3cca0d

Take care,

-- 
Kees Cook

