Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ECE1BCA19
	for <linux-hardening@vger.kernel.org>; Mon, 10 Feb 2025 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739178763; cv=none; b=UiCHhLtv3afRcoLN3KXKYW3lE3AVhPkUTGefgXk3/J8CIcLTeea+tohCHAk0/Fg+qT79YK9zUi+N6yNDxEDT1IjI9B355LxDi9C+YkqCuUx7ch9HzlxLKs0glq36qF2EPukTqANZH8Wqbmt7mnBcKl+Wmfae+oIYl2zEcRFfm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739178763; c=relaxed/simple;
	bh=KpP0VauWezlZl9zLEnci186WAPTItH41JwByqjcT1Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQG50BICS1WIBxKD0J9q+kFy4USwvM44091DAj+alqkn2BeWZ6Ki/eBfFF7qyvr/1hSMqJFy1CTOoLizGpfxvpgQ12O2TmbLq8vecjZSSQFsQey9ldIgo4oax3zrJbqmCROapS3dltiiMbpzunKPEyErQl7/LKLLMSSCYFPBSyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hx+P1oTG; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hx+P1oTG"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f77b9e0a34so29469827b3.2
        for <linux-hardening@vger.kernel.org>; Mon, 10 Feb 2025 01:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739178761; x=1739783561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpP0VauWezlZl9zLEnci186WAPTItH41JwByqjcT1Sg=;
        b=Hx+P1oTGKLCO6v/M+eJ7H3JyeiB1hcsM+tlDK7/oMd2/I/vf+QAxik82pF1PwInqd+
         qNOH4VM9oshPuBCFABBWYuC6GvdK2+TKQvLUbEuSwlo69Xh+RFUoCPousUJE33X2sti/
         0rKI8r83uLQRfw5rwD7X+3c4S7hZJciXIevSrQZqns+gp5xkBwzaVCCGaJN9w2pOr9q1
         63KNDVsd0VM0D8WrOsH3A7BHRY+DxHkGEKMg8FKxPKkNqdZY6zo4+u+wxk2QAWG12bHK
         OhEwyD0cEkKrihn1ULI3L74Nc/AfZgJQsxmPhUuoZ5R2Y3NXf6UiOpHjzriP6cTk/EOg
         0mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739178761; x=1739783561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpP0VauWezlZl9zLEnci186WAPTItH41JwByqjcT1Sg=;
        b=QM9qY8pjuc/zVEEXuZ0PWcVt3nZL5rFkaS+Dzb2ULTp02l0ApDpMY5Zcz7wWtMDYnP
         AR7VHzQ2NCRfMfThaZaufn3ZKD5FCcoGLDf3lp5Lklw01WQBvYF3mfobsIrl5+kic5bn
         ThjqAoO/JSbQYsns5OZXQijJsjoGitxWn8SxJEMvn+lQU+XVrcHxOmeA2TJVmh/8uGOg
         E0HuQ7sFdYBQyGzpr+B/8BlOGcjI8nT7bMjf8ZEhIqwNL0FNpargTudZlBpa+sajx59+
         gydvR4a528s/hBVmWzzMHDgNxD6kNJ5ZkGagdYdNwfoYpwRi8YnNZfuPSk38saTP94hj
         7q1w==
X-Forwarded-Encrypted: i=1; AJvYcCVE5y0RD45sW4dQ0IK+eSxAzH7/upWbrP77kmAsb9MNBJLbcBf4D7tAtuwLht+auckVHEU0mM9cPZoDRhdi1Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNWI2MIlZkLQJ1/4siWGfoKxQam9jtUZx6HiCa5MZzj3H0tw8K
	HhITMB5LrKVzrmSelHnZJkeuGHOnXqOKcDTJVzeZnp4zBR2uJLeBYyVa/4e5Fiao8Z9mYuYfezQ
	5XrAxI9e1w0kYzbHSdHiyIKYpwFINoxlLiuaj1w==
X-Gm-Gg: ASbGncsOFbyr7frh29hub/RobdrC2QZzTt/EHGtDRGV599/Z45OUeIQyFzHs+BkRlA5
	0HyIGrJIqZ/GtXJKF9vGbArmfBaBvIRL4rx/6rYm8ZRB8OIu95Bqc64KkRrOJqPzREGWO8Rfw
X-Google-Smtp-Source: AGHT+IFAawMg2Nf7mqa5umT0YKscWEuVFFrDSBesMFIgDCoKmA9MK9WP2lFoyGsa/Z/8TYQ1P+7gsxVF6nzcDCRCG5E=
X-Received: by 2002:a05:690c:6306:b0:6f9:4bb6:eb46 with SMTP id
 00721157ae682-6f9b2a21876mr119497097b3.31.1739178761099; Mon, 10 Feb 2025
 01:12:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203121843.3183991-1-andriy.shevchenko@linux.intel.com> <20250203121843.3183991-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250203121843.3183991-3-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 10 Feb 2025 10:12:27 +0100
X-Gm-Features: AWEUYZnXwUXk95Ic6JXWl33Js0Fr1hk4GXmLDnCXzS64aYVBM9dHPxfnvm3rnoc
Message-ID: <CACRpkdbwBB7aS=oRHCkUcZybigXabD6x_z9m_X7iveRakYxLxw@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] gpio: 74x164: Simplify code with cleanup helpers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 1:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Use macros defined in linux/cleanup.h to automate resource lifetime
> control in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Clearly this is more readable and less prone to accidental bugs.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
