Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602B01FF5F9
	for <linux-hardening@vger.kernel.org>; Sat,  3 Jan 2026 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767434578; cv=none; b=kLveooRUlX833+vgEcHDvqD554yzmFpb5Di+wSFy7ge1zTy8CoC2i2aVXS862+lBH4SAhCOCXRrufeUgvk4q2nS2M+u9+unKQWsMR9bIv2uvjKALBzCFpfFNoYap259xlxOKHkVSVukzufucaztcdhhm66EN7Gu/cJjKfDwtXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767434578; c=relaxed/simple;
	bh=qPbRsMMm0OalGU9qVWShgfi/u94dI5ZvzdhcCM49xKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPizQIZZwEj4U4e3CQrqk8/OAS+M135kkM8C0Lnbgou3ko2k+i/J0gY2VeYOw+bMcu0mh9JVG4a6pK9dlOL5tw14BiceU0EO6ADoUNUqNwPv8QR3BGri8wOMUuB9TSZwdOQbjvzCvu13N3CgKyRC2vq/lsK9/dNMmLQcApRcjyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FwgzKfIY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FwgzKfIY"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so6025979f8f.2
        for <linux-hardening@vger.kernel.org>; Sat, 03 Jan 2026 02:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767434574; x=1768039374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVMxWDM6IlrZiTwjie+uTeOt+ekq2BmDE9odN218w14=;
        b=FwgzKfIYM1ex2C/PxtpeVUnJAA+ULw7L2VMcXJqrCfix8tgyA4w/nOGqo/3NUkQn8J
         lDo6qrMLDBd+lORO2LSqRhF0ScNbvTaSN9oy4v/o6M3wGRBhFDQ1MPNjt3ib6iIqIu5+
         +O1YrMfn9B8Jjr2xunyKhHpJSpltlfDN+eZ87dpNmt4l+k0CDH7pYiihKqcXZuPHY2sx
         dSak1ir4ZQ4hftt/bGNrtkQXvm4zBQnxSN5iL+qH3hTAxAFwo0eCvbJ7OrIGnV88OQL6
         Ukdr8zFlwE67pOXI7CVx0wND88xAQ2g7mhVxR3ca/pIkESKER5mjgewzbuInPc2F2aYN
         wHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767434574; x=1768039374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVMxWDM6IlrZiTwjie+uTeOt+ekq2BmDE9odN218w14=;
        b=wm7ZsYi8ZLwCex9RgeNxDOt4rIRFJsznOdxKVBF6NOfTSKVvSly0HklOmv8lNFkpMX
         xGmStXgEK1RSLSpW3E8oPvjzV9X1UC2c4U8o3l15Tc6uTK9nthivrZg+eHdpHSAZT9J8
         A/9bG0mhFyMzr/3msw/uzaf7kDwMC33Ixe52277m15FMDOZrgqJo5v075Qv0q+ICdESg
         S/0hsAEF9oCgOE1j8nFAmTNqb1VdTy6HZh5fXbcrjs//L5WEhhiE/tpCv7uMIOHlSMJt
         HN6s1/ZLMQrlXtZcd8dVrQUAc13oBRT9hcA5SeOMjELACvlAww2UnCFgKrihJaUSJGM5
         cguw==
X-Forwarded-Encrypted: i=1; AJvYcCX2HvLZNcnUODnBlbXtK/sFuqfWiNXW4w043kFVTP4bHxMgjzy0vOwo44SR+dWtW6sGTIQtETpvEZS0c+izZH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfbtJfRJax4XSFBgq5kkz9JrvaAvxt41fSkd2idjpNzbiW6Bi5
	tsAxvqx6TfPVkfYefeOr3aqX1p2Dg2XRQT9F1m+MhPiSUkRcbtAnmR2VPwUzRG0OpAk=
X-Gm-Gg: AY/fxX70oqTbSj2FTnCo8CZi4HIQLx1SbnAvyZfbr9A+eRsw8LweN9gEwe5/Dhp34SU
	lonFCZQ32bdqhfbRJzFovSoLuBkOlW/pXEPD8YCc3dk/qG8ITjaEiNqrlb7xu50MRz0OeW6s7z9
	woRTxQg+AQ6iJxrnzE6iBldHAnL+mGFSHD81nVAoH4HkT4H2gUq8l53SzLr3R5b+GLJhiLB+AfS
	JRm8JTbLqUpx1cLfvowPHtOTERNHJEScUiKtwKz1DR6302SkCv0aEjPObWeAVo6inFyzt5XKrAc
	XGN6Pbgr6sQrsO9k90XY1gQ+ik/KzrDtpLIbQ2z1Pic88lOsj6v4msfobzxIMMKYaH0Mx/UCyV7
	ZN9ddBJ3bF+5/e85n6GHmhw4rXwJZ+8SFpGYZ+q5s++SX7r1GrbjsSt8i3GQ+KZAuUYaqz7xUW2
	mtZ7bBUEHwupPU7vIDUrGT9dDMNA==
X-Google-Smtp-Source: AGHT+IFPkanq3RHUbcsbNCpasG6Z313jdsfGQVH9J5om8n/FtqWwK7E4sTbdu6zUmursa5ksRK1pIw==
X-Received: by 2002:a05:6000:3113:b0:42f:bb4a:9989 with SMTP id ffacd0b85a97d-4324e4d0fc1mr49661835f8f.28.1767434573075;
        Sat, 03 Jan 2026 02:02:53 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2a94sm89174903f8f.43.2026.01.03.02.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 02:02:52 -0800 (PST)
Date: Sat, 3 Jan 2026 13:02:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
	linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] overflow: Update is_non_negative() and is_negative()
 comment
Message-ID: <903ba91b-f052-4b1c-827d-6292965026c5@moroto.mountain>
References: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
 <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
 <acdd84b2-e893-419c-8a46-da55d695dda2@kernel.org>
 <20260101-futuristic-petrel-of-ecstasy-23db5f@lindesnes>
 <CANiq72=jRT+6+2PBgshsK-TpxPiRK70H-+3D6sYaN-fdfC83qw@mail.gmail.com>
 <b549e430-5623-4c60-acb1-4b5e095ae870@kernel.org>
 <b6b35138-2c37-4b82-894e-59e897ec7d58@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6b35138-2c37-4b82-894e-59e897ec7d58@kernel.org>

Thanks Randy, for sending this to me.  I'm on the sparse list, but
I've been on vacation and haven't caught up with my email.  I can
easily silence this in Smatch.

regards,
dan carpenter

diff --git a/check_unsigned_lt_zero.c b/check_unsigned_lt_zero.c
index bfeb3261f91d..ac3e650704ce 100644
--- a/check_unsigned_lt_zero.c
+++ b/check_unsigned_lt_zero.c
@@ -105,7 +105,8 @@ static bool is_allowed_zero(struct expression *expr)
 	    strcmp(macro, "STRTO_H") == 0 ||
 	    strcmp(macro, "SUB_EXTEND_USTAT") == 0 ||
 	    strcmp(macro, "TEST_CASTABLE_TO_TYPE_VAR") == 0 ||
-	    strcmp(macro, "TEST_ONE_SHIFT") == 0)
+	    strcmp(macro, "TEST_ONE_SHIFT") == 0 ||
+	    strcmp(macro, "check_shl_overflow") == 0)
 		return true;
 	return false;
 }
