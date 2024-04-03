Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A29156674
	for <linux-hardening@vger.kernel.org>; Wed,  3 Apr 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180206; cv=none; b=CN0vhBsnsQCpQFU+Co9RvU4jgRNc29r6m2UADXi1ebdlZQYPXtmaVeV3T1VBzkb34Yib/0fckWmDfEVYobjte19uG1+v1fsw0OKOMcVX1jkYYpb4yrqM7hJty3z4LinyAWIAP+P5oz7ryUkK8PLQCFLejQ/hxeOmjjEhQ87ETeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180206; c=relaxed/simple;
	bh=NdBqKp0juwWtRnrAtCIbTx8J+qGB2w1A5P7tVAcCA/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dp4EUJSZZP+VlGIclbXkp+N0uPxYztSqJUYuqAL4Y2MeVY+OlQ+y05aa3e//0l+RJAt+BRbBfAKm/0KL2RKhHS7fYmXMkUc0UMwIWfwl7WM/NKu+hqrw8DALvhTJ3DlVlRQbqgKs2QAbn6nfO5XDA82CLx7vJMwpLedN/knhcRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C6WiZzrQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C6WiZzrQ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso243758b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 03 Apr 2024 14:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712180204; x=1712785004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXb/hya9MuzyVUKh4KO8Jgkudhwo0tzYCFb8lkCPFT8=;
        b=C6WiZzrQZjQ6VK6yvW5QziXTcszW83nEtpB6wyTc10Y7Sr9HjaQiSogPBC1YdQ1Fu+
         HKIv18chG8/woMzNvEmRWRJHR6ukIJ02y2gdP3lGXPYIZyUF8kQfY4BaZ3qoj50wNZ/l
         xsi2zm1iZ/HCNksvn39iZXLpdAFcmbbkcMuhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712180204; x=1712785004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXb/hya9MuzyVUKh4KO8Jgkudhwo0tzYCFb8lkCPFT8=;
        b=PAeSDKAqFeGGhojZSao887mzUlqnZ9TfyZ1iRzUv1AsowlevhHfGrka5Qyr0WDimQc
         Q8RJlxAP5OChA3xMR/47VVCPiDQSe4alCNPbdfxgFmO9sRYlOxlSa7k2b/gcDNI7il37
         hxXLxlsOwMTAImNDtAVSgm0WF3ZoQa5kJaT/Hx1wyUC8kSrMboHbgLXnhc1twsDPlCdU
         dMeou5K8cUdHC+YybJzz0rKGggqHcbF5czJ5envssMNofE+Abvhsm8b16jFOUimnY3CR
         nb5N1Z+9HEp8WW3UYO6QQ8VFkYBvwhKkN3kRuoD7JKgXaqg/uV+SHhK+3jeh9uNA5czM
         uxIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnm3RPM2R53gkZmSRwrz88b8QrqgjRfdNrRD4rVoEDYz+X5vnJK6TEjuiDVvANhEFdJjZNHu63pXdq+cYLL8NCreLDBVA3PAm9nDUnUK4K
X-Gm-Message-State: AOJu0YwFdxNTv04OOTAWNUR6T7gv5oTn5w1Pwof+vQiqV6XwS3llY3A5
	3nPAMerMH9fbTbJCF5P3X7/c8NidTt5nYDKzYhx814K6UGrOUESx9QLcVSYcKA==
X-Google-Smtp-Source: AGHT+IFQ8/7XnV2Lir+npGRY/WkOn5joFd7y+Pw7U5KvNmhECatsiBYh2vrisoxpgesvx1BiuveZZw==
X-Received: by 2002:a05:6a20:9151:b0:1a3:adc3:ce29 with SMTP id x17-20020a056a20915100b001a3adc3ce29mr1090942pzc.15.1712180204577;
        Wed, 03 Apr 2024 14:36:44 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j5-20020aa783c5000000b006eac81fa1fbsm12273046pfn.66.2024.04.03.14.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 14:36:44 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org
Subject: Re: (subset) [PATCH 02/34] ubsan: fix unused variable warning in test module
Date: Wed,  3 Apr 2024 14:36:37 -0700
Message-Id: <171218019557.1345248.1235044277725212529.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403080702.3509288-3-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org> <20240403080702.3509288-3-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 03 Apr 2024 10:06:20 +0200, Arnd Bergmann wrote:
> This is one of the drivers with an unused variable that is marked 'const'.
> Adding a __used annotation here avoids the warning and lets us enable
> the option by default:
> 
> lib/test_ubsan.c:137:28: error: unused variable 'skip_ubsan_array' [-Werror,-Wunused-const-variable]
> 
> 
> [...]

Applied to for-next/hardening, thanks!

[02/34] ubsan: fix unused variable warning in test module
        https://git.kernel.org/kees/c/bbda3ba626b9

Take care,

-- 
Kees Cook

