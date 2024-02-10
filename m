Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC9414010
	for <linux-hardening@vger.kernel.org>; Sat, 10 Feb 2024 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707546670; cv=none; b=aRAFBbXHUnICAYhWxA/J/RfBZ+oqwAisNG+r4ZoGwB3i1BGEQsI0spI9uD0O8y7m8dJmXXCYX8aX6bjVUTrIGJhwOyGByH9aqITy+uaYnxbxQHoNa+umezl3e4g9s8PeB+3I11b65BTq2O/YGd3V1l00D7gyzHn2O1n29SbOtZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707546670; c=relaxed/simple;
	bh=oEFPGDlqXEyocwhoWKRMJ4ziIc3upKjM4O5Rg/7Y5HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/2+UbrXEEhVnBTNL2igkF7Ns5NEENO9KW3MhhnEKynVP6ejKpV6Uy/Q2kKIqYuVtpCTrXshmKmt8ve4LVhMUm6yCwm9BQx7N9F2bFmrOzo/B4xLgSm/aDF7yJHIYc9+5JdMKee4nrBHhv55/EjiwvAHie9QuZOLjzSpINwrngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jzAg3/bs; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jzAg3/bs"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e04fd5e05aso1127046b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 09 Feb 2024 22:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707546668; x=1708151468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xoLZGjYDgNhuH6I83/DOtjfO4FsY/e01Dj2umhInvU=;
        b=jzAg3/bsxEdFZwBOTEDYPTRa296mXeJf8leYMbASt09CTEjWBCAgCCQY0owH40d/3Z
         MOHcAK0MHp+SBtfPFJYGxl0Ytx7zOeSspk4V/V44Gk3PG43iCaLoLk5sL1v7Kp1JnZwm
         5oGNK6U7RhvoGGmD8NrJ89XjzOecSM6E9LycU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707546668; x=1708151468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xoLZGjYDgNhuH6I83/DOtjfO4FsY/e01Dj2umhInvU=;
        b=WCgGPyosPrce9Rb2kzXhBI29nE6JLN1gQZmFHJnc4Ln9rnEn1tIgXF++xBx4PMJSdN
         bJxJ3DkdMBietegLkGYm3ibbKlrdR+r/o+MhXfaJrO3tGirOvAjR5bOb5atYM/nt9yy/
         FTRbeAhrgOmdfCmP4PyD6j3TaB4FODYojjRd8FW3QnqObtrlCVsQNxcaqq9bM8w12bay
         R/CGRzws56YJ1HxVTRrxAvYS2ee+x11S7MbXLn6Hi7xwuGTgaNhKGAWIdMRwX7u2mFj9
         4G/YFCF/XojSVkT0WmjWoqG17AmhPw7Vw5MYKbAem2HhVSaSnPkrjPY+5NCkhoXs7h5z
         2Faw==
X-Gm-Message-State: AOJu0YwHWe9BY7agAmjGPWcuIZthRpVV4F5n+Ed6Br2SYKEiLIkZWz/x
	+Xh7ueTFjbRZQ++FJWlwsobhJzKEo7/eqwX69scyqKYfPoXKRLu4e31l16rrfw==
X-Google-Smtp-Source: AGHT+IGIjsMjH28pAXwc+S4f0NGXsC9lvIPOn1ZKQThtlNQlz7+q0LVvVrnSA61E2r3dygZ2dIbtIg==
X-Received: by 2002:a05:6a00:2d04:b0:6e0:4b81:907b with SMTP id fa4-20020a056a002d0400b006e04b81907bmr4279382pfb.10.1707546668009;
        Fri, 09 Feb 2024 22:31:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeR16fEjgRofT9DwwK4x/w7h70DzSFIY/iXLACRlUQdayJfSewmuJCc/Zyfwu4iS0RIK7MTqZ9DCo5WgFTvLgmHg8s7QMnseCkRupMh/7UQf0sM2oHIrucsVlB3TOT2EQVLQxirszeZNbEx09S7juFayaiRnl1Y8lJ2wwNNmVxHOsG0MTwbnQ3vRvQeYcAKxKiAut/9d02yoPayF23AUefe8pdwlBdcg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z5-20020a62d105000000b006e08437d2c6sm1705037pfg.12.2024.02.09.22.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 22:31:07 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Drop obsolete configs from hardening.config
Date: Fri,  9 Feb 2024 22:31:04 -0800
Message-Id: <170754666057.1708532.12818016531447895933.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208091045.9219-1-lukas.bulwahn@gmail.com>
References: <20240208091045.9219-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 08 Feb 2024 10:10:43 +0100, Lukas Bulwahn wrote:
> here are two patches cleaning up the hardening config fragment from obsolete
> config options.
> 
> Feel free to squash them if you think they should not be two separate commits.
> 
> Lukas
> 
> [...]

Applied to for-next/hardening, thanks!

[1/2] hardening: drop obsolete UBSAN_SANITIZE_ALL from config fragment
      https://git.kernel.org/kees/c/8ab2b5398287
[2/2] hardening: drop obsolete DRM_LEGACY from config fragment
      https://git.kernel.org/kees/c/8dafd56868ef

Take care,

-- 
Kees Cook

