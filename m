Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C08626D
	for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411353; cv=none; b=H7OE5zBfOnH5lzETfJRusytz0qONVcMiAxnQmdzTQkhLamcooqePaoeH123S00sDkfp9dES2vY+L69M2JW4kxW2snSjUfkp/F70gtllAo3Cv/641I/rRmeJnpbSdwjTeg6q5805bqGKE09CPPqE1cziEtsH8RrKVrtN/xw0Q3f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411353; c=relaxed/simple;
	bh=VLGmItW5ga3i2vucUGKN+/K2d9+so6B6J6fiy3vkgXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaBfIf0aZIdf0fGyZw6w32ldweauQPR8ZENNvyIoZt3YlBJ/GKrJc4b76QtroMRnYEsMcDmAWPXvqAsGuZTBN5huXV9ZBgrezu8dUWSCjYsNGdDASRhudlC6oWsmLIgAQbyCS3QoQg3UmGg8WOUqIYt9M+BAvt87sdNH1QtrVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eVR+i43j; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eVR+i43j"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed5109d924so4105630b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714411351; x=1715016151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrsQtT6vqpidE7jqQvIsXqGG97ueXdTLbeNWZ9MIj88=;
        b=eVR+i43jKsIETmBHxBGyttpficd1BdwjIx36z2jtTC+/CvH1x4ZV7TrQFmiYUx7Xl/
         yCrGCr8Ia29y6zHkrwdLh4wtpNNn+J7PJWNjC0nDtX/tZaaJ6XCt8HIkvPeG/UlpEK89
         scV6sc8TzaH/O0/VGqYjdj9ALfTNDX0KvkxnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714411351; x=1715016151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrsQtT6vqpidE7jqQvIsXqGG97ueXdTLbeNWZ9MIj88=;
        b=oqeIZ0VzQksfZi3cTEzJCyUdCH/Pk4U5IfLp/9gDje4CR8K004vlRtCUpDd5FKJKle
         CunIucM0GGYTPbdinaEc981aFKjkRyZkkGH7vTDxuR5nP3RmBjGPrXdOqGJv7T1GY6wE
         DSNZ0ZLLZVjgJSZmVcHSO6u/d0hvenH0DSlkKQ2qgV3ywTVhph+maiKaGJRYIGRWDMpQ
         CQoWZiTP3u7SSLiWn4czegT5oL174IbHH3SG+3tD6Hf5/iMDW1GBnZTLCgxx0AygWWDT
         +t528VKgc2pRN1dt+TNOgaxZoidk7vAv5HT7H0Oy0CIz2adZzkrSCNdqwDcg2STUk7nk
         zVWA==
X-Forwarded-Encrypted: i=1; AJvYcCWCRoJ1XIUHYva6pVa5wsYZUd6M9wyKMcYTgGGyoHwiaoI2oV3M8tW4b7BBKgdjP+KHFK72HZ4XwBY6uAQR269cE0xgMA/5+bixzvfafMFm
X-Gm-Message-State: AOJu0YxOFmM4czJmN0CHgvag1Aiqn6ULeMhFUx52rt/9/0BSDKQJFOrI
	a5eyXPz//GO0vWZgjN5nutKUvscIwAtctscYPchafIWYzr1bPgQcKt/8s0YgWw==
X-Google-Smtp-Source: AGHT+IF/wveFnNgLqoHoltkqRov7qZYoAWhi4TxR94HT+5mZ1aDoYcZO+Oavxv5LvbLOtyFNePXXJA==
X-Received: by 2002:a05:6a20:d80f:b0:1af:3d3f:83f1 with SMTP id iv15-20020a056a20d80f00b001af3d3f83f1mr7142861pzb.44.1714411351403;
        Mon, 29 Apr 2024 10:22:31 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s4-20020a17090aa10400b002a54632931bsm21052900pjp.23.2024.04.29.10.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:22:31 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org,
	Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] init: replace deprecated strncpy with strscpy_pad
Date: Mon, 29 Apr 2024 10:22:28 -0700
Message-Id: <171441134708.2359415.3239349305778672892.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402-strncpy-init-do_mounts-c-v1-1-e16d7bc20974@google.com>
References: <20240402-strncpy-init-do_mounts-c-v1-1-e16d7bc20974@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 02 Apr 2024 20:39:49 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> data_page wants to be NUL-terminated and NUL-padded, use strscpy_pad to
> provide both of these. data_page no longer awkwardly relies on
> init_mount to perform its NUL-termination, although that sanity check is
> left unchanged.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] init: replace deprecated strncpy with strscpy_pad
      https://git.kernel.org/kees/c/fa6475acde9a

Take care,

-- 
Kees Cook

