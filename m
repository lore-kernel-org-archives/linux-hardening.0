Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC738DC3;
	Sun,  9 Jun 2024 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717937038; cv=none; b=PhzYTslU9+htlb1+flwUcuFV0yS6sNWPU5PIh/41mgqcuEB/hP458BtOhPi1UTw1GleQAde8zc+N1lVPNuBhHLG6Hbs4PG6nFQRsk26iSyqqEZlMTHD6lS4XANpK95v8ur0CcSJpiTyb0PQURGuzPmeyessoDJDTXf8k6SS8aCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717937038; c=relaxed/simple;
	bh=ftckS2Uy+EaxPqpxARW/p9vVImlaebLo7LGaNO9aVM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EIJNG/OpaVjNRwwpQSkUvRqEZmxjQ3ZFmAyEyBrA7jgeQpKO1PSzbkTUIgJ3Q2m9h+Ml+9EnIHLDTEaaJJ4rg/BUMh08hnDZfGokIEcjL/8mdKwc6lKuGIsF8F2cpKXjul+ZMC/p11Th7gTsduY7qVH6pGmRfDlJN47FoRiSMro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bU0IA91q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bU0IA91q"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f6559668e1so29817825ad.3;
        Sun, 09 Jun 2024 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717937036; x=1718541836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftckS2Uy+EaxPqpxARW/p9vVImlaebLo7LGaNO9aVM4=;
        b=bU0IA91q1jbv0MaywdZLrZenfRD0Ikst/0R43LfrUC0K6bH9n0fLZr++k2ae0jYwUp
         V1I/p/D1y4ZzRaHJcaUdLI8f2rSTLM3WcE3Dd7ekxN17csO6uTn89m+8pD/93/+2Eyv5
         PvS83E4dva7C6jH6UaQkZR+r9TdcXt3SBtK4z72od3H/NGqrrn9wnShEnAi8DUjJEgUH
         FiMxTjU8snJ4tuRQNTaSMnGKjkoVBn/gPu9GgUUuB4i4nuKF5WVoTlQ4hp6S/Sa8wiy9
         xoHDf/Le8WRocbA0U58k0LCLDYm6EpUngwKlh9CTbPaEljMIQHfUGT28ygCz3enuOeMk
         Zy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717937036; x=1718541836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftckS2Uy+EaxPqpxARW/p9vVImlaebLo7LGaNO9aVM4=;
        b=cDPfh6ZwWvBs+HEoDhwN41vWRzx39XkVslk+jwpmtUhwohj1XB8tdElzJ9s8XGt7+4
         I7ngK9M4WRPscHyJOMiFzV581mmO9AQ8zaO3WwfIqaBAIQSxviom5sb9VGDTysO8UctM
         5HGT2BQdwEjMl+FbTug2KAaHJwD40VLxqRTXLPJoUw+uPrLz/AISImT/ELbTPT2B44Ft
         990FxMVS8IrQUUR98KJJsf9x4Dwum4j7O8WKCirwPcg2QLoOqRyP1BoDvdAyFv/N5EeH
         UwsBwZVPEgp/xMmCDxl31AuLRNVLJa18B8ExTh5LCs+k4QUA2bNYj5+nJrwpgim2bvKM
         7vsw==
X-Forwarded-Encrypted: i=1; AJvYcCVtO+vZFPAd310QePV/FLyu3CR0+F8yx5L0LgkwOGHPB9O6s3fPdIael4gvVpvkLzkuLWnA28r86HuTiB+cmYPJvTJ4en95JFlwIJMdFpV4mmyi9UWh8r4Y8L31M8SeAzNTQef7uyWqPoJ7DDx/
X-Gm-Message-State: AOJu0Yx/p0XJC4KbFZd30yVX11qZ5QezleCew1wTwNKiNpTTD6bF+aVM
	/gUkw48LY2XWH59uiS3Cc0mNNQWd3FdlzgpuSH5N05WBfsp178wl
X-Google-Smtp-Source: AGHT+IFAgx7Y06VM6CXWwRUhLM3/gQ30/sIiFLYszFFI18Vm8EBAfvysJyPqJFTdE7do80LNUNI6gw==
X-Received: by 2002:a17:902:8c8e:b0:1f6:8290:175a with SMTP id d9443c01a7336-1f6d031cf18mr60644235ad.40.1717937036067;
        Sun, 09 Jun 2024 05:43:56 -0700 (PDT)
Received: from dev0.. ([49.43.162.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6e785858fsm37026285ad.221.2024.06.09.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 05:43:55 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: kees@kernel.org
Cc: gpiccoli@igalia.com,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	tony.luck@intel.com
Subject: Re: [PATCH v2] pstore/ram: Replace of_node_put with __free() for automatic cleanup
Date: Sun,  9 Jun 2024 12:43:49 +0000
Message-Id: <20240609124349.51187-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202406060902.4F06AA0DF6@keescook>
References: <202406060902.4F06AA0DF6@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jun 05, 2024 at 09:49:44PM, Kees Cook wrote:
> The history and version links should be below the "---" line.

I have made the change.

>
> But more importantly, please base your patch on the upstream tree,
> rather than on your v1 patch. :) (i.e. squash your v1 and v2 together).

I have squashed the two commits and shared v3 of the patch here:
https://lore.kernel.org/all/20240609124124.51166-1-jain.abhinav177@gmail.com/
>
> -Kees

--
Abhinav
