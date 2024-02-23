Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1526295
	for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710097; cv=none; b=u4EOGckZp9iGJ/RACZBAHxic2NGVHiAzp5yEXf5xS1VmlSavywxoPoCwlgaxqaleoVsDmJm9ifxJufcM3MW3ylaUd2kFN/Rpn+97PWfvM6d7/X4iMoWbVImBB/xOPSVna1sd/w4Pa/qupr7G450vQP2lJV6T0ZQ8NNPODD3AXpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710097; c=relaxed/simple;
	bh=/cfXkZKvvqLcP6jJz/p/9gKAVQOgMwem9pa4Afsc7kA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHqRrGAnP7wdRMB5f7ldxF+akFzl0jGfpc3qmpjU1+T3heT1svTe6BXgKj1Xz/cnwuE5cjMM0kCksvCTo8tcCox6wUHeO7GzOKAW9qSuF8F4mLVUKx6rZtv8KU1QXJn390fGBgWENTCGSoVO/KLetaVGI3h61gcC9dyTs0JOhe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cUu8XqDT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cUu8XqDT"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e4ea90762aso364857b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 09:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708710095; x=1709314895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7UJGfjTB3r4rfNyh0P4i8Q6gZhf2u55+l1+DfEGGmQ=;
        b=cUu8XqDTT5kMpTqn5S691Bs3VKzmlw2lYY4lIB38fFiTfArB/bb/EQsvv4iJKaT2ai
         z+taZH+uDt1tRkhxm5tC4bN0+FZzqHyz6bqL6DC49ugpEKCQGEV4f97z2m9DCbefoG4R
         0dwcW9+MRmwC94yoYCXIO/PFbwhMsI4OMIfYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710095; x=1709314895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7UJGfjTB3r4rfNyh0P4i8Q6gZhf2u55+l1+DfEGGmQ=;
        b=loLek4y+HZETi+Iei6KZJkH58ky5GsJM3ABgflsg/ghVYo09MuLzNwJe3+grsuAp1y
         V3e5kwrH+vzsxmdYEMGxCUVFLtWKLtxoCc3yNRV+xc4ramRX1tQ5Fx5wm/wgIDGNTmXb
         S/oqNl5PFiOhmG6RmOBnyLHUzQN+e9Ym411yZyEZPodgjst08eLg+ZQc50xTCP9xAwHS
         pNuKsluoSdATaYmaIjEqn/VMfAFfkt3kX/3kaOvk7sTiukEmP08/W2KdMnMlHQG7YBWZ
         /crij31XXJMZsu62dYlKTy7Dg/AQErs246PfAm/UP6lMUZBCfO9kAFiuOXN7BLwkAdim
         Fpvw==
X-Forwarded-Encrypted: i=1; AJvYcCXlJxXzimYSrAhT3ShDB+kAarIqMfCY+WW0vKNZUoDjBd+1J2uVEksULUmYTJQNnw/K+65lBQLCGjG/pYdwyvHbaH0cMhw+N6s3KQht3E/3
X-Gm-Message-State: AOJu0YwpMIRU0+sn3YEkwm1tnAYgTfzk+T39PZ1dA/cJ2Uct9/pfevjd
	iu+5J3WkvirSiF3lOx1cStexoMsWJR0tZShJK32yBgCq9pT3nzRAW+ci8fhXBQ==
X-Google-Smtp-Source: AGHT+IHI3sboCzzLm5bJGfvuXYCbUIC67s5dRbVsLDDPz+tIpD5ZqlS6VGpG8bKgUJgEkZhff7aV/Q==
X-Received: by 2002:a17:90b:23cb:b0:29a:8e6a:ffe2 with SMTP id md11-20020a17090b23cb00b0029a8e6affe2mr575548pjb.26.1708710095280;
        Fri, 23 Feb 2024 09:41:35 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r13-20020a17090ad40d00b0029a7df64720sm1586705pju.53.2024.02.23.09.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:41:34 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] kernel.h: Move lib/cmdline.c prototypes to string.h
Date: Fri, 23 Feb 2024 09:41:28 -0800
Message-Id: <170871008605.2107490.16630176763358283551.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003130142.2936503-1-andriy.shevchenko@linux.intel.com>
References: <20231003130142.2936503-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 03 Oct 2023 16:01:42 +0300, Andy Shevchenko wrote:
> The lib/cmdline.c is basically a set of some small string parsers
> which are wide used in the kernel. Their prototypes belong to the
> string.h rather then kernel.h.

Applied to for-next/hardening, thanks!

[1/1] kernel.h: Move lib/cmdline.c prototypes to string.h
      https://git.kernel.org/kees/c/9f938458a5dd

Take care,

-- 
Kees Cook

